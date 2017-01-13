# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/12 下午8:29'

from django.conf.urls import url, include
from .views import CourseListView, CourseDetailView, CourseInfoView


urlpatterns = [
    # 课程列表页
    url(r'^list/$', CourseListView.as_view(), name='course_list'),

    # 课程详情页
    url(r'^detail/(?P<course_id>\d+)/$', CourseDetailView.as_view(), name='course_detail'),

    # 课程章节信息
    url(r'^info/(?P<course_id>\d+)/$', CourseInfoView.as_view(), name='course_info'),
]
