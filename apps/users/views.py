from django.shortcuts import render
from django.contrib.auth import authenticate, login
from django.contrib.auth.backends import ModelBackend
from django.db.models import Q
from django.views.generic.base import View
from django.contrib.auth.hashers import make_password

from .models import UserProfile, EmailVerifyRecord
from .forms import LoginForm, RegisterForm
from utils.email_send import send_register_email

# Create your views here.

#让用户可以用邮箱登录
class CustomBackend(ModelBackend):
    def authenticate(self, username=None, password=None, **kwargs):
        try:
            user = UserProfile.objects.get(Q(username = username) | Q(email=username))
            if user.check_password(password):
                return user
        except Exception as e:
            return None


# 用户登录
def user_login(request):
    if request.method == 'POST':
        user_name = request.POST.get('username', '')
        password = request.POST.get('password', '')
        # 上面的 authenticate 方法 return user
        user = authenticate(username=user_name, password=password)

        if user is not None:
            if user.is_active:
                login(request, user)
                return render(request, 'index.html')
            return render(request, 'login.html', {'msg': '用户未激活！'})
        return render(request, 'login.html', {'msg': '用户名或者密码错误！'})

    elif request.method == 'GET':
        return render(request, 'login.html')


# 用户登录
class LoginView(View):
    def get(self, request):
        return render(request, 'login.html')

    def post(self, request):
        login_form = LoginForm(request.POST)
        if login_form.is_valid():
            user_name = request.POST.get('username', '')
            password = request.POST.get('password', '')
            # 上面的 authenticate 方法 return user
            user = authenticate(username=user_name, password=password)

            if user is not None:
                login(request, user)
                return render(request, 'index.html')
            return render(request, 'login.html', {'msg': '用户名或者密码错误！'})

        return render(request, 'login.html', {'form_errors': login_form.errors})


# 用户注册
class RegisterView(View):
    def get(self, request):
        # get 请求的时候，把验证码组件一系列的 HTML render 到 register.html 里
        register_form = RegisterForm()
        return render(request, 'register.html', {'register_form': register_form})

    def post(self, request):
        register_form = RegisterForm(request.POST)
        if register_form.is_valid():
            email = request.POST.get('email', '')
            if UserProfile.objects.filter(email=email):
                return render(request, 'register.html', {'msg': '用户已经存在！'})
            password = request.POST.get('password', '')

            user_profile = UserProfile()
            user_profile.username = email
            user_profile.email = email
            user_profile.password = make_password(password)
            user_profile.is_active = False
            user_profile.save()

            send_register_email(email, 'register')
            return render(request, 'send_success.html')

        return render(request, 'register.html', {'register_form': register_form})


# 验证用户注册后，在邮件里点击注册链接
class ActiveUserView(View):
    def get(self, request, active_code):
        # 为什么用 filter ？ 因为用户可能注册了好多次，一个 email 对应了好多个 code
        all_records = EmailVerifyRecord.objects.filter(code=active_code)
        if all_records:
            for records in all_records:
                email = records.email
                user = UserProfile.objects.get(email=email)
                user.is_active = True
                user.save()
        else:
            return render(request, 'active_fail.html')
        return render(request, 'login.html')
