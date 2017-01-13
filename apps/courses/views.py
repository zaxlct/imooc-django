# -*- coding: utf-8 -*-
from django.shortcuts import render
from django.views.generic.base import View
from pure_pagination import Paginator, EmptyPage, PageNotAnInteger
from operation.models import UserFavorite

from .models import Course


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
