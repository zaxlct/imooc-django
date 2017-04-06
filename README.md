# IMOOC
仿照[慕课网](http://www.imooc.com/)搭建的在线编程学习平台


### 如何启动项目
1. 克隆项目
`git clone https://github.com/zaxlct/MxOnline_Django`
2. 下载项目依赖
 `make dev`
3. 创建数据表
 `make migrate`
4. 启动 Django 的 server
 `make run`
### 依赖
- python 3.5
- Django==1.10.5
- Pillow==4.0.0
- PyMySQL==0.7.10
- httplib2==0.10.3
- django-formtools==2.0
- django-crispy-forms==1.6.1


### users
- 邮箱验证码
- 图片轮播

operation 是底层的 app，储存用户操作的内容，比如用户的评论、点赞