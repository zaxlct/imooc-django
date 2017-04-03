__author__ = 'zaxlct'
__date__ = '2017/4/3 下午12:29'

from django import forms


class LoginForm(forms.Form):
    username = forms.CharField(required=True)
    password = forms.CharField(required=True, min_length=5)