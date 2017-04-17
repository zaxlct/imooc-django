"""imooc URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls import url, include
from django.views.generic import TemplateView
from django.views.static import serve #处理静态文件

from imooc.settings import MEDIA_ROOT

# from django.contrib import admin
import xadmin

# from users.views import user_login
from users.views import IndexView
from users.views import LoginView, RegisterView, ActiveUserView, ForgetPwdView, ResetView, ModifyPwdView, LogoutView

urlpatterns = [
    url(r'^admin/', xadmin.site.urls),
    url(r'^$', IndexView.as_view(), name="index"),
    # 验证码
    url(r'^captcha/', include('captcha.urls')),

    #配置上传文件的访问处理函数
    url(r'^media/(?P<path>.*)$', serve, {'document_root': MEDIA_ROOT}),

    # TemplateView 只返回静态模板，不用在 views 里写逻辑
    # url(r'^login/$', TemplateView.as_view(template_name='login.html'), name='login'),

    # 基于函数 的 View 映射 URL 方法
    # url(r'^login/$', user_login, name='login'),
    url(r'^login/$', LoginView.as_view(), name='login'),

    # 验证用户注册后，在邮件里点击注册链接
    url(r'^active/(?P<active_code>.*)/$', ActiveUserView.as_view(), name='user_active'),

    # 注册页面
    url(r'^register/$', RegisterView.as_view(), name='register'),
    # 忘记密码
    url(r'^forget/$', ForgetPwdView.as_view(), name='forget_pwd'),

    # 退出登录
    url(r'^logout/$', LogoutView.as_view(), name='logout'),

    #用户在邮件里点击重置密码链接
    url(r'^reset/(?P<active_code>.*)/$', ResetView.as_view(), name='reset_pwd'),

    # 重置密码表单 POST 请求
    url(r'^modify_pwd/$', ModifyPwdView.as_view(), name='modify_pwd'),

    #课程机构相关 URL
    url(r'^org/', include('organization.urls', namespace='org')),

    # 课程相关 URL 配置
    url(r'^course/', include('courses.urls', namespace='courses')),

    # 用户中心 URL 配置
    url(r'^users/', include('users.urls', namespace='users')),
]

# 全局 404 页面配置（django 会自动调用这个变量）
handler404 = 'users.views.page_not_found'
handler500 = 'users.views.page_error'


if settings.DEBUG:
    # debug_toolbar 插件配置
    import debug_toolbar
    urlpatterns.append(url(r'^__debug__/', include(debug_toolbar.urls)))
else:
    # 项目部署上线时使用
    from imooc.settings import STATIC_ROOT
    # 配置静态文件访问处理
    urlpatterns.append(url(r'^static/(?P<path>.*)$', serve, {'document_root': STATIC_ROOT}))