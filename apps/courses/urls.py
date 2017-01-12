# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/12 下午8:29'

from django.conf.urls import url, include
from .views import CourseListView


urlpatterns = [
    #课程列表页
    url(r'^list/$', CourseListView.as_view(), name='course_list'),
]
