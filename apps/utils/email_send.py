# -*- coding: utf-8 -*-
__author__ = 'zaxlct'
__date__ = '2017/1/10 下午3:48'

from random import Random
from django.core.mail import send_mail
import string

from users.models import EmailVerifyRecord
from MxOnline.settings import EMAIL_FROM


def send_register_email(email, send_type='register'):
    email_record = EmailVerifyRecord()
    code = random_str(16)
    email_record.code = code
    email_record.email = email
    email_record.send_type = send_type
    email_record.save()

    email_title = ''
    email_body = ''

    if send_type == 'register':
        email_title = '慕雪在线网注册激活链接'
        email_body = '请点击下面的链接激活你的账号：http://127.0.0.1:8000/active/{0}'.format(code)

        send_status = send_mail(email_title, email_body, EMAIL_FROM, [email])
        if send_status:
            # TODO 提示发送成功
            pass
    elif send_type == 'forget':
        email_title = '慕雪在线网密码重置链接'
        email_body = '请点击下面的链接重置你的密码：http://127.0.0.1:8000/reset/{0}'.format(code)

        send_status = send_mail(email_title, email_body, EMAIL_FROM, [email])
        if send_status:
            # TODO 提示发送成功
            pass


def random_str(randomlength=8):
    str_init = ""
    chars = string.letters + str(string.digits)  # 26个大小写字母加数字
    length = len(chars) - 1
    random = Random()
    for i in range(randomlength):
        str_init += chars[random.randint(0, length)]
    return str_init
