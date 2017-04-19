# IMOOC
- 仿照[慕课网](http://www.imooc.com/)搭建的在线编程学习平台
- **master 分支是 python 3 环境，其余的所有分支均为 Python 2.7**
- 下面所有的配置只针对 master 分支，其余的分支都是按照课程章节划分的，请按照需求选择分支
- [支持 python 3.5 的 xadmin 安装下载](https://github.com/zaxlct/MxOnline_Django/tree/xadmin-python3)
- [Django + Vue 单页面应用的开发环境搭建](http://www.jianshu.com/p/fe74907e16b9)
- 如果该项目对您有帮助，欢迎 star ：)

### 环境
- Python 3.5
- Django 1.10.5
- xadmin 0.6


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
 2. `settingsdev.py`里的 `DATABASES` 填入你的本地的数据库信息（开发环境），`settings.py` 里填入你服务器的数据库信息（部署环境）。
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

    1. 第一步：点击 Edit Config

    ![点击 Edit Config](http://ww4.sinaimg.cn/large/006tKfTcly1ferrn4bio1j30go04cdge.jpg)

    2. 第二步：点击 环境变量配置

    ![点击 环境变量配置](http://ww2.sinaimg.cn/large/006tNbRwly1ferrozrvchj313q03m3zk.jpg)

    3. 第三步：输入环境变量

    ![输入环境变量](http://ww3.sinaimg.cn/large/006tNbRwly1ferrpwx0kgj30kc044aal.jpg)
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

### python3 的一些坑
`models.py` 里 `def __unicode__(self):` => `def __str__(self):`


### Django 1.10 的一些坑
In Django 1.10 `django.core.context_processors` has been moved to `django.template.context_processors`


## Docker-compose部署(CentOS 7)

### 1.Docker安装
```bash
yum install -y docker
systemctl start docker
chkconfig docker on
```


### 2.Dcoker-compose安装
```bash
yum install -y python-pip
pip install -U daocloud
docker-compose -v
```


### 3.Dowload
```bash
git clone https://github.com/zaxlct/MxOnline_Django.git
```
1. 修改conf/nginx/mx_nginx.conf中的IP或者域名
2. 修改sesttings中数据库配置HOST为mysql


### 4.启动docker-compose
```bash
cd MxOnline_Django/
daocloud up -d
```


### 5.同步数据库
```
daocloud exec kele_imooc /usr/local/bin/python manage.py makemigrations
daocloud exec kele_imooc /usr/local/bin/python manage.py migrate
```


### 6.最后还需要导入你的数据