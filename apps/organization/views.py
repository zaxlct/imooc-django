# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.views.generic import View
from pure_pagination import Paginator, EmptyPage, PageNotAnInteger
from django.http import HttpResponse

from .models import CourseOrg, CityDict
from .forms import UserAskForm
from courses.models import Course

import json
# Create your views here.


class OrgView(View):
    # 课程机构列表功能
    def get(self, request):
        # 取出所有的课程机构
        all_orgs = CourseOrg.objects.all()

        # 热门机构的提取 （order_by 方法实际上执行的是 SQL 的 order 语句）
        # 按照点击数来排名（TODO: 怎么统计点击数呢）
        hot_orgs = all_orgs.order_by('click_nums')[:3]

        # 这个 count 方法是 django 提供的
        # 实际上执行了一条 SQL 语句 SELECT count(*) from table_name
        # 和 python 提供的 count 函数有区别

        # 取出城市数据
        all_citys = CityDict.objects.all()

        # 城市筛选
        city_id = request.GET.get('city', '')
        if city_id:
            all_orgs = all_orgs.filter(city_id=int(city_id))

        # 类别筛选
        category = request.GET.get('ct', '')
        if category:
            all_orgs = all_orgs.filter(category=category)

        # 排序
        sort = request.GET.get('sort', '')
        if sort:
            if sort == 'students':
                all_orgs = all_orgs.order_by('-students')
            elif sort == 'courses':
                all_orgs = all_orgs.order_by('-course_nums')

        # 筛选完成之后再进行统计
        org_nums = all_orgs.count()

        # 对课程机构进行分页
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
            'category': category,
            'hot_orgs': hot_orgs,
            'sort': sort,
        })


class AddUserAskView(View):
    # 用户添加咨询表单提交
    def post(self, request):
        userask_form = UserAskForm(request.POST)
        if userask_form.is_valid():
            userask_form.save(commit=True)
            res = {}
            res['status'] = 'success'
        else:
            res = {}
            res['status'] = 'fail'
            res['msg'] = '添加出错'
        return HttpResponse(json.dumps(res), content_type='application/json')


class OrgHomeView(View):
    # 机构首页
    def get(self, request, org_id):
        #取出对应 id 的课程机构
        course_org = CourseOrg.objects.get(id=int(org_id))

        #取出某个指定课程机构下所有的课程(course)
        # 语法 course + _set
        all_courses = course_org.course_set.all()[:3]

        # 取出某个指定课程机构下所有的老师(course)
        all_teachers = course_org.teacher_set.all()[:1]

        current_page = 'home'

        return render(request, 'org-detail-homepage.html', {
            'all_courses': all_courses,
            'all_teachers': all_teachers,
            'course_org': course_org,
            'current_page': current_page,
        })


class OrgCourseView(View):
    # 机构课程列表页
    def get(self, request, org_id):
        current_page = 'course'
        course_org = CourseOrg.objects.get(id=int(org_id))
        all_courses = course_org.course_set.all()
        return render(request, 'org-detail-course.html', {
            'all_courses': all_courses,
            'course_org': course_org,
            'current_page': current_page,
        })


class OrgDescView(View):
    # 课程机构介绍页
    def get(self, request, org_id):
        current_page = 'desc'
        course_org = CourseOrg.objects.get(id=int(org_id))
        return render(request, 'org-detail-desc.html', {
            'course_org': course_org,
            'current_page': current_page,
        })



class OrgTeacherView(View):
    # 机构讲师详情页
    def get(self, request, org_id):
        current_page = 'teacher'
        course_org = CourseOrg.objects.get(id=int(org_id))
        all_teachers = course_org.teacher_set.all()
        return render(request, 'org-detail-teachers.html', {
            'all_teachers': all_teachers,
            'current_page': current_page,
            'course_org': course_org,
        })