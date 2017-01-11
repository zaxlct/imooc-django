# -*- coding: utf-8 -*-

from django.shortcuts import render
from django.views.generic import View
from pure_pagination import Paginator, EmptyPage, PageNotAnInteger

from .models import CourseOrg, CityDict

# Create your views here.


class OrgView(View):
    # 课程机构列表功能
    def get(self, request):
        # 课程机构
        all_orgs = CourseOrg.objects.all()

        org_nums = all_orgs.count()
        # 这个 count 方法是 django 提供的
        # 实际上执行了一条 SQL 语句 SELECT count(*) from table_name
        # 和 python 提供的 count 函数有区别

        # 对课程机构进行分页
        try:
            page = request.GET.get('page', 1)
        except PageNotAnInteger:
            page = 1

        p = Paginator(all_orgs, 2, request=request)
        orgs = p.page(page)

        # 城市
        all_citys = CityDict.objects.all()
        return render(request, 'org-list.html', {
            'all_orgs': orgs,
            'all_citys': all_citys,
            'org_nums': org_nums,
        })