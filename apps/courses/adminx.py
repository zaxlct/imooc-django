# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/8 下午12:27'

from .models import Course, Lesson, Video, CourseResource, BannerCourse
import xadmin

# 添加课程的时候可以顺便添加章节
class LessonInline(object):
    model = Lesson
    extra = 0


# 添加课程的时候可以顺便添加课程资源
class CourseResourceInline(object):
    model = CourseResource
    extra = 0


class CourseAdmin(object):
    list_display = ['name', 'desc', 'detail', 'degree', 'learn_times', 'students', 'fav_nums',
                    'click_nums', 'add_time']
    search_fields = ['name', 'desc', 'detail', 'degree', 'learn_times', 'students', 'fav_nums',
                    'click_nums']
    list_filter = ['name', 'desc', 'detail', 'degree', 'learn_times', 'students', 'fav_nums',
                    'click_nums', 'add_time']
    ordering = ['-click_nums']

    # readonly_fields 和 exclude 的字段不要重复，否则会冲突
    readonly_fields = ['click_nums']
    exclude = ['fav_nums']

    #Inline # 添加课程的时候可以顺便添加章节、课程资源
    inlines = [LessonInline, CourseResourceInline]

    def queryset(self):
        qs = super(CourseAdmin, self).queryset()
        qs = qs.filter(is_banner=False)
        return qs


class BannerCourseAdmin(object):
    list_display = ['name', 'desc', 'detail', 'degree', 'learn_times', 'students', 'fav_nums',
                    'click_nums', 'add_time']
    search_fields = ['name', 'desc', 'detail', 'degree', 'learn_times', 'students', 'fav_nums',
                    'click_nums']
    list_filter = ['name', 'desc', 'detail', 'degree', 'learn_times', 'students', 'fav_nums',
                    'click_nums', 'add_time']
    ordering = ['-click_nums']

    # readonly_fields 和 exclude 的字段不要重复，否则会冲突
    readonly_fields = ['click_nums']
    exclude = ['fav_nums']

    #Inline # 添加课程的时候可以顺便添加章节、课程资源
    inlines = [LessonInline, CourseResourceInline]

    def queryset(self):
        qs = super(BannerCourseAdmin, self).queryset()
        qs = qs.filter(is_banner=True)
        return qs


class LessonAdmin(object):
    # 外键的处理方法
    # course 是一个对象，xadmin 不能搜索，需要指定搜索 course 对象里哪一个属性
    list_display = ['course', 'name', 'add_time']
    search_fields = ['course', 'name']
    list_filter = ['course__name', 'name', 'add_time']


class VideoAdmin(object):
    list_display = ['lesson', 'name', 'add_time']
    search_fields = ['lesson', 'name']
    list_filter = ['lesson', 'name', 'add_time']


class CourseResourceAdmin(object):
    list_display = ['course', 'name', 'download', 'add_time']
    search_fields = ['course', 'name', 'download']
    list_filter = ['course__name', 'name', 'add_time']


xadmin.site.register(Course, CourseAdmin)
xadmin.site.register(BannerCourse, BannerCourseAdmin)
xadmin.site.register(Lesson, LessonAdmin)
xadmin.site.register(Video, VideoAdmin)
xadmin.site.register(CourseResource, CourseResourceAdmin)