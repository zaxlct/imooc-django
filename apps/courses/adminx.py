# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/8 下午12:27'

import xadmin

from .models import Course, Lesson, Video, CourseResource, BannerCourse
from organization.models import CourseOrg

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
                    'click_nums', 'add_time', 'get_zj_nums', 'go_to']
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

    # 在线编辑
    list_editable = ['degree', 'desc']

    # 定时刷新
    refresh_times = [3, 5]

    # 筛选最终的 result
    def queryset(self):
        qs = super(CourseAdmin, self).queryset()
        qs = qs.filter(is_banner=False)
        return qs

    def save_models(self):
        # 在保存课程的时候统计课程机构的课程数
        # 比如保存了《前端教程》课程，保存之前选择了属于'慕课网'这个课程机构，保存完成后，慕课网课程机构下面的课程总数要 + 1
        obj = self.new_obj
        obj.save()
        if obj.course_org is not None:
            # 课程机构的实例
            course_org = obj.course_org

            course_org.course_nums = CourseOrg.objects.filter(course_org=course_org).count()
            course_org.save()



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