# -*- coding: utf-8 -*-
from django.shortcuts import render
from django.contrib.auth import authenticate, login
from django.contrib.auth.backends import ModelBackend
from django.db.models import Q
from django.views.generic.base import View
from django.contrib.auth.hashers import make_password
from django.http import HttpResponse

from .models import UserProfile, EmailVerifyRecord
from .forms import LoginForm, RegisterForm, ForgetForm, ModifyPwdForm, UploadImageForm, UserInfoForm
from utils.email_send import send_register_email
from utils.mixin_utils import LoginRequiredMixin
from operation.models import UserCourse, UserFavorite
from organization.models import CourseOrg, Teacher
from courses.models import Course

import json

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


# 未登录下，用户修改密码
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


# 用户个人信息展示
class UserInfoView(LoginRequiredMixin, View):
    def get(self, request):
        return render(request, 'usercenter-info.html', {})

    # 用户修改昵称，手机号，地址，生日
    def post(self, request):
        # 如果不用 instance ，就会新增加一个用户
        user_info_form = UserInfoForm(request.POST, instance=request.user)
        res = {}
        if user_info_form.is_valid():
            user_info_form.save()
            res['status'] = 'success'

        else:
            res = user_info_form.errors

        return HttpResponse(json.dumps(res), content_type='application/json')



# 用户修改头像
class UploadImageView(LoginRequiredMixin, View):
    def post(self, request):
        # image_form = UploadImageForm(request.POST, request.FILES)
        # if image_form.is_valid():
        #     image = image_form.cleaned_data['image']
        #     request.user.image = image
        #     request.user.save()

        image_form = UploadImageForm(request.POST, request.FILES, instance=request.user)
        res = {}
        if image_form.is_valid():
            image_form.save()
            res['status'] = 'success'
            res['msg'] = u'头像修改成功'
        else:
            res['status'] = 'fail'
            res['msg'] = u'头像修改失败'
        return HttpResponse(json.dumps(res), content_type='application/json')


# 用户在个人中心修改密码
class UpdatePwdView(LoginRequiredMixin, View):
    def post(self, request):
        modify_form = ModifyPwdForm(request.POST)
        res = {}

        if modify_form.is_valid():
            pwd1 = request.POST.get('password1', '')
            pwd2 = request.POST.get('password2', '')
            if pwd1 != pwd2:
                res['status'] = 'fail'
                res['msg'] = u'两次密码不一致'
                return HttpResponse(json.dumps(res), content_type='application/json')

            user = request.user
            user.password = make_password(pwd2)
            user.save()

            res['status'] = 'success'
            res['msg'] = u'密码修改成功'
        else:
            res = modify_form.errors

        return HttpResponse(json.dumps(res), content_type='application/json')


# 发送邮箱验证码
class SendEmailCodeView(LoginRequiredMixin, View):
    def get(self, request):
        email = request.GET.get('email', '')

        res = {}
        if UserProfile.objects.filter(email=email):
            res['email'] = u'邮箱已注册'
            return HttpResponse(json.dumps(res), content_type='application/json')
        send_register_email(email, 'update_email')
        res['status'] = 'success'
        res['msg'] = u'发送验证码成功'
        return HttpResponse(json.dumps(res), content_type='application/json')


# 修改个人邮箱
class UpdateEmailView(LoginRequiredMixin, View):
    def post(self, request):
        email = request.POST.get('email', '')
        code = request.POST.get('code', '')

        existed_records = EmailVerifyRecord.objects.filter(email=email, code=code, send_type='update_email')
        res = {}
        if existed_records:
            user = request.user
            user.email = email
            user.save()
            res['status'] = 'success'
            res['msg'] = u'邮箱修改成功！'
        else:
            res['status'] = 'fail'
            res['msg'] = u'验证码出错！'

        return HttpResponse(json.dumps(res), content_type='application/json')


# 我的课程
class MyCourseView(LoginRequiredMixin, View):
     def get(self, request):
         user_courses = UserCourse.objects.filter(user=request.user)
         return render(request, 'usercenter-mycourse.html', {
             'user_courses': user_courses,
         })


# 我收藏的课程机构
class MyFavOrgView(LoginRequiredMixin, View):
     def get(self, request):
         org_list = []
         fav_orgs = UserFavorite.objects.filter(user=request.user, fav_type=2)
         for fav_org in fav_orgs:
             org_id = fav_org.fav_id
             org = CourseOrg.objects.get(id=org_id)
             org_list.append(org)
         return render(request, 'usercenter-fav-org.html', {
             'org_list': org_list,
         })


# 我收藏的授课讲师
class MyFavTeacherView(LoginRequiredMixin, View):
     def get(self, request):
         teacher_list = []
         fav_teachers = UserFavorite.objects.filter(user=request.user, fav_type=3)
         for fav_teacher in fav_teachers:
             teacher_id = fav_teacher.fav_id
             teacher = Teacher.objects.get(id=teacher_id)
             teacher_list.append(teacher)
         return render(request, 'usercenter-fav-teacher.html', {
             'teacher_list': teacher_list,
         })


# 我收藏的课程
class MyFavCourseView(LoginRequiredMixin, View):
     def get(self, request):
         course_list = []
         fav_courses = UserFavorite.objects.filter(user=request.user, fav_type=1)
         for fav_course in fav_courses:
             course_id = fav_course.fav_id
             course = Course.objects.get(id=course_id)
             course_list.append(course)
         return render(request, 'usercenter-fav-course.html', {
             'course_list': course_list,
         })