# Linux/Mac/Windos 用 Docker 部署项目步骤

### 1.Docker安装
Linux(CenOS 7)：
```bash
yum install -y docker
systemctl start docker
chkconfig docker on
```
Windows :
- Windows 10 以下推荐使用 Docker Toolbox
Toolbox的介绍和帮助：mirrors.aliyun.com/help/docker-toolbox
Windows系统的安装文件目录：http://mirrors.aliyun.com/docker-toolbox/windows/docker-toolbox/
- Windows 10 以上推荐使用 Docker for Windows
Windows系统的安装文件目录：http://mirrors.aliyun.com/docker-toolbox/windows/docker-for-windows/

Mac :
- 10.10.3 以下推荐使用 Docker Toolbox
Toolbox的介绍和帮助：mirrors.aliyun.com/help/docker-toolbox
Mac系统的安装文件目录：http://mirrors.aliyun.com/docker-toolbox/mac/docker-toolbox/
- 10.10.3以上推荐使用 Docker for Mac
Mac系统的安装文件目录：http://mirrors.aliyun.com/docker-toolbox/mac/docker-for-mac/


### 2.Dcoker-compose安装
```bash
yum install -y python-pip
pip install -U docker-compose

# Win/ Mac 用户从这里开始执行
git clone https://github.com/zaxlct/MxOnline_Django.git
cd MxOnline_Django
docker-compose -v
```


### 3.修改配置文件
1. 修改 `conf/nginx/mx_nginx.conf` 中的 IP 和域名，默认都是 `127.0.0.1`
2. `settings.py` 中 `DATABASES` 配置要和 `docker-compose.yml`里的数据库配置保持一致（可以不做修改使用默认值），其中 HOST 为 `mysql`。


### 4.启动项目
```bash
docker-compose up -d
```


### 5.同步数据库
```
docker-compose exec kele_imooc /usr/local/bin/python manage.py makemigrations
docker-compose exec kele_imooc /usr/local/bin/python manage.py migrate
```
如果浏览器打开 `127.0.0.1` 或者打开你自己配置的域名 or IP，就能预览项目了。

### 6.最后还需要导入你的数据

---

当然你本地也可以用 Docker 作为开发环境，这个时候应使用应修改 `manage.py`, 使用 `settingsdev.py` 而不是 `settings.py`。