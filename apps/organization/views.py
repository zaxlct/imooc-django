# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.views.generic import View
from pure_pagination import Paginator, EmptyPage, PageNotAnInteger

from .models import CourseOrg, CityDict

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