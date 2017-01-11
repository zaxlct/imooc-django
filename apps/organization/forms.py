# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/11 下午8:36'

import re
from django import forms
from operation.models import UserAsk

# class UserAskForm(forms.Form):
#     name = forms.CharField(required=True, min_length=2, max_length=20)
#     phone = forms.CharField(required=True, min_length=11, max_length=11)
#     course_name = forms.CharField(required=True, min_length=5, max_length=50)


class UserAskForm(forms.ModelForm):
    # 还可以新增字段
    #price = forms.CharField(required=True, min_length=2, max_length=20)

    class Meta:
        model = UserAsk
        fields = ['name', 'mobile', 'course_name']

    def clean_mobile(self):
        mobile = self.cleaned_data['mobile']
        p = re.compile('^0\d{2,3}\d{7,8}$|^1[358]\d{9}$|^147\d{8}')
        if p.match(mobile):
            return mobile
        else:
            raise forms.ValidationError(u' 手机号码非法', code='mobile_inval')