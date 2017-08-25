-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.25-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.2.0.4947
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 bohuifin 的数据库结构
CREATE DATABASE IF NOT EXISTS `bohuifin` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bohuifin`;


-- 导出  表 bohuifin.c3p0_test 结构
CREATE TABLE IF NOT EXISTS `c3p0_test` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bohuifin.c3p0_test 的数据：~0 rows (大约)
DELETE FROM `c3p0_test`;
/*!40000 ALTER TABLE `c3p0_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `c3p0_test` ENABLE KEYS */;


-- 导出  函数 bohuifin.nextval 结构
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `nextval`(`user_seq_name` VARCHAR(100)) RETURNS bigint(20)
    READS SQL DATA
BEGIN
DECLARE sn_cur_val BIGINT;
DECLARE sn_new_val BIGINT;
DECLARE try_times INT;

SET sn_cur_val=-1;
SET sn_new_val=-1;
SET try_times=0;

REPEAT

SELECT cur_val INTO sn_cur_val FROM t_sequences WHERE t_sequences.seq_name = user_seq_name;
IF(sn_cur_val=-1) THEN
	INSERT INTO t_sequences (seq_name,init_val,cur_val) VALUES (user_seq_name,1,1);
	RETURN 1;
END IF;
UPDATE  t_sequences  SET cur_val=cur_val+1 WHERE t_sequences.seq_name = user_seq_name;
SELECT cur_val INTO sn_new_val FROM t_sequences WHERE t_sequences.seq_name = user_seq_name;

SET try_times=try_times+1;

UNTIL (sn_new_val-sn_cur_val=1) or (sn_new_val=-1) or (try_times>100)
END REPEAT;

IF(try_times>100)  THEN
SET sn_new_val=-2;
END IF;

RETURN sn_new_val;
END//
DELIMITER ;


-- 导出  表 bohuifin.t_access_log 结构
CREATE TABLE IF NOT EXISTS `t_access_log` (
  `log_id` bigint(18) NOT NULL COMMENT '日志ID',
  `context_path` varchar(100) NOT NULL COMMENT 'URL的路径',
  `params` varchar(300) DEFAULT NULL COMMENT 'URL的参数',
  `ip` varchar(100) NOT NULL COMMENT 'IP地址',
  `access_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
  `referer` varchar(300) DEFAULT NULL COMMENT '访问来源',
  `user_agent` varchar(300) DEFAULT NULL COMMENT '用户浏览器信息',
  `user_id` int(9) DEFAULT '-1' COMMENT '用户ID，未登录为-1',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户名，未登录为空',
  `true_name` varchar(100) DEFAULT NULL COMMENT '用户姓名，未登录为空',
  PRIMARY KEY (`log_id`),
  KEY `index_context_path` (`context_path`),
  KEY `index_userid_acclog` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='访问日志表';

-- 正在导出表  bohuifin.t_access_log 的数据：0 rows
DELETE FROM `t_access_log`;
/*!40000 ALTER TABLE `t_access_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_access_log` ENABLE KEYS */;


-- 导出  表 bohuifin.t_account_record 结构
CREATE TABLE IF NOT EXISTS `t_account_record` (
  `record_id` varchar(32) NOT NULL,
  `account_id` varchar(32) DEFAULT NULL COMMENT '资金ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `product_id` varchar(32) DEFAULT NULL COMMENT '项目ID',
  `money` double DEFAULT NULL COMMENT '资金',
  `money_operate` char(1) DEFAULT NULL COMMENT '资金操作（入金、出金）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_Reference_2` (`account_id`),
  KEY `FK_Reference_5` (`user_id`),
  KEY `FK_Reference_6` (`product_id`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`account_id`) REFERENCES `t_user_accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_t_account_record_t_users` FOREIGN KEY (`user_id`) REFERENCES `t_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金记录';

-- 正在导出表  bohuifin.t_account_record 的数据：~0 rows (大约)
DELETE FROM `t_account_record`;
/*!40000 ALTER TABLE `t_account_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_account_record` ENABLE KEYS */;


-- 导出  表 bohuifin.t_authority 结构
CREATE TABLE IF NOT EXISTS `t_authority` (
  `authority_id` int(11) NOT NULL,
  `authority_name` varchar(32) DEFAULT NULL,
  `authority_level` int(11) DEFAULT NULL,
  `authority_code` varchar(100) DEFAULT NULL,
  `authority_url` varchar(300) DEFAULT NULL,
  `parent_authority_id` int(11) DEFAULT NULL,
  `is_leaf` char(1) DEFAULT NULL,
  `is_menu` char(1) DEFAULT NULL,
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`authority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';

-- 正在导出表  bohuifin.t_authority 的数据：~37 rows (大约)
DELETE FROM `t_authority`;
/*!40000 ALTER TABLE `t_authority` DISABLE KEYS */;
INSERT INTO `t_authority` (`authority_id`, `authority_name`, `authority_level`, `authority_code`, `authority_url`, `parent_authority_id`, `is_leaf`, `is_menu`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	(0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-06-30 10:06:42', '1', '2017-06-30 10:06:38', '1', 1),
	(1, '人员管理', 1, 'icon-globe', '', 0, '2', '1', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(2, '用户管理', 2, 'icon-user', '/admin/users/showUser', 1, '1', '1', 1, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(3, '管理员管理', 2, 'icon-group', '/admin/managers/showManager', 1, '1', '1', 2, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(4, '操作员管理', 2, 'icon-credit-card', '/admin/dealers/showDealer', 1, '1', '1', 3, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(5, '获取用户列表', 3, 'userData', '/admin/users/userData', 2, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(6, '跳转到用户添加/修改页面', 3, 'showadduser', '/admin/users/showAddUser', 2, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(7, '保存用户', 4, 'saveuser', '/admin/users/saveUser', 6, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(8, '删除用户前的数据检查', 4, 'beforedel', '/admin/users/beforeDel', 5, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(9, '删除用户', 5, 'deluser', '/admin/users/delUser', 8, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(10, '初始化用户密码', 4, 'initpwd', '/admin/users/initpwd', 5, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(11, '获取管理员列表', 3, 'managerData', '/admin/manager/managerData', 3, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(12, '跳转到管理员添加/修改页面', 3, 'showaddmanager', '/admin/manager/showAddManager', 3, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(13, '保存管理员', 4, 'savemanager', '/admin/manager/saveManager', 12, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(14, '删除管理员前的数据检查', 4, 'beforedel', '/admin/manager/beforeDel', 11, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(15, '删除管理员', 5, 'delmanager', '/admin/manager/delManager', 14, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(16, '初始化管理员密码', 4, 'initpwd', '/admin/manager/initpwd', 12, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(17, '获取操作员列表', 3, 'dealerData', '/admin/dealer/dealerData', 4, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(18, '跳转到操作员添加/修改页面', 3, 'showadddealer', '/admin/dealer/showAddDealer', 4, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(19, '保存操作员', 4, 'savedealer', '/admin/dealer/saveDealer', 17, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(20, '删除操作员前的数据检查', 4, 'beforedel', '/admin/dealer/beforeDel', 17, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(21, '删除操作员', 5, 'deldealer', '/admin/dealer/delDealer', 20, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(22, '初始化操作员密码', 4, 'initpwd', '/admin/dealer/initpwd', 17, NULL, '2', NULL, '2017-06-10 09:47:09', '1', '2017-06-30 10:06:38', '1', 1),
	(23, '产品管理', 1, 'icon-certificate', '/admin/products/showProduct', 0, '1', '1', NULL, '2017-06-30 11:04:00', '1', '2017-06-30 11:04:01', '1', 1),
	(24, '显示产品信息', 2, 'productData', '/admin/products/productData', 23, NULL, '2', NULL, '2017-07-15 11:07:05', '1', '2017-07-15 11:07:07', '1', 1),
	(25, '跳转到产品添加/修改页面', 3, 'showaddproduct', '/admin/products/showAddProduct', 24, NULL, '2', NULL, '2017-07-15 11:07:57', '1', '2017-07-15 11:07:57', '1', 1),
	(26, '保存产品', 4, 'saveproduct', '/admin/products/saveProduct', 25, NULL, '2', NULL, '2017-07-15 11:08:42', '1', '2017-07-15 11:08:43', '1', 1),
	(27, '删除产品前的数据检查', 3, 'beforedel', '/admin/products/beforeDel', 24, NULL, '2', NULL, '2017-07-15 11:09:25', '1', '2017-07-15 11:09:26', '1', 1),
	(28, '删除产品', 4, 'delproduct', '/admin/products/delProduct', 27, NULL, '2', NULL, '2017-07-15 11:09:59', '1', '2017-07-15 11:09:59', '1', 1),
	(29, '设置投资状态时间', 3, 'showaddoperstate', '/admin/product_oper_state/showAddOperState', 24, NULL, '2', NULL, '2017-07-27 17:16:20', '1', '2017-07-27 17:16:21', '1', 1),
	(30, '保存投资状态时间', 4, 'saveoperstate', '/admin/product_oper_state/saveOperState', 29, NULL, '2', NULL, '2017-07-27 17:16:51', '1', '2017-07-27 17:16:51', '1', 1),
	(31, '更改产品审核状态', 3, 'changeproductstate', '/admin/products/changeProductState', 24, NULL, '2', NULL, '2017-07-27 17:20:26', '1', '2017-07-27 17:20:27', '1', 1),
	(32, '设置产品收益', 3, 'addincomebegin', '/admin/productIncomeRecord/addIncomeBegin', 24, NULL, '2', NULL, '2017-08-01 14:24:15', '1', '2017-08-01 14:24:16', '1', 1),
	(33, '保存产品收益', 4, 'saveincome', '/admin/productIncomeRecord/saveIncome', 32, NULL, '2', NULL, '2017-08-01 17:51:40', '1', '2017-08-01 17:11:41', '1', 1),
	(34, '删除产品收益', 4, 'removeincome', '/admin/productIncomeRecord/removeIncome', 32, NULL, '2', NULL, '2017-08-04 10:01:09', '1', '2017-08-04 10:01:10', '1', 1),
	(35, '交易员评论管理', 1, 'icon-comments', '/admin/dealertalk/showDealerTalk', 0, NULL, '1', NULL, '2017-08-14 09:34:42', '1', '2017-08-14 09:34:44', '1', 1),
	(36, '显示交易员评论数据', 2, 'dealertalkdata', '/admin/dealertalk/dealerTalkData', 35, NULL, '2', NULL, '2017-08-14 09:35:25', '1', '2017-08-14 09:35:26', '1', 1),
	(37, '跳转到评论添加/修改页面', 3, 'showadddealertalk', '/admin/dealertalk/showAddDealerTalk', 36, NULL, '2', NULL, '2017-08-14 09:36:03', '1', '2017-08-14 09:36:04', '1', 1),
	(38, '保存评论', 4, 'savedealertalk', '/admin/dealertalk/saveDealerTalk', 37, NULL, '2', NULL, '2017-08-14 09:36:41', '1', '2017-08-14 09:36:47', '1', 1),
	(39, '删除评论前的数据检查', 3, 'beforedel', '/admin/dealertalk/beforeDel', 36, NULL, '2', NULL, '2017-08-14 09:37:48', '1', '2017-08-14 09:37:49', '1', 1),
	(40, '删除评论', 4, 'deldealertalk', '/admin/dealertalk/delDealerTalk', 39, NULL, '2', NULL, '2017-08-14 09:39:17', '1', '2017-08-14 09:39:18', '1', 1),
	(41, '通过操作员查询已上线产品', 4, 'listproductsbydealer', '/admin/products/listProductsByDealer', 37, NULL, '2', NULL, '2017-08-16 14:53:29', '1', '2017-08-16 14:53:30', '1', 1);
/*!40000 ALTER TABLE `t_authority` ENABLE KEYS */;


-- 导出  表 bohuifin.t_authority_authority_group 结构
CREATE TABLE IF NOT EXISTS `t_authority_authority_group` (
  `authority_id` int(11) NOT NULL,
  `authority_group_id` int(11) NOT NULL,
  PRIMARY KEY (`authority_id`,`authority_group_id`),
  KEY `FK_Reference_10` (`authority_group_id`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`authority_group_id`) REFERENCES `t_authority_group` (`authority_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`authority_id`) REFERENCES `t_authority` (`authority_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限、权限组关联表';

-- 正在导出表  bohuifin.t_authority_authority_group 的数据：~49 rows (大约)
DELETE FROM `t_authority_authority_group`;
/*!40000 ALTER TABLE `t_authority_authority_group` DISABLE KEYS */;
INSERT INTO `t_authority_authority_group` (`authority_id`, `authority_group_id`) VALUES
	(1, 2),
	(2, 2),
	(3, 2),
	(4, 2),
	(5, 2),
	(6, 2),
	(7, 2),
	(8, 2),
	(9, 2),
	(10, 2),
	(11, 2),
	(12, 2),
	(13, 2),
	(14, 2),
	(15, 2),
	(16, 2),
	(17, 2),
	(18, 2),
	(19, 2),
	(20, 2),
	(21, 2),
	(22, 2),
	(23, 2),
	(24, 2),
	(25, 2),
	(26, 2),
	(27, 2),
	(28, 2),
	(29, 2),
	(30, 2),
	(31, 2),
	(35, 2),
	(36, 2),
	(39, 2),
	(40, 2),
	(23, 4),
	(24, 4),
	(25, 4),
	(26, 4),
	(27, 4),
	(28, 4),
	(29, 4),
	(30, 4),
	(32, 4),
	(33, 4),
	(34, 4),
	(35, 4),
	(36, 4),
	(37, 4),
	(38, 4),
	(39, 4),
	(41, 4);
/*!40000 ALTER TABLE `t_authority_authority_group` ENABLE KEYS */;


-- 导出  表 bohuifin.t_authority_group 结构
CREATE TABLE IF NOT EXISTS `t_authority_group` (
  `authority_group_id` int(11) NOT NULL,
  `authority_group_name` varchar(100) DEFAULT NULL,
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`authority_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限组';

-- 正在导出表  bohuifin.t_authority_group 的数据：~3 rows (大约)
DELETE FROM `t_authority_group`;
/*!40000 ALTER TABLE `t_authority_group` DISABLE KEYS */;
INSERT INTO `t_authority_group` (`authority_group_id`, `authority_group_name`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	(2, '系统管理员', 1, '2017-06-26 14:34:55', NULL, '2017-06-26 14:34:56', NULL, 2),
	(3, '用户', 2, '2017-06-26 14:35:16', NULL, '2017-06-26 14:35:16', NULL, 1),
	(4, '操作员', 3, '2017-06-26 14:35:32', NULL, '2017-06-26 14:35:33', NULL, 1);
/*!40000 ALTER TABLE `t_authority_group` ENABLE KEYS */;


-- 导出  表 bohuifin.t_dealer 结构
CREATE TABLE IF NOT EXISTS `t_dealer` (
  `dealer_id` varchar(32) NOT NULL COMMENT '交易员ID',
  `dealer_name` varchar(50) DEFAULT NULL COMMENT '交易员用户名',
  `pwd` varchar(50) DEFAULT NULL,
  `salt` varchar(20) DEFAULT NULL,
  `true_name` varchar(10) DEFAULT NULL COMMENT '交易员真实姓名',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '交易员昵称',
  `head_img` varchar(500) DEFAULT NULL COMMENT '头像',
  `dept_id` bigint(20) DEFAULT NULL,
  `authority_group_id` int(11) DEFAULT NULL,
  `introduce` text COMMENT '交易员简介',
  `overall_profit_and_loss` double DEFAULT NULL COMMENT '整体盈亏（可后台配置，也可设计那个后台生成）',
  `avg_profit_ratio` double DEFAULT NULL COMMENT '平均盈亏比',
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`dealer_id`),
  KEY `FK_t_dealer_t_dept` (`dept_id`),
  KEY `FK_t_dealer_t_authority_group` (`authority_group_id`),
  CONSTRAINT `FK_t_dealer_t_authority_group` FOREIGN KEY (`authority_group_id`) REFERENCES `t_authority_group` (`authority_group_id`),
  CONSTRAINT `FK_t_dealer_t_dept` FOREIGN KEY (`dept_id`) REFERENCES `t_dept` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易员表';

-- 正在导出表  bohuifin.t_dealer 的数据：~4 rows (大约)
DELETE FROM `t_dealer`;
/*!40000 ALTER TABLE `t_dealer` DISABLE KEYS */;
INSERT INTO `t_dealer` (`dealer_id`, `dealer_name`, `pwd`, `salt`, `true_name`, `nick_name`, `head_img`, `dept_id`, `authority_group_id`, `introduce`, `overall_profit_and_loss`, `avg_profit_ratio`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	('5', 'dengli', 'fa445bb5b42a49d406f921eecc320ce4', '8fyUrzQdEq', '邓丽', '樱翼帝国', 'http://exam.enorth.com.cn:9000/upload/2017\\6\\26\\b64e2f94b01140a3a913078b075699e6.jpg', 0, NULL, NULL, 0, 0, 1, '2017-07-15 11:37:30', '25', '2017-07-27 08:58:32', '1', 1),
	('54', 'yy', 'c25ae56cb9135857c9dfdccbc33545f4', 'Pu0ORvR6jf', '杨洋', '守护者', 'http://exam.enorth.com.cn:9000/upload/2017\\6\\26\\34eeb50052b944358aed9c51eee695bd.jpg', 0, NULL, NULL, 0, 0, 1, '2017-06-29 17:44:39', '1', '2017-07-26 14:23:10', '1', 1),
	('55', 'admin', 'bb05242a9703252c06614b5a56b94826', 'C6iN9vtGWZ', '系统', '系统', NULL, NULL, NULL, NULL, 0, 0, 2, '2017-06-30 09:02:17', '1', '2017-06-30 09:39:19', '1', 1),
	('7', 'andy', '352a1e0e0e5293ce55cd6e841a86de15', 'ovH3IGTyhE', '安迪', 'andy', 'http://exam.enorth.com.cn:9000/upload/2017\\6\\26\\ce0aca1885334122a157e51d2b2b8174.jpg', 0, NULL, NULL, 0, 0, 1, '2017-07-16 21:56:09', '1', '2017-07-26 14:23:02', '1', 1);
/*!40000 ALTER TABLE `t_dealer` ENABLE KEYS */;


-- 导出  表 bohuifin.t_dealer_talk 结构
CREATE TABLE IF NOT EXISTS `t_dealer_talk` (
  `talk_id` bigint(20) NOT NULL,
  `dealer_id` varchar(32) NOT NULL,
  `product_id` varchar(32) NOT NULL,
  `talk_content` varchar(500) NOT NULL,
  `list_order` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(50) NOT NULL,
  `state` int(11) NOT NULL,
  `install_date` datetime NOT NULL,
  PRIMARY KEY (`talk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易员留言板';

-- 正在导出表  bohuifin.t_dealer_talk 的数据：~0 rows (大约)
DELETE FROM `t_dealer_talk`;
/*!40000 ALTER TABLE `t_dealer_talk` DISABLE KEYS */;
INSERT INTO `t_dealer_talk` (`talk_id`, `dealer_id`, `product_id`, `talk_content`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`, `install_date`) VALUES
	(1, '5', '17', '123', 1, '2017-08-11 10:13:59', '1', '2017-08-11 10:14:03', '1', 1, '2017-08-11 10:14:05');
/*!40000 ALTER TABLE `t_dealer_talk` ENABLE KEYS */;


-- 导出  表 bohuifin.t_dept 结构
CREATE TABLE IF NOT EXISTS `t_dept` (
  `dept_id` bigint(18) NOT NULL COMMENT '部门ID',
  `dept_name` varchar(50) NOT NULL COMMENT '部门名称',
  `dept_code` varchar(50) DEFAULT NULL COMMENT '部门代码',
  `parent_id` bigint(18) DEFAULT NULL COMMENT '上级部门ID',
  `dept_level` int(9) NOT NULL COMMENT '部门层级',
  `welcome_page` varchar(150) DEFAULT NULL COMMENT '部门首页网址',
  `state` int(9) NOT NULL DEFAULT '1' COMMENT '状态，1正常，-1隐藏',
  `list_order` int(9) NOT NULL DEFAULT '100' COMMENT '显示序号',
  `accept_ask` int(9) NOT NULL DEFAULT '1' COMMENT '可接受提问',
  `accept_delegate` int(9) NOT NULL DEFAULT '1' COMMENT '可接受分拨',
  `allow_delegate` int(9) NOT NULL DEFAULT '0' COMMENT '可将办件分给他人',
  `dept_icon` varchar(150) DEFAULT NULL COMMENT '部门图标',
  `memo` longtext COMMENT '备注',
  `dept_shortname` varchar(50) DEFAULT NULL COMMENT '部门简称',
  `accept_report` int(9) NOT NULL DEFAULT '0' COMMENT '可接受报送',
  PRIMARY KEY (`dept_id`),
  KEY `index_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门表';

-- 正在导出表  bohuifin.t_dept 的数据：~0 rows (大约)
DELETE FROM `t_dept`;
/*!40000 ALTER TABLE `t_dept` DISABLE KEYS */;
INSERT INTO `t_dept` (`dept_id`, `dept_name`, `dept_code`, `parent_id`, `dept_level`, `welcome_page`, `state`, `list_order`, `accept_ask`, `accept_delegate`, `allow_delegate`, `dept_icon`, `memo`, `dept_shortname`, `accept_report`) VALUES
	(0, '博汇金融', '1', NULL, 1, NULL, 1, 100, 1, 1, 0, NULL, NULL, NULL, 0);
/*!40000 ALTER TABLE `t_dept` ENABLE KEYS */;


-- 导出  表 bohuifin.t_manager 结构
CREATE TABLE IF NOT EXISTS `t_manager` (
  `manager_id` varchar(32) NOT NULL,
  `manager_name` varchar(32) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `salt` varchar(20) DEFAULT NULL,
  `true_name` varchar(32) DEFAULT NULL,
  `dept_id` bigint(20) DEFAULT NULL,
  `nick_name` varchar(32) DEFAULT NULL,
  `authority_group_id` int(11) DEFAULT NULL,
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`manager_id`),
  KEY `FK_Reference_12` (`authority_group_id`),
  KEY `FK_t_manager_t_dept` (`dept_id`),
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`authority_group_id`) REFERENCES `t_authority_group` (`authority_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_t_manager_t_dept` FOREIGN KEY (`dept_id`) REFERENCES `t_dept` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员';

-- 正在导出表  bohuifin.t_manager 的数据：~8 rows (大约)
DELETE FROM `t_manager`;
/*!40000 ALTER TABLE `t_manager` DISABLE KEYS */;
INSERT INTO `t_manager` (`manager_id`, `manager_name`, `pwd`, `salt`, `true_name`, `dept_id`, `nick_name`, `authority_group_id`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	('1', 'admin', '0fc5ffd829a2cfe807e84d72203d270d', 'kJzb4dQFWQ', '系统管理员', 0, '系统管理员', 2, 1, '2017-06-27 14:49:55', NULL, '2017-07-15 11:05:42', '1', 1),
	('25', 'yangzhe', 'bec99085e2d64c32abc12fba3e7f8589', 'bZvRZ0F8mP', '杨哲', NULL, '111', 2, 1, '2017-07-15 11:36:10', '1', NULL, '0', 1),
	('48', 'admin', '11a4e43e49e9a70db5979a5ef0098c71', 'XYIF4eVoST', '系统管理员', NULL, '系统管理员', 2, NULL, '2017-06-29 16:35:07', '1', NULL, '0', -1),
	('49', 'root', '00381ae554fd41ca9cec26e771969ce5', 'ODQRxdO2TM', '系统管理员', NULL, '系统管理员', 2, NULL, '2017-06-29 16:35:53', '1', NULL, '0', -1),
	('50', 'root1', '8d8eedbf2becba13823ed1f8b0ac2d26', 'XY195f4EL1', '系统管理员', NULL, '系统管理员', 2, NULL, '2017-06-29 16:36:03', '1', NULL, '0', -1),
	('51', 'root2', 'e3f0b33d6fd1364d336de75c2995c16c', 'SiGN9XfTcz', '系统管理员', NULL, '系统管理员', 2, NULL, '2017-06-29 16:36:11', '1', NULL, '0', -1),
	('52', 'root4', '4764bba0f4de3f38303750290e62a3b6', 'XYDcnDEeDp', '管理员', NULL, '管理员', 2, NULL, '2017-06-29 16:37:13', '1', NULL, '0', -1),
	('53', 'root5', 'f2e804a04cc1f70d6e547e7be63ff9b2', 'QnN0jolJQY', '系统管理员', NULL, '系统管理员', 2, NULL, '2017-06-29 16:37:25', '1', NULL, '0', -1);
/*!40000 ALTER TABLE `t_manager` ENABLE KEYS */;


-- 导出  表 bohuifin.t_oper_state 结构
CREATE TABLE IF NOT EXISTS `t_oper_state` (
  `oper_state_id` int(11) NOT NULL COMMENT '投资状态ID',
  `oper_state_name` varchar(32) DEFAULT NULL COMMENT '投资状态（草稿箱、等待开始、募集中、正在投资、投资结束）',
  `prev_oper_state_id` int(11) DEFAULT NULL COMMENT '上一个投资状态',
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `state` int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`oper_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='目前产品的流程状态（草稿箱、等待开始、募集中、正在投资、投资结束）';

-- 正在导出表  bohuifin.t_oper_state 的数据：~5 rows (大约)
DELETE FROM `t_oper_state`;
/*!40000 ALTER TABLE `t_oper_state` DISABLE KEYS */;
INSERT INTO `t_oper_state` (`oper_state_id`, `oper_state_name`, `prev_oper_state_id`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	(1, '草稿箱', -1, 1, '2017-06-30 16:59:19', '1', '2017-06-30 16:59:20', '1', 1),
	(2, '等待开始', 1, 2, '2017-06-30 16:59:19', '1', '2017-06-30 16:59:20', '1', 1),
	(3, '募集中', 2, 3, '2017-06-30 16:59:19', '1', '2017-06-30 16:59:20', '1', 1),
	(4, '正在投资', 3, 4, '2017-06-30 16:59:19', '1', '2017-06-30 16:59:20', '1', 1),
	(5, '投资结束', 4, 5, '2017-06-30 16:59:19', '1', '2017-06-30 16:59:20', '1', 1);
/*!40000 ALTER TABLE `t_oper_state` ENABLE KEYS */;


-- 导出  表 bohuifin.t_op_log 结构
CREATE TABLE IF NOT EXISTS `t_op_log` (
  `log_id` bigint(18) NOT NULL COMMENT '日志编号',
  `op_item_id` varchar(100) DEFAULT NULL COMMENT '操作对象ID',
  `user_id` int(9) NOT NULL COMMENT '用户ID',
  `dept_id` bigint(18) NOT NULL DEFAULT '-1' COMMENT '部门编号',
  `question_id` int(9) NOT NULL DEFAULT '-1' COMMENT '办件编号',
  `op_desc` varchar(1000) NOT NULL COMMENT '操作说明',
  `op_date` datetime NOT NULL COMMENT '操作时间',
  `ip` varchar(100) NOT NULL COMMENT 'IP地址',
  PRIMARY KEY (`log_id`),
  KEY `index_loguserid` (`user_id`),
  KEY `index_logopdate` (`op_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户操作日志表';

-- 正在导出表  bohuifin.t_op_log 的数据：0 rows
DELETE FROM `t_op_log`;
/*!40000 ALTER TABLE `t_op_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_op_log` ENABLE KEYS */;


-- 导出  表 bohuifin.t_product 结构
CREATE TABLE IF NOT EXISTS `t_product` (
  `product_id` varchar(32) NOT NULL COMMENT '产品ID',
  `product_name` varchar(200) DEFAULT NULL COMMENT '产品名',
  `introduce` text COMMENT '产品介绍',
  `dealer_id` varchar(32) DEFAULT NULL COMMENT '交易员ID',
  `product_type_id` int(11) DEFAULT NULL COMMENT '产品类型（大类可分为用户投资类和用户充值类）',
  `oper_state_id` int(11) DEFAULT NULL COMMENT '投资状态ID',
  `is_oper_interval_set_up` int(11) DEFAULT '0' COMMENT '每一个投资状态的时间是否都已设置',
  `project_amount` double DEFAULT NULL COMMENT '产品金额',
  `investable_amount` double DEFAULT NULL COMMENT '可投资金额',
  `management_cost` double DEFAULT NULL COMMENT '管理费',
  `stop_loss_value` double DEFAULT NULL COMMENT '止损值',
  `expected_yield` double DEFAULT NULL COMMENT '预期收益率（用作保底收益）',
  `trading_cycle` int(11) DEFAULT NULL COMMENT '交易周期',
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`product_id`),
  KEY `FK_Reference_3` (`product_type_id`),
  KEY `FK_Reference_4` (`dealer_id`),
  KEY `FK_Reference_9` (`oper_state_id`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`product_type_id`) REFERENCES `t_product_type` (`product_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`oper_state_id`) REFERENCES `t_oper_state` (`oper_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_t_product_t_dealer` FOREIGN KEY (`dealer_id`) REFERENCES `t_dealer` (`dealer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表';

-- 正在导出表  bohuifin.t_product 的数据：~2 rows (大约)
DELETE FROM `t_product`;
/*!40000 ALTER TABLE `t_product` DISABLE KEYS */;
INSERT INTO `t_product` (`product_id`, `product_name`, `introduce`, `dealer_id`, `product_type_id`, `oper_state_id`, `is_oper_interval_set_up`, `project_amount`, `investable_amount`, `management_cost`, `stop_loss_value`, `expected_yield`, `trading_cycle`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	('15', '测试产品', '产品介绍', '5', 1, 5, 1, 0, NULL, 10, 20, 10, 45, 1, '2017-08-01 14:57:47', '5', '2017-08-01 15:21:32', '5', 2000),
	('17', '新手专享13期', '新手专享标，每名新用户享有一次“新手专享标”投资机会，限额2000元，投满即止。', '5', 3, 5, 1, 0, NULL, 95, 10, 20, 5, 9, '2017-08-07 17:29:03', '5', '2017-08-07 17:30:32', '5', 2000);
/*!40000 ALTER TABLE `t_product` ENABLE KEYS */;


-- 导出  表 bohuifin.t_product_income_record 结构
CREATE TABLE IF NOT EXISTS `t_product_income_record` (
  `record_id` bigint(20) NOT NULL COMMENT '主键',
  `product_id` varchar(32) NOT NULL COMMENT '产品ID',
  `income` double NOT NULL COMMENT '收益',
  `income_time` datetime NOT NULL,
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_t_product_income_record_t_product` (`product_id`),
  CONSTRAINT `FK_t_product_income_record_t_product` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品每日收益';

-- 正在导出表  bohuifin.t_product_income_record 的数据：~2 rows (大约)
DELETE FROM `t_product_income_record`;
/*!40000 ALTER TABLE `t_product_income_record` DISABLE KEYS */;
INSERT INTO `t_product_income_record` (`record_id`, `product_id`, `income`, `income_time`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	(4, '15', 401, '2017-08-02 00:00:00', 0, '2017-08-02 13:50:18', '5', '2017-08-04 09:11:30', '5', -1),
	(5, '15', 12, '2017-08-02 00:00:00', 0, '2017-08-04 10:07:43', '5', '2017-08-04 10:24:28', '5', 1);
/*!40000 ALTER TABLE `t_product_income_record` ENABLE KEYS */;


-- 导出  表 bohuifin.t_product_oper_log 结构
CREATE TABLE IF NOT EXISTS `t_product_oper_log` (
  `oper_id` varchar(32) NOT NULL COMMENT '操作日志ID',
  `product_id` varchar(32) DEFAULT NULL COMMENT '产品ID',
  `oper_state_id` int(11) DEFAULT NULL COMMENT '目前产品的投资状态ID（等待开始、募集中、正在投资、投资结束）',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`oper_id`),
  KEY `FK_Reference_7` (`product_id`),
  KEY `FK_Reference_8` (`oper_state_id`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`oper_state_id`) REFERENCES `t_oper_state` (`oper_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品的操作日志';

-- 正在导出表  bohuifin.t_product_oper_log 的数据：~0 rows (大约)
DELETE FROM `t_product_oper_log`;
/*!40000 ALTER TABLE `t_product_oper_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_product_oper_log` ENABLE KEYS */;


-- 导出  表 bohuifin.t_product_oper_state 结构
CREATE TABLE IF NOT EXISTS `t_product_oper_state` (
  `product_id` varchar(50) NOT NULL COMMENT '产品ID',
  `oper_state_id` int(11) NOT NULL COMMENT '投资状态ID',
  `oper_state_start_time` datetime DEFAULT NULL COMMENT '该投资状态的开始时间',
  `state` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `list_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`oper_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品投资状态关联表';

-- 正在导出表  bohuifin.t_product_oper_state 的数据：~8 rows (大约)
DELETE FROM `t_product_oper_state`;
/*!40000 ALTER TABLE `t_product_oper_state` DISABLE KEYS */;
INSERT INTO `t_product_oper_state` (`product_id`, `oper_state_id`, `oper_state_start_time`, `state`, `create_time`, `create_by`, `update_time`, `update_by`, `list_order`) VALUES
	('15', 2, '2017-07-30 00:00:00', 1, '2017-08-01 15:21:32', '5', NULL, NULL, 0),
	('15', 3, '2017-07-31 00:00:00', 1, '2017-08-01 15:21:32', '5', NULL, NULL, 0),
	('15', 4, '2017-08-01 00:00:00', 1, '2017-08-01 15:21:32', '5', NULL, NULL, 0),
	('15', 5, '2017-08-02 00:00:00', 1, '2017-08-01 15:21:32', '5', NULL, NULL, 0),
	('17', 2, '2017-08-03 00:00:00', 1, '2017-08-07 17:30:32', '5', NULL, NULL, 0),
	('17', 3, '2017-08-04 00:00:00', 1, '2017-08-07 17:30:32', '5', NULL, NULL, 0),
	('17', 4, '2017-08-09 00:00:00', 1, '2017-08-07 17:30:32', '5', NULL, NULL, 0),
	('17', 5, '2017-08-14 00:00:00', 1, '2017-08-07 17:30:32', '5', NULL, NULL, 0);
/*!40000 ALTER TABLE `t_product_oper_state` ENABLE KEYS */;


-- 导出  表 bohuifin.t_product_product_tag 结构
CREATE TABLE IF NOT EXISTS `t_product_product_tag` (
  `product_id` varchar(50) NOT NULL COMMENT '产品ID',
  `tag_id` int(11) NOT NULL,
  `state` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `list_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品标签表';

-- 正在导出表  bohuifin.t_product_product_tag 的数据：~6 rows (大约)
DELETE FROM `t_product_product_tag`;
/*!40000 ALTER TABLE `t_product_product_tag` DISABLE KEYS */;
INSERT INTO `t_product_product_tag` (`product_id`, `tag_id`, `state`, `create_time`, `create_by`, `update_time`, `update_by`, `list_order`) VALUES
	('15', 7, 1, '2017-08-01 14:57:47', 5, NULL, NULL, 0),
	('15', 8, 1, '2017-08-01 14:57:47', 5, NULL, NULL, 0),
	('17', 9, 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0),
	('17', 10, 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0),
	('17', 11, 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0),
	('17', 12, 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0);
/*!40000 ALTER TABLE `t_product_product_tag` ENABLE KEYS */;


-- 导出  表 bohuifin.t_product_tag 结构
CREATE TABLE IF NOT EXISTS `t_product_tag` (
  `tag_id` int(11) DEFAULT NULL COMMENT '产品标签ID',
  `tag_name` varchar(50) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `list_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品标签表';

-- 正在导出表  bohuifin.t_product_tag 的数据：~6 rows (大约)
DELETE FROM `t_product_tag`;
/*!40000 ALTER TABLE `t_product_tag` DISABLE KEYS */;
INSERT INTO `t_product_tag` (`tag_id`, `tag_name`, `state`, `create_time`, `create_by`, `update_time`, `update_by`, `list_order`) VALUES
	(7, '100起投', 1, '2017-08-01 14:57:47', 5, NULL, NULL, 0),
	(8, ' 2000收益', 1, '2017-08-01 14:57:47', 5, NULL, NULL, 0),
	(9, '保本机制', 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0),
	(10, ' 超短周期', 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0),
	(11, ' 投资限额2000元', 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0),
	(12, ' 100元起投', 1, '2017-08-07 17:29:03', 5, NULL, NULL, 0);
/*!40000 ALTER TABLE `t_product_tag` ENABLE KEYS */;


-- 导出  表 bohuifin.t_product_type 结构
CREATE TABLE IF NOT EXISTS `t_product_type` (
  `product_type_id` int(11) NOT NULL COMMENT '产品种类ID',
  `product_type_name` varchar(100) DEFAULT NULL COMMENT '产品种类名称（固收型、驱动型、稳健型）或（银联、支付宝等）',
  `product_type` int(11) DEFAULT NULL COMMENT '产品种类（投资、充值）',
  `description` text COMMENT '描述',
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`product_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品种类表';

-- 正在导出表  bohuifin.t_product_type 的数据：~5 rows (大约)
DELETE FROM `t_product_type`;
/*!40000 ALTER TABLE `t_product_type` DISABLE KEYS */;
INSERT INTO `t_product_type` (`product_type_id`, `product_type_name`, `product_type`, `description`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	(1, '固收型', 1, '固收型描述内容', 1, '2017-06-30 16:51:25', 1, '2017-06-30 16:51:26', 1, 1),
	(2, '驱动型', 1, '驱动型描述内容', 1, '2017-06-30 16:51:25', 1, '2017-06-30 16:51:26', 1, 1),
	(3, '稳健型', 1, '稳健型描述内容', 1, '2017-06-30 16:51:25', 1, '2017-06-30 16:51:26', 1, 1),
	(4, '银联', 2, '银联描述内容', 1, '2017-06-30 16:51:25', 1, '2017-06-30 16:51:26', 1, 1),
	(5, '支付宝', 2, '支付宝描述内容', 1, '2017-06-30 16:51:25', 1, '2017-06-30 16:51:26', 1, 1);
/*!40000 ALTER TABLE `t_product_type` ENABLE KEYS */;


-- 导出  表 bohuifin.t_role 结构
CREATE TABLE IF NOT EXISTS `t_role` (
  `role_id` int(9) NOT NULL COMMENT '角色ID',
  `role_name` varchar(200) NOT NULL COMMENT '角色名称',
  `list_order` int(9) NOT NULL DEFAULT '100' COMMENT '显示序号',
  `state` int(9) NOT NULL DEFAULT '1' COMMENT '状态，1正常，-1不显示',
  `memo` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `ak_key_2` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- 正在导出表  bohuifin.t_role 的数据：~0 rows (大约)
DELETE FROM `t_role`;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;


-- 导出  表 bohuifin.t_role_priv 结构
CREATE TABLE IF NOT EXISTS `t_role_priv` (
  `role_id` int(9) NOT NULL COMMENT '角色ID',
  `priv_ename` varchar(50) NOT NULL COMMENT '权限名',
  PRIMARY KEY (`priv_ename`,`role_id`),
  KEY `index_roleid` (`role_id`),
  CONSTRAINT `fk_reference_17` FOREIGN KEY (`priv_ename`) REFERENCES `t_sys_priv` (`priv_ename`),
  CONSTRAINT `fk_reference_18` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- 正在导出表  bohuifin.t_role_priv 的数据：~0 rows (大约)
DELETE FROM `t_role_priv`;
/*!40000 ALTER TABLE `t_role_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_role_priv` ENABLE KEYS */;


-- 导出  表 bohuifin.t_sequences 结构
CREATE TABLE IF NOT EXISTS `t_sequences` (
  `seq_name` varchar(50) NOT NULL COMMENT '序列名称',
  `init_val` bigint(18) NOT NULL DEFAULT '1' COMMENT '初始值',
  `max_val` bigint(18) NOT NULL DEFAULT '999999999' COMMENT '最大值',
  `cur_val` bigint(18) NOT NULL DEFAULT '1' COMMENT '当前值',
  `step_val` int(9) NOT NULL DEFAULT '1' COMMENT '步长',
  `cache_size` int(9) NOT NULL DEFAULT '20' COMMENT '缓冲值',
  `seq_memo` varchar(200) DEFAULT NULL COMMENT '序列描述',
  PRIMARY KEY (`seq_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='序列表';

-- 正在导出表  bohuifin.t_sequences 的数据：9 rows
DELETE FROM `t_sequences`;
/*!40000 ALTER TABLE `t_sequences` DISABLE KEYS */;
INSERT INTO `t_sequences` (`seq_name`, `init_val`, `max_val`, `cur_val`, `step_val`, `cache_size`, `seq_memo`) VALUES
	('sn_user_id', 1, 999999999, 60, 1, 20, NULL),
	('sn_manager_id', 1, 999999999, 25, 1, 20, NULL),
	('sn_dealer_id', 1, 999999999, 7, 1, 20, NULL),
	('sn_product_id', 1, 999999999, 17, 1, 20, NULL),
	('sn_product_tag_id', 1, 999999999, 12, 1, 20, NULL),
	('sn_role_id', 1, 999999999, 1, 1, 20, NULL),
	('sn_log_id', 1, 999999999, 1, 1, 20, NULL),
	('sn_access_log', 1, 999999999, 1, 1, 20, NULL),
	('sn_product_income_record_id', 1, 999999999, 5, 1, 20, NULL);
/*!40000 ALTER TABLE `t_sequences` ENABLE KEYS */;


-- 导出  表 bohuifin.t_sys_priv 结构
CREATE TABLE IF NOT EXISTS `t_sys_priv` (
  `priv_ename` varchar(50) NOT NULL COMMENT '权限名',
  `priv_cname` varchar(200) NOT NULL COMMENT '权限中文名',
  `priv_desc` varchar(200) DEFAULT NULL COMMENT '权限描述',
  `list_order` int(9) NOT NULL DEFAULT '100' COMMENT '显示序号',
  `state` int(9) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`priv_ename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统权限名表';

-- 正在导出表  bohuifin.t_sys_priv 的数据：~0 rows (大约)
DELETE FROM `t_sys_priv`;
/*!40000 ALTER TABLE `t_sys_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_sys_priv` ENABLE KEYS */;


-- 导出  表 bohuifin.t_users 结构
CREATE TABLE IF NOT EXISTS `t_users` (
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `user_name` varchar(32) NOT NULL COMMENT '用户名',
  `pwd` varchar(50) NOT NULL COMMENT '密码',
  `true_name` varchar(32) NOT NULL COMMENT '真实姓名',
  `dept_id` bigint(20) NOT NULL COMMENT '部门编号',
  `salt` varchar(20) NOT NULL,
  `authority_group_id` int(11) DEFAULT NULL COMMENT '权限ID',
  `nick_name` varchar(32) DEFAULT NULL COMMENT '昵称',
  `memo` varchar(200) DEFAULT NULL COMMENT '备注',
  `id_card` varchar(32) DEFAULT NULL COMMENT '身份证号',
  `id_card_img_font` varchar(500) DEFAULT NULL COMMENT '身份证照片（前照）',
  `id_card_img_back` varchar(500) DEFAULT NULL COMMENT '身份证照片（后照）',
  `opening_date` datetime DEFAULT NULL COMMENT '开户日期',
  `headimg` varchar(500) DEFAULT NULL COMMENT '头像',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `personal_signature` text COMMENT '个人签名',
  `list_order` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`user_id`),
  KEY `dept_id` (`dept_id`),
  KEY `FK_t_users_t_authority_group` (`authority_group_id`),
  CONSTRAINT `FK_t_users_t_authority_group` FOREIGN KEY (`authority_group_id`) REFERENCES `t_authority_group` (`authority_group_id`),
  CONSTRAINT `FK_t_users_t_dept` FOREIGN KEY (`dept_id`) REFERENCES `t_dept` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- 正在导出表  bohuifin.t_users 的数据：~8 rows (大约)
DELETE FROM `t_users`;
/*!40000 ALTER TABLE `t_users` DISABLE KEYS */;
INSERT INTO `t_users` (`user_id`, `user_name`, `pwd`, `true_name`, `dept_id`, `salt`, `authority_group_id`, `nick_name`, `memo`, `id_card`, `id_card_img_font`, `id_card_img_back`, `opening_date`, `headimg`, `email`, `personal_signature`, `list_order`, `create_time`, `create_by`, `update_time`, `update_by`, `state`) VALUES
	('18', 'admin', 'a32fd87f0fd0f12ca4bf469f373dec8e', '系统管理员', 0, 'bURDvSGmt4', 3, '系统管理员', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, '2017-06-27 17:41:10', 1, '2017-06-29 09:57:47', 1, -1),
	('28', 'root', 'c1e6830e6ae74a12bb5c841ab9e36418', '系统管理员', 0, '5qo6zUgk7y', 3, '系统管理员', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-06-29 10:27:37', 1, NULL, 0, -1),
	('30', 'administrator', 'c9d6e6bd3616ddfeab50381980356aaa', '系统管理员', 0, 'CfIuFlUIeh', 3, '系统管理员', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-06-29 10:28:22', 1, NULL, 0, -1),
	('34', 'root', 'ce7c792de27ba73bb2a33885da6cb8c8', '系统', 0, 'O5jXR6nVEu', 3, '系统', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-06-29 10:43:00', 1, '2017-06-29 10:44:20', 1, -1),
	('41', 'admin', '55ea912ccc09167c131e8245bc27580b', '系统管理员', 0, 'N3KFZIWzuW', 3, '系统管理员', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-06-29 10:52:15', 1, '2017-07-15 10:44:19', 1, 1),
	('43', 'root', '8f234974e4ee092fc7d918278d14ac99', '系统管理员', 0, '4OiXwV6JDb', 3, '系统管理员', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2017-06-29 10:52:37', 1, '2017-06-29 10:59:46', 1, 1),
	('58', 'yangzhe', '8f569e245afec8102fa77c639a256d42', '杨哲', 0, 'ph9VsSJiFy', 3, '没有昵称', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-07-15 10:52:06', 1, NULL, 0, 1),
	('60', 'andy', 'c7e60bc69a065b26125b5a45e73ebe5e', '安迪', 0, 'UFw1jBQRFO', 3, 'andy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-07-16 21:54:24', 1, NULL, 0, 1);
/*!40000 ALTER TABLE `t_users` ENABLE KEYS */;


-- 导出  表 bohuifin.t_user_accounts 结构
CREATE TABLE IF NOT EXISTS `t_user_accounts` (
  `account_id` varchar(32) NOT NULL COMMENT '账户ID',
  `account_name` varchar(100) DEFAULT NULL COMMENT '账户名称',
  `account_money` double DEFAULT NULL COMMENT '账户金额',
  `create_time` datetime DEFAULT NULL COMMENT '账户创建日期',
  `create_by` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '账户状态',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`account_id`),
  KEY `FK_Reference_1` (`user_id`),
  CONSTRAINT `FK_t_user_accounts_t_users` FOREIGN KEY (`user_id`) REFERENCES `t_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户账户信息表';

-- 正在导出表  bohuifin.t_user_accounts 的数据：~0 rows (大约)
DELETE FROM `t_user_accounts`;
/*!40000 ALTER TABLE `t_user_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_user_accounts` ENABLE KEYS */;


-- 导出  表 bohuifin.t_user_product_amount 结构
CREATE TABLE IF NOT EXISTS `t_user_product_amount` (
  `amount_id` varchar(32) NOT NULL COMMENT '表ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `product_id` varchar(32) NOT NULL COMMENT '产品ID',
  `amount` double DEFAULT NULL COMMENT '投资金额',
  `invest_time` timestamp NULL DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '投资状态（200：等待确认；1已投资）',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`amount_id`),
  KEY `FK_t_user_product_amount_t_users` (`user_id`),
  KEY `FK_t_user_product_amount_t_product` (`product_id`),
  CONSTRAINT `FK_t_user_product_amount_t_product` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`product_id`),
  CONSTRAINT `FK_t_user_product_amount_t_users` FOREIGN KEY (`user_id`) REFERENCES `t_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户产品投资金额表';

-- 正在导出表  bohuifin.t_user_product_amount 的数据：~0 rows (大约)
DELETE FROM `t_user_product_amount`;
/*!40000 ALTER TABLE `t_user_product_amount` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_user_product_amount` ENABLE KEYS */;


-- 导出  表 bohuifin.t_user_role 结构
CREATE TABLE IF NOT EXISTS `t_user_role` (
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `dept_id` bigint(18) NOT NULL COMMENT '部门ID',
  `role_id` int(9) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`dept_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `dept_id` (`dept_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `FK_t_user_role_t_dept` FOREIGN KEY (`dept_id`) REFERENCES `t_dept` (`dept_id`),
  CONSTRAINT `FK_t_user_role_t_role` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`role_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_t_user_role_t_users` FOREIGN KEY (`user_id`) REFERENCES `t_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- 正在导出表  bohuifin.t_user_role 的数据：~0 rows (大约)
DELETE FROM `t_user_role`;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
