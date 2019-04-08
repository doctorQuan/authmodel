/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50711
Source Host           : 127.0.0.1:3306
Source Database       : thinkphp5

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2019-04-08 10:26:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `extend_user_info`
-- ----------------------------
DROP TABLE IF EXISTS `extend_user_info`;
CREATE TABLE `extend_user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `age` int(11) DEFAULT NULL,
  `mobile` varchar(16) DEFAULT NULL,
  `sys_user_id` varchar(40) DEFAULT NULL,
  `dep_name` varchar(40) DEFAULT NULL COMMENT '部门名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of extend_user_info
-- ----------------------------
INSERT INTO `extend_user_info` VALUES ('1', '41', '18826410992', '090d29277c16e176631ac11683efbd45', '阿斯蒂芬');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(40) NOT NULL COMMENT '菜单栏目唯一标识',
  `icon` varchar(50) DEFAULT NULL COMMENT '一级菜单图标',
  `name` varchar(512) DEFAULT NULL COMMENT '菜单名称',
  `is_visiable` int(8) unsigned DEFAULT NULL COMMENT '是否可见，1代表可见 2表示不可见',
  `parentid` varchar(40) DEFAULT NULL COMMENT '父级菜单id',
  `link` varchar(255) DEFAULT NULL COMMENT '链接',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `ifchoose` int(11) DEFAULT '1' COMMENT '-1 代表普通管理员不可见',
  `remark` varchar(32) DEFAULT NULL,
  `default` int(11) DEFAULT NULL COMMENT '1=代表默认菜单（控制面板），其他非默认',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('c7c15f002200614b4c37debd75ca1ebc', '&#xe61f;', 'a:1:{s:2:\"cn\";s:12:\"添加菜单\";}', '1', '08a33fc225535ac2030ad8d31158bf40', '/admin/Menu/AddShow', '2', '-1', '', null);
INSERT INTO `sys_menu` VALUES ('c44b85dc36e23002f0d6f19a8c365992', '&#xe658', 'a:1:{s:2:\"cn\";s:12:\"菜单列表\";}', '1', '08a33fc225535ac2030ad8d31158bf40', '/admin/Menu/Index', '1', '-1', '', '2');
INSERT INTO `sys_menu` VALUES ('9dcb81ff8b98656a9c76513ee47db5ad', '<i class=\"menu_font\">&#xea16;</i>', 'a:1:{s:2:\"cn\";s:12:\"权限管理\";}', '1', '0', '', '10', '1', '', '2');
INSERT INTO `sys_menu` VALUES ('fb79753137d4ffadcdf9209f2f90706d', '<i class=\"menu_font\">&#xe8db;</i>', 'a:1:{s:2:\"cn\";s:15:\"管理员列表\";}', '1', '9dcb81ff8b98656a9c76513ee47db5ad', '/admin/AdminUser/Index', '2', '1', '', '2');
INSERT INTO `sys_menu` VALUES ('0a1f3890b46398373af508674fe997b8', '<i class=\"menu_font\">&#xe8db;</i>', 'a:1:{s:2:\"cn\";s:12:\"角色列表\";}', '1', '9dcb81ff8b98656a9c76513ee47db5ad', '/admin/AdminUserRole/RoleIndex', '4', '1', '', '2');
INSERT INTO `sys_menu` VALUES ('1127ad67084facfefeb0fd87e375c4a7', '&#xe61f;', 'a:1:{s:2:\"cn\";s:15:\"添加管理员\";}', '1', '9dcb81ff8b98656a9c76513ee47db5ad', '/admin/AdminUser/AddShow', '3', '1', '', '2');
INSERT INTO `sys_menu` VALUES ('e4af03af232309856bc656c13e9e700d', '&#xe61f;', 'a:1:{s:2:\"cn\";s:12:\"添加角色\";}', '1', '9dcb81ff8b98656a9c76513ee47db5ad', '/admin/AdminUserRole/AddRoleView', '5', '1', '', '2');
INSERT INTO `sys_menu` VALUES ('08a33fc225535ac2030ad8d31158bf40', '&#xe653;', 'a:1:{s:2:\"cn\";s:12:\"系统维护\";}', '1', '0', '', '11', '-1', '仅开发管理员才能使用', null);
INSERT INTO `sys_menu` VALUES ('6939485aa949e4d96540e4c4e838e01a', '', 'a:1:{s:2:\"cn\";s:18:\"管理员控制台\";}', '2', '0', '/testrole/Main/Index', '50', '1', '管理员控制台', '1');

-- ----------------------------
-- Table structure for `sys_menu_mvc`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_mvc`;
CREATE TABLE `sys_menu_mvc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` varchar(40) DEFAULT NULL,
  `moudle` varchar(32) DEFAULT NULL COMMENT '模块名称',
  `controller` varchar(32) DEFAULT NULL COMMENT '模型类名称',
  `method` varchar(32) DEFAULT NULL COMMENT '方法名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu_mvc
-- ----------------------------
INSERT INTO `sys_menu_mvc` VALUES ('107', '1127ad67084facfefeb0fd87e375c4a7', 'admin', 'AdminUserController', '*');
INSERT INTO `sys_menu_mvc` VALUES ('106', 'fb79753137d4ffadcdf9209f2f90706d', 'admin', 'AdminUserController', '*');
INSERT INTO `sys_menu_mvc` VALUES ('117', '0a1f3890b46398373af508674fe997b8', 'admin', 'AdminUserRoleController', '*');
INSERT INTO `sys_menu_mvc` VALUES ('111', 'e4af03af232309856bc656c13e9e700d', 'admin', 'AdminUserController', '*');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(40) NOT NULL COMMENT '主键',
  `role_name` varchar(128) DEFAULT NULL COMMENT '名称（客服A,客服B,客服C，高级管理员等）',
  `status` int(4) DEFAULT NULL COMMENT '1、代表可用，2、代表禁用',
  `sys_user_id` varchar(40) DEFAULT NULL COMMENT '创建该角色的用户id',
  `editable` int(4) DEFAULT NULL COMMENT '-1 代表不可以编辑',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台角色组';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('b33536bc79c95d76f5b05783398d8c74', '系统管理员', '1', 'f629d53d8a23f61b4b2f8fe589733e09', '-1');

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_role_id` varchar(40) DEFAULT NULL,
  `sys_menu_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=543 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('542', 'b33536bc79c95d76f5b05783398d8c74', 'e4af03af232309856bc656c13e9e700d');
INSERT INTO `sys_role_menu` VALUES ('541', 'b33536bc79c95d76f5b05783398d8c74', '0a1f3890b46398373af508674fe997b8');
INSERT INTO `sys_role_menu` VALUES ('540', 'b33536bc79c95d76f5b05783398d8c74', '1127ad67084facfefeb0fd87e375c4a7');
INSERT INTO `sys_role_menu` VALUES ('539', 'b33536bc79c95d76f5b05783398d8c74', 'fb79753137d4ffadcdf9209f2f90706d');
INSERT INTO `sys_role_menu` VALUES ('538', 'b33536bc79c95d76f5b05783398d8c74', '9dcb81ff8b98656a9c76513ee47db5ad');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(40) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `truename` varchar(20) DEFAULT NULL COMMENT '真实名称',
  `status` int(4) unsigned DEFAULT '1' COMMENT '1、代表启用 2、代表禁用 3、不允许编辑 ',
  `parentid` varchar(40) DEFAULT NULL COMMENT '上级管理员id',
  `is_edit` tinyint(2) unsigned DEFAULT '1' COMMENT '{0：不允许编辑，1：可编辑}',
  `is_supper_admin` int(11) DEFAULT '0' COMMENT '如果是99代表超级管理员，不受权限限制',
  `session_key` varchar(40) DEFAULT NULL COMMENT 'api登录状态维护',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('f629d53d8a23f61b4b2f8fe589733e09', 'super-admin', '0D874A5A3B0C3AAB71E35EE325693762', '', '1', '907a0578b3507e395c40f837586f14ed', '0', '99', null);
INSERT INTO `sys_user` VALUES ('d3c11bff33aa71c19cd490a7999c39aa', 'admin', '02392958DFAC15DB5F61DD3BF7F07237', '系统管理员', '2', 'f629d53d8a23f61b4b2f8fe589733e09', '1', '0', null);
INSERT INTO `sys_user` VALUES ('090d29277c16e176631ac11683efbd45', 'shigong', 'F59BD65F7EDAFB087A81D4DCA06C4910', '石工', '1', 'f629d53d8a23f61b4b2f8fe589733e09', '1', '0', null);

-- ----------------------------
-- Table structure for `sys_user_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_log`;
CREATE TABLE `sys_user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '时间',
  `user_id` varchar(40) DEFAULT NULL,
  `controller` varchar(16) DEFAULT NULL,
  `moudle` varchar(16) DEFAULT NULL,
  `action` varchar(16) DEFAULT NULL,
  `data` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_log
-- ----------------------------
INSERT INTO `sys_user_log` VALUES ('1', '2019-03-14 17:21:41', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionindex', '{\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"Index\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('2', '2019-03-14 17:23:09', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionindex', '{\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"Index\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('3', '2019-03-14 17:23:10', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionuserlist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"UserList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('4', '2019-03-14 17:23:19', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionindex', '{\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"Index\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('5', '2019-03-14 17:23:19', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionuserlist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"UserList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('6', '2019-03-14 17:23:21', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionaddshow', '{\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"AddShow\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('7', '2019-03-14 17:23:23', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionroleindex', '{\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleIndex\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('8', '2019-03-14 17:23:23', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionrolelist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('9', '2019-03-14 17:23:24', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionaddrolevie', '{\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"AddRoleView\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('10', '2019-03-14 17:24:25', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionindex', '{\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"Index\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('11', '2019-03-14 17:24:25', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionuserlist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"UserList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('12', '2019-03-15 16:03:36', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionroleindex', '{\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleIndex\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('13', '2019-03-15 16:03:37', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionrolelist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('14', '2019-03-15 18:33:45', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionindex', '{\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"Index\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('15', '2019-03-15 18:33:46', '090d29277c16e176631ac11683efbd45', 'adminuserControl', 'admin', 'actionuserlist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUser\",\"a\":\"UserList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('16', '2019-03-15 18:40:31', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionroleindex', '{\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleIndex\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('17', '2019-03-15 18:40:32', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionrolelist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('18', '2019-03-15 18:40:34', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actioneditshow', '{\"id\":\"b33536bc79c95d76f5b05783398d8c74\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"EditShow\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('19', '2019-03-15 18:40:36', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionmenusettin', '{\"id\":\"b33536bc79c95d76f5b05783398d8c74\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"MenuSetting\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('20', '2019-03-15 18:40:39', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionupdatemenu', '{\"m\":\"Admin\",\"c\":\"AdminUserRole\",\"a\":\"UpdateMenuSetting\",\"menu_id\":{\"9dcb81ff8b98656a9c76513ee47db5ad\":\"9dcb81ff8b98656a9c76513ee47db5ad\",\"fb79753137d4ffadcdf9209f2f90706d\":\"fb79753137d4ffadcdf9209f2f90706d\",\"1127ad67084facfefeb0fd87e375c4a7\":\"1127ad67084facfefeb0fd87e375c4a7\",\"0a1f3890b46398373af508674fe997b8\":\"0a1f3890b46398373af508674fe997b8\",\"e4af03af232309856bc656c13e9e700d\":\"e4af03af232309856bc656c13e9e700d\",\"6939485aa949e4d96540e4c4e838e01a\":\"6939485aa949e4d96540e4c4e838e01a\"},\"role_id\":\"b33536bc79c95d76f5b05783398d8c74\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('21', '2019-03-15 18:41:07', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionroleindex', '{\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleIndex\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('22', '2019-03-15 18:41:07', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionrolelist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('23', '2019-03-15 18:41:08', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionmenusettin', '{\"id\":\"b33536bc79c95d76f5b05783398d8c74\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"MenuSetting\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('24', '2019-03-15 18:41:10', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionupdatemenu', '{\"m\":\"Admin\",\"c\":\"AdminUserRole\",\"a\":\"UpdateMenuSetting\",\"menu_id\":{\"9dcb81ff8b98656a9c76513ee47db5ad\":\"9dcb81ff8b98656a9c76513ee47db5ad\",\"fb79753137d4ffadcdf9209f2f90706d\":\"fb79753137d4ffadcdf9209f2f90706d\",\"1127ad67084facfefeb0fd87e375c4a7\":\"1127ad67084facfefeb0fd87e375c4a7\",\"0a1f3890b46398373af508674fe997b8\":\"0a1f3890b46398373af508674fe997b8\",\"e4af03af232309856bc656c13e9e700d\":\"e4af03af232309856bc656c13e9e700d\",\"6939485aa949e4d96540e4c4e838e01a\":\"6939485aa949e4d96540e4c4e838e01a\"},\"role_id\":\"b33536bc79c95d76f5b05783398d8c74\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('25', '2019-03-15 19:31:35', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionroleindex', '{\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleIndex\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('26', '2019-03-15 19:31:35', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionrolelist', '{\"page\":\"1\",\"limit\":\"10\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"RoleList\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('27', '2019-03-15 19:31:37', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionmenusettin', '{\"id\":\"b33536bc79c95d76f5b05783398d8c74\",\"m\":\"admin\",\"c\":\"AdminUserRole\",\"a\":\"MenuSetting\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');
INSERT INTO `sys_user_log` VALUES ('28', '2019-03-15 19:31:40', '090d29277c16e176631ac11683efbd45', 'adminuserroleCon', 'admin', 'actionupdatemenu', '{\"m\":\"Admin\",\"c\":\"AdminUserRole\",\"a\":\"UpdateMenuSetting\",\"menu_id\":{\"9dcb81ff8b98656a9c76513ee47db5ad\":\"9dcb81ff8b98656a9c76513ee47db5ad\",\"fb79753137d4ffadcdf9209f2f90706d\":\"fb79753137d4ffadcdf9209f2f90706d\",\"1127ad67084facfefeb0fd87e375c4a7\":\"1127ad67084facfefeb0fd87e375c4a7\",\"0a1f3890b46398373af508674fe997b8\":\"0a1f3890b46398373af508674fe997b8\",\"e4af03af232309856bc656c13e9e700d\":\"e4af03af232309856bc656c13e9e700d\",\"6939485aa949e4d96540e4c4e838e01a\":\"6939485aa949e4d96540e4c4e838e01a\"},\"role_id\":\"b33536bc79c95d76f5b05783398d8c74\",\"PHPSESSID\":\"9fcbssb1vt6bmm361mhkf46046\",\"Hm_lvt_830d4b546edcedbd284204a41acb7c90\":\"1551787654,1551855628\",\"Hm_lpvt_830d4b546edcedbd284204a41acb7c90\":\"1551855628\"}');

-- ----------------------------
-- Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(40) DEFAULT NULL,
  `role_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('13', 'd3c11bff33aa71c19cd490a7999c39aa', 'b33536bc79c95d76f5b05783398d8c74');
INSERT INTO `sys_user_role` VALUES ('96', '090d29277c16e176631ac11683efbd45', 'b33536bc79c95d76f5b05783398d8c74');
