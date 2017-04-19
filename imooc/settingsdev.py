from .settings import *

# DEBUG=False 不会用自带的 server 去 server js/css 等静态文件
# 需要用 nginx 之类的去做静态文件的 server.
DEBUG = True
INTERNAL_IPS = ['127.0.0.1']
ALLOWED_HOSTS += INTERNAL_IPS
ALLOWED_HOSTS.append('localhost')

# 重置 setting 里的 STATIC_ROOT 配置
STATIC_ROOT = ''

# static 目录配置
# 如果 DEBUG 为 False 这里就会失效，需要用 NGIX 代理
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]

INSTALLED_APPS.append('debug_toolbar')
MIDDLEWARE.append('debug_toolbar.middleware.DebugToolbarMiddleware')

# 请按照你开发时本机的数据库名字，密码，端口填写
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'imooc',
        'USER': 'root',
        'PASSWORD': 'root',
        'HOST': '127.0.0.1',
    }
}