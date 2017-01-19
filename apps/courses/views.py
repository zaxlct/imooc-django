# -*- coding: utf-8 -*-
from django.shortcuts import render
from django.views.generic.base import View
from pure_pagination import Paginator, EmptyPage, PageNotAnInteger
from django.http import HttpResponse
from django.db.models import Q

from .models import Course, CourseResource, Video
from operation.models import UserFavorite, CourseComments, UserCourse
from utils.mixin_utils import LoginRequiredMixin

import json
# Create your views here.


class CourseListView(View):
    def get(self, request):
        # 全部的课程数据，并按照最新的时间排序
        all_courses = Course.objects.all().order_by('-add_time')

        # 取点击数最高的三个课程
        hot_courses = Course.objects.all().order_by('-click_nums')[:3]

        # 课程搜索
        search_keywords = request.GET.get('keywords', '')
        if search_keywords:
            all_courses = all_courses.filter(
                Q(name__icontains=search_keywords) | Q(desc__icontains=search_keywords)
                | Q(detail__icontains=search_keywords))

        # 课程排序
        sort = request.GET.get('sort', '')
        if sort:
            if sort == 'students':
                all_courses = all_courses.order_by('-students')
            elif sort == 'hot':
                all_courses = all_courses.order_by('-click_nums')

        # 对课程进行分页
        try:
            page = request.GET.get('page', 1)
        except PageNotAnInteger:
            page = 1

        p = Paginator(all_courses, 3, request=request)
        courses = p.page(page)

        return render(request, 'course-list.html', {
            'all_courses': courses,
            'hot_courses': hot_courses,
            'sort': sort,
        })


class CourseDetailView(View):
    # 课程详情
    def get(self, request, course_id):
        course = Course.objects.get(id=int(course_id))

        # 进入该课程详情后，该课程的点击数 + 1
        course.click_nums += 1
        course.save()

        # 课程相关
        tag = course.tag
        relate_courses = []
        if tag:
            relate_courses = Course.objects.filter(tag=tag)[:2]

        # 课程收藏 and 机构收藏
        has_fav_course = False
        has_fav_org = False
        if request.user.is_authenticated():
            if UserFavorite.objects.filter(user=request.user, fav_id=course.id, fav_type=1):
                has_fav_course = True
            if UserFavorite.objects.filter(user=request.user, fav_id=course.course_org.id, fav_type=2):
                has_fav_org = True

        return render(request, 'course-detail.html', {
            'course': course,
            'relate_courses': relate_courses,
            'has_fav_course': has_fav_course,
            'has_fav_org': has_fav_org,
        })


class CourseInfoView(LoginRequiredMixin, View):
    # 课程章节信息
    def get(self, request, course_id):
        course = Course.objects.get(id=int(course_id))

        #点击课程，学习人数 + 1
        course.students += 1
        course.save()

        # 查询用户是否已经关联了该课程
        user_courses = UserCourse.objects.filter(user=request.user, course=course)
        if not user_courses:
            user_course = UserCourse(user=request.user, course=course)
            user_course.save()


        # 取出 UserCourse 表里和这个课程一样的所有数据 data
        user_courses = UserCourse.objects.filter(course=course)

        # 取出 data 里所有用户的 user_ids 列表
        user_ids = [user_course.user.id for user_course in user_courses]

        # 取出 UserCourse 表里， 集合 user_ids 每个元素对应的数据
        all_user_courses = UserCourse.objects.filter(user_id__in=user_ids)

        # 取出 all_user_courses 里所有课程的 course_ids 列表
        course_ids = [user_course.course.id for user_course in all_user_courses]

        # 取出 Course 表里，集合 course_ids 每个元素对应的数据
        # 需要画图才能理清楚
        relate_courses = Course.objects.filter(id__in=course_ids)
        relate_courses = relate_courses.order_by('-click_nums')[:5]

        all_resources = CourseResource.objects.filter(course=course)
        return render(request, 'course-video.html', {
            'course': course,
            'all_resources': all_resources,
            'relate_courses': relate_courses,
        })


class CommentView(LoginRequiredMixin, View):
    # 课程评论
    def get(self, request, course_id):
        course = Course.objects.get(id=int(course_id))
        all_resources = CourseResource.objects.filter(course=course)
        all_comments = CourseComments.objects.all()
        return render(request, 'course-comment.html', {
            'course': course,
            'all_comments': all_comments,
            'all_resources': all_resources,
        })


class AddCommentView(View):
    # 用户添加课程评论
    def post(self, request):
        # 判断用户登录状态
        if not request.user.is_authenticated():
            res = {}
            res['status'] = 'fail'
            res['msg'] = u'用户未登录'
            return HttpResponse(json.dumps(res), content_type='application/json')

        course_id = request.POST.get('course_id', 0)
        comments = request.POST.get('comments', '')

        res = {}
        if course_id > 0 and comments:
            course_comments = CourseComments()
            # get 和 filter 区别
            # get 只能取出一条数据，如果取出多条或者为空，都会抛出异常
            # filter 返回一个数组，不会抛出异常
            course = Course.objects.get(id=int(course_id))

            course_comments.course = course
            course_comments.comments = comments
            course_comments.user = request.user
            course_comments.save()

            res['status'] = 'success'
            res['msg'] = u'添加成功'
        else:
            res['status'] = 'fail'
            res['msg'] = u'添加失败'

        return HttpResponse(json.dumps(res), content_type='application/json')


class VideoPlayView(View):
    # 播放视频页面
    def get(self, request, video_id):
        video = Video.objects.get(id=int(video_id))
        course = video.lesson.course

        # 查询用户是否已经关联了该课程
        user_courses = UserCourse.objects.filter(user=request.user, course=course)
        if not user_courses:
            user_course = UserCourse(user=request.user, course=course)
            user_course.save()

        # 取出 UserCourse 表里和这个课程一样的所有数据 data
        user_courses = UserCourse.objects.filter(course=course)

        # 取出 data 里所有用户的 user_ids 列表
        user_ids = [user_course.user.id for user_course in user_courses]

        # 取出 UserCourse 表里， 集合 user_ids 每个元素对应的数据
        all_user_courses = UserCourse.objects.filter(user_id__in=user_ids)

        # 取出 all_user_courses 里所有课程的 course_ids 列表
        course_ids = [user_course.course.id for user_course in all_user_courses]

        # 取出 Course 表里，集合 course_ids 每个元素对应的数据
        # 需要画图才能理清楚
        relate_courses = Course.objects.filter(id__in=course_ids)
        relate_courses = relate_courses.order_by('-click_nums')[:5]

        all_resources = CourseResource.objects.filter(course=course)
        return render(request, 'course-play.html', {
            'course': course,
            'all_resources': all_resources,
            'relate_courses': relate_courses,
            'video': video,
        })