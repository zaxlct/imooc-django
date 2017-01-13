# -*- coding: utf-8 -*-
from django.shortcuts import render
from django.views.generic.base import View
from pure_pagination import Paginator, EmptyPage, PageNotAnInteger
from operation.models import UserFavorite, CourseComments
from django.http import HttpResponse

from .models import Course, CourseResource

import json
# Create your views here.


class CourseListView(View):
    def get(self, request):
        # 全部的课程数据，并按照最新的时间排序
        all_courses = Course.objects.all().order_by('-add_time')

        # 取点击数最高的三个课程
        hot_courses = Course.objects.all().order_by('-click_nums')[:3]

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


class CourseInfoView(View):
    # 课程章节信息
    def get(self, request, course_id):
        course = Course.objects.get(id=int(course_id))
        all_resources = CourseResource.objects.filter(course=course)
        return render(request, 'course-video.html', {
            'course': course,
            'all_resources': all_resources,
        })


class CommentView(View):
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