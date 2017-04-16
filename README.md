# IMOOC
- 仿照[慕课网](http://www.imooc.com/)搭建的在线编程学习平台
- **master 分支是 python 3 环境，其余的所有分支均为 Python 2.7**
- 下面所有的配置只针对 master 分支，其余的分支都是按照课程章节划分的，请按照需求选择分支
- 如果该项目对您有帮助，欢迎 star ：)

### 环境
- python 3.5
- django 1.10.5


### 如何启动项目
- 克隆项目
```bash
git clone https://github.com/zaxlct/MxOnline_Django
```


- 下载项目依赖
```bash
make dev
```
 
 
- 配置数据库
 1. 确保你已经安装了 MySQL
 2. `setting.py`里的 `DATABASES` 填入你的本地的数据库信息
 ```python
 # 这是我本机的数据库信息，仅提供参考
 DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'imooc',
        'USER': 'root', 
        'PASSWORD': 'root',
        'HOST': '127.0.0.1',
    }
}
 ```
 
 
- 创建数据表
```bash
make migrate
```

 
- 配置 PyCharm 项目环境变量

第一步
![点击 Edit Config](https://ww2.sinaimg.cn/large/006tNbRwly1fecpi4b3emj30uq08kt9v.jpg)

第二步
![点击 环境变量配置](https://ww1.sinaimg.cn/large/006tKfTcly1fecplahtbzj31480xu446.jpg)

第三步
![输入环境变量](https://ww3.sinaimg.cn/large/006tKfTcly1fecrb0y7p9j30qg062wff.jpg)
```
Name:   DJANGO_SETTINGS_MODULE
Value:  imooc.settingsdev
```


- 启动 Django 的 server
```bash
make run
```
 
 
### `settingsdev.py` 有什么用？
项目上线时 `settings.py` 必须设置 `DEBUG=False`,当 `DEBUG=FALSE`时，Django 不会用自带的 server 去加载 js/css 等静态文件，需要用 nginx 之类的去做静态文件的 server。    

而且 ALLOWED_HOSTS 需要配置本地 IP。这些只有在开发项目时才用到的配置可以放到 `settingsdev.py` 里。
另外项目开发阶段还可以安装辅助插件（比如`django-debug-toolbar`）也能配置到 `settingsdev.py` 里。

** 注意：PyCharm 默认 `settings.py` 为配置文件，所以需要更改一下项目环境变量配置，开发时以  `settingsdev.py` 为准。 **


### Django 操作 MySql 配置
```
# 安装 PyMySQL
pip install PyMySQL

# settings.py
import pymysql
pymysql.install_as_MySQLdb()
```

### 安装支持 python3 的 xadmin
- 复制 `extra_apps` 目录下的 xadmin 到你的项目
- 安装 `httplib2 django-formtools django-crispy-forms`
- `INSTALLED_APPS` 里增加 `xadmin, crispy_forms`
剩下的就和安装 xadmin 步骤一样了，就不啰嗦了


### 为什么我这个 xadmin 支持 python3 ？
说多了都是泪，一行一行的改报错呗


### python3 的一些坑
`models.py` 里 `def __unicode__(self):` => `def __str__(self):`


### Django 1.10 的一些坑
In Django 1.10 `django.core.context_processors` has been moved to `django.template.context_processors`


### TODO 
添加 Docker 配置文件，实现一键 Docker 部署项目

### 其他
[Django + Vue 单页面应用的开发环境搭建](http://www.jianshu.com/p/fe74907e16b9)



 Docker-compose部署(CentOS 7)
-
### 1.Docker安装
- yum install -y docker
- systemctl start docker
- chkconfig docker on 
### 2.Dcoker-compose安装
- yum install -y python-pip
- pip install -U docker-compose
- docker-compose -v
### 3.Dowload
- git clone https://github.com/zaxlct/MxOnline_Django.git
- 修改conf/nginx/mx_nginx.conf中的IP或者域名
- 修改sesttings中数据库配置HOST为mysql
### 4.启动docker-compose
- cd MxOnline_Django/
- docker-compose up -d


### 5.同步数据库
- docker-compose exec kele_imooc /usr/local/bin/python manage.py makemigrations
- docker-compose exec kele_imooc /usr/local/bin/python manage.py migrate

#### 最后还需要导入你的数据