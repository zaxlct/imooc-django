# IMOOC

- 仿照[慕课网](http://www.imooc.com/)搭建的在线编程学习平台
- 下面所有的配置只针对 master 分支，master 分支是 python 3.5 环境，其余的所有分支均为 python 2.7
- [支持 python 3.5 的 xadmin 安装下载方法](https://github.com/zaxlct/MxOnline_Django/tree/xadmin-python3)
- [Django + Vue 单页面应用的开发环境搭建步骤](http://www.jianshu.com/p/fe74907e16b9)
- [Django 使用 QQ邮箱 / 新浪邮箱发送邮件配置](http://www.jianshu.com/p/5c30ff053381)
- [SQL 文件](https://github.com/zaxlct/imooc-django/blob/master/imooc.sql)
- QQ 交流群 163801325（聊天，斗图，学习，交流。伸手党勿进）

### 环境
- Python 3.5
- Django 1.10.5
- xadmin 0.6

### 网站功能
![网站功能脑图](http://ww4.sinaimg.cn/large/006tNbRwly1fetfjhp2xvj318b0qk441.jpg)

### 快速启动该项目
1. 安装 mysql 
2. 安装 python3
3. 建立虚拟环境（可选步骤）
```bash
git clone https://github.com/zaxlct/MxOnline_Django
cd MxOnline_Django
make dev
# 建立一个名为 imooc 数据库
make migrate
make run
```
因为此时数据库为空，所以页面看起来没什么东西，需要手动往数据库里加数据，或者登陆 admin ，添加数据。


### 使用 docker 快速部署/开发项目
 [Linux/Mac/Windos 用 Docker 部署项目步骤](https://github.com/zaxlct/MxOnline_Django/blob/master/Deployment.md)


### Pycharm 启动项目详细步骤
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
项目上线时 `settings.py` 必须设置 `DEBUG=False`，这时 Django 不会用自带的 server 去加载 js/css/img 等静态文件，需要用 nginx 之类的去做静态文件的 server。    
为了避免来回的修改 `setting.py`，项目开发时的配置在 `settingsdev.py` 里，项目部署上线时的配置在 `settings.py` 里。不要随意修改 `setting.py`。

** 注意：PyCharm 默认 `settings.py` 为配置文件，所以才需要配置 PyCharm 项目环境变量 **


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


### xadmin 不支持 Django 1.11
django 1.11 `Lib\site-packages\django\forms\widgets.py` 中已经没有了 `RadioFieldRenderer` 这个类，故 [xadmin-python3](https://github.com/zaxlct/MxOnline_Django/tree/xadmin-python3) 分支只支持到 django 1.10
