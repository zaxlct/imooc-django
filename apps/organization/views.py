import json

from django.shortcuts import render
from django.views.generic import View
from django.http import HttpResponse
from django.db.models import Q
# Create your views here.

from pure_pagination import Paginator, EmptyPage, PageNotAnInteger
from .models import CourseOrg, CityDict, Teacher
from .forms import UserAskForm
from operation.models import UserFavorite
from courses.models import Course


# 课程机构列表页，筛选页
class OrgView(View):
    def get(self, request):
        all_orgs = CourseOrg.objects.all()
        hot_orgs = all_orgs.order_by('-click_nums')[:3]
        all_citys = CityDict.objects.all()

        # 取出筛选城市
        city_id = request.GET.get('city', '')
        if city_id:
            all_orgs = all_orgs.filter(city_id=int(city_id))

        # 课程机构类别筛选
        category = request.GET.get('ct', '')
        if category:
            all_orgs = all_orgs.filter(category=category)

        # 排序
        sort = request.GET.get('sort', '')
        if sort == 'students':
            all_orgs = all_orgs.order_by('-students')
        elif sort == 'courses':
            all_orgs = all_orgs.order_by('-course_nums')

        #筛选完成之后再进行统计
        org_nums = all_orgs.count()

        # 分页
        try:
            page = request.GET.get('page', 1)
        except PageNotAnInteger:
            page = 1

        p = Paginator(all_orgs, 2, request=request)

        orgs = p.page(page)

        return render(request, 'org-list.html', {
            'all_orgs': orgs,
            'all_citys': all_citys,
            'org_nums': org_nums,
            'city_id': city_id,
            'sort': sort,
            'category': category,
            'hot_orgs': hot_orgs,
        })


# 用户添加咨询课程表单提交
class AddUserAskView(View):
    def post(self, request):
        user_ask_form = UserAskForm(request.POST)
        res = dict()
        if user_ask_form.is_valid():
            user_ask_form.save(commit=True)
            res['status'] = 'success'
        else:
            res['status'] = 'fail'
            res['msg'] = '添加出错'
        return HttpResponse(json.dumps(res), content_type='application/json')


# 课程机构详情页的首页
class OrgHomeView(View):
    def get(self, request, org_id):
        course_org = CourseOrg.objects.get(id=int(org_id))

        # 取出某个指定课程机构下所有的课程(course)
        # 语法 course + _set
        all_courses = course_org.course_set.all()[:3]

        # 取出某个指定课程机构下所有的老师(course)
        all_teachers = course_org.teacher_set.all()[:1]

        # 初始化判断是否收藏
        has_fav = False
        if request.user.is_authenticated():
            if UserFavorite.objects.filter(user=request.user, fav_id=course_org.id, fav_type=2):
                has_fav = True

        current_page = 'home'

        return render(request, 'org-detail-homepage.html', {
            'all_courses': all_courses,
            'all_teachers': all_teachers,
            'course_org': course_org,
            'current_page': current_page,
            'has_fav': has_fav,
            'org_id': org_id,
        })


# 课程机构详情页讲师页面
class OrgCourseView(View):
    def get(self, request, org_id):
        current_page = 'course'
        course_org = CourseOrg.objects.get(id=int(org_id))
        all_courses = course_org.course_set.all()

        #初始化判断是否收藏
        has_fav = False
        if request.user.is_authenticated():
            if UserFavorite.objects.filter(user=request.user, fav_id = course_org.id, fav_type=2):
                has_fav = True

        # 分页
        try:
            page = request.GET.get('page', 1)
        except PageNotAnInteger:
            page = 1

        p = Paginator(all_courses, 2, request=request)

        courses = p.page(page)

        return render(request, 'org-detail-course.html', {
            'all_courses': courses,
            'course_org': course_org,
            'current_page': current_page,
            'has_fav': has_fav,
        })


class OrgDescView(View):
    # 课程机构介绍页
    def get(self, request, org_id):
        current_page = 'desc'
        course_org = CourseOrg.objects.get(id=int(org_id))

        # 初始化判断是否收藏
        has_fav = False
        if request.user.is_authenticated():
            if UserFavorite.objects.filter(user=request.user, fav_id=course_org.id, fav_type=2):
                has_fav = True

        return render(request, 'org-detail-desc.html', {
            'course_org': course_org,
            'current_page': current_page,
            'has_fav': has_fav,
        })


# 课程机构详情页讲师页面
class OrgTeacherView(View):
    def get(self, request, org_id):
        current_page = 'teacher'
        course_org = CourseOrg.objects.get(id=int(org_id))
        all_teachers = course_org.teacher_set.all()

        # 初始化判断是否收藏
        has_fav = False
        if request.user.is_authenticated():
            if UserFavorite.objects.filter(user=request.user, fav_id=course_org.id, fav_type=2):
                has_fav = True

        return render(request, 'org-detail-teachers.html', {
            'all_teachers': all_teachers,
            'current_page': current_page,
            'course_org': course_org,
            'has_fav': has_fav,
        })


class AddFavView(View):
    # 用户收藏、取消收藏 课程机构
    def set_fav_nums(self, fav_type, fav_id, num=1):
        if fav_type == 1:
            course = Course.objects.get(id=fav_id)
            course.fav_nums += num
            course.save()
        elif fav_type == 2:
            course_org = CourseOrg.objects.get(id=fav_id)
            course_org.fav_nums += num
            course_org.save()
        elif fav_type == 3:
            teacher = Teacher.objects.get(id=fav_id)
            teacher.fav_nums += num
            teacher.save()

    def post(self, request):
        fav_id = int(request.POST.get('fav_id', 0))
        fav_type = int(request.POST.get('fav_type', 0))

        res = dict()
        if not request.user.is_authenticated():
            res['status'] = 'fail'
            res['msg'] = '用户未登录'
            return HttpResponse(json.dumps(res), content_type='application/json')

        # 查询收藏记录
        exist_records = UserFavorite.objects.filter(user=request.user, fav_id=fav_id, fav_type=fav_type)
        if exist_records:
            exist_records.delete()
            self.set_fav_nums(fav_type, fav_id, -1)
            res['status'] = 'success'
            res['msg'] = '收藏'
        else:
            user_fav = UserFavorite()
            if fav_id and fav_type:
                user_fav.user = request.user
                user_fav.fav_id = fav_id
                user_fav.fav_type = fav_type
                user_fav.save()
                self.set_fav_nums(fav_type, fav_id, 1)

                res['status'] = 'success'
                res['msg'] = '已收藏'
            else:
                res['status'] = 'fail'
                res['msg'] = '收藏出错'
        return HttpResponse(json.dumps(res), content_type='application/json')


# 讲师列表页
class TeacherListView(View):
    def get(self, request):
        all_teachers = Teacher.objects.all()
        sorted_teacher = Teacher.objects.all().order_by('-click_nums')[:3]

        search_keywords = request.GET.get('keywords', '')
        if search_keywords:
            all_teachers = all_teachers.filter(
                Q(name__icontains=search_keywords) |
                Q(work_company__icontains=search_keywords) |
                Q(work_position__icontains=search_keywords)
            )
        sort = request.GET.get('sort', '')
        if sort == 'hot':
            all_teachers = all_teachers.order_by('-click_nums')

        # 对讲师进行分页
        try:
            page = request.GET.get('page', 1)
        except PageNotAnInteger:
            page = 1

        p = Paginator(all_teachers, 2, request=request)
        teachers = p.page(page)

        return render(request, 'teachers-list.html', {
            'all_teachers': teachers,
            'sorted_teacher': sorted_teacher,
            'sort': sort,
        })


# 讲师详情
class TeacherDetailView(View):
    def get(self, request, teacher_id):
        sorted_teacher = Teacher.objects.all().order_by('-click_nums')[:3]

        teacher = Teacher.objects.get(id=int(teacher_id))
        teacher.click_nums += 1
        teacher.save()
        all_courses = Course.objects.filter(teacher=teacher)

        has_teacher_faved = False
        # 注意这里有个坑就是 teacher_id 是字符串，teacher.id 是数字
        if UserFavorite.objects.filter(user=request.user, fav_type=3, fav_id=teacher.id):
            has_teacher_faved = True

        has_org_faved = False
        if UserFavorite.objects.filter(user=request.user, fav_type=2, fav_id=teacher.org.id):
            has_org_faved = True

        return render(request, 'teacher-detail.html', {
            'teacher': teacher,
            'all_courses': all_courses,
            'sorted_teacher': sorted_teacher,
            'has_teacher_faved': has_teacher_faved,
            'has_org_faved': has_org_faved,
        })
