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
# from django.contrib import admin
from django.views.generic import TemplateView

import xadmin

# from users.views import user_login
from users.views import LoginView, RegisterView, ActiveUserView

urlpatterns = [
    url(r'^admin/', xadmin.site.urls),
    url(r'^$', TemplateView.as_view(template_name='index.html'), name='index'),
    url(r'^captcha/', include('captcha.urls')),

    # TemplateView 只返回静态模板，不用在 views 里写逻辑
    # url(r'^login/$', TemplateView.as_view(template_name='login.html'), name='login')

    # 基于函数 的 View 映射 URL 方法
    # url(r'^login/$', user_login, name='login'),
    url(r'^login/$', LoginView.as_view(), name='login'),

    # 验证用户注册后，在邮件里点击注册链接
    url(r'active/(?P<active_code>.*)/$', ActiveUserView.as_view(), name='user_active'),

    url(r'^register/$', RegisterView.as_view(), name='register'),
    url(r'^forget/$', TemplateView.as_view(template_name='index.html'), name='forget_pwd'),

]


if settings.DEBUG:
    import debug_toolbar
    urlpatterns.append(url(r'^__debug__/', include(debug_toolbar.urls)))