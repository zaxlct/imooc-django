from django.shortcuts import render
from django.contrib.auth import authenticate, login
from django.contrib.auth.backends import ModelBackend
from django.db.models import Q
from django.views.generic.base import View

from .models import UserProfile
from .forms import LoginForm

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


def user_login(request):
    if request.method == 'POST':
        user_name = request.POST.get('username', '')
        password = request.POST.get('password', '')
        # 上面的 authenticate 方法 return user
        user = authenticate(username=user_name, password=password)

        if user is not None:
            login(request, user)
            return render(request, 'index.html')
        return render(request, 'login.html', {'msg': '用户名或者密码错误！'})

    elif request.method == 'GET':
        return render(request, 'login.html')


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
