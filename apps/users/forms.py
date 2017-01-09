# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/9 下午5:47'

from django import forms


class LoginForm(forms.Form):
    username = forms.CharField(required=True)
    password = forms.CharField(required=True, min_length=5)