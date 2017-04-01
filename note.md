- 继承 django 的 user 表时，要返回 django user 表里的 username
```python
 def __unicode__(self):
        return self.username
```
- setting 里 INSTALL_APPS 下面要加上
`AUTH_USER_MODEL = 'users.UserProfile'`