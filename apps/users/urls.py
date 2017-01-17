# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/17 下午3:15'

from django.conf.urls import url, include
from .views import UserInfoView, UploadImageView, UpdatePwdView


urlpatterns = [
    # 用户信息
    url(r'^info/$', UserInfoView.as_view(), name='user_info'),

    # 用户头像修改
    url(r'^image/upload/$', UploadImageView.as_view(), name='image_upload'),

    # 用户个人中心修改密码
    url(r'^update/pwd/$', UpdatePwdView.as_view(), name='update_pwd'),

]
