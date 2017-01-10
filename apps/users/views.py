# -*- coding: utf-8 -*-
from django.shortcuts import render
from django.contrib.auth import authenticate, login
from django.contrib.auth.backends import ModelBackend
from django.db.models import Q
from django.views.generic.base import View
from django.contrib.auth.hashers import make_password

from .models import UserProfile, EmailVerifyRecord
from .forms import LoginForm, RegisterForm, ForgetForm, ModifyPwdForm
from utils.email_send import send_register_email

# Create your views here.


# setting 里要有对应的配置
class CustomBackend(ModelBackend):
    def authenticate(self, username=None, password=None, **kwargs):
        try:
            user = UserProfile.objects.get(Q(username = username) | Q(email = username))
            if user.check_password(password):
                return user
        except Exception as e:
            return None


class LoginView(View):
    def get(self, request):
        return render(request, 'login.html', {})

    def post(self, request):
        login_form = LoginForm(request.POST)
        if login_form.is_valid():
            user_name = request.POST.get('username', '')
            password = request.POST.get('password', '')
            user = authenticate(username=user_name, password=password)
            if user is not None:
                if user.is_active:
                    login(request, user)
                    return render(request, 'index.html')
                else:
                    return render(request, 'login.html', {'msg': '用户未激活！'})
            else:
                return render(request, 'login.html', {'msg': '用户名或密码错误！'})
        else:
            return render(request, 'login.html', {'login_form': login_form})


class RegisterView(View):
    def get(self, request):
        register_form = RegisterForm()
        return render(request, 'register.html', {'register_form': register_form})

    def post(self, request):
        register_form = RegisterForm(request.POST)
        if register_form.is_valid():
            # 拿到的是邮箱
            user_name = request.POST.get('email', '')
            if UserProfile.objects.filter(email=user_name):
                return render(request, 'register.html', {'register_form': register_form, 'msg': '用户已经存在！'})

            pass_word = request.POST.get('password', '')

            user_profile = UserProfile()
            # 邮箱也设置成了用户名，我觉得可以设置个随机的昵称
            user_profile.username = user_name
            user_profile.email = user_name
            user_profile.password = make_password(pass_word)
            # is_active 是 auth_user 表里预定义的字段
            user_profile.is_active = False
            user_profile.save()

            # TODO 发送邮箱后提示用户
            # 发送邮件函数
            send_register_email(user_name, 'register')
            # 发送邮件成功后跳转到登录页面
            return render(request, 'send_success.html')

        else:
            return render(request, 'register.html', {'register_form': register_form})


# 验证用户点击邮件里的注册连接
class ActiveUserView(View):
    def get(self, request, active_code):
        all_records = EmailVerifyRecord.objects.filter(code=active_code)
        # 如果用户存在
        if all_records:
            for records in all_records:
                email = records.email
                user = UserProfile.objects.get(email=email)
                user.is_active = True
                user.save()
        else:
            return render(request, 'active_fail.html')
        return render(request, 'login.html')


# 忘记密码
class ForgetPwdView(View):
    def get(self, request):
        forget_form = ForgetForm()
        return render(request, 'forgetpwd.html', {'forget_form': forget_form})

    def post(self, request):
        forget_form = ForgetForm(request.POST)
        if forget_form.is_valid():
            email = request.POST.get('email', '')
            send_register_email(email, 'forget')
            # 发送邮件成功后跳转到对应页面
            return render(request, 'send_success.html')
        else:
            return render(request, 'forgetpwd.html', {'forget_form': forget_form})


# 验证用户点击邮件里的找回密码连接
class ResetView(View):
    def get(self, request, active_code):
        all_records = EmailVerifyRecord.objects.filter(code=active_code)
        # 如果用户存在
        if all_records:
            for records in all_records:
                email = records.email
                return render(request, 'password_reset.html', {'email': email})
        else:
            return render(request, 'active_fail.html')
        return render(request, 'login.html')


class ModifyPwdView(View):
    def post(self, request):
        modify_form = ModifyPwdForm(request.POST)
        email = request.POST.get('email', '')
        if modify_form.is_valid():
            pwd1 = request.POST.get('password1', '')
            pwd2 = request.POST.get('password2', '')
            if pwd1 != pwd2:
                return render(request, 'password_reset.html', {'email': email, 'msg': '密码不一致！'})
            user = UserProfile.objects.get(email=email)
            user.password = make_password(pwd2)
            user.save()
            return render(request, 'login.html')
        else:
            return render(request, 'password_reset.html', {'email': email, 'modify_form': modify_form})


