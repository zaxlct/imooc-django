/*
Navicat MySQL Data Transfer

Source Server         : testdjango
Source Server Version : 50096
Source Host           : localhost:3306
Source Database       : mxonline

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2016-12-11 23:28:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES ('1', '编辑部门');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
INSERT INTO `auth_group_permissions` VALUES ('1', '1', '37');
INSERT INTO `auth_group_permissions` VALUES ('2', '1', '38');
INSERT INTO `auth_group_permissions` VALUES ('3', '1', '72');
INSERT INTO `auth_group_permissions` VALUES ('4', '1', '75');
INSERT INTO `auth_group_permissions` VALUES ('5', '1', '28');
INSERT INTO `auth_group_permissions` VALUES ('6', '1', '29');

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`)
) ENGINE=MyISAM AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('20', 'Can change 用户信息', '7', 'change_userprofile');
INSERT INTO `auth_permission` VALUES ('19', 'Can add 用户信息', '7', 'add_userprofile');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete 用户信息', '7', 'delete_userprofile');
INSERT INTO `auth_permission` VALUES ('22', 'Can add 邮箱验证码', '8', 'add_emailverifyrecord');
INSERT INTO `auth_permission` VALUES ('23', 'Can change 邮箱验证码', '8', 'change_emailverifyrecord');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete 邮箱验证码', '8', 'delete_emailverifyrecord');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 轮播图', '9', 'add_banner');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 轮播图', '9', 'change_banner');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 轮播图', '9', 'delete_banner');
INSERT INTO `auth_permission` VALUES ('28', 'Can add 课程', '10', 'add_course');
INSERT INTO `auth_permission` VALUES ('29', 'Can change 课程', '10', 'change_course');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete 课程', '10', 'delete_course');
INSERT INTO `auth_permission` VALUES ('31', 'Can add 章节', '11', 'add_lesson');
INSERT INTO `auth_permission` VALUES ('32', 'Can change 章节', '11', 'change_lesson');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete 章节', '11', 'delete_lesson');
INSERT INTO `auth_permission` VALUES ('34', 'Can add 视频', '12', 'add_video');
INSERT INTO `auth_permission` VALUES ('35', 'Can change 视频', '12', 'change_video');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete 视频', '12', 'delete_video');
INSERT INTO `auth_permission` VALUES ('37', 'Can add 课程资源', '13', 'add_courseresource');
INSERT INTO `auth_permission` VALUES ('38', 'Can change 课程资源', '13', 'change_courseresource');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete 课程资源', '13', 'delete_courseresource');
INSERT INTO `auth_permission` VALUES ('40', 'Can add 城市', '14', 'add_citydict');
INSERT INTO `auth_permission` VALUES ('41', 'Can change 城市', '14', 'change_citydict');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete 城市', '14', 'delete_citydict');
INSERT INTO `auth_permission` VALUES ('43', 'Can add 课程机构', '15', 'add_courseorg');
INSERT INTO `auth_permission` VALUES ('44', 'Can change 课程机构', '15', 'change_courseorg');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete 课程机构', '15', 'delete_courseorg');
INSERT INTO `auth_permission` VALUES ('46', 'Can add 教师', '16', 'add_teacher');
INSERT INTO `auth_permission` VALUES ('47', 'Can change 教师', '16', 'change_teacher');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete 教师', '16', 'delete_teacher');
INSERT INTO `auth_permission` VALUES ('49', 'Can add 用户咨询', '17', 'add_userask');
INSERT INTO `auth_permission` VALUES ('50', 'Can change 用户咨询', '17', 'change_userask');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete 用户咨询', '17', 'delete_userask');
INSERT INTO `auth_permission` VALUES ('52', 'Can add 课程评论', '18', 'add_coursecomments');
INSERT INTO `auth_permission` VALUES ('53', 'Can change 课程评论', '18', 'change_coursecomments');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete 课程评论', '18', 'delete_coursecomments');
INSERT INTO `auth_permission` VALUES ('55', 'Can add 用户收藏', '19', 'add_userfavorite');
INSERT INTO `auth_permission` VALUES ('56', 'Can change 用户收藏', '19', 'change_userfavorite');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete 用户收藏', '19', 'delete_userfavorite');
INSERT INTO `auth_permission` VALUES ('58', 'Can add 用户消息', '20', 'add_usermessage');
INSERT INTO `auth_permission` VALUES ('59', 'Can change 用户消息', '20', 'change_usermessage');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete 用户消息', '20', 'delete_usermessage');
INSERT INTO `auth_permission` VALUES ('61', 'Can add 用户课程', '21', 'add_usercourse');
INSERT INTO `auth_permission` VALUES ('62', 'Can change 用户课程', '21', 'change_usercourse');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete 用户课程', '21', 'delete_usercourse');
INSERT INTO `auth_permission` VALUES ('64', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('65', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('66', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('67', 'Can view 用户信息', '7', 'view_userprofile');
INSERT INTO `auth_permission` VALUES ('68', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('69', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('70', 'Can view 邮箱验证码', '8', 'view_emailverifyrecord');
INSERT INTO `auth_permission` VALUES ('71', 'Can view 轮播图', '9', 'view_banner');
INSERT INTO `auth_permission` VALUES ('72', 'Can view 课程', '10', 'view_course');
INSERT INTO `auth_permission` VALUES ('73', 'Can view 章节', '11', 'view_lesson');
INSERT INTO `auth_permission` VALUES ('74', 'Can view 视频', '12', 'view_video');
INSERT INTO `auth_permission` VALUES ('75', 'Can view 课程资源', '13', 'view_courseresource');
INSERT INTO `auth_permission` VALUES ('76', 'Can view 城市', '14', 'view_citydict');
INSERT INTO `auth_permission` VALUES ('77', 'Can view 课程机构', '15', 'view_courseorg');
INSERT INTO `auth_permission` VALUES ('78', 'Can view 教师', '16', 'view_teacher');
INSERT INTO `auth_permission` VALUES ('79', 'Can view 用户咨询', '17', 'view_userask');
INSERT INTO `auth_permission` VALUES ('80', 'Can view 课程评论', '18', 'view_coursecomments');
INSERT INTO `auth_permission` VALUES ('81', 'Can view 用户收藏', '19', 'view_userfavorite');
INSERT INTO `auth_permission` VALUES ('82', 'Can view 用户消息', '20', 'view_usermessage');
INSERT INTO `auth_permission` VALUES ('83', 'Can view 用户课程', '21', 'view_usercourse');
INSERT INTO `auth_permission` VALUES ('84', 'Can add Bookmark', '22', 'add_bookmark');
INSERT INTO `auth_permission` VALUES ('85', 'Can change Bookmark', '22', 'change_bookmark');
INSERT INTO `auth_permission` VALUES ('86', 'Can delete Bookmark', '22', 'delete_bookmark');
INSERT INTO `auth_permission` VALUES ('87', 'Can add User Setting', '23', 'add_usersettings');
INSERT INTO `auth_permission` VALUES ('88', 'Can change User Setting', '23', 'change_usersettings');
INSERT INTO `auth_permission` VALUES ('89', 'Can delete User Setting', '23', 'delete_usersettings');
INSERT INTO `auth_permission` VALUES ('90', 'Can add User Widget', '24', 'add_userwidget');
INSERT INTO `auth_permission` VALUES ('91', 'Can change User Widget', '24', 'change_userwidget');
INSERT INTO `auth_permission` VALUES ('92', 'Can delete User Widget', '24', 'delete_userwidget');
INSERT INTO `auth_permission` VALUES ('93', 'Can view Bookmark', '22', 'view_bookmark');
INSERT INTO `auth_permission` VALUES ('94', 'Can view User Setting', '23', 'view_usersettings');
INSERT INTO `auth_permission` VALUES ('95', 'Can view User Widget', '24', 'view_userwidget');
INSERT INTO `auth_permission` VALUES ('124', 'Can view log entry', '35', 'view_log');
INSERT INTO `auth_permission` VALUES ('123', 'Can delete log entry', '35', 'delete_log');
INSERT INTO `auth_permission` VALUES ('122', 'Can change log entry', '35', 'change_log');
INSERT INTO `auth_permission` VALUES ('105', 'Can add captcha store', '28', 'add_captchastore');
INSERT INTO `auth_permission` VALUES ('106', 'Can change captcha store', '28', 'change_captchastore');
INSERT INTO `auth_permission` VALUES ('107', 'Can delete captcha store', '28', 'delete_captchastore');
INSERT INTO `auth_permission` VALUES ('108', 'Can view captcha store', '28', 'view_captchastore');
INSERT INTO `auth_permission` VALUES ('113', 'Can add 轮播课程', '10', 'add_bannercourse');
INSERT INTO `auth_permission` VALUES ('112', 'Can view 轮播课程', '32', 'view_bannercourse');
INSERT INTO `auth_permission` VALUES ('114', 'Can change 轮播课程', '10', 'change_bannercourse');
INSERT INTO `auth_permission` VALUES ('115', 'Can delete 轮播课程', '10', 'delete_bannercourse');
INSERT INTO `auth_permission` VALUES ('121', 'Can add log entry', '35', 'add_log');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL auto_increment,
  `password` varchar(128) NOT NULL,
  `last_login` datetime default NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for captcha_captchastore
-- ----------------------------
DROP TABLE IF EXISTS `captcha_captchastore`;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL auto_increment,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=MyISAM AUTO_INCREMENT=225 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of captcha_captchastore
-- ----------------------------
INSERT INTO `captcha_captchastore` VALUES ('224', 'TCKN', 'tckn', '2dd1244f8efca32bd489f1eeba39b893dff1a142', '2016-11-13 12:16:48');
INSERT INTO `captcha_captchastore` VALUES ('223', 'MGNX', 'mgnx', 'bf9b28c64c0940805d013f2a6b38fba914a71f6f', '2016-11-13 12:16:43');

-- ----------------------------
-- Table structure for courses_course
-- ----------------------------
DROP TABLE IF EXISTS `courses_course`;
CREATE TABLE `courses_course` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `desc` varchar(300) NOT NULL,
  `detail` longtext NOT NULL,
  `degree` varchar(2) NOT NULL,
  `learn_times` int(11) NOT NULL,
  `students` int(11) NOT NULL,
  `fav_nums` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `click_nums` int(11) NOT NULL,
  `add_time` datetime NOT NULL,
  `course_org_id` int(11),
  `category` varchar(20) NOT NULL,
  `tag` varchar(10) NOT NULL,
  `teacher_id` int(11),
  `teacher_tell` varchar(300) NOT NULL,
  `youneed_know` varchar(300) NOT NULL,
  `is_banner` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `courses_course_11456c5a` (`course_org_id`),
  KEY `courses_course_d9614d40` (`teacher_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of courses_course
-- ----------------------------
INSERT INTO `courses_course` VALUES ('1', 'django入门', 'django入门', '<p><br/> </p><h1 label=\"Title center\" name=\"tc\" style=\"border-bottom-color:#cccccc;border-bottom-width:2px;border-bottom-style:solid;padding:0px 4px 0px 0px;text-align:center;margin:0px 0px 20px;\" class=\"ue_t\">[此处键入文章标题]</h1><p><img src=\"http://img.baidu.com/hi/youa/y_0034.gif\" style=\"width:300px;height:200px;float:left;\" width=\"300\" vspace=\"0\" hspace=\"0\" height=\"200\" border=\"0\"/>图文混排方法</p><p>1. 图片居左，文字围绕图片排版</p><p>方法：在文字前面插入图片，设置居左对齐，然后即可在右边输入多行文本</p><p><br/> </p><p>2. 图片居右，文字围绕图片排版</p><p>方法：在文字前面插入图片，设置居右对齐，然后即可在左边输入多行文本</p><p><br/> </p><p>3. 图片居中环绕排版</p><p>方法：亲，这个真心没有办法。。。</p><p><br/> </p><p><br/> </p><p><img src=\"http://img.baidu.com/hi/youa/y_0040.gif\" style=\"width:300px;height:300px;float:right;\" width=\"300\" vspace=\"0\" hspace=\"0\" height=\"300\" border=\"0\"/> </p><p>还有没有什么其他的环绕方式呢？这里是居右环绕</p><p><br/> </p><p>欢迎大家多多尝试，为UEditor提供更多高质量模板！</p><p><br/> </p><p>占位</p><p><br/> </p><p>占位</p><p><br/> </p><p>占位</p><p><br/> </p><p>占位</p><p><br/> </p><p>占位</p><p><br/> </p><p><br/> </p><p><br/> </p>', 'cj', '0', '3', '0', 'courses/2016/11/mysql.jpg', '6', '2016-10-25 23:40:00', '1', '后端开发', 'django开发', null, 'django开发', 'django开发', '0');
INSERT INTO `courses_course` VALUES ('2', 'java入门', 'java入门', 'java入门java入门java入门java入门java入门\r\n\r\njava入门java入门\r\njava入门', 'zj', '20', '0', '0', 'courses/2016/11/57035ff200014b8a06000338-240-135.jpg', '0', '2016-11-05 16:04:00', '2', '后端开发', '', null, '', '', '0');
INSERT INTO `courses_course` VALUES ('3', 'python入门', 'python入门', 'python入门python入门python入门python入门python入门', 'zj', '0', '0', '0', 'courses/2016/11/540e57300001d6d906000338-240-135.jpg', '0', '2016-11-05 16:07:00', '4', '后端开发', '', null, '', '', '0');
INSERT INTO `courses_course` VALUES ('4', 'java入门2', 'java入门2', 'java入门2java入门2java入门2\r\njava入门2\r\njava入门2\r\njava入门2\r\njava入门2', 'gj', '0', '0', '0', 'courses/2016/11/57035ff200014b8a06000338-240-135_dHfj8Nq.jpg', '2', '2016-11-05 16:08:00', '5', '后端开发', '', null, '', '', '0');
INSERT INTO `courses_course` VALUES ('5', 'java入门3', 'java入门3', 'java入门3\r\njava入门3\r\njava入门3\r\njava入门3\r\njava入门3', 'cj', '0', '1', '0', 'courses/2016/11/57035ff200014b8a06000338-240-135_0nFiBSI.jpg', '1', '2016-11-05 16:08:00', '6', '后端开发', '', null, '', '', '0');
INSERT INTO `courses_course` VALUES ('6', 'python入门2', 'python入门2', 'python入门2\r\npython入门2\r\npython入门2\r\npython入门2\r\npython入门2\r\npython入门2', 'zj', '0', '0', '0', 'courses/2016/11/540e57300001d6d906000338-240-135_MSIqfvw.jpg', '0', '2016-11-05 16:08:00', '10', '后端开发', '', null, '', '', '0');
INSERT INTO `courses_course` VALUES ('7', 'django与vuejs实战项目', 'python入门2', '<p>&nbsp; &nbsp; python入门2\r\npython入门2\r\npython入门2\r\npython入门2\r\npython入门2</p>', 'zj', '0', '2', '0', 'courses/2016/11/540e57300001d6d906000338-240-135_Z3HIQ2t.jpg', '7', '2016-11-05 16:09:00', '2', '后端开发', '前端开发', null, 'go语言', '前端开发', '1');
INSERT INTO `courses_course` VALUES ('8', 'django实战项目', 'django实战项目', 'django实战项目\r\ndjango实战项目\r\ndjango实战项目\r\ndjango实战项目\r\ndjango实战项目\r\ndjango实战项目', 'zj', '0', '0', '0', 'courses/2016/11/540e57300001d6d906000338-240-135_mvvGYHL.jpg', '1', '2016-11-05 16:09:00', '1', '后端开发', 'python', null, '', '', '0');
INSERT INTO `courses_course` VALUES ('9', 'go语言入门', 'django实战项目', 'django实战项目\r\ndjango实战项目\r\ndjango实战项目\r\ndjango实战项目', 'zj', '0', '1', '0', 'courses/2016/11/540e57300001d6d906000338-240-135_wH52IED.jpg', '13', '2016-11-05 16:10:00', '2', '后端开发', 'go语言', null, 'go语言', 'go语言', '1');
INSERT INTO `courses_course` VALUES ('10', 'django与vuejs实战项目2', 'django与vuejs实战项目', '<p>&nbsp; &nbsp; django与vuejs实战项目</p><p><img src=\"/media/courses/ueditor/aobama_20161113225044_773.png\" title=\"\" alt=\"aobama.png\"/> </p><table><tbody><tr class=\"firstRow\"><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">课程</td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">课时<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">难度<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">时长<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">学习人数<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">点击数<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">点击数</td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">点击数</td></tr><tr><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">django开发<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">20<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">中级<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">30<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">100000<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">100000<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">100000<br/> </td><td style=\"word-break: break-all;\" width=\"53\" valign=\"top\">100000<br/> </td></tr><tr><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td></tr><tr><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td></tr><tr><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td></tr><tr><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td><td width=\"53\" valign=\"top\"><br/> </td></tr></tbody></table><p><br/> </p><p><img src=\"http://img.baidu.com/hi/jx2/j_0025.gif\"/> </p><p><br/> </p><h1 class=\"ue_t\" label=\"Title center\" name=\"tc\" style=\"border-bottom-color:#cccccc;border-bottom-width:2px;border-bottom-style:solid;padding:0px 4px 0px 0px;text-align:center;margin:0px 0px 20px;\"><span style=\"color:#c0504d;\">[键入文档标题]</span></h1><p style=\"text-align:center;\"><strong class=\"ue_t\">[键入文档副标题]</strong></p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 1]</span></h3><p class=\"ue_t\" style=\"text-indent:2em;\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p class=\"ue_t\" style=\"text-indent:2em;\"><img src=\"http://127.0.0.1:8000/media/courses/ueditor/57aa86a0000145c512000460_20161210234050_865.jpg\" title=\"\" alt=\"57aa86a0000145c512000460.jpg\"/> </p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 2]</span></h3><p><img src=\"http://api.map.baidu.com/staticimage?center=116.410899,39.863624&zoom=11&width=530&height=340&markers=116.404,39.915\" width=\"530\" height=\"340\"/> </p><p class=\"ue_t\" style=\"text-indent:2em;\">在“开始”选项卡上，通过从快速样式库中为所选文本选择一种外观，您可以方便地更改文档中所选文本的格式。 您还可以使用“开始”选项卡上的其他控件来直接设置文本格式。大多数控件都允许您选择是使用当前主题外观，还是使用某种直接指定的格式。</p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 3]</span></h3><p>2016-12-10</p><p class=\"ue_t\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p><br/> </p>', 'gj', '0', '10', '0', 'courses/2016/11/540e57300001d6d906000338-240-135_n0L8vbw.jpg', '102', '2016-11-05 16:10:00', '2', '后端开发', 'python', '1', 'django的进阶开发', 'python基础你需要有', '0');
INSERT INTO `courses_course` VALUES ('11', '前端开发', '前端开发', '前端开发', 'cj', '0', '0', '0', 'courses/2016/11/default_middile_1.png', '3', '2016-11-09 00:01:00', '1', '后端开发', '前端开发', '2', '前端开发', '前端开发', '0');
INSERT INTO `courses_course` VALUES ('12', 'scrapy教程', 'scrapy教程scrapy教程scrapy教程scrapy教程scrapy教程scrapy教程', '<h1 class=\"ue_t\" label=\"Title center\" name=\"tc\" style=\"border-bottom-color:#cccccc;border-bottom-width:2px;border-bottom-style:solid;padding:0px 4px 0px 0px;text-align:center;margin:0px 0px 20px;\"><span style=\"color:#c0504d;\">[键入文档标题]</span></h1><p style=\"text-align:center;\"><strong class=\"ue_t\">[键入文档副标题]</strong></p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 1]</span></h3><p class=\"ue_t\" style=\"text-indent:2em;\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p class=\"ue_t\" style=\"text-indent:2em;\"><img src=\"/media/courses/ueditor/57aa86a0000145c512000460_20161210234050_865.jpg\" title=\"\" alt=\"57aa86a0000145c512000460.jpg\"/> </p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 2]</span></h3><p><img src=\"http://api.map.baidu.com/staticimage?center=116.410899,39.863624&zoom=11&width=530&height=340&markers=116.404,39.915\" width=\"530\" height=\"340\"/> </p><p class=\"ue_t\" style=\"text-indent:2em;\">在“开始”选项卡上，通过从快速样式库中为所选文本选择一种外观，您可以方便地更改文档中所选文本的格式。 您还可以使用“开始”选项卡上的其他控件来直接设置文本格式。大多数控件都允许您选择是使用当前主题外观，还是使用某种直接指定的格式。</p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 3]</span></h3><p>2016-12-10</p><p class=\"ue_t\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p class=\"ue_t\"><br/> </p><p><br/> </p>', 'zj', '55', '0', '1', 'courses/2016/12/57035ff200014b8a06000338-240-135_dHfj8Nq.jpg', '3', '2016-12-10 23:39:00', '2', '后端开发', 'django开发', null, '前端开发', 'django开发', '0');
INSERT INTO `courses_course` VALUES ('13', 'xadmin进阶开发', 'xadmin进阶开发xadmin进阶开发xadmin进阶开发xadmin进阶开发', '<h1 class=\"ue_t\" label=\"Title center\" name=\"tc\" style=\"border-bottom-color:#cccccc;border-bottom-width:2px;border-bottom-style:solid;padding:0px 4px 0px 0px;text-align:center;margin:0px 0px 20px;\"><span style=\"color:#c0504d;\">[键入文档标题]</span></h1><p style=\"text-align:center;\"><strong class=\"ue_t\">[键入文档副标题]</strong></p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 1]</span></h3><p class=\"ue_t\" style=\"text-indent:2em;\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p class=\"ue_t\" style=\"text-indent:2em;\"><img src=\"http://127.0.0.1:8000/media/courses/ueditor/57aa86a0000145c512000460_20161210234050_865.jpg\" title=\"\" alt=\"57aa86a0000145c512000460.jpg\"/> </p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 2]</span></h3><p><img src=\"http://api.map.baidu.com/staticimage?center=116.410899,39.863624&zoom=11&width=530&height=340&markers=116.404,39.915\" width=\"530\" height=\"340\"/> </p><p class=\"ue_t\" style=\"text-indent:2em;\">在“开始”选项卡上，通过从快速样式库中为所选文本选择一种外观，您可以方便地更改文档中所选文本的格式。 您还可以使用“开始”选项卡上的其他控件来直接设置文本格式。大多数控件都允许您选择是使用当前主题外观，还是使用某种直接指定的格式。</p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 3]</span></h3><p>2016-12-10</p><p class=\"ue_t\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p class=\"ue_t\"><br/> </p><p><br/></p>', 'zj', '30', '1', '1', 'courses/2016/12/mysql.jpg', '4', '2016-12-10 23:43:00', '1', '后端开发', 'django开发', '1', 'django开发', 'django开发', '0');

-- ----------------------------
-- Table structure for courses_courseresource
-- ----------------------------
DROP TABLE IF EXISTS `courses_courseresource`;
CREATE TABLE `courses_courseresource` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `download` varchar(100) NOT NULL,
  `add_time` datetime NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `courses_courseresource_ea134da7` (`course_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of courses_courseresource
-- ----------------------------
INSERT INTO `courses_courseresource` VALUES ('1', '前端页面', 'course/resource/2016/11/media.zip', '2016-11-05 22:13:00', '10');
INSERT INTO `courses_courseresource` VALUES ('2', '前端页面', 'course/resource/2016/11/curl_wget.rar', '2016-11-09 00:01:00', '11');

-- ----------------------------
-- Table structure for courses_lesson
-- ----------------------------
DROP TABLE IF EXISTS `courses_lesson`;
CREATE TABLE `courses_lesson` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `add_time` datetime NOT NULL,
  `course_id` int(11) NOT NULL,
  `learn_times` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `courses_lesson_ea134da7` (`course_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of courses_lesson
-- ----------------------------
INSERT INTO `courses_lesson` VALUES ('1', '第一章 django基础知识', '2016-10-25 23:44:00', '1', '20');
INSERT INTO `courses_lesson` VALUES ('2', '第一章 基础知识', '2016-11-05 21:50:00', '10', '0');
INSERT INTO `courses_lesson` VALUES ('3', '第二章 进阶开发', '2016-11-05 21:50:00', '10', '0');
INSERT INTO `courses_lesson` VALUES ('4', '第一章', '2016-11-09 00:01:00', '11', '10');
INSERT INTO `courses_lesson` VALUES ('5', '第二章 django url配置', '2016-12-10 23:32:00', '1', '30');
INSERT INTO `courses_lesson` VALUES ('6', '第三章 django model配置和编码', '2016-12-10 23:32:00', '1', '50');
INSERT INTO `courses_lesson` VALUES ('7', '第三章 需求分析和数据库设计', '2016-12-11 00:00:00', '10', '200');
INSERT INTO `courses_lesson` VALUES ('8', '第四章 django基础知识回顾', '2016-12-11 00:00:00', '10', '30');
INSERT INTO `courses_lesson` VALUES ('9', '第五章 通过xadmin搭建后台管理系统', '2016-12-11 00:01:00', '10', '60');

-- ----------------------------
-- Table structure for courses_video
-- ----------------------------
DROP TABLE IF EXISTS `courses_video`;
CREATE TABLE `courses_video` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `add_time` datetime NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `url` varchar(200) NOT NULL,
  `learn_times` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `courses_video_55174b7b` (`lesson_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of courses_video
-- ----------------------------
INSERT INTO `courses_video` VALUES ('1', '1.1 hello world', '2016-11-05 21:59:00', '2', 'http://www.imooc.com/video/1430', '0');
INSERT INTO `courses_video` VALUES ('2', '1.2 基本概念', '2016-11-05 22:02:00', '2', 'http://www.imooc.com/video/1430', '0');
INSERT INTO `courses_video` VALUES ('3', '2.1 test', '2016-11-05 22:02:00', '3', 'http://www.imooc.com/video/1430', '0');
INSERT INTO `courses_video` VALUES ('4', '2.2 test2', '2016-11-05 22:02:00', '3', 'http://www.imooc.com/video/1430', '0');
INSERT INTO `courses_video` VALUES ('5', 'django settings.py 配置', '2016-12-10 23:35:00', '2', 'http://imooc.com/', '0');
INSERT INTO `courses_video` VALUES ('6', '3.1 django app设计', '2016-12-11 00:01:00', '7', 'http://imooc.com/', '0');
INSERT INTO `courses_video` VALUES ('7', '3.2 django model设计', '2016-12-11 00:02:00', '7', 'http://imooc.com/', '0');
INSERT INTO `courses_video` VALUES ('8', '3.3 django users models设计', '2016-12-11 00:02:00', '7', 'http://imooc.com/', '0');
INSERT INTO `courses_video` VALUES ('9', '3.4 django course models设计', '2016-12-11 00:02:00', '7', 'http://imooc.com/', '0');
INSERT INTO `courses_video` VALUES ('10', '3.5 organization models设计', '2016-12-11 00:02:00', '7', 'http://imooc.com/', '0');
INSERT INTO `courses_video` VALUES ('11', '4.1 django settings配置', '2016-12-11 00:03:00', '8', 'http://imooc.com/', '0');
INSERT INTO `courses_video` VALUES ('12', '4.2 models设计', '2016-12-11 00:04:00', '8', 'http://imooc.com/', '20');
INSERT INTO `courses_video` VALUES ('13', '5.1 django admin讲解', '2016-12-11 00:05:00', '9', 'http://imooc.com/', '10');
INSERT INTO `courses_video` VALUES ('14', '5.2 xadmin的安装和注册', '2016-12-11 00:05:00', '9', 'http://imooc.com/', '0');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL auto_increment,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) default NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2016-10-24 23:41:17', '3', 'bobby1', '1', '已添加。', '7', '2');

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL auto_increment,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('7', 'users', 'userprofile');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('8', 'users', 'emailverifyrecord');
INSERT INTO `django_content_type` VALUES ('9', 'users', 'banner');
INSERT INTO `django_content_type` VALUES ('10', 'courses', 'course');
INSERT INTO `django_content_type` VALUES ('11', 'courses', 'lesson');
INSERT INTO `django_content_type` VALUES ('12', 'courses', 'video');
INSERT INTO `django_content_type` VALUES ('13', 'courses', 'courseresource');
INSERT INTO `django_content_type` VALUES ('14', 'organization', 'citydict');
INSERT INTO `django_content_type` VALUES ('15', 'organization', 'courseorg');
INSERT INTO `django_content_type` VALUES ('16', 'organization', 'teacher');
INSERT INTO `django_content_type` VALUES ('17', 'operation', 'userask');
INSERT INTO `django_content_type` VALUES ('18', 'operation', 'coursecomments');
INSERT INTO `django_content_type` VALUES ('19', 'operation', 'userfavorite');
INSERT INTO `django_content_type` VALUES ('20', 'operation', 'usermessage');
INSERT INTO `django_content_type` VALUES ('21', 'operation', 'usercourse');
INSERT INTO `django_content_type` VALUES ('22', 'xadmin', 'bookmark');
INSERT INTO `django_content_type` VALUES ('23', 'xadmin', 'usersettings');
INSERT INTO `django_content_type` VALUES ('24', 'xadmin', 'userwidget');
INSERT INTO `django_content_type` VALUES ('35', 'xadmin', 'log');
INSERT INTO `django_content_type` VALUES ('28', 'captcha', 'captchastore');
INSERT INTO `django_content_type` VALUES ('32', 'courses', 'bannercourse');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL auto_increment,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2016-10-18 15:47:48');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2016-10-18 15:47:51');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2016-10-18 15:47:51');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2016-10-18 15:47:52');
INSERT INTO `django_migrations` VALUES ('12', 'sessions', '0001_initial', '2016-10-18 15:47:53');
INSERT INTO `django_migrations` VALUES ('13', 'users', '0001_initial', '2016-10-18 16:36:59');
INSERT INTO `django_migrations` VALUES ('14', 'courses', '0001_initial', '2016-10-20 15:01:04');
INSERT INTO `django_migrations` VALUES ('15', 'operation', '0001_initial', '2016-10-20 15:01:05');
INSERT INTO `django_migrations` VALUES ('16', 'organization', '0001_initial', '2016-10-20 15:01:05');
INSERT INTO `django_migrations` VALUES ('17', 'users', '0002_banner_emailverifyrecord', '2016-10-20 15:01:05');
INSERT INTO `django_migrations` VALUES ('18', 'users', '0003_auto_20161024_2337', '2016-10-24 23:37:30');
INSERT INTO `django_migrations` VALUES ('20', 'users', '0004_auto_20161025_2122', '2016-10-25 21:22:31');
INSERT INTO `django_migrations` VALUES ('66', 'xadmin', '0001_initial', '2016-12-11 22:14:16');
INSERT INTO `django_migrations` VALUES ('67', 'xadmin', '0002_log', '2016-12-11 22:20:34');
INSERT INTO `django_migrations` VALUES ('68', 'xadmin', '0003_auto_20160715_0100', '2016-12-11 22:20:34');
INSERT INTO `django_migrations` VALUES ('34', 'captcha', '0001_initial', '2016-10-30 19:28:47');
INSERT INTO `django_migrations` VALUES ('35', 'courses', '0002_auto_20161030_1928', '2016-10-30 19:28:47');
INSERT INTO `django_migrations` VALUES ('36', 'organization', '0002_auto_20161102_2224', '2016-11-02 22:24:13');
INSERT INTO `django_migrations` VALUES ('37', 'organization', '0003_auto_20161103_0056', '2016-11-03 00:56:15');
INSERT INTO `django_migrations` VALUES ('38', 'courses', '0003_course_course_org', '2016-11-03 23:47:26');
INSERT INTO `django_migrations` VALUES ('39', 'organization', '0004_auto_20161104_0022', '2016-11-04 00:22:45');
INSERT INTO `django_migrations` VALUES ('40', 'organization', '0005_auto_20161104_0024', '2016-11-04 00:24:28');
INSERT INTO `django_migrations` VALUES ('41', 'courses', '0004_course_category', '2016-11-05 17:32:04');
INSERT INTO `django_migrations` VALUES ('42', 'courses', '0005_course_tag', '2016-11-05 18:01:24');
INSERT INTO `django_migrations` VALUES ('44', 'courses', '0006_video_url', '2016-11-05 21:58:18');
INSERT INTO `django_migrations` VALUES ('45', 'courses', '0007_lesson_learn_times', '2016-11-05 22:10:32');
INSERT INTO `django_migrations` VALUES ('46', 'courses', '0008_video_learn_times', '2016-11-05 22:12:35');
INSERT INTO `django_migrations` VALUES ('47', 'courses', '0009_course_teacher', '2016-11-05 22:21:01');
INSERT INTO `django_migrations` VALUES ('48', 'courses', '0010_auto_20161105_2226', '2016-11-05 22:26:40');
INSERT INTO `django_migrations` VALUES ('49', 'organization', '0006_teacher_age', '2016-11-06 00:14:12');
INSERT INTO `django_migrations` VALUES ('50', 'users', '0005_auto_20161106_2007', '2016-11-06 20:07:07');
INSERT INTO `django_migrations` VALUES ('51', 'courses', '0011_course_is_banner', '2016-11-07 22:52:51');
INSERT INTO `django_migrations` VALUES ('52', 'organization', '0007_courseorg_tag', '2016-11-07 23:18:16');
INSERT INTO `django_migrations` VALUES ('53', 'courses', '0012_auto_20161113_1724', '2016-11-13 17:25:05');
INSERT INTO `django_migrations` VALUES ('54', 'courses', '0013_remove_course_detail2', '2016-11-13 21:03:02');
INSERT INTO `django_migrations` VALUES ('55', 'courses', '0014_auto_20161113_2218', '2016-11-13 22:18:55');
INSERT INTO `django_migrations` VALUES ('56', 'organization', '0008_auto_20161210_2353', '2016-12-10 23:53:24');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY  (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('2jam9b4q6flchzg7g3z43j9akxu7iio3', 'ODFkYTY2NzI2Y2EyYmNmZTQ2MzliZTg0NjZhNTQ0ZDVhMDg3NjI2Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6InVzZXJzLnZpZXdzLkN1c3RvbUJhY2tlbmQiLCJMSVNUX1FVRVJZIjpbWyJvcmdhbml6YXRpb24iLCJjb3Vyc2VvcmciXSwiIl0sIl9hdXRoX3VzZXJfaGFzaCI6IjRlZThlMGU2NWRmNmFkOGRkMTlkYjA2Y2RhNTNlNmQ3MDliYWYxNDIiLCJfYXV0aF91c2VyX2lkIjoiMiJ9', '2016-11-23 01:11:13');
INSERT INTO `django_session` VALUES ('qhgbcuuydbcvobjanwirbbqmf73rme81', 'ODgzYTNjYTVkOTIyY2ZiOGE4NTA1YWE2OGM3NjA5MzRiNDBhMTE4MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6InVzZXJzLnZpZXdzLkN1c3RvbUJhY2tlbmQiLCJMSVNUX1FVRVJZIjpbWyJjb3Vyc2VzIiwiY291cnNlIl0sIiJdLCJfYXV0aF91c2VyX2hhc2giOiI0ZWU4ZTBlNjVkZjZhZDhkZDE5ZGIwNmNkYTUzZTZkNzA5YmFmMTQyIiwiX2F1dGhfdXNlcl9pZCI6IjIifQ==', '2016-11-28 00:07:33');
INSERT INTO `django_session` VALUES ('7vmowjzj0k4dpe0js1lh9dp0euq0tdx9', 'MjQ1ZGVjYmU4MDcxNmQ1MGFhNWE3YTE1Zjk3ODE5YTNlNWU1YWQxMjp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiTElTVF9RVUVSWSI6W1siY291cnNlcyIsImNvdXJzZXJlc291cmNlIl0sIiJdLCJfYXV0aF91c2VyX2hhc2giOiJiN2ZjZjEyZTViOTNiMjg5MWUzOTA4MTZkYTZkZTYxOWUyZDEwMGYzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCJ9', '2016-11-22 22:55:43');
INSERT INTO `django_session` VALUES ('nmjg2imxv7aps2830bubyduhh08g92dk', 'ODgzYTNjYTVkOTIyY2ZiOGE4NTA1YWE2OGM3NjA5MzRiNDBhMTE4MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6InVzZXJzLnZpZXdzLkN1c3RvbUJhY2tlbmQiLCJMSVNUX1FVRVJZIjpbWyJjb3Vyc2VzIiwiY291cnNlIl0sIiJdLCJfYXV0aF91c2VyX2hhc2giOiI0ZWU4ZTBlNjVkZjZhZDhkZDE5ZGIwNmNkYTUzZTZkNzA5YmFmMTQyIiwiX2F1dGhfdXNlcl9pZCI6IjIifQ==', '2016-11-27 18:58:54');
INSERT INTO `django_session` VALUES ('9n51clhwi9wza9xsrxzxeggvk6rd73mp', 'OTQwNzViYzQ0MmMyYjQxNWFkYTFiMDMyZjhiYjU5MTUyOWNlZjE4MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6InVzZXJzLnZpZXdzLkN1c3RvbUJhY2tlbmQiLCJMSVNUX1FVRVJZIjpbWyJjb3Vyc2VzIiwiY291cnNlIl0sIiJdLCJfYXV0aF91c2VyX2hhc2giOiIzYjNmYzA1ZTAxNWQ2NDIzNjc5NzY4ZmNjYzQ4OTM3NDU4YjA5ODA1IiwiX2F1dGhfdXNlcl9pZCI6IjIifQ==', '2016-12-25 22:53:41');
INSERT INTO `django_session` VALUES ('r88zwg0ox2e86k5rbz3i8h189g2tljia', 'ZjIxOGI1MDRkMTA4ZTFlNGYxNzdkNzJjODY4YmNmODJkYmY0NTczMDp7IkxJU1RfUVVFUlkiOltbInhhZG1pbiIsImxvZyJdLCIiXSwiX2F1dGhfdXNlcl9oYXNoIjoiNjRiZDAwMTk3ZmFiYjc0MzZmNjNiNDQ5YjEyOGI1ZGNmY2U1ODI1NSIsIl9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCJ9', '2016-12-25 22:08:53');

-- ----------------------------
-- Table structure for operation_coursecomments
-- ----------------------------
DROP TABLE IF EXISTS `operation_coursecomments`;
CREATE TABLE `operation_coursecomments` (
  `id` int(11) NOT NULL auto_increment,
  `comments` varchar(200) NOT NULL,
  `add_time` datetime NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `operation_coursecomments_ea134da7` (`course_id`),
  KEY `operation_coursecomments_e8701ad4` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_coursecomments
-- ----------------------------
INSERT INTO `operation_coursecomments` VALUES ('1', '给问问', '2016-11-05 23:09:57', '10', '2');
INSERT INTO `operation_coursecomments` VALUES ('2', '讲的很不错', '2016-11-05 23:13:13', '10', '2');
INSERT INTO `operation_coursecomments` VALUES ('3', 'good ', '2016-11-05 23:18:16', '10', '2');
INSERT INTO `operation_coursecomments` VALUES ('4', '再来一次', '2016-11-05 23:18:31', '10', '2');
INSERT INTO `operation_coursecomments` VALUES ('5', '好', '2016-12-08 22:06:57', '5', '2');
INSERT INTO `operation_coursecomments` VALUES ('6', '好', '2016-12-08 22:07:06', '5', '2');
INSERT INTO `operation_coursecomments` VALUES ('7', '好', '2016-12-08 22:07:14', '5', '2');

-- ----------------------------
-- Table structure for operation_userask
-- ----------------------------
DROP TABLE IF EXISTS `operation_userask`;
CREATE TABLE `operation_userask` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `course_name` varchar(50) NOT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_userask
-- ----------------------------
INSERT INTO `operation_userask` VALUES ('3', 'bobby', '13548', 'django', '2016-11-03 23:17:38');
INSERT INTO `operation_userask` VALUES ('4', 'bobby', '18786592568', 'django', '2016-11-03 23:29:26');

-- ----------------------------
-- Table structure for operation_usercourse
-- ----------------------------
DROP TABLE IF EXISTS `operation_usercourse`;
CREATE TABLE `operation_usercourse` (
  `id` int(11) NOT NULL auto_increment,
  `add_time` datetime NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `operation_usercourse_ea134da7` (`course_id`),
  KEY `operation_usercourse_e8701ad4` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_usercourse
-- ----------------------------
INSERT INTO `operation_usercourse` VALUES ('1', '2016-11-05 17:40:00', '10', '2');
INSERT INTO `operation_usercourse` VALUES ('2', '2016-11-05 23:43:12', '7', '2');
INSERT INTO `operation_usercourse` VALUES ('3', '2016-11-05 23:46:03', '4', '2');
INSERT INTO `operation_usercourse` VALUES ('4', '2016-11-05 23:47:04', '1', '2');
INSERT INTO `operation_usercourse` VALUES ('5', '2016-12-08 22:06:35', '5', '2');
INSERT INTO `operation_usercourse` VALUES ('6', '2016-12-08 22:09:54', '9', '2');
INSERT INTO `operation_usercourse` VALUES ('7', '2016-12-10 23:57:08', '13', '2');

-- ----------------------------
-- Table structure for operation_userfavorite
-- ----------------------------
DROP TABLE IF EXISTS `operation_userfavorite`;
CREATE TABLE `operation_userfavorite` (
  `id` int(11) NOT NULL auto_increment,
  `fav_id` int(11) NOT NULL,
  `fav_type` int(11) NOT NULL,
  `add_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `operation_userfavorite_e8701ad4` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_userfavorite
-- ----------------------------
INSERT INTO `operation_userfavorite` VALUES ('28', '1', '3', '2016-11-09 22:58:37', '2');
INSERT INTO `operation_userfavorite` VALUES ('29', '1', '2', '2016-11-09 23:04:14', '2');
INSERT INTO `operation_userfavorite` VALUES ('32', '12', '1', '2016-12-10 23:46:28', '2');
INSERT INTO `operation_userfavorite` VALUES ('31', '13', '1', '2016-12-10 23:46:21', '2');
INSERT INTO `operation_userfavorite` VALUES ('33', '2', '2', '2016-12-10 23:46:29', '2');
INSERT INTO `operation_userfavorite` VALUES ('34', '2', '3', '2016-12-10 23:46:37', '2');

-- ----------------------------
-- Table structure for operation_usermessage
-- ----------------------------
DROP TABLE IF EXISTS `operation_usermessage`;
CREATE TABLE `operation_usermessage` (
  `id` int(11) NOT NULL auto_increment,
  `user` int(11) NOT NULL,
  `message` varchar(500) NOT NULL,
  `has_read` tinyint(1) NOT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_usermessage
-- ----------------------------
INSERT INTO `operation_usermessage` VALUES ('1', '2', '欢迎注册', '1', '2016-11-06 23:49:00');

-- ----------------------------
-- Table structure for organization_citydict
-- ----------------------------
DROP TABLE IF EXISTS `organization_citydict`;
CREATE TABLE `organization_citydict` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `desc` varchar(200) NOT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_citydict
-- ----------------------------
INSERT INTO `organization_citydict` VALUES ('1', '北京市', '北京市', '2016-11-02 21:17:00');
INSERT INTO `organization_citydict` VALUES ('2', '上海市', '上海市', '2016-11-02 21:18:00');
INSERT INTO `organization_citydict` VALUES ('3', '广州市', '广州市', '2016-11-02 21:18:00');
INSERT INTO `organization_citydict` VALUES ('4', '深圳市', '深圳市', '2016-11-02 21:18:00');
INSERT INTO `organization_citydict` VALUES ('5', '天津市', '天津市', '2016-11-02 21:20:00');

-- ----------------------------
-- Table structure for organization_courseorg
-- ----------------------------
DROP TABLE IF EXISTS `organization_courseorg`;
CREATE TABLE `organization_courseorg` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `desc` longtext NOT NULL,
  `click_nums` int(11) NOT NULL,
  `fav_nums` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `address` varchar(150) NOT NULL,
  `add_time` datetime NOT NULL,
  `city_id` int(11) NOT NULL,
  `category` varchar(20) NOT NULL,
  `course_nums` int(11) NOT NULL,
  `students` int(11) NOT NULL,
  `tag` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `organization_courseorg_c7141997` (`city_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_courseorg
-- ----------------------------
INSERT INTO `organization_courseorg` VALUES ('1', '慕课网', '<p>&nbsp; &nbsp;</p><h1 class=\"ue_t\" label=\"Title center\" name=\"tc\" style=\"border-bottom-color:#cccccc;border-bottom-width:2px;border-bottom-style:solid;padding:0px 4px 0px 0px;text-align:center;margin:0px 0px 20px;\"><span style=\"color:#c0504d;\">[键入文档标题]</span></h1><p style=\"text-align:center;\"><strong class=\"ue_t\">[键入文档副标题]</strong></p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 1]</span></h3><p class=\"ue_t\" style=\"text-indent:2em;\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p class=\"ue_t\" style=\"text-indent:2em;\"><img src=\"/media/courses/ueditor/57aa86a0000145c512000460_20161210234050_865.jpg\" title=\"\" alt=\"57aa86a0000145c512000460.jpg\"/> </p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 2]</span></h3><p><img src=\"http://api.map.baidu.com/staticimage?center=116.410899,39.863624&zoom=11&width=530&height=340&markers=116.404,39.915\" width=\"530\" height=\"340\"/> </p><p class=\"ue_t\" style=\"text-indent:2em;\">在“开始”选项卡上，通过从快速样式库中为所选文本选择一种外观，您可以方便地更改文档中所选文本的格式。 您还可以使用“开始”选项卡上的其他控件来直接设置文本格式。大多数控件都允许您选择是使用当前主题外观，还是使用某种直接指定的格式。</p><h3><span class=\"ue_t\" style=\"font-family:幼圆\">[标题 3]</span></h3><p>2016-12-10</p><p class=\"ue_t\">对于“插入”选项卡上的库，在设计时都充分考虑了其中的项与文档整体外观的协调性。 您可以使用这些库来插入表格、页眉、页脚、列表、封面以及其他文档构建基块。 您创建的图片、图表或关系图也将与当前的文档外观协调一致。</p><p class=\"ue_t\"><br/> </p><p><br/></p><p><br/></p>', '22', '1', 'org/2016/11/imooc.png', '北京市', '2016-11-02 21:28:00', '1', 'pxjg', '4', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('2', '北京大学', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '1', 'org/2016/11/bjdx.jpg', '北京市', '2016-11-02 18:50:00', '3', 'gx', '5', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('3', '清华大学', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '0', 'org/2016/11/qhdx-logo.png', '北京市', '2016-11-02 18:53:00', '3', 'pxjg', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('4', '南京大学', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '0', 'org/2016/11/njdx.jpg', '南京市', '2016-11-02 18:53:00', '4', 'pxjg', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('5', '慕课网2', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '3', '0', 'org/2016/11/imooc_klgAUn5.png', '深圳市', '2016-11-02 18:54:00', '5', 'gr', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('6', '慕课网3', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '0', 'org/2016/11/imooc_Gn1sRjp.png', '天津市', '2016-11-02 18:54:00', '6', 'pxjg', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('7', '慕课网3', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '0', 'org/2016/11/imooc_Y2Tonsq.png', '上海市', '2016-11-02 18:54:00', '3', 'pxjg', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('8', '慕课网4', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '0', 'org/2016/11/imooc_OO2ykYP.png', '深圳市', '2016-11-02 18:55:00', '5', 'gx', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('9', '慕课网5', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '0', 'org/2016/11/imooc_V0TJOyb.png', '北京市', '2016-11-02 18:55:00', '4', 'pxjg', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('10', '慕课网666', '慕课网是垂直的互联网IT技能免费学习网站。以独家视频教程、在线编程工具、学习计划、问答社区为核心特色。在这里，你可以找到最好的互联网技术牛人，也可以通过免费的在线公开视频课程学习国内领先的互联网IT技术。\r\n    慕课网课程涵盖前端开发、PHP、Html5、Android、iOS、Swift等IT前沿技术语言，包括基础课程、实用案例、高级分享三大类型，适合不同阶段的学习人群。以纯干货、短视频的形式为平台特点，为在校学生、职场白领提供了一个迅速提升技能、共同分享进步的学习平台。[1] \r\n4月2日，国内首个IT技能学习类应用——慕课网3.1.0版本在应用宝首发。据了解，在此次上线的版本中，慕课网新增了课程历史记录、相关课程推荐等四大功能，为用户营造更加丰富的移动端IT学习体验。[2]', '0', '0', 'org/2016/11/imooc_qEaMov1.png', '深圳市', '2016-11-02 18:56:00', '2', 'pxjg', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('11', '慕学网', '慕学网慕学网\r\n慕学网慕学网慕学网\r\n慕学网慕学网慕学网\r\n\r\n慕学网慕学网慕学网\r\n\r\n慕学网', '0', '0', 'org/2016/12/bjdx.jpg', '北京市', '2016-12-10 23:28:00', '4', 'pxjg', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('12', 'python培训机构', 'python培训机构\r\npython培训机构\r\npython培训机构\r\npython培训机构\r\npython培训机构\r\npython培训机构\r\npython培训机构\r\npython培训机构\r\npython培训机构', '0', '0', 'org/2016/12/imooc_Gn1sRjp.png', '北京市', '2016-12-10 23:30:00', '2', 'gr', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('13', 'vuejs培训', 'vuejs培训vuejs培训vuejs培训vuejs培训\r\nvuejs培训vuejs培训vuejs培训vuejs培训\r\nvuejs培训vuejs培训vuejs培训vuejs培训\r\nvuejs培训vuejs培训vuejs培训vuejs培训', '0', '0', 'org/2016/12/bjdx_cCpdUw8.jpg', '北京市', '2016-12-10 23:30:00', '2', 'gr', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('14', 'nodejs培训', 'nodejs培训nodejs培训nodejs培训nodejs培训nodejs培训\r\nnodejs培训nodejs培训nodejs培训nodejs培训nodejs培训', '0', '0', 'org/2016/12/imooc_klgAUn5.png', '北京市', '2016-12-10 23:30:00', '2', 'gr', '0', '0', '全国知名');
INSERT INTO `organization_courseorg` VALUES ('15', '慕学在线', '慕学在线慕学在线慕学在线慕学在线慕学在线\r\n慕学在线慕学在线慕学在线慕学在线慕学在线', '0', '0', 'org/2016/12/bjdx_bcd0m07.jpg', '北京市', '2016-12-10 23:31:00', '5', 'gx', '0', '0', '全国知名');

-- ----------------------------
-- Table structure for organization_teacher
-- ----------------------------
DROP TABLE IF EXISTS `organization_teacher`;
CREATE TABLE `organization_teacher` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `work_years` int(11) NOT NULL,
  `work_company` varchar(50) NOT NULL,
  `work_position` varchar(50) NOT NULL,
  `points` varchar(50) NOT NULL,
  `click_nums` int(11) NOT NULL,
  `fav_nums` int(11) NOT NULL,
  `add_time` datetime NOT NULL,
  `org_id` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `organization_teacher_9cf869aa` (`org_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_teacher
-- ----------------------------
INSERT INTO `organization_teacher` VALUES ('1', 'bobby', '5', 'xxx', 'xxx', 'xxx', '14', '1', '2016-11-03 23:43:00', '1', 'teacher/2016/11/aobama_CXWwMef.png', '18');
INSERT INTO `organization_teacher` VALUES ('2', '还是bobby', '5', 'xxx', 'xxx', 'xxx', '2', '1', '2016-11-03 23:44:00', '1', 'teacher/2016/11/aobama.png', '18');

-- ----------------------------
-- Table structure for users_banner
-- ----------------------------
DROP TABLE IF EXISTS `users_banner`;
CREATE TABLE `users_banner` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `url` varchar(200) NOT NULL,
  `index` int(11) NOT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users_banner
-- ----------------------------
INSERT INTO `users_banner` VALUES ('1', '第一个', 'banner/2016/11/57a801860001c34b12000460.jpg', 'http://www.imooc.com', '1', '2016-11-07 22:55:00');
INSERT INTO `users_banner` VALUES ('2', '第二个', 'banner/2016/11/57aa86a0000145c512000460.jpg', 'http://www.projectsedu.com', '2', '2016-11-07 22:56:00');
INSERT INTO `users_banner` VALUES ('3', '第三个', 'banner/2016/11/57a801860001c34b12000460_z4Vb8zl.jpg', 'http://www.projectsedu.com', '3', '2016-11-07 22:57:00');
INSERT INTO `users_banner` VALUES ('4', '第四个', 'banner/2016/11/57aa86a0000145c512000460_nMwvoQD.jpg', 'http://www.projectsedu.com', '4', '2016-11-07 22:57:00');
INSERT INTO `users_banner` VALUES ('5', '第五个', 'banner/2016/11/57aa86a0000145c512000460_GXIBATC.jpg', 'http://www.projectsedu.com', '5', '2016-11-07 22:58:00');

-- ----------------------------
-- Table structure for users_emailverifyrecord
-- ----------------------------
DROP TABLE IF EXISTS `users_emailverifyrecord`;
CREATE TABLE `users_emailverifyrecord` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `send_type` varchar(30) NOT NULL,
  `send_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users_emailverifyrecord
-- ----------------------------
INSERT INTO `users_emailverifyrecord` VALUES ('6', 'admin', 'xxx@qq.com', 'register', '2016-10-25 23:13:00');
INSERT INTO `users_emailverifyrecord` VALUES ('8', 'bobby', 'admin@admin.com', 'forget', '2016-10-25 23:26:00');
INSERT INTO `users_emailverifyrecord` VALUES ('9', '3XMbn5Owwv6tc6mc', 'projectsedu@sina.com', 'register', '2016-10-30 22:52:56');
INSERT INTO `users_emailverifyrecord` VALUES ('10', 'xul6s2tlQMW6o38E', 'projectsedu@sina.com', 'register', '2016-10-30 22:57:43');
INSERT INTO `users_emailverifyrecord` VALUES ('11', 'ekB9xHRNDng9wlHq', 'projectsedu@sina.com', 'register', '2016-10-30 23:02:20');
INSERT INTO `users_emailverifyrecord` VALUES ('12', 'RIGoVBtSxt3U01YP', 'projectsedu@sina.com', 'forget', '2016-11-01 22:04:08');
INSERT INTO `users_emailverifyrecord` VALUES ('13', '73gYZCG4NID3hBIk', 'projectsedu@sina.com', 'forget', '2016-11-01 22:06:23');
INSERT INTO `users_emailverifyrecord` VALUES ('14', 'KIjhoogFyi8xu4TB', 'projectsedu@sina.com', 'update_ema', '2016-11-06 19:46:49');
INSERT INTO `users_emailverifyrecord` VALUES ('15', 'xrHe', 'projectsedu@sina.com', 'update_email', '2016-11-06 19:50:45');
INSERT INTO `users_emailverifyrecord` VALUES ('16', 'jCeSMseZ58DeGPDx', 'projectsedu@sina.com', 'forget', '2016-11-08 22:39:08');

-- ----------------------------
-- Table structure for users_userprofile
-- ----------------------------
DROP TABLE IF EXISTS `users_userprofile`;
CREATE TABLE `users_userprofile` (
  `id` int(11) NOT NULL auto_increment,
  `password` varchar(128) NOT NULL,
  `last_login` datetime default NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `nick_name` varchar(50) NOT NULL,
  `birday` date default NULL,
  `gender` varchar(6) NOT NULL,
  `address` varchar(100) NOT NULL,
  `mobile` varchar(11) default NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users_userprofile
-- ----------------------------
INSERT INTO `users_userprofile` VALUES ('2', 'pbkdf2_sha256$24000$F1yNeo5gRaWI$6TxfkDeHwc0X25DLCBI8O5W7exiud1Zz9FW8xtrPHSE=', '2016-12-11 22:42:34', '1', 'bobby', '', '', 'projectsedu@sina.com', '1', '1', '2016-10-24 14:58:33', 'django', '2009-09-02', 'female', '我来自火星', '', 'image/2016/12/default_big_14.png');
INSERT INTO `users_userprofile` VALUES ('3', 'admin123', '2016-10-30 23:40:00', '0', 'bobby1', '', '', '', '0', '1', '2016-10-24 23:40:00', 'bobby', '2016-10-05', 'female', '慕课网', '', 'image/default.png');
INSERT INTO `users_userprofile` VALUES ('6', 'pbkdf2_sha256$24000$fqNxJK7sfjE4$pcomeAWpo2AQtFIYq68wpqWszR+FMquouz731Xnc4q4=', '2016-11-08 22:44:00', '0', 'projectsedu1@sina.com', '', '', 'projectsedu1@sina.com', '1', '1', '2016-10-30 23:01:00', 'projectsedu', null, 'female', '北京市', '', 'image/default.png');

-- ----------------------------
-- Table structure for users_userprofile_groups
-- ----------------------------
DROP TABLE IF EXISTS `users_userprofile_groups`;
CREATE TABLE `users_userprofile_groups` (
  `id` int(11) NOT NULL auto_increment,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `users_userprofile_groups_userprofile_id_823cf2fc_uniq` (`userprofile_id`,`group_id`),
  KEY `users_userprofile_groups_group_id_3de53dbf_fk_auth_group_id` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users_userprofile_groups
-- ----------------------------
INSERT INTO `users_userprofile_groups` VALUES ('1', '6', '1');

-- ----------------------------
-- Table structure for users_userprofile_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `users_userprofile_user_permissions`;
CREATE TABLE `users_userprofile_user_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `users_userprofile_user_permissions_userprofile_id_d0215190_uniq` (`userprofile_id`,`permission_id`),
  KEY `users_userprofile_u_permission_id_393136b6_fk_auth_permission_id` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users_userprofile_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for xadmin_bookmark
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_bookmark`;
CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_bookma_content_type_id_60941679_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc_fk_users_userprofile_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xadmin_bookmark
-- ----------------------------

-- ----------------------------
-- Table structure for xadmin_log
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_log`;
CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL auto_increment,
  `action_time` datetime NOT NULL,
  `ip_addr` char(39) default NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) default NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_log_417f1b1c` (`content_type_id`),
  KEY `xadmin_log_e8701ad4` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xadmin_log
-- ----------------------------

-- ----------------------------
-- Table structure for xadmin_usersettings
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_usersettings`;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_users_userprofile_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xadmin_usersettings
-- ----------------------------
INSERT INTO `xadmin_usersettings` VALUES ('1', 'dashboard:home:pos', '', '2');

-- ----------------------------
-- Table structure for xadmin_userwidget
-- ----------------------------
DROP TABLE IF EXISTS `xadmin_userwidget`;
CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL auto_increment,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_userwidget_user_id_c159233a_fk_users_userprofile_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xadmin_userwidget
-- ----------------------------
