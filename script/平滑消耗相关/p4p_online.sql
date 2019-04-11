/*
 Navicat Premium Data Transfer

 Source Server         : 123.126.94.58
 Source Server Type    : MySQL
 Source Server Version : 50619
 Source Host           : 123.126.94.58:3306
 Source Schema         : p4p_online

 Target Server Type    : MySQL
 Target Server Version : 50619
 File Encoding         : 65001

 Date: 05/12/2018 18:19:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acklog
-- ----------------------------
DROP TABLE IF EXISTS `acklog`;
CREATE TABLE `acklog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` char(24) COLLATE utf8_bin NOT NULL COMMENT '消息id',
  `exchange` varchar(45) COLLATE utf8_bin NOT NULL COMMENT 'mq exchange',
  `routingKey` varchar(45) COLLATE utf8_bin NOT NULL COMMENT 'mq rountingkey',
  `body` text CHARACTER SET utf8 NOT NULL COMMENT '消息体(json)',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态， 1 未确认 2 已确认',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '新建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mid_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=733918 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for active_rule_parameters
-- ----------------------------
DROP TABLE IF EXISTS `active_rule_parameters`;
CREATE TABLE `active_rule_parameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active_rule_id` int(11) NOT NULL,
  `rules_parameter_id` int(11) NOT NULL,
  `value` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `rules_parameter_key` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for active_rules
-- ----------------------------
DROP TABLE IF EXISTS `active_rules`;
CREATE TABLE `active_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `rule_id` int(11) NOT NULL,
  `failure_level` int(11) NOT NULL,
  `inheritance` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `created_at` bigint(20) DEFAULT NULL,
  `updated_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_profile_rule_ids` (`profile_id`,`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=500 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ad_access_service
-- ----------------------------
DROP TABLE IF EXISTS `ad_access_service`;
CREATE TABLE `ad_access_service` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `position_id` int(11) unsigned NOT NULL COMMENT '资源位id',
  `code` varchar(20) DEFAULT NULL COMMENT '接入服务编码',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `priority` tinyint(2) DEFAULT NULL COMMENT '接入服务的优先级',
  `flow_switch` tinyint(2) DEFAULT NULL COMMENT '流量开关（0-关；1-开；2-不可操作）',
  `sale_switch` tinyint(2) DEFAULT NULL COMMENT '售卖开关（0-关；1-开；2-不可操作）',
  PRIMARY KEY (`id`),
  KEY `position_id_idx` (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47735 DEFAULT CHARSET=utf8 COMMENT='广告位接入服务';

-- ----------------------------
-- Table structure for ad_channel
-- ----------------------------
DROP TABLE IF EXISTS `ad_channel`;
CREATE TABLE `ad_channel` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键自增ID',
  `code` varchar(20) DEFAULT NULL COMMENT '频道编码',
  `name` varchar(30) DEFAULT NULL COMMENT '频道名称',
  `flow_switch` tinyint(2) DEFAULT NULL COMMENT '流量开关（0-关；1-开；2-不可操作）',
  `sale_switch` tinyint(2) DEFAULT NULL COMMENT '售卖开关（0-关；1-开；2-不可操作）',
  `client` tinyint(2) DEFAULT NULL COMMENT '客户端类型:0=移动端；1=WAP端；2=PC端',
  `nex_floor_price` decimal(10,2) DEFAULT NULL COMMENT 'nex底价',
  `cpc_floor_price` decimal(10,2) DEFAULT NULL COMMENT '易效cpc底价',
  `cpm_floor_price` decimal(10,2) DEFAULT NULL COMMENT '易效cpm底价',
  `data_status` tinyint(2) DEFAULT NULL COMMENT '数据状态(0:可用;1:不可用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源位频道';

-- ----------------------------
-- Table structure for ad_channel_shielding_words
-- ----------------------------
DROP TABLE IF EXISTS `ad_channel_shielding_words`;
CREATE TABLE `ad_channel_shielding_words` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增ID',
  `channel_id` int(11) unsigned DEFAULT NULL COMMENT '频道ID',
  `name` varchar(30) DEFAULT NULL COMMENT '屏蔽词',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8 COMMENT='频道屏蔽词';

-- ----------------------------
-- Table structure for ad_column
-- ----------------------------
DROP TABLE IF EXISTS `ad_column`;
CREATE TABLE `ad_column` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键自增ID',
  `channel_id` int(11) unsigned NOT NULL COMMENT '所属频道ID',
  `code` varchar(20) DEFAULT NULL COMMENT '栏目编码',
  `name` varchar(30) DEFAULT NULL COMMENT '栏目名称',
  `flow_switch` tinyint(2) DEFAULT NULL COMMENT '流量开关（0-关；1-开；2-不可操作）',
  `sale_switch` tinyint(2) DEFAULT NULL COMMENT '售卖开关（0-关；1-开；2-不可操作）',
  `type` tinyint(2) DEFAULT NULL COMMENT '栏目类型：1-普通栏目；2-通发栏目',
  `client` tinyint(2) DEFAULT NULL COMMENT '客户端类型:0=移动端；1=WAP端；2=PC端',
  `data_status` tinyint(2) DEFAULT NULL COMMENT '数据状态(0:可用;1:不可用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源位栏目';

-- ----------------------------
-- Table structure for ad_column_batch
-- ----------------------------
DROP TABLE IF EXISTS `ad_column_batch`;
CREATE TABLE `ad_column_batch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增ID',
  `batch_column_id` int(11) unsigned NOT NULL COMMENT '通发栏目ID',
  `column_id` int(11) unsigned NOT NULL COMMENT '普通栏目ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8 COMMENT='通发资源位关系表';

-- ----------------------------
-- Table structure for ad_constant
-- ----------------------------
DROP TABLE IF EXISTS `ad_constant`;
CREATE TABLE `ad_constant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) DEFAULT '0' COMMENT '类型，1代表url黑名单',
  `content` varchar(1024) COLLATE utf8_bin DEFAULT '' COMMENT '配置内容',
  `status` tinyint(3) DEFAULT '1' COMMENT '1代表正常 0代表删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='参数';

-- ----------------------------
-- Table structure for ad_convert
-- ----------------------------
DROP TABLE IF EXISTS `ad_convert`;
CREATE TABLE `ad_convert` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `name` varchar(100) DEFAULT NULL COMMENT '转化名称',
  `source` tinyint(4) DEFAULT '1' COMMENT '转化来源（1:移动应用-API 2:落地页-JS）',
  `type` tinyint(4) DEFAULT '1' COMMENT '转化类型（1:激活 2:注册 3:拨打电话 4:表单提交 5:有效咨询 6:微信复制 7:应用下载 8:页面访问 9:购买 10:其他）',
  `scheme` tinyint(4) DEFAULT '1' COMMENT '转化方案（1:API）',
  `status` tinyint(4) DEFAULT '0' COMMENT '转化状态（0:未启用 1:启用 2:暂停 3:删除）',
  `debug_status` tinyint(4) DEFAULT '0' COMMENT '联调状态（0:未联调 1:联调成功 2:联调中 3:联调失败 4:待验证 5:活跃）',
  `turn` tinyint(4) DEFAULT '0' COMMENT '开关 （0：关闭，1 开启）',
  `feedback_url` varchar(2048) DEFAULT NULL COMMENT 'feedback_url',
  `uuid` varchar(50) DEFAULT NULL COMMENT '联调uuid',
  `reason` varchar(500) DEFAULT NULL COMMENT '联调失败原因',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` timestamp NULL DEFAULT NULL COMMENT '删除时间（转化状态修改为删除的时间）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ad_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `ad_dictionary`;
CREATE TABLE `ad_dictionary` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `code` varchar(20) DEFAULT NULL COMMENT '编码',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `type` varchar(20) DEFAULT NULL COMMENT '类型',
  `seq` tinyint(2) DEFAULT NULL COMMENT '顺序',
  `parent_id` int(11) unsigned DEFAULT NULL COMMENT '父ID',
  `flow_switch` tinyint(2) DEFAULT NULL COMMENT '流量开关（0-关；1-开；2-不可操作）',
  `sale_switch` tinyint(2) DEFAULT NULL COMMENT '售卖开关（0-关；1-开；2-不可操作）',
  `priority` tinyint(2) DEFAULT NULL COMMENT '优先级',
  `client` tinyint(2) DEFAULT NULL COMMENT '客户端类型:10-属于全部客户端；0=移动端；1=WAP端；2=PC端',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源位字典元素表';

-- ----------------------------
-- Table structure for ad_display
-- ----------------------------
DROP TABLE IF EXISTS `ad_display`;
CREATE TABLE `ad_display` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `position_id` int(11) unsigned DEFAULT NULL COMMENT '资源位id',
  `access_service_id` int(11) unsigned DEFAULT NULL COMMENT '接入服务id',
  `code` varchar(20) DEFAULT NULL COMMENT '展现形式编码',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `sale_switch` tinyint(2) DEFAULT NULL COMMENT '售卖开关（0-关；1-开；2-不可操作）',
  `style` varchar(20) DEFAULT NULL COMMENT '客户端编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=264917 DEFAULT CHARSET=utf8 COMMENT='广告位展现形式';

-- ----------------------------
-- Table structure for ad_feedback
-- ----------------------------
DROP TABLE IF EXISTS `ad_feedback`;
CREATE TABLE `ad_feedback` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `generate_style` tinyint(4) DEFAULT NULL COMMENT '生成方式 1:固定 2:一级行业 3:广告来源',
  `contents` varchar(50) DEFAULT NULL COMMENT '按钮文本',
  `engine_id` int(11) DEFAULT NULL COMMENT '负反馈唯一标识',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 1:正常 0:未发布 9:删除',
  `orders` int(11) DEFAULT NULL COMMENT '排序',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ad_industry_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `ad_industry_blacklist`;
CREATE TABLE `ad_industry_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `column_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `industry_ids` varchar(200) DEFAULT NULL COMMENT '行业黑名单关联表，多个逗号分隔',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2253 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for ad_plan
-- ----------------------------
DROP TABLE IF EXISTS `ad_plan`;
CREATE TABLE `ad_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL COMMENT '计划名称',
  `cast_speed` int(11) NOT NULL COMMENT '投放方式:1.平均  2.快速',
  `budget` double(13,2) NOT NULL DEFAULT '0.00',
  `start_date` date NOT NULL COMMENT '开始时间',
  `end_date` date DEFAULT NULL COMMENT '结束时间',
  `turn` int(11) NOT NULL COMMENT '开关  0:关 1:开',
  `ask_type` int(11) NOT NULL COMMENT '投放时段类型 0.不限  1.自定义',
  `status` int(11) NOT NULL COMMENT '状态 0.失效 1.生效',
  `creater` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时期',
  PRIMARY KEY (`id`),
  KEY `index_user_id` (`creater`)
) ENGINE=InnoDB AUTO_INCREMENT=144992 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for ad_plan_askdate
-- ----------------------------
DROP TABLE IF EXISTS `ad_plan_askdate`;
CREATE TABLE `ad_plan_askdate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ad_plan_id` bigint(20) NOT NULL COMMENT '计划id',
  `day` int(11) NOT NULL COMMENT '天',
  `hours` varchar(100) NOT NULL COMMENT '小时 用逗号分隔',
  PRIMARY KEY (`id`),
  KEY `fk_ad_plan_askdate_ad_plan_idx` (`ad_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1432775 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for ad_plan_message_flag
-- ----------------------------
DROP TABLE IF EXISTS `ad_plan_message_flag`;
CREATE TABLE `ad_plan_message_flag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ad_plan_id` bigint(20) DEFAULT NULL COMMENT '广告计划id',
  `flag` tinyint(4) DEFAULT '0' COMMENT '计划已达日限额消息标志位，0：消息未发送 1：消息已经发送',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ad_plan_id_UNIQUE` (`ad_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2505327 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ad_position
-- ----------------------------
DROP TABLE IF EXISTS `ad_position`;
CREATE TABLE `ad_position` (
  `id` bigint(20) unsigned NOT NULL,
  `crm_res_id` int(11) unsigned DEFAULT NULL COMMENT '营销平台资源id',
  `channel_id` int(11) unsigned DEFAULT NULL COMMENT '频道ID',
  `column_id` int(11) unsigned NOT NULL COMMENT '栏目主键ID',
  `column_code` varchar(20) DEFAULT NULL COMMENT '栏目编码',
  `name` varchar(30) DEFAULT NULL COMMENT '位置名称',
  `devices` varchar(10) DEFAULT NULL COMMENT '设备：1-iphone，2-android，3-ipad，以逗号间隔',
  `ad_type` varchar(20) DEFAULT NULL COMMENT '广告形式（字典表code）',
  `pos_type` varchar(20) DEFAULT NULL COMMENT '资源位类型(1:程序化&易投;2:程序化;3:易投)（字典表code）',
  `location` int(10) DEFAULT NULL COMMENT '绝对位置',
  `position` int(10) DEFAULT NULL COMMENT '相对位置',
  `flow_switch` tinyint(2) DEFAULT NULL COMMENT '流量开关（0-关；1-开；2-不可操作）',
  `sale_switch` tinyint(2) DEFAULT NULL COMMENT '售卖开关（0-关；1-开；2-不可操作）',
  `type` tinyint(2) DEFAULT NULL COMMENT '类型：1-普通资源位，2-通发资源位',
  `fixed_type` tinyint(2) DEFAULT NULL COMMENT '类型：1-固定位，2-非标位',
  `client` tinyint(2) DEFAULT NULL COMMENT '客户端类型:0=移动端；1=WAP端；2=PC端',
  `parent_id` int(11) unsigned DEFAULT NULL COMMENT '父节点id',
  `nex_floor_price` decimal(10,2) DEFAULT NULL COMMENT 'nex底价',
  `cpc_floor_price` decimal(10,2) DEFAULT NULL COMMENT '易效cpc底价',
  `cpm_floor_price` decimal(10,2) DEFAULT NULL COMMENT '易效cpm底价',
  `dsp_notice` tinyint(2) DEFAULT NULL COMMENT '是否通知dsp 0=不通知  1=通知',
  `data_status` tinyint(2) DEFAULT NULL COMMENT '数据状态(0:可用;1:不可用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(2) DEFAULT NULL COMMENT '发送状态：0-草稿，1-已发送',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告位';

-- ----------------------------
-- Table structure for ad_style_type
-- ----------------------------
DROP TABLE IF EXISTS `ad_style_type`;
CREATE TABLE `ad_style_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0',
  `name` varchar(30) COLLATE utf8_bin NOT NULL,
  `unique_code` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '唯一码，内部使用',
  `engine_code` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '引擎交互码',
  `platforms` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '支持一级平台，多个逗号分隔',
  `level` smallint(4) DEFAULT NULL COMMENT '等级：1 style 广告形式，2 type 类型',
  `weight` int(11) DEFAULT NULL COMMENT '权重',
  `status` smallint(4) DEFAULT NULL COMMENT '状态：0 不显示，1 显示',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Guang';

-- ----------------------------
-- Table structure for ad_style_type_mapping
-- ----------------------------
DROP TABLE IF EXISTS `ad_style_type_mapping`;
CREATE TABLE `ad_style_type_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `style_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `status` smallint(4) DEFAULT '1' COMMENT '状态：0 禁用，1 正常',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ad_tags
-- ----------------------------
DROP TABLE IF EXISTS `ad_tags`;
CREATE TABLE `ad_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id',
  `tag_name` varchar(45) DEFAULT NULL COMMENT '广告标签名称',
  `tag_level` tinyint(4) DEFAULT NULL COMMENT '广告标签级别',
  `tag_type` tinyint(4) DEFAULT NULL COMMENT '标签类型，0广告标签，1聚类',
  `tag_status` tinyint(3) DEFAULT '0' COMMENT '状态',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='广告标签表';

-- ----------------------------
-- Table structure for ad_yx_js_convert
-- ----------------------------
DROP TABLE IF EXISTS `ad_yx_js_convert`;
CREATE TABLE `ad_yx_js_convert` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dt` datetime DEFAULT NULL COMMENT '时间',
  `idea_id` bigint(20) DEFAULT NULL COMMENT '创意ID',
  `scheduling_id` bigint(20) DEFAULT NULL COMMENT '推广组ID',
  `adplan_id` bigint(20) DEFAULT NULL COMMENT '计划ID',
  `advertise_id` bigint(20) NOT NULL COMMENT '广告主ID',
  `network` int(11) NOT NULL COMMENT '网络环境',
  `os` int(11) NOT NULL COMMENT '操作系统',
  `province_id` bigint(20) NOT NULL COMMENT '省份编码',
  `city_id` bigint(20) NOT NULL COMMENT '城市编码',
  `convert_type` int(11) NOT NULL COMMENT '转化类型',
  `convert_count` bigint(20) NOT NULL COMMENT '转化数，当convert_type为请求数时，convert_cout和request_count值相同',
  `request_count` bigint(20) NOT NULL COMMENT '请求数',
  `convert_id` bigint(20) NOT NULL,
  `date_dd` int(11) NOT NULL COMMENT '日期到天，yyyymmdd',
  `date_hh` int(11) NOT NULL COMMENT '日期小时，hh',
  `date_mm` int(11) NOT NULL COMMENT '日期分钟，mm',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for additional_idea_turn
-- ----------------------------
DROP TABLE IF EXISTS `additional_idea_turn`;
CREATE TABLE `additional_idea_turn` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL,
  `mobile_turn` tinyint(4) NOT NULL DEFAULT '0' COMMENT '打电话开关 0 关闭 1 打开',
  `form_turn` tinyint(4) NOT NULL DEFAULT '0' COMMENT '表单收集开关 0 关闭 1 打开',
  `history_form_turn` tinyint(4) DEFAULT '0' COMMENT '表单收集是否曾经开启过',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54323 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='附加创意开关';

-- ----------------------------
-- Table structure for agent_account_info
-- ----------------------------
DROP TABLE IF EXISTS `agent_account_info`;
CREATE TABLE `agent_account_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_info_id` bigint(20) DEFAULT '0' COMMENT '代理商信息id',
  `name` varchar(200) DEFAULT NULL COMMENT '销售名称',
  `password` varchar(45) NOT NULL DEFAULT '' COMMENT '密码',
  `mail` varchar(256) NOT NULL DEFAULT '' COMMENT '邮箱',
  `status` tinyint(3) DEFAULT '1' COMMENT '状态：1 正常 2已删除',
  `role` tinyint(3) DEFAULT '1' COMMENT '角色：1 管理员，2 销售',
  `level` smallint(6) NOT NULL DEFAULT '1' COMMENT '代理商等级，从1开始',
  `login_time` timestamp NULL DEFAULT NULL COMMENT '登陆时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织结构ID',
  `user_permit` tinyint(4) DEFAULT NULL COMMENT '客户权限 1：自己+下属 2：全部',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=874 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for agent_account_role
-- ----------------------------
DROP TABLE IF EXISTS `agent_account_role`;
CREATE TABLE `agent_account_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account_id` bigint(20) NOT NULL COMMENT '代理商账号ID',
  `role_id` bigint(20) NOT NULL COMMENT '代理商角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=663 DEFAULT CHARSET=utf8 COMMENT='代理商账户-角色关联表';

-- ----------------------------
-- Table structure for agent_contactor_info
-- ----------------------------
DROP TABLE IF EXISTS `agent_contactor_info`;
CREATE TABLE `agent_contactor_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `relation_id` bigint(20) DEFAULT NULL COMMENT '数据类型关联数据主键',
  `name` varchar(50) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `type` smallint(6) DEFAULT '1' COMMENT '数据类型：1 广告主联系人，2 经销商联系人',
  `status` smallint(6) DEFAULT '1' COMMENT '状态： 1 正常',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6741 DEFAULT CHARSET=utf8 COMMENT='代理商新建客户所填写的联系人信息';

-- ----------------------------
-- Table structure for agent_info
-- ----------------------------
DROP TABLE IF EXISTS `agent_info`;
CREATE TABLE `agent_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL DEFAULT '0' COMMENT '父id',
  `agent_account_id` bigint(20) DEFAULT NULL COMMENT '代理商id（agent_account_info）',
  `agent_name` varchar(200) DEFAULT NULL COMMENT '代理商名称',
  `short_agent_name` varchar(50) DEFAULT NULL,
  `agent_code` varchar(100) DEFAULT NULL,
  `agent_url` varchar(2048) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `saler_name` varchar(50) DEFAULT NULL,
  `saler_mail` varchar(255) DEFAULT NULL,
  `saler_mobile` varchar(20) DEFAULT NULL,
  `contactor` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `mail` varchar(128) DEFAULT NULL,
  `province` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `available_balance` double(13,2) NOT NULL DEFAULT '0.00' COMMENT '可用余额',
  `recharge` double(13,2) NOT NULL DEFAULT '0.00' COMMENT '充值总额',
  `available_reward_balance` double(13,2) NOT NULL DEFAULT '0.00' COMMENT '可用返点额--弃用',
  `reward_recharge` double(13,2) NOT NULL DEFAULT '0.00' COMMENT '充值总额返点',
  `level` smallint(6) NOT NULL DEFAULT '1' COMMENT '代理商等级，从1开始',
  `salesman_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '对应销售id',
  `status` smallint(4) DEFAULT '1' COMMENT '状态：1 正常',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  `pay_type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '支付方式： 1.预充值 2.后付费',
  `operation_id` bigint(20) DEFAULT '0' COMMENT '对应运营',
  `vip_level` tinyint(3) DEFAULT '0' COMMENT '0代表普通，1代表vip',
  `history_vip_level` tinyint(3) DEFAULT '0' COMMENT '历史最高vip级别',
  `least_budget` int(11) DEFAULT NULL COMMENT '广告主剩余预算最小值',
  `least_budget_percent` tinyint(4) DEFAULT NULL COMMENT '广告主剩余预算最小百分比',
  `least_balance` int(11) DEFAULT NULL COMMENT '广告主账户余额最小值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqe_agent_code` (`agent_code`)
) ENGINE=InnoDB AUTO_INCREMENT=491 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for agent_organization
-- ----------------------------
DROP TABLE IF EXISTS `agent_organization`;
CREATE TABLE `agent_organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT '组织结构名称',
  `parent_id` bigint(20) NOT NULL COMMENT '父节点ID',
  `agent_info_id` bigint(20) NOT NULL COMMENT '代理商信息ID',
  `level` tinyint(4) NOT NULL COMMENT '组织结构的等级 1:一级 2:二级 3:三级 以此类推',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=667 DEFAULT CHARSET=utf8 COMMENT='代理商组织结构表';

-- ----------------------------
-- Table structure for agent_organization_relation
-- ----------------------------
DROP TABLE IF EXISTS `agent_organization_relation`;
CREATE TABLE `agent_organization_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `org_id` bigint(20) NOT NULL COMMENT '组织结构节点ID',
  `org_child_id` bigint(20) NOT NULL COMMENT '组织结构子节点ID',
  `depth` int(11) NOT NULL COMMENT '父节点与子节点层级关系',
  `agent_info_id` bigint(20) NOT NULL COMMENT '代理商信息ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_agent_org_relation_unique` (`org_id`,`org_child_id`,`depth`)
) ENGINE=InnoDB AUTO_INCREMENT=1207 DEFAULT CHARSET=utf8 COMMENT='组织结构关系表';

-- ----------------------------
-- Table structure for agent_permission
-- ----------------------------
DROP TABLE IF EXISTS `agent_permission`;
CREATE TABLE `agent_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `type` tinyint(4) DEFAULT '1' COMMENT '预留字段-权限类型 1：菜单 2：功能点',
  `url` varchar(100) DEFAULT NULL COMMENT '预留字段-菜单url地址',
  `code` varchar(50) NOT NULL COMMENT '权限编码',
  `parent_id` bigint(20) NOT NULL COMMENT '父节点ID',
  `available` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否可用 0：不可用 1：可用',
  `orders` int(11) DEFAULT NULL COMMENT '排序字段',
  `level` tinyint(4) NOT NULL COMMENT '功能权限的等级 1:一级 2:二级 3:三级 以此类推',
  `agent_level` tinyint(4) NOT NULL COMMENT '代理商等级 1:一级代理商 2:二级代理商',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8 COMMENT='代理商权限表';

-- ----------------------------
-- Table structure for agent_role
-- ----------------------------
DROP TABLE IF EXISTS `agent_role`;
CREATE TABLE `agent_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `available` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否可用 0：不可用 1：可用',
  `manager` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否是管理员 0：非管理员 1：管理员',
  `agent_info_id` bigint(20) NOT NULL COMMENT '代理商信息ID',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8 COMMENT='代理商角色表';

-- ----------------------------
-- Table structure for agent_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `agent_role_permission`;
CREATE TABLE `agent_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `permission_id` bigint(20) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18001 DEFAULT CHARSET=utf8 COMMENT='代理商角色-权限关系表';

-- ----------------------------
-- Table structure for anti_attack_log
-- ----------------------------
DROP TABLE IF EXISTS `anti_attack_log`;
CREATE TABLE `anti_attack_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(20) DEFAULT NULL COMMENT '用户名',
  `locus` varchar(255) DEFAULT NULL COMMENT '手机号',
  `device_id` varchar(255) DEFAULT NULL COMMENT '设备id',
  `ip` varchar(20) DEFAULT NULL COMMENT 'ip地址',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `user_name_index` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NOT NULL COMMENT '父节点id',
  `code` varchar(45) NOT NULL,
  `level` varchar(50) DEFAULT NULL COMMENT '级别,第几级节点',
  `name` varchar(50) NOT NULL COMMENT '地区名称',
  `status` int(11) NOT NULL COMMENT '0:删除,\n1:正常',
  `description` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_area_pid` (`parent_id`),
  KEY `idx_area_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=486 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for authors
-- ----------------------------
DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_author_logins` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bid
-- ----------------------------
DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `ad_style` int(11) DEFAULT NULL COMMENT '广告形式',
  `platform` int(11) DEFAULT NULL COMMENT '一级平台',
  `way` tinyint(4) DEFAULT NULL COMMENT '出价方式 0:cpm 1:cpc',
  `limits` varchar(50) DEFAULT NULL COMMENT '出价范围',
  `pay` double DEFAULT NULL COMMENT '出价',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for blacklist_info
-- ----------------------------
DROP TABLE IF EXISTS `blacklist_info`;
CREATE TABLE `blacklist_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '广告主id',
  `top_agent_id` bigint(20) DEFAULT NULL COMMENT '所属顶级代理商',
  `platform` int(11) DEFAULT NULL COMMENT '禁投平台类型',
  `request_param` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '请求参数',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：0 无效， 1 正常',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='黑名单';

-- ----------------------------
-- Table structure for bussiness_nature
-- ----------------------------
DROP TABLE IF EXISTS `bussiness_nature`;
CREATE TABLE `bussiness_nature` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态：1 正常',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='公司性质';

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NOT NULL DEFAULT '0' COMMENT '父级id',
  `category` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目码',
  `platform` tinyint(4) DEFAULT NULL COMMENT '平台11：网易新闻',
  `sub_platform` tinyint(4) DEFAULT NULL COMMENT '二级平台1：网易新闻客户端 2：手机网易网 8：厂商资源',
  `third_platform` tinyint(4) DEFAULT NULL COMMENT '三级平台',
  `platform_type` tinyint(4) DEFAULT NULL COMMENT '平台类型1：栏目信息流 2：文章底部信息流',
  `level` tinyint(4) DEFAULT NULL COMMENT '层级,从1开始',
  `name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1：正常',
  `orders` int(11) DEFAULT NULL COMMENT '排序字段',
  `engine_type` int(11) DEFAULT NULL COMMENT '平台字段引擎交互码',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=355 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='行业分类';

-- ----------------------------
-- Table structure for category_item
-- ----------------------------
DROP TABLE IF EXISTS `category_item`;
CREATE TABLE `category_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_id` bigint(20) NOT NULL COMMENT '页面上显示的栏目ID（多对一）关系',
  `ad_column_id` bigint(20) DEFAULT NULL COMMENT '运管推送栏目ID',
  `name` varchar(30) NOT NULL COMMENT '栏目名称',
  `code` varchar(50) NOT NULL COMMENT '栏目编码',
  `platform` tinyint(4) DEFAULT NULL COMMENT '平台11：网易新闻',
  `sub_platform` tinyint(4) DEFAULT NULL COMMENT '二级平台1：网易新闻客户端 2：手机网易网 8：厂商资源',
  `third_platform` tinyint(4) DEFAULT NULL COMMENT '三级平台',
  `platform_type` tinyint(4) DEFAULT NULL COMMENT '平台类型1：栏目信息流 2：文章底部信息流',
  `type` tinyint(4) DEFAULT NULL COMMENT '栏目编码类型1：通用 2：ipad 3：ios 4：android 5：乐视负二屏 11：网易号编码 12：频道编码 13：栏目category',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 1：正常',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=830 DEFAULT CHARSET=utf8 COMMENT='栏目详情';

-- ----------------------------
-- Table structure for category_package
-- ----------------------------
DROP TABLE IF EXISTS `category_package`;
CREATE TABLE `category_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '广告主ID',
  `name` varchar(50) NOT NULL COMMENT '栏目包名称',
  `category_id` varchar(2000) DEFAULT NULL COMMENT '栏目ID英文逗号分隔',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='自定义栏目包';

-- ----------------------------
-- Table structure for category_package_item
-- ----------------------------
DROP TABLE IF EXISTS `category_package_item`;
CREATE TABLE `category_package_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '广告主ID',
  `category_package_id` bigint(20) NOT NULL COMMENT '栏目包ID',
  `platform` tinyint(4) NOT NULL COMMENT '平台11：网易新闻',
  `sub_platform` tinyint(4) NOT NULL COMMENT '二级平台1：网易新闻客户端 2：手机网易网 8：厂商资源',
  `platform_type` tinyint(4) NOT NULL COMMENT '平台类型1：栏目信息流 2：文章底部信息流',
  `category_id` varchar(1000) DEFAULT NULL COMMENT '栏目ID英文逗号分隔',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_package_id` (`category_package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='栏目包详细信息';

-- ----------------------------
-- Table structure for ce_activity
-- ----------------------------
DROP TABLE IF EXISTS `ce_activity`;
CREATE TABLE `ce_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) COLLATE utf8_bin NOT NULL,
  `task_type` varchar(15) COLLATE utf8_bin NOT NULL,
  `component_uuid` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(15) COLLATE utf8_bin NOT NULL,
  `is_last` tinyint(1) NOT NULL,
  `is_last_key` varchar(55) COLLATE utf8_bin NOT NULL,
  `submitter_login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `submitted_at` bigint(20) NOT NULL,
  `started_at` bigint(20) DEFAULT NULL,
  `executed_at` bigint(20) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  `execution_time_ms` bigint(20) DEFAULT NULL,
  `analysis_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `error_message` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `error_stacktrace` longtext COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ce_activity_uuid` (`uuid`),
  KEY `ce_activity_component_uuid` (`component_uuid`),
  KEY `ce_activity_islastkey` (`is_last_key`),
  KEY `ce_activity_islast_status` (`is_last`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ce_queue
-- ----------------------------
DROP TABLE IF EXISTS `ce_queue`;
CREATE TABLE `ce_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) COLLATE utf8_bin NOT NULL,
  `task_type` varchar(15) COLLATE utf8_bin NOT NULL,
  `component_uuid` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(15) COLLATE utf8_bin NOT NULL,
  `submitter_login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `started_at` bigint(20) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ce_queue_uuid` (`uuid`),
  KEY `ce_queue_component_uuid` (`component_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ce_scanner_context
-- ----------------------------
DROP TABLE IF EXISTS `ce_scanner_context`;
CREATE TABLE `ce_scanner_context` (
  `task_uuid` varchar(40) COLLATE utf8_bin NOT NULL,
  `context_data` longblob NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`task_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ce_task_input
-- ----------------------------
DROP TABLE IF EXISTS `ce_task_input`;
CREATE TABLE `ce_task_input` (
  `task_uuid` varchar(40) COLLATE utf8_bin NOT NULL,
  `input_data` longblob,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`task_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for city_demo
-- ----------------------------
DROP TABLE IF EXISTS `city_demo`;
CREATE TABLE `city_demo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=432432219801 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for collector_view
-- ----------------------------
DROP TABLE IF EXISTS `collector_view`;
CREATE TABLE `collector_view` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `counts` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for configure_account_info
-- ----------------------------
DROP TABLE IF EXISTS `configure_account_info`;
CREATE TABLE `configure_account_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(63) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '邮箱前缀',
  `name` varchar(63) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '名字',
  `role_id` bigint(20) DEFAULT '0' COMMENT '账号的roleId',
  `status` tinyint(3) DEFAULT '1' COMMENT '1代表正常 0代表删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mail_prefix` (`nick_name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配置平台账号信息';

-- ----------------------------
-- Table structure for configure_permission
-- ----------------------------
DROP TABLE IF EXISTS `configure_permission`;
CREATE TABLE `configure_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT '0',
  `name` varchar(63) COLLATE utf8mb4_bin DEFAULT '' COMMENT '列表名',
  `url` varchar(255) COLLATE utf8mb4_bin DEFAULT '' COMMENT 'url',
  `code` varchar(10) CHARACTER SET utf8mb4 DEFAULT '' COMMENT 'code',
  `type` tinyint(3) DEFAULT '1' COMMENT '1代表菜单 2代表按钮',
  `orders` int(11) DEFAULT '1' COMMENT '顺序',
  `status` tinyint(3) DEFAULT '1' COMMENT '1代表正常0代表删除',
  `level` tinyint(3) DEFAULT '1' COMMENT 'level',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='权限列表';

-- ----------------------------
-- Table structure for configure_role
-- ----------------------------
DROP TABLE IF EXISTS `configure_role`;
CREATE TABLE `configure_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(63) COLLATE utf8mb4_bin DEFAULT '' COMMENT '类型名称',
  `role_type` tinyint(3) DEFAULT '1' COMMENT '1代表管理员 2代表普通成员',
  `status` tinyint(3) DEFAULT '1' COMMENT '1代表正常 0代表删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='账号类型';

-- ----------------------------
-- Table structure for configure_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `configure_role_permission`;
CREATE TABLE `configure_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL,
  `permission_id` bigint(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(3) DEFAULT '1' COMMENT '1代表正常',
  PRIMARY KEY (`id`),
  KEY `idx_role` (`role_id`,`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for contract_info
-- ----------------------------
DROP TABLE IF EXISTS `contract_info`;
CREATE TABLE `contract_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` bigint(20) DEFAULT '0' COMMENT '营销平台合同id',
  `agent_info_id` bigint(20) DEFAULT '0' COMMENT '代理商id',
  `order_number` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '合同号，对应agent_info的agent_code',
  `customer_code` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '客户编码',
  `sales` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '所属销售',
  `status` tinyint(3) DEFAULT '0' COMMENT '合同状态 1:正常 2:废弃',
  `start_time` date DEFAULT NULL COMMENT '合同生效时间',
  `end_time` date DEFAULT NULL COMMENT '合同失效时间',
  `pay_type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '冗余自agentinfo的付费类型。1.预充值 2.后付费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='合同信息';

-- ----------------------------
-- Table structure for contract_info2
-- ----------------------------
DROP TABLE IF EXISTS `contract_info2`;
CREATE TABLE `contract_info2` (
  `id` double NOT NULL,
  `app_id` double DEFAULT NULL,
  `agent_info_id` double DEFAULT NULL,
  `order_number` varchar(765) DEFAULT NULL,
  `customer_code` varchar(765) DEFAULT NULL,
  `sales` varchar(765) DEFAULT NULL,
  `status` tinyint(3) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for counselor_info
-- ----------------------------
DROP TABLE IF EXISTS `counselor_info`;
CREATE TABLE `counselor_info` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '企业名称',
  `user_name` varchar(63) COLLATE utf8_bin DEFAULT '' COMMENT '用户名',
  `mobile_phone` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '电话',
  `mail` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '邮箱',
  `origin_from` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '来源',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='广告顾问来电服务';

-- ----------------------------
-- Table structure for creative_ad_tag
-- ----------------------------
DROP TABLE IF EXISTS `creative_ad_tag`;
CREATE TABLE `creative_ad_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creative_id` bigint(20) DEFAULT NULL,
  `ad_tag_id` bigint(20) DEFAULT NULL,
  `creative_status` tinyint(3) DEFAULT '0',
  `update_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=469719 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credential_info
-- ----------------------------
DROP TABLE IF EXISTS `credential_info`;
CREATE TABLE `credential_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `credential_name` varchar(45) DEFAULT NULL COMMENT '资质名称',
  `credential_type` int(11) DEFAULT NULL COMMENT '资质类型 0-营业执照,1-ICP备案,2-身份证复印件,100-创意明星资质',
  `credential_property` tinyint(3) DEFAULT NULL COMMENT '0为必备资质，1为选填资质',
  `url` varchar(512) DEFAULT NULL COMMENT '资质url地址',
  `file_name` varchar(45) DEFAULT NULL COMMENT '文件名称',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0- 审核中 1 - 审核通过 2 - 审核未通过',
  `descript` varchar(512) DEFAULT NULL COMMENT '描述',
  `auditing_time` timestamp NULL DEFAULT NULL COMMENT '审核时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `is_perpetual` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否永久性：0 否  1 是',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45002 DEFAULT CHARSET=utf8 COMMENT='资质信息表';

-- ----------------------------
-- Table structure for credential_info_copy
-- ----------------------------
DROP TABLE IF EXISTS `credential_info_copy`;
CREATE TABLE `credential_info_copy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `credential_name` varchar(45) DEFAULT NULL COMMENT '资质名称',
  `credential_type` int(11) DEFAULT NULL COMMENT '资质类型 0-营业执照,1-ICP备案,2-身份证复印件,100-创意明星资质',
  `credential_property` tinyint(4) DEFAULT NULL,
  `url` varchar(512) DEFAULT NULL COMMENT '资质url地址',
  `file_name` varchar(45) DEFAULT NULL COMMENT '文件名称',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '资质有效开始时间',
  `end_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0- 审核中 1 - 审核通过 2 - 审核未通过',
  `descript` varchar(512) DEFAULT NULL COMMENT '描述',
  `auditing_time` timestamp NULL DEFAULT NULL COMMENT '审核时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `is_perpetual` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否永久性：0 否  1 是',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资质信息表';

-- ----------------------------
-- Table structure for credential_item
-- ----------------------------
DROP TABLE IF EXISTS `credential_item`;
CREATE TABLE `credential_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `credential_info_id` bigint(20) DEFAULT NULL COMMENT '资质信息主表ID',
  `file_name` varchar(45) DEFAULT NULL COMMENT '文件名称',
  `url` varchar(512) DEFAULT NULL COMMENT '资质url地址',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45067 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for credential_summary
-- ----------------------------
DROP TABLE IF EXISTS `credential_summary`;
CREATE TABLE `credential_summary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '广告主ID',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0:-- 1:审核中 2:未通过 3:已通过 4:已失效',
  `is_lack` tinyint(4) DEFAULT NULL COMMENT '是否缺少资质 0:否 1:是',
  `descript` varchar(512) DEFAULT NULL COMMENT '描述',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=956 DEFAULT CHARSET=utf8 COMMENT='资质总状态';

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '设备名称',
  `unique_code` int(11) DEFAULT NULL COMMENT '唯一码，内部使用',
  `engine_code` int(11) DEFAULT NULL COMMENT '引擎交互编码',
  `orders` int(11) DEFAULT NULL COMMENT '排序字段',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 1：正常',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for device_relation
-- ----------------------------
DROP TABLE IF EXISTS `device_relation`;
CREATE TABLE `device_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `device_unique_code` int(11) DEFAULT NULL COMMENT '设备定向内部编码',
  `relation_unique_code` int(11) DEFAULT NULL COMMENT '与设备关联定向的内部编码',
  `type` tinyint(4) DEFAULT NULL COMMENT '定向类型1：广告形式 2：一级平台 3：二级平台',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for diagnosis
-- ----------------------------
DROP TABLE IF EXISTS `diagnosis`;
CREATE TABLE `diagnosis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scheduling_info_id` bigint(20) NOT NULL COMMENT '推广组id',
  `t` double(10,6) NOT NULL COMMENT '填充率:易效胜出数/易效库存',
  `stocks` int(11) NOT NULL COMMENT '易效库存',
  `win_count` int(11) NOT NULL COMMENT '易效胜出数',
  `views` int(11) NOT NULL COMMENT '曝光数',
  `e25` double(10,6) NOT NULL,
  `e80` double(10,6) NOT NULL,
  `lt_e25_views` int(11) NOT NULL COMMENT '小于e25曝光数',
  `p25` double(10,6) NOT NULL,
  `lt_p25_views` int(11) NOT NULL COMMENT '小于p25曝光数',
  `c25` double(10,6) NOT NULL,
  `lt_c25_views` int(11) NOT NULL COMMENT '小于c25曝光数',
  `p80` double(10,6) NOT NULL,
  `cost_way` tinyint(2) NOT NULL COMMENT '投放类型0:cpm 1:cpc',
  `result_type` tinyint(4) NOT NULL COMMENT '诊断结果类型',
  `time` datetime NOT NULL COMMENT '诊断时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 1 正常 0 删除',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_scheduling_info_id_time` (`scheduling_info_id`,`time`),
  KEY `index_scheduling_info_id` (`scheduling_info_id`),
  KEY `index_time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告诊断';

-- ----------------------------
-- Table structure for diagnosis_config
-- ----------------------------
DROP TABLE IF EXISTS `diagnosis_config`;
CREATE TABLE `diagnosis_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `t` double(10,6) NOT NULL,
  `x` double(10,6) NOT NULL COMMENT '大于等于t的x值',
  `y` double(10,6) NOT NULL COMMENT '大于等于t的y值',
  `z` double(10,6) DEFAULT NULL COMMENT '大于等于t的z值',
  `x1` double(10,6) NOT NULL COMMENT '小于t的x值',
  `y1` double(10,6) NOT NULL COMMENT '小于t的y值',
  `z1` double(10,6) NOT NULL COMMENT '小于t的z值',
  `status` tinyint(4) NOT NULL COMMENT '状态 0未发布 1发布',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='广告诊断配置';

-- ----------------------------
-- Table structure for dimension_statistics
-- ----------------------------
DROP TABLE IF EXISTS `dimension_statistics`;
CREATE TABLE `dimension_statistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'userId',
  `dimension_id` bigint(20) DEFAULT NULL COMMENT '推广计划id, 推广组id,创意id',
  `dimension_type` tinyint(4) DEFAULT NULL COMMENT '1-推广计划、2-推广组、3-创意',
  `total_cost` double(16,5) DEFAULT NULL COMMENT '总花费',
  `total_show` bigint(20) DEFAULT NULL COMMENT '总曝光',
  `total_click` bigint(20) DEFAULT NULL COMMENT '总点击',
  `cost_per_thousand_show` double(16,5) DEFAULT NULL COMMENT '千次展现成本',
  `average_click_cost` double(16,5) DEFAULT NULL COMMENT '平均点击成本',
  `daily_chain` double(10,4) DEFAULT NULL COMMENT '日环比',
  `active_count` int(11) NOT NULL DEFAULT '0' COMMENT '激活数量',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态',
  `date_time` date DEFAULT NULL COMMENT '日期',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `page_dialing` int(11) NOT NULL DEFAULT '0' COMMENT '落地页拨打电话',
  `page_submit_form` int(11) NOT NULL DEFAULT '0' COMMENT '落地页提交表单',
  `page_effective_consultation` int(11) NOT NULL DEFAULT '0' COMMENT '落地页有效咨询',
  `page_weixin_copy` int(11) NOT NULL DEFAULT '0' COMMENT '落地页微信复制',
  `page_app_download` int(11) NOT NULL DEFAULT '0' COMMENT '落地页应用下载',
  `page_page_views` int(11) NOT NULL DEFAULT '0' COMMENT '落地页页面访问',
  `page_other` int(11) NOT NULL DEFAULT '0' COMMENT '落地页其他',
  PRIMARY KEY (`id`),
  KEY `idx_userid` (`user_id`),
  KEY `idx_dimension` (`dimension_id`,`dimension_type`),
  KEY `idx_datetime` (`date_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5421490 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for directional_package
-- ----------------------------
DROP TABLE IF EXISTS `directional_package`;
CREATE TABLE `directional_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '定向包名称',
  `user_id` bigint(20) NOT NULL COMMENT '广告主id',
  `device` varchar(50) NOT NULL DEFAULT '1' COMMENT '设备分类',
  `system` varchar(50) NOT NULL DEFAULT '0' COMMENT '操作系统 3.IOS/ANDROID  2. IOS  1.ANDROID',
  `network` varchar(50) NOT NULL DEFAULT '0' COMMENT '网络环境 0.不限 1.wifi 2.4G 3.3G 4.其它',
  `network_operator` varchar(20) NOT NULL DEFAULT '0' COMMENT '网络运营商',
  `device_price` varchar(45) NOT NULL DEFAULT '0' COMMENT '设备价格","分割例如1,2,3',
  `ad_formats` varchar(20) NOT NULL DEFAULT '0' COMMENT '广告形式',
  `platform` int(11) NOT NULL DEFAULT '0' COMMENT '平台',
  `area` text COMMENT '地域',
  `persons` text COMMENT '人群定向',
  `person_select_type` tinyint(4) DEFAULT NULL COMMENT '人群定向包类型： 1 包含 2 排除',
  `sex` varchar(50) NOT NULL,
  `age` varchar(50) NOT NULL,
  `interest` text COMMENT '兴趣',
  `app_type` varchar(16) NOT NULL DEFAULT '0' COMMENT 'APP行为定向，多个用逗号隔开 0：不限，1：非游戏，2：游戏; 例如："1,2"',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 1 正常 0 删除',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_userid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=288791 DEFAULT CHARSET=utf8mb4 COMMENT='推广组定向包';

-- ----------------------------
-- Table structure for idea_config
-- ----------------------------
DROP TABLE IF EXISTS `idea_config`;
CREATE TABLE `idea_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unique_code` bigint(20) DEFAULT '0' COMMENT '唯一码,关联的是idea_info中的type',
  `material_config_unique_codes` varchar(256) CHARACTER SET utf8 DEFAULT '' COMMENT '素材类型ids json',
  `material_count` int(11) DEFAULT '1' COMMENT '素材数量，和上面的ids正相关',
  `show_type` tinyint(3) DEFAULT '1' COMMENT '展示状态1代表显示，0代表隐藏',
  `title_min_length` int(11) DEFAULT '0' COMMENT '标题最小长度(字节)',
  `title_max_length` int(11) DEFAULT '0' COMMENT '标题最大长度(字节)',
  `desc_min_length` int(11) DEFAULT '0' COMMENT '创意描述最少长度(字节)',
  `desc_max_length` int(11) DEFAULT '0' COMMENT '创意描述最大长度(字节)',
  `scheduling_condition` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '推官组关联条件，json结构',
  `description` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '描述',
  `code` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '送审code',
  `style` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT 'style',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `has_title` tinyint(3) DEFAULT '0' COMMENT '0代表没有标题 1代表有标题',
  `has_ios_url` tinyint(3) DEFAULT '0' COMMENT '0代表没有ios下载url 1代表有',
  `has_android_url` tinyint(3) DEFAULT '0' COMMENT '0代表没有安卓下载url 1代表有',
  `has_idea_desc` tinyint(3) DEFAULT '0' COMMENT '0代表没有创意描述 1代表有',
  `has_phone_form` tinyint(3) DEFAULT '0' COMMENT '是否有表单收集/手机号功能',
  `has_ad_interact` tinyint(4) DEFAULT '0' COMMENT '是否有关闭广告互动 1是 0否',
  `has_ad_feedback` tinyint(4) DEFAULT '0' COMMENT '是否有广告负反馈 1:是 0:否',
  `has_deeplink` tinyint(4) DEFAULT '0' COMMENT '是否有deeplink 1:是 0:否',
  `name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '展现形式',
  `model_num` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `status` tinyint(3) DEFAULT '1' COMMENT '状态 0未发布 1发布',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `size_desc` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '创意尺寸描述',
  `clip` tinyint(4) DEFAULT '-1' COMMENT '1为裁剪，0为不裁剪',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_code` (`unique_code`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='创意类型';

-- ----------------------------
-- Table structure for idea_info
-- ----------------------------
DROP TABLE IF EXISTS `idea_info`;
CREATE TABLE `idea_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `scheduling_info_id` bigint(20) DEFAULT NULL COMMENT '推广组id',
  `idea_type` tinyint(4) DEFAULT NULL COMMENT '创意展现形式',
  `name` varchar(30) DEFAULT NULL COMMENT '创意名称',
  `title` varchar(100) DEFAULT NULL COMMENT '创意标题',
  `turn` tinyint(4) DEFAULT NULL COMMENT '开关 0 - 关闭 1 - 开启',
  `direct_url` varchar(2048) DEFAULT NULL COMMENT '目标网址',
  `android_url` varchar(2048) DEFAULT NULL COMMENT '下载类 android_url',
  `ios_url` varchar(2048) DEFAULT NULL COMMENT '下载类 ios_url',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0 - 审核中 1 - 审核通过 2 - 审核未通过',
  `descript` text COMMENT '描述',
  `auditing_time` timestamp NULL DEFAULT NULL COMMENT '审核时间',
  `is_pending` tinyint(4) DEFAULT NULL COMMENT '是否待审',
  `is_idea_credential_pending` tinyint(3) DEFAULT '0' COMMENT '创意资质送审',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `is_delete` tinyint(3) DEFAULT '0',
  `platform` int(11) DEFAULT '3' COMMENT '平台类型，同scheduling_info的platform',
  `platform_new` varchar(255) DEFAULT '' COMMENT '子平台标识',
  `idea_desc` varchar(512) DEFAULT NULL COMMENT '创意描述',
  `source` varchar(16) DEFAULT NULL COMMENT '创意来源',
  `load_page_update` int(11) DEFAULT '0' COMMENT '落地页内容是否发生变更 没变更 0 （默认） 变更 1；',
  `btn_type` tinyint(3) DEFAULT '0' COMMENT '按钮文本类型 1 立即报名 2立即预约',
  `telephone` varchar(64) DEFAULT '' COMMENT '拨打电话：电话号；',
  `has_form_name` tinyint(3) DEFAULT '0' COMMENT '是否有表单收集：姓名 0代表没有 1代表有',
  `ext_type` tinyint(3) DEFAULT '0' COMMENT '附加创意类型，0 没有，1：拨打电话，2：表单',
  `has_form_phone` tinyint(3) DEFAULT '0' COMMENT '是否有表单：电话 0代表没有 1代表有',
  `close_ad_interact` tinyint(4) DEFAULT '1' COMMENT '关闭广告互动 1：是 0：否',
  `doc_id` varchar(50) DEFAULT NULL COMMENT '主贴ID',
  `deeplink` varchar(2048) DEFAULT NULL COMMENT 'deeplink网址',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `scheduling_info_id_index` (`scheduling_info_id`),
  KEY `idx_direct_url` (`direct_url`(50))
) ENGINE=InnoDB AUTO_INCREMENT=727508 DEFAULT CHARSET=utf8 COMMENT='推广创意表';

-- ----------------------------
-- Table structure for idea_material_mapping
-- ----------------------------
DROP TABLE IF EXISTS `idea_material_mapping`;
CREATE TABLE `idea_material_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL,
  `idea_info_id` bigint(20) DEFAULT NULL COMMENT '创意id',
  `material_info_id` bigint(20) DEFAULT NULL COMMENT '资源id',
  `position_num` tinyint(3) DEFAULT NULL COMMENT '素材位置',
  `scene` tinyint(4) DEFAULT NULL COMMENT '使用场景\n0-封面 1-素材',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1051487 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for idea_tag_mapping
-- ----------------------------
DROP TABLE IF EXISTS `idea_tag_mapping`;
CREATE TABLE `idea_tag_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `industry_level2_id` bigint(20) DEFAULT '0',
  `tag_id` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for interest
-- ----------------------------
DROP TABLE IF EXISTS `interest`;
CREATE TABLE `interest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '编码',
  `parent_code` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT '父编码 ',
  `level` int(11) NOT NULL COMMENT '层级',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '名字',
  `status` int(11) DEFAULT NULL COMMENT '0:删除,\n1:正常',
  `orders` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for interest_item
-- ----------------------------
DROP TABLE IF EXISTS `interest_item`;
CREATE TABLE `interest_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(255) DEFAULT NULL COMMENT '兴趣编码',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `interest_id` bigint(20) DEFAULT NULL COMMENT '基础兴趣ID',
  `interest_code` varchar(255) DEFAULT NULL COMMENT '基础兴趣编码',
  `orders` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for internal_properties
-- ----------------------------
DROP TABLE IF EXISTS `internal_properties`;
CREATE TABLE `internal_properties` (
  `kee` varchar(20) COLLATE utf8_bin NOT NULL,
  `is_empty` tinyint(1) NOT NULL,
  `text_value` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `clob_value` longtext COLLATE utf8_bin,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`kee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for invoice
-- ----------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL COMMENT '发票抬头',
  `money` double NOT NULL COMMENT '发票金额',
  `item` tinyint(4) NOT NULL COMMENT '发票项目：1 广告费  2 广告发布费',
  `type` tinyint(4) NOT NULL COMMENT '发票类型：1 增值税普票 2 增值税专票',
  `company_name` varchar(42) NOT NULL COMMENT '公司名称',
  `bank` varchar(100) NOT NULL COMMENT '开户行',
  `account` varchar(20) NOT NULL COMMENT '银行账户',
  `taxpayer_code` varchar(20) NOT NULL COMMENT '纳税人识别码',
  `company_address` varchar(200) NOT NULL COMMENT '公司地址',
  `company_telephone` varchar(20) NOT NULL COMMENT '公司电话',
  `contacts_name` varchar(100) NOT NULL COMMENT '联系人姓名',
  `contacts_telephone` varchar(20) NOT NULL COMMENT '联系人电话',
  `postal_address` varchar(200) NOT NULL COMMENT '邮寄地址',
  `credential_url` varchar(200) NOT NULL COMMENT '资质文件url地址',
  `credential_valid_date` datetime NOT NULL COMMENT '资质有效日期',
  `status` tinyint(4) NOT NULL COMMENT '状态: 1 未开具，2 未邮寄， 3 已邮寄， 4  已拒绝， 5  已作废',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '申请时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '处理时间',
  `main_agent_id` bigint(20) DEFAULT NULL COMMENT '代理商账户ID',
  PRIMARY KEY (`id`),
  KEY `index_state` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for invoice_apply
-- ----------------------------
DROP TABLE IF EXISTS `invoice_apply`;
CREATE TABLE `invoice_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '发票ID',
  `dsp_id` bigint(20) DEFAULT NULL COMMENT 'DSP ID',
  `apply_amount` bigint(16) DEFAULT NULL COMMENT '申请金额(单位元*100，如101代表1.01元)',
  `invoice_type` tinyint(4) NOT NULL COMMENT '发票类型，1 - 增值税普票， 2 - 增值税专票',
  `invoice_title` varchar(150) DEFAULT NULL COMMENT '发票抬头',
  `invoice_item_type` tinyint(4) DEFAULT NULL COMMENT '发票项目：1-广告费 2-广告发布费',
  `invoice_amount` decimal(16,2) DEFAULT NULL COMMENT '发票金额(此字段暂无用)',
  `corp_name` varchar(150) DEFAULT NULL COMMENT '公司名称',
  `corp_rate_code` varchar(20) DEFAULT NULL COMMENT '纳税人识别码',
  `corp_address` varchar(400) DEFAULT NULL COMMENT '地址',
  `corp_bank` varchar(150) DEFAULT NULL COMMENT '开户行',
  `corp_bank_account` varchar(20) DEFAULT NULL COMMENT '银行账号',
  `corp_tel` varchar(100) DEFAULT NULL COMMENT '电话',
  `corp_cert_url` varchar(2048) DEFAULT NULL COMMENT '资质文件URL',
  `corp_cert_begin` datetime DEFAULT NULL COMMENT '资质有效期开始',
  `corp_cert_end` datetime DEFAULT NULL COMMENT '资质有效期结束',
  `contact_person` varchar(150) DEFAULT NULL COMMENT '联系人姓名',
  `contact_address` varchar(400) DEFAULT NULL COMMENT '地址',
  `contact_email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `contact_tel` varchar(20) DEFAULT NULL COMMENT '电话',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态, 0 - 未开具， 1 - 未邮寄， 2 - 已邮寄， 3 - 已作废， 4 - 已拒绝',
  `last_status` tinyint(4) DEFAULT NULL COMMENT '上一状态',
  `first_commit` tinyint(4) DEFAULT NULL COMMENT '是否首次提交: 1 是， 0 否',
  `refuse_reason` varchar(150) DEFAULT '' COMMENT '拒绝原因',
  `creation_date` datetime NOT NULL COMMENT '创建时间',
  `last_modified_date` datetime NOT NULL COMMENT '最后修改时间',
  `last_modifier` bigint(20) NOT NULL COMMENT '最后修改人',
  PRIMARY KEY (`id`),
  KEY `idx_dsp_id` (`dsp_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发票申请';

-- ----------------------------
-- Table structure for invoice_op_log
-- ----------------------------
DROP TABLE IF EXISTS `invoice_op_log`;
CREATE TABLE `invoice_op_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `invoice_apply_id` bigint(20) NOT NULL COMMENT '发票申请记录ID',
  `op_type` tinyint(4) NOT NULL COMMENT '操作类型, 1 - 标记开具， 2 - 邮寄发票， 3 - 作废发票，4 - 拒绝， 5 - 撤销， 6 - 审核通过， 7 - 审核拒绝',
  `reason` varchar(4000) DEFAULT NULL COMMENT '原因',
  `op_date` datetime NOT NULL COMMENT '操作时间',
  `operator` bigint(100) NOT NULL COMMENT '操作人',
  `operator_str` varchar(400) DEFAULT NULL COMMENT '操作人姓名',
  `revoke_apply_id` bigint(20) NOT NULL COMMENT '撤销申请ID',
  PRIMARY KEY (`id`),
  KEY `fk_invoice_op_log_invoice_apply1_idx` (`invoice_apply_id`),
  KEY `fk_invoice_op_log_invoice_revoke_apply1_idx` (`revoke_apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发票操作记录';

-- ----------------------------
-- Table structure for invoice_revoke_apply
-- ----------------------------
DROP TABLE IF EXISTS `invoice_revoke_apply`;
CREATE TABLE `invoice_revoke_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `applier` bigint(20) DEFAULT NULL COMMENT '申请人',
  `invoice_apply_id` bigint(20) DEFAULT NULL COMMENT '发票申请ID',
  `reason` varchar(300) DEFAULT NULL COMMENT '申请原因',
  `creation_date` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态',
  `approver` bigint(20) DEFAULT NULL COMMENT '处理人',
  `approve_date` datetime DEFAULT NULL COMMENT '处理时间',
  `approve_comment` varchar(300) DEFAULT NULL COMMENT '处理意见',
  `result` tinyint(4) DEFAULT NULL COMMENT '处理结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for issue_changes
-- ----------------------------
DROP TABLE IF EXISTS `issue_changes`;
CREATE TABLE `issue_changes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kee` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `issue_key` varchar(50) COLLATE utf8_bin NOT NULL,
  `user_login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `change_type` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `change_data` longtext COLLATE utf8_bin,
  `created_at` bigint(20) DEFAULT NULL,
  `updated_at` bigint(20) DEFAULT NULL,
  `issue_change_creation_date` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_changes_kee` (`kee`),
  KEY `issue_changes_issue_key` (`issue_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for issues
-- ----------------------------
DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kee` varchar(50) COLLATE utf8_bin NOT NULL,
  `rule_id` int(11) DEFAULT NULL,
  `severity` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `manual_severity` tinyint(1) NOT NULL,
  `message` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `line` int(11) DEFAULT NULL,
  `gap` decimal(30,20) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `resolution` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `checksum` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `reporter` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `assignee` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `author_login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `action_plan_key` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `issue_attributes` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `effort` int(11) DEFAULT NULL,
  `created_at` bigint(20) DEFAULT NULL,
  `updated_at` bigint(20) DEFAULT NULL,
  `issue_creation_date` bigint(20) DEFAULT NULL,
  `issue_update_date` bigint(20) DEFAULT NULL,
  `issue_close_date` bigint(20) DEFAULT NULL,
  `tags` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `component_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `project_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `locations` longblob,
  `issue_type` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issues_kee` (`kee`),
  KEY `issues_rule_id` (`rule_id`),
  KEY `issues_resolution` (`resolution`),
  KEY `issues_assignee` (`assignee`),
  KEY `issues_updated_at` (`updated_at`),
  KEY `issues_component_uuid` (`component_uuid`),
  KEY `issues_project_uuid` (`project_uuid`),
  KEY `issues_creation_date` (`issue_creation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for loaded_templates
-- ----------------------------
DROP TABLE IF EXISTS `loaded_templates`;
CREATE TABLE `loaded_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kee` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `template_type` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for manual_measures
-- ----------------------------
DROP TABLE IF EXISTS `manual_measures`;
CREATE TABLE `manual_measures` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `metric_id` int(11) NOT NULL,
  `value` decimal(38,20) DEFAULT NULL,
  `text_value` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `user_login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `created_at` bigint(20) DEFAULT NULL,
  `updated_at` bigint(20) DEFAULT NULL,
  `component_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manual_measures_component_uuid` (`component_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for material_config
-- ----------------------------
DROP TABLE IF EXISTS `material_config`;
CREATE TABLE `material_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) DEFAULT '0' COMMENT '0代表img，1代表MP4 2,代表gif',
  `unique_code` bigint(20) DEFAULT '0' COMMENT '唯一码',
  `show_name` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '展示名字，素材库列表中用到',
  `material_size_condition` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '素材尺寸条件',
  `sort` int(10) DEFAULT '0' COMMENT '排序',
  `duration_condition` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '时长condition，单位是秒',
  `material_volume_condition` varchar(256) CHARACTER SET utf8 DEFAULT '0' COMMENT '素材大小(容量)条件，单位是kb',
  `idea_list_condition` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '创意列表展示条件',
  `idea_view_condition` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '播放预览展示条件',
  `idea_preview_condition` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '创意预览展示条件',
  `material_library_condition` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '使用素材库上传展示条件',
  `after_upload_condition` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '上传后尺寸展示条件',
  `material_list_condition` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '素材库列表尺寸展示条件',
  `material_preview_condition` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '素材库尺寸预览展示条件',
  `status` tinyint(3) DEFAULT '1' COMMENT '状态 0未发布 1发布',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_code` (`unique_code`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for material_info
-- ----------------------------
DROP TABLE IF EXISTS `material_info`;
CREATE TABLE `material_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `material_unique_code` bigint(20) DEFAULT '0' COMMENT '对应materialConfig里的uniqueCode',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态',
  `material_type` tinyint(4) DEFAULT NULL COMMENT '资源类型',
  `url` varchar(2048) DEFAULT NULL COMMENT 'url',
  `material_size` varchar(30) DEFAULT NULL COMMENT '素材尺寸',
  `ratio` varchar(45) DEFAULT NULL COMMENT '视频比例',
  `uniq_code` varchar(512) DEFAULT NULL COMMENT '唯一值',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `vid` varchar(64) DEFAULT NULL COMMENT '视频转码服务id',
  `duration` int(11) DEFAULT NULL COMMENT '视频时长，单位秒',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `vid_index` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=299157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_0
-- ----------------------------
DROP TABLE IF EXISTS `message_0`;
CREATE TABLE `message_0` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17884 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_1
-- ----------------------------
DROP TABLE IF EXISTS `message_1`;
CREATE TABLE `message_1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20922 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_2
-- ----------------------------
DROP TABLE IF EXISTS `message_2`;
CREATE TABLE `message_2` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21417 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_3
-- ----------------------------
DROP TABLE IF EXISTS `message_3`;
CREATE TABLE `message_3` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21995 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_4
-- ----------------------------
DROP TABLE IF EXISTS `message_4`;
CREATE TABLE `message_4` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14511 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_5
-- ----------------------------
DROP TABLE IF EXISTS `message_5`;
CREATE TABLE `message_5` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19184 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_6
-- ----------------------------
DROP TABLE IF EXISTS `message_6`;
CREATE TABLE `message_6` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27761 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_7
-- ----------------------------
DROP TABLE IF EXISTS `message_7`;
CREATE TABLE `message_7` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `type` tinyint(4) NOT NULL COMMENT '消息类型，1：系统消息，2：财务消息，3：审核消息',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `title` varchar(400) NOT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '状态，0：未读，1：已读',
  `rich_text_id` bigint(20) DEFAULT NULL COMMENT '富文本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23182 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_channel
-- ----------------------------
DROP TABLE IF EXISTS `message_channel`;
CREATE TABLE `message_channel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '账户id',
  `type` tinyint(4) NOT NULL COMMENT '消息类型',
  `second_type` tinyint(4) NOT NULL COMMENT '消息具体类型',
  `receive_email` tinyint(4) DEFAULT '1' COMMENT '是否接收邮件，0：不接收 1：接收',
  `receive_message` tinyint(4) DEFAULT '1' COMMENT '是否接收站内信，0：不接收 1：接收',
  `trigger_condition` tinyint(4) DEFAULT '0' COMMENT '是否有额外触发条件：0 无，1 具体数字，2 百分比',
  `trigger_value` varchar(10) DEFAULT NULL COMMENT '触发条件，trigger_condition满足情况下判断具的体条件',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：0 禁用，1 正常',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94686 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_flag
-- ----------------------------
DROP TABLE IF EXISTS `message_flag`;
CREATE TABLE `message_flag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `balance_not_enough` tinyint(4) NOT NULL DEFAULT '0' COMMENT '余额不足消息标志位，0：消息未发送 1：消息已经发送',
  `balance_will_exhaust` tinyint(4) NOT NULL DEFAULT '0' COMMENT '余额将要耗尽消息标志位，0：消息未发送 1：消息已经发送',
  `reach_budget` tinyint(4) NOT NULL DEFAULT '0' COMMENT '账户已达日限额消息标志位，0：消息未发送 1：消息已经发送',
  `user_id` bigint(20) NOT NULL COMMENT '账户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4822 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_receiver
-- ----------------------------
DROP TABLE IF EXISTS `message_receiver`;
CREATE TABLE `message_receiver` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键，自增长',
  `user_id` bigint(20) NOT NULL COMMENT '账户id，接受者对应的账户',
  `name` varchar(100) NOT NULL COMMENT '接收者名字',
  `phone` char(11) NOT NULL COMMENT '手机号',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `type` varchar(50) NOT NULL COMMENT '消息类型, 1:系统消息，2：财务消息，3 :审核消息  多个消息以","间隔',
  `create_time` datetime NOT NULL COMMENT '新建时间',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_USERID_NAME` (`user_id`,`name`),
  UNIQUE KEY `UNIQUE_USERID_PHONE` (`user_id`,`phone`),
  UNIQUE KEY `UNIQUE_USERID_EMAIL` (`user_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10954 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_richtext
-- ----------------------------
DROP TABLE IF EXISTS `message_richtext`;
CREATE TABLE `message_richtext` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `msg_id` bigint(20) NOT NULL,
  `content` text COLLATE utf8_bin NOT NULL COMMENT '富文本消息内容',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 0 不显示 1 显示',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index_msgid` (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for message_template
-- ----------------------------
DROP TABLE IF EXISTS `message_template`;
CREATE TABLE `message_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '标题模板',
  `content` text COLLATE utf8_bin COMMENT '内容模板',
  `category` smallint(6) DEFAULT NULL COMMENT '分类：1 站内信，2 邮箱',
  `type` smallint(6) DEFAULT NULL COMMENT '类型：',
  `status` smallint(6) DEFAULT '1' COMMENT '状态：0 禁用，1 正常',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for metrics
-- ----------------------------
DROP TABLE IF EXISTS `metrics`;
CREATE TABLE `metrics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `direction` int(11) NOT NULL DEFAULT '0',
  `domain` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `short_name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `qualitative` tinyint(1) NOT NULL DEFAULT '0',
  `val_type` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `user_managed` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '1',
  `worst_value` decimal(38,20) DEFAULT NULL,
  `best_value` decimal(38,20) DEFAULT NULL,
  `optimized_best_value` tinyint(1) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `delete_historical_data` tinyint(1) DEFAULT NULL,
  `decimal_scale` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `metrics_unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for mobile_list
-- ----------------------------
DROP TABLE IF EXISTS `mobile_list`;
CREATE TABLE `mobile_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile_number` varchar(24) COLLATE utf8_bin DEFAULT '' COMMENT '手机号',
  `relation_type` tinyint(3) DEFAULT '1' COMMENT '关联类型 1代表广告主',
  `type` tinyint(3) DEFAULT '1' COMMENT '名单类型 1代表白名单',
  `status` tinyint(3) DEFAULT '1' COMMENT '1代表有效 0代表无效',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='特殊手机号列表管理';

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for omp_info_ext
-- ----------------------------
DROP TABLE IF EXISTS `omp_info_ext`;
CREATE TABLE `omp_info_ext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `omp_id` bigint(20) DEFAULT '0' COMMENT '运管操作者id',
  `ext` varchar(1024) COLLATE utf8_bin DEFAULT '' COMMENT '额外信息',
  `status` tinyint(3) DEFAULT '1' COMMENT '预留字段',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `omp_id` (`omp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='运管信息';

-- ----------------------------
-- Table structure for operate_item
-- ----------------------------
DROP TABLE IF EXISTS `operate_item`;
CREATE TABLE `operate_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operate_id` bigint(20) DEFAULT NULL,
  `item_name` int(11) DEFAULT NULL COMMENT '操作项名称',
  `old_value` varchar(4000) DEFAULT NULL COMMENT '修改之前的值',
  `new_value` varchar(4000) DEFAULT NULL COMMENT '修改之后的值',
  `content_type` tinyint(4) DEFAULT NULL COMMENT '类型,1:普通文本 2 ：普通图片 3：gif图片 4：视频 5:地域信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for operate_log
-- ----------------------------
DROP TABLE IF EXISTS `operate_log`;
CREATE TABLE `operate_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '操作记录id，自增长',
  `operator_id` bigint(20) NOT NULL COMMENT '操作人ID',
  `operator_name` varchar(100) NOT NULL COMMENT '操作人用户名',
  `operate_project` tinyint(4) NOT NULL COMMENT '操作对象',
  `operate_project_name` varchar(200) NOT NULL COMMENT '操作对象名称',
  `operate_type` tinyint(4) NOT NULL COMMENT '操作类型(1:新建,2:修改, 3:删除)',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `ip` int(10) DEFAULT NULL COMMENT 'ip地址,inet_aton(),inet_ntoa()函数可以提供ip与数字之间的转换',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for organizations
-- ----------------------------
DROP TABLE IF EXISTS `organizations`;
CREATE TABLE `organizations` (
  `uuid` varchar(40) COLLATE utf8_bin NOT NULL,
  `kee` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `description` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `url` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `avatar_url` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `organization_key` (`kee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for perm_templates_groups
-- ----------------------------
DROP TABLE IF EXISTS `perm_templates_groups`;
CREATE TABLE `perm_templates_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `template_id` int(11) NOT NULL,
  `permission_reference` varchar(64) COLLATE utf8_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for perm_templates_users
-- ----------------------------
DROP TABLE IF EXISTS `perm_templates_users`;
CREATE TABLE `perm_templates_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `permission_reference` varchar(64) COLLATE utf8_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for perm_tpl_characteristics
-- ----------------------------
DROP TABLE IF EXISTS `perm_tpl_characteristics`;
CREATE TABLE `perm_tpl_characteristics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL,
  `permission_key` varchar(64) COLLATE utf8_bin NOT NULL,
  `with_project_creator` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_perm_tpl_charac` (`template_id`,`permission_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for permission_templates
-- ----------------------------
DROP TABLE IF EXISTS `permission_templates`;
CREATE TABLE `permission_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `kee` varchar(100) COLLATE utf8_bin NOT NULL,
  `description` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `key_pattern` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `organization_uuid` varchar(40) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for person_package
-- ----------------------------
DROP TABLE IF EXISTS `person_package`;
CREATE TABLE `person_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '广告主id',
  `package_name` varchar(64) CHARACTER SET utf8 DEFAULT '' COMMENT '人群名称',
  `package_type` tinyint(3) DEFAULT '1' COMMENT '号码包类型 1:IDFA号  2:IMEI号 3:IDFA-MD5号 4:IMEI-MD5号 99:不限',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '数据类型： 1 添加自定义人群，2 广告数据，3 行业数据，4 扩展获新，5 双11电商偏好，6 双11用户安装电商APP',
  `type_relation_ids` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '类型关联的id列表： 类型为广告数据时为推广id。类型为行业数据是为兴趣列表。多个值逗号分隔',
  `type_direction_data` varchar(1024) COLLATE utf8_bin DEFAULT '' COMMENT '人群包选择信息，json格式，适用于多类选项',
  `data_type` tinyint(3) DEFAULT NULL COMMENT '数据类型：1 点击',
  `data_type_count` int(11) NOT NULL DEFAULT '0' COMMENT '数据类型次数',
  `data_type_condition` tinyint(3) DEFAULT NULL COMMENT '数据类型条件： 1 大于等于，2 小于等于',
  `auto_update` tinyint(3) DEFAULT NULL COMMENT '是否自动更新：0 否，1 是',
  `update_days` int(11) DEFAULT NULL COMMENT '自动更新天数',
  `update_begin_date` datetime DEFAULT NULL COMMENT '数据产生日期开始',
  `update_end_date` datetime DEFAULT NULL COMMENT '数据产生日期结束',
  `status` tinyint(3) DEFAULT '0' COMMENT '定向包状态： 0代表新建 2生效处理中 3解析完成(已生效)  9删除 10 失效处理中 12 失效',
  `url` varchar(2048) CHARACTER SET utf8 DEFAULT '' COMMENT 'nos路径',
  `all_count` int(11) DEFAULT NULL COMMENT '数据总量',
  `valid_count` int(11) DEFAULT NULL COMMENT '格式有效数据数量',
  `cover_count` int(11) DEFAULT NULL COMMENT '覆盖人群数量',
  `summary` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '解析失败说明',
  `effect_time` timestamp NULL DEFAULT NULL COMMENT '生效时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
  `extend_ratio` int(11) DEFAULT NULL COMMENT '扩展倍数',
  `seed_person_id` bigint(20) DEFAULT NULL COMMENT '种子人群包ID',
  `reserve_seed_person` tinyint(4) DEFAULT NULL COMMENT '是否保留人群种子 0 不保留， 1 保留',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_userid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1562 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='人群定向';

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8mb4 NOT NULL COMMENT '资源位名称',
  `category_id` bigint(20) NOT NULL COMMENT '栏目id',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 1正常',
  `orders` int(11) DEFAULT NULL COMMENT '排序字段',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=691 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for position_black_list
-- ----------------------------
DROP TABLE IF EXISTS `position_black_list`;
CREATE TABLE `position_black_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `position_id` bigint(20) DEFAULT '0' COMMENT '位置id',
  `user_ids` varchar(16384) CHARACTER SET utf8 DEFAULT '' COMMENT '广告主id,以|分割',
  `status` tinyint(3) DEFAULT '1' COMMENT '预留字段0删除，1正常',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_position_id` (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for position_item
-- ----------------------------
DROP TABLE IF EXISTS `position_item`;
CREATE TABLE `position_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `position_id` bigint(20) NOT NULL COMMENT '页面上显示的位置ID',
  `ad_position_id` bigint(20) DEFAULT NULL COMMENT '运管推送的位置ID',
  `category_id` bigint(20) NOT NULL COMMENT '栏目ID',
  `name` char(50) DEFAULT NULL COMMENT '位置名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '位置类型1：通用 2：ipad 3：ios 4：android',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态1：正常',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1571 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for position_package
-- ----------------------------
DROP TABLE IF EXISTS `position_package`;
CREATE TABLE `position_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '广告主ID',
  `name` varchar(50) NOT NULL COMMENT '位置包名称',
  `position_id` text COMMENT '栏目ID:位置ID,位置ID示例如下44:1,2;45:11,12',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态1：正常',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for position_package_item
-- ----------------------------
DROP TABLE IF EXISTS `position_package_item`;
CREATE TABLE `position_package_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '广告主ID',
  `position_package_id` bigint(20) NOT NULL COMMENT '位置包ID',
  `platform` tinyint(4) NOT NULL COMMENT '平台11：网易新闻',
  `sub_platform` tinyint(4) NOT NULL COMMENT '二级平台1：网易新闻客户端 2：手机网易网 8：厂商资源',
  `platform_type` tinyint(4) NOT NULL COMMENT '平台类型1：栏目信息流 2：文章底部信息流',
  `category_id` bigint(20) DEFAULT NULL COMMENT '栏目ID',
  `position_id` text COMMENT '位置ID英文逗号分隔',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态1：正常',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for project_links
-- ----------------------------
DROP TABLE IF EXISTS `project_links`;
CREATE TABLE `project_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_type` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `href` varchar(2048) COLLATE utf8_bin NOT NULL,
  `component_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for project_measures
-- ----------------------------
DROP TABLE IF EXISTS `project_measures`;
CREATE TABLE `project_measures` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` decimal(38,20) DEFAULT NULL,
  `metric_id` int(11) NOT NULL,
  `text_value` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `alert_status` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `alert_text` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `variation_value_1` decimal(38,20) DEFAULT NULL,
  `variation_value_2` decimal(38,20) DEFAULT NULL,
  `variation_value_3` decimal(38,20) DEFAULT NULL,
  `variation_value_4` decimal(38,20) DEFAULT NULL,
  `variation_value_5` decimal(38,20) DEFAULT NULL,
  `measure_data` longblob,
  `component_uuid` varchar(50) COLLATE utf8_bin NOT NULL,
  `analysis_uuid` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `measures_person` (`person_id`),
  KEY `measures_component_uuid` (`component_uuid`),
  KEY `measures_analysis_metric` (`analysis_uuid`,`metric_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for project_qprofiles
-- ----------------------------
DROP TABLE IF EXISTS `project_qprofiles`;
CREATE TABLE `project_qprofiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_uuid` varchar(50) COLLATE utf8_bin NOT NULL,
  `profile_key` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_project_qprofiles` (`project_uuid`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `scope` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  `qualifier` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `kee` varchar(400) COLLATE utf8_bin DEFAULT NULL,
  `language` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `long_name` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `path` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `deprecated_kee` varchar(400) COLLATE utf8_bin DEFAULT NULL,
  `uuid` varchar(50) COLLATE utf8_bin NOT NULL,
  `project_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `module_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `module_uuid_path` varchar(1500) COLLATE utf8_bin DEFAULT NULL,
  `authorization_updated_at` bigint(20) DEFAULT NULL,
  `root_uuid` varchar(50) COLLATE utf8_bin NOT NULL,
  `copy_component_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `developer_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `uuid_path` varchar(1500) COLLATE utf8_bin NOT NULL,
  `b_changed` tinyint(1) DEFAULT NULL,
  `b_copy_component_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `b_description` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `b_enabled` tinyint(1) DEFAULT NULL,
  `b_language` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `b_long_name` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `b_module_uuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `b_module_uuid_path` varchar(1500) COLLATE utf8_bin DEFAULT NULL,
  `b_name` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `b_path` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `b_qualifier` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `b_uuid_path` varchar(1500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_project_uuid` (`project_uuid`),
  KEY `projects_module_uuid` (`module_uuid`),
  KEY `projects_kee` (`kee`(255)),
  KEY `projects_qualifier` (`qualifier`),
  KEY `projects_root_uuid` (`root_uuid`),
  KEY `projects_uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for properties
-- ----------------------------
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prop_key` varchar(512) COLLATE utf8_bin NOT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `is_empty` tinyint(1) NOT NULL,
  `text_value` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `clob_value` longtext COLLATE utf8_bin,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `properties_key` (`prop_key`(255))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for qprofile_changes
-- ----------------------------
DROP TABLE IF EXISTS `qprofile_changes`;
CREATE TABLE `qprofile_changes` (
  `kee` varchar(40) COLLATE utf8_bin NOT NULL,
  `qprofile_key` varchar(255) COLLATE utf8_bin NOT NULL,
  `change_type` varchar(20) COLLATE utf8_bin NOT NULL,
  `user_login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `change_data` longtext COLLATE utf8_bin,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`kee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for quality_gate_conditions
-- ----------------------------
DROP TABLE IF EXISTS `quality_gate_conditions`;
CREATE TABLE `quality_gate_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qgate_id` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  `period` int(11) DEFAULT NULL,
  `operator` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  `value_error` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `value_warning` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for quality_gates
-- ----------------------------
DROP TABLE IF EXISTS `quality_gates`;
CREATE TABLE `quality_gates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_quality_gates` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for recharge_info
-- ----------------------------
DROP TABLE IF EXISTS `recharge_info`;
CREATE TABLE `recharge_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agent_info_id` bigint(20) DEFAULT NULL COMMENT '代理商ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作人id，有可能是代理商账户id，由user_type 决定，0代表系统',
  `switch_id` bigint(20) DEFAULT '0' COMMENT '转账对象id。user_type为0时代表userid，user_type为1时代表agentinfoid',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '充值类型 1.代理商转账 2.网易充值 3.支付宝充值 4.代理商撤回 5.一代转入 6.一代转出 7.返点',
  `price` double(13,2) DEFAULT '0.00' COMMENT '充值金额',
  `serial_number` varchar(100) NOT NULL COMMENT '流水',
  `p_serial_number` varchar(100) DEFAULT '' COMMENT '父流水号，返点记录会有',
  `status` int(11) DEFAULT '0' COMMENT '充值状态',
  `recharge_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '到账时间',
  `user_type` int(11) DEFAULT '0' COMMENT '0易效，1代理商',
  `illustration` varchar(255) DEFAULT NULL COMMENT '说明',
  `reward` double(13,2) DEFAULT '0.00' COMMENT '返点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48891 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for record_attribute
-- ----------------------------
DROP TABLE IF EXISTS `record_attribute`;
CREATE TABLE `record_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `model_id` bigint(50) DEFAULT NULL COMMENT '领域id',
  `name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `json_key` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '对应的json中的key',
  `data_type` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '数据类型',
  `attribute_type` tinyint(4) DEFAULT NULL COMMENT '属性类型:1 普通文本 2 图片 3 gif 4 视频',
  `oper_type` tinyint(4) NOT NULL DEFAULT '3' COMMENT '操作类型：1 新增，2 删除，3 修改，4 复制，5 联调',
  `template` varchar(400) COLLATE utf8_bin DEFAULT NULL COMMENT '模板',
  `vip_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '当前记录代理商等级， 20为运管资源优化操作记录',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '权重，记录的顺序，值越小排序越靠前',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 0 无效 1 有效 2 有效并且传递过来为null的情况下，会做额外处理，比如计划结束日期，传递过来为null，处理为不限',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `combine_unique_key` (`model_id`,`json_key`,`oper_type`,`vip_level`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for record_domain
-- ----------------------------
DROP TABLE IF EXISTS `record_domain`;
CREATE TABLE `record_domain` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `value_template` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT 'domain value 对应的模板',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 0 无效 1 有效 ',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='记录具体可变更实体，如【账户信息】、【创意】等';

-- ----------------------------
-- Table structure for record_info
-- ----------------------------
DROP TABLE IF EXISTS `record_info`;
CREATE TABLE `record_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account_id` bigint(20) DEFAULT NULL COMMENT '账户id',
  `account_type` tinyint(4) DEFAULT NULL COMMENT '账户类型：1 易效， 2 代理商',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `operator_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '操作人名称',
  `operate_type` tinyint(4) DEFAULT NULL COMMENT '操作类型：1 新建，2 修改，3删除',
  `domain_id` bigint(20) NOT NULL COMMENT 'domain id',
  `value` longtext COLLATE utf8_bin,
  `vip_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '当前记录代理商等级',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 0 无效 1 有效 ',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `ip` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '操作人ip地址',
  PRIMARY KEY (`id`),
  KEY `account_id_index` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2047381 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for resource_index
-- ----------------------------
DROP TABLE IF EXISTS `resource_index`;
CREATE TABLE `resource_index` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kee` varchar(400) COLLATE utf8_bin NOT NULL,
  `position` int(11) NOT NULL,
  `name_size` int(11) NOT NULL,
  `qualifier` varchar(10) COLLATE utf8_bin NOT NULL,
  `component_uuid` varchar(50) COLLATE utf8_bin NOT NULL,
  `root_component_uuid` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_index_key` (`kee`(255)),
  KEY `resource_index_component` (`component_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for rule_repositories
-- ----------------------------
DROP TABLE IF EXISTS `rule_repositories`;
CREATE TABLE `rule_repositories` (
  `kee` varchar(200) COLLATE utf8_bin NOT NULL,
  `language` varchar(20) COLLATE utf8_bin NOT NULL,
  `name` varchar(4000) COLLATE utf8_bin NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`kee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for rules
-- ----------------------------
DROP TABLE IF EXISTS `rules`;
CREATE TABLE `rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `plugin_rule_key` varchar(200) COLLATE utf8_bin NOT NULL,
  `plugin_config_key` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `plugin_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `description` longtext COLLATE utf8_bin,
  `priority` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `status` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `language` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `note_created_at` datetime DEFAULT NULL,
  `note_updated_at` datetime DEFAULT NULL,
  `note_user_login` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `note_data` longtext COLLATE utf8_bin,
  `remediation_function` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `def_remediation_function` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `remediation_gap_mult` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `def_remediation_gap_mult` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `remediation_base_effort` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `def_remediation_base_effort` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `gap_description` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `tags` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `system_tags` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `is_template` tinyint(1) NOT NULL DEFAULT '0',
  `description_format` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `created_at` bigint(20) DEFAULT NULL,
  `updated_at` bigint(20) DEFAULT NULL,
  `rule_type` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rules_repo_key` (`plugin_rule_key`,`plugin_name`)
) ENGINE=InnoDB AUTO_INCREMENT=740 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for rules_parameters
-- ----------------------------
DROP TABLE IF EXISTS `rules_parameters`;
CREATE TABLE `rules_parameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  `description` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `param_type` varchar(512) COLLATE utf8_bin NOT NULL,
  `default_value` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rules_parameters_rule_id` (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for rules_profiles
-- ----------------------------
DROP TABLE IF EXISTS `rules_profiles`;
CREATE TABLE `rules_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `language` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `kee` varchar(255) COLLATE utf8_bin NOT NULL,
  `parent_kee` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rules_updated_at` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `last_used` bigint(20) DEFAULT NULL,
  `user_updated_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_qprof_key` (`kee`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for scheduling_askdate
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_askdate`;
CREATE TABLE `scheduling_askdate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scheduling_info_id` bigint(20) NOT NULL COMMENT '计划id',
  `day` int(11) NOT NULL COMMENT '天',
  `hours` varchar(100) NOT NULL COMMENT '小时 用逗号分隔',
  PRIMARY KEY (`id`),
  KEY `idx_scheduling_info_id` (`scheduling_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for scheduling_category_package
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_category_package`;
CREATE TABLE `scheduling_category_package` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `scheduling_id` bigint(11) DEFAULT NULL,
  `category_package_id` bigint(11) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '1' COMMENT '状态：1 正常',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='组-栏目包对应关系表';

-- ----------------------------
-- Table structure for scheduling_dp_area
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_dp_area`;
CREATE TABLE `scheduling_dp_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scheduling_info_id` bigint(20) NOT NULL COMMENT '推广组id',
  `area_id` bigint(20) NOT NULL COMMENT '地域id',
  `area_code` varchar(45) NOT NULL COMMENT '地域code',
  `level` varchar(50) DEFAULT NULL COMMENT '级别',
  `transfer_status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_scheduling_dp_area_scheduling_info1_idx` (`scheduling_info_id`),
  KEY `dp_area_aid_index` (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30044183 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for scheduling_dp_areas
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_dp_areas`;
CREATE TABLE `scheduling_dp_areas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `scheduling_info_id` bigint(20) NOT NULL COMMENT '推广组ID',
  `area_id` varchar(1500) NOT NULL COMMENT '地域ID',
  `area_code` varchar(2500) NOT NULL COMMENT '地域编码',
  `level` varchar(50) DEFAULT NULL COMMENT '级别',
  PRIMARY KEY (`id`),
  KEY `fk_scheduling_dp_areas_scheduling_info_id` (`scheduling_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=881925 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for scheduling_dp_interest
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_dp_interest`;
CREATE TABLE `scheduling_dp_interest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scheduling_info_id` bigint(20) NOT NULL COMMENT '推广组id',
  `interest_id` bigint(20) NOT NULL COMMENT '兴趣id',
  `interest_code` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '兴趣编码',
  `level` int(11) NOT NULL COMMENT '层级',
  PRIMARY KEY (`id`),
  KEY `scheduling_interes_index` (`scheduling_info_id`),
  KEY `interest_interest_indxe` (`interest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6768095 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for scheduling_dp_person
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_dp_person`;
CREATE TABLE `scheduling_dp_person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '广告主id',
  `ad_plan_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '计划id',
  `scheduling_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '推广组id',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '定向类型： 1.选择 2.排除',
  `person_package_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '人群定向包id',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_scheduling` (`scheduling_id`),
  KEY `idx_person` (`person_package_id`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7132 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='推广组与人群定向关系表';

-- ----------------------------
-- Table structure for scheduling_dp_position
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_dp_position`;
CREATE TABLE `scheduling_dp_position` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `scheduling_info_id` bigint(20) NOT NULL,
  `position_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dp_position_sid_index` (`scheduling_info_id`),
  KEY `dp_position_pid_index` (`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for scheduling_info
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_info`;
CREATE TABLE `scheduling_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL COMMENT '推广组名称',
  `ad_plan_id` bigint(20) NOT NULL COMMENT '计划id',
  `turn` int(11) NOT NULL COMMENT '开关  0:关 1:开',
  `device` varchar(50) NOT NULL DEFAULT '' COMMENT '设备 0.不限 1.手机 2.pc',
  `system` varchar(50) NOT NULL COMMENT ' 操作系统 3.IOS/ANDROID  2. IOS  1.ANDROID',
  `network` varchar(50) NOT NULL COMMENT '网络环境 0.不限 1.wifi 2.4G 3.3G 4.其它',
  `sex` varchar(50) DEFAULT '0',
  `age` varchar(50) DEFAULT '0',
  `platform` int(11) NOT NULL COMMENT '平台 1.新闻客户端',
  `sub_platform` varchar(30) DEFAULT NULL,
  `cast_way` int(11) NOT NULL COMMENT '投放方式: 0.cpm 1. cpc',
  `pay` double NOT NULL COMMENT '出价',
  `creater` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 0.失效 1.生效',
  `category` varchar(255) DEFAULT '0',
  `vip_level` tinyint(3) DEFAULT '0' COMMENT '代管修改的话，保存广告主的vip等级',
  `device_price` varchar(45) NOT NULL DEFAULT '0' COMMENT '设备价格","分割例如1,2,3',
  `category_type` tinyint(3) DEFAULT '1' COMMENT '栏目类型：1 不限，2 指定栏目包',
  `type_direction` varchar(20) DEFAULT '0' COMMENT '类型定向，多个逗号分隔',
  `ad_formats` varchar(20) DEFAULT '1' COMMENT '广告形式',
  `position_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '位置类型：1 不限，2 指定位置包',
  `app_type` varchar(16) DEFAULT '0' COMMENT 'APP行为定向，多个用逗号隔开 0：不限，1：非游戏，2：游戏; 例如："1,2"',
  `network_operator` varchar(20) NOT NULL DEFAULT '0' COMMENT '网络运营商定向',
  `directional_package_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '定向包id',
  `directional_package_origin` tinyint(4) DEFAULT NULL COMMENT '定向包来源： 1 推广组新建 2 从工具箱选择',
  PRIMARY KEY (`id`),
  KEY `fk_scheduling_info_ad_plan1_idx` (`ad_plan_id`),
  KEY `index_user_id` (`creater`),
  KEY `idx_directional_package_id` (`directional_package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=451560 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for scheduling_position_package
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_position_package`;
CREATE TABLE `scheduling_position_package` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `scheduling_id` bigint(11) DEFAULT NULL,
  `position_package_id` bigint(11) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '1' COMMENT '状态：1 正常',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='组-位置包对应关系表';

-- ----------------------------
-- Table structure for tips
-- ----------------------------
DROP TABLE IF EXISTS `tips`;
CREATE TABLE `tips` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL COMMENT '消息内容',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型：1 系统升级消息，2 账户冻结消息',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id，-1：全部用户有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tips_user
-- ----------------------------
DROP TABLE IF EXISTS `tips_user`;
CREATE TABLE `tips_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `system_upgrade_version` bigint(20) DEFAULT NULL COMMENT '系统消息版本',
  `frozen_account_version` bigint(20) DEFAULT NULL COMMENT '账户被冻结消息版本',
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_unique` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6150 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_archives
-- ----------------------------
DROP TABLE IF EXISTS `user_archives`;
CREATE TABLE `user_archives` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '广告主信息',
  `product` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '推广产品',
  `product_url` varchar(2048) COLLATE utf8_bin DEFAULT NULL,
  `company_name` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '公司名称',
  `company_url` varchar(2048) CHARACTER SET utf8 NOT NULL COMMENT '公司网址',
  `bussiness_nature` tinyint(4) NOT NULL COMMENT '公司性质',
  `industry_level_1_id` int(11) NOT NULL COMMENT '一级行业',
  `industry_level_2_id` int(11) NOT NULL COMMENT '二级行业',
  `top_agent_info_id` bigint(20) NOT NULL COMMENT '所属一代代理商',
  `agent_info_id` bigint(20) DEFAULT '0' COMMENT '所属二代代理商',
  `supporter_id` bigint(20) DEFAULT '0' COMMENT '媒介支持id',
  `son_supporter_id` bigint(20) DEFAULT '0' COMMENT '二代媒介支持',
  `reason` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '通过/驳回原因',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 1：报备中 2：报备通过（未开户）3：报备通过（已开户）4：报备驳回 5：账户释放',
  `operator_name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '操作人名称',
  `submit_time` datetime DEFAULT NULL COMMENT '报备提交时间',
  `check_time` datetime DEFAULT NULL COMMENT '审核时间',
  `release_time` datetime DEFAULT NULL COMMENT '释放时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `opened_time` datetime DEFAULT NULL COMMENT '开户时间',
  `archives_comment` varchar(40) COLLATE utf8_bin DEFAULT '' COMMENT '报备备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='客户报备信息';

-- ----------------------------
-- Table structure for user_freeze
-- ----------------------------
DROP TABLE IF EXISTS `user_freeze`;
CREATE TABLE `user_freeze` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '广告主ID',
  `check_status` int(11) DEFAULT NULL COMMENT '审批中的状态 1：冻结审核中 2：冻结已通过 3：冻结已驳回 11：解冻审核中 12：解冻已通过 13：解冻已驳回',
  `status` int(11) DEFAULT '1' COMMENT '0：已关闭 1：激活中',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_freeze_step
-- ----------------------------
DROP TABLE IF EXISTS `user_freeze_step`;
CREATE TABLE `user_freeze_step` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `freezen_id` bigint(20) DEFAULT NULL COMMENT '冻结流程主表ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '广告主ID',
  `action` int(11) DEFAULT NULL COMMENT '操作类型 1：冻结申请 2：冻结通过 3：冻结驳回 11：解冻申请 12：解冻通过 13：解冻驳回',
  `reason` varchar(512) DEFAULT NULL COMMENT '操作原因',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作者ID',
  `operator_name` varchar(100) DEFAULT NULL COMMENT '操作者名称',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `index_freezen_id` (`freezen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_mapped_id` bigint(20) DEFAULT NULL COMMENT '运管平台id',
  `user_name` varchar(35) COLLATE utf8_bin DEFAULT '' COMMENT '用户名',
  `password` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `user_type` tinyint(4) DEFAULT '0' COMMENT '用户类型\\n0 - 网站注册\\n1 - 代理商代理',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态\\n0-初始账户,1-初始审核中,2-初始未未通过,3-审核中,4-未通过,5-已通过,9-冻结帐户',
  `account_status` tinyint(3) DEFAULT '1' COMMENT '帐户状态',
  `mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `mail` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `contactor` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '联系人',
  `qq` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT 'qq',
  `bussiness_nature` tinyint(4) DEFAULT NULL COMMENT '公司性质\n1 - 政府机构\n2 - 事业单位\n3 - 普通企业',
  `company_name` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `company_url` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '公司网址',
  `industry_level_1_id` int(11) DEFAULT NULL COMMENT '所属行业一级分类',
  `industry_level_2_id` int(11) DEFAULT NULL COMMENT '所属行业二级分类',
  `city` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '城市',
  `province` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '省份',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '详细地址',
  `price` double(13,2) NOT NULL DEFAULT '0.00' COMMENT '充值总金额',
  `reward_price` double(13,2) NOT NULL DEFAULT '0.00' COMMENT '返点总金额',
  `budget` double(13,2) NOT NULL DEFAULT '0.00' COMMENT '预算',
  `is_consumption` tinyint(3) DEFAULT '0' COMMENT '是否消费满7天\n0-未消费满7天,1-消费满7天',
  `cost_price` double(16,5) DEFAULT '0.00000',
  `descript` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '审核描述',
  `is_pending` tinyint(4) DEFAULT '0' COMMENT '是否待审 0：否，1 是',
  `is_ic_pending` tinyint(3) DEFAULT '0' COMMENT '创意资质送审',
  `agent_info_id` bigint(11) DEFAULT NULL COMMENT '所属代理商id',
  `salesman_id` bigint(11) DEFAULT NULL COMMENT '所属销售id',
  `escrow` tinyint(3) DEFAULT '0' COMMENT '是否代管：0 否，1 一代代管 2 二代代管',
  `escrow_id` bigint(20) DEFAULT '0' COMMENT '代管代理商id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `is_pass` tinyint(3) DEFAULT '0' COMMENT '资质是否未通过（含历史）',
  `is_freezen` tinyint(3) DEFAULT '0' COMMENT '是否冻结',
  `freezen_time` timestamp NULL DEFAULT NULL COMMENT '冻结时间',
  `freezen_desc` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '冻结原因',
  `is_invalid` tinyint(3) DEFAULT '0' COMMENT '资质是否失效（含历史）',
  `is_init_pass` tinyint(3) DEFAULT '1' COMMENT '初始状态是否通过',
  `top_agent_info_id` bigint(20) DEFAULT NULL,
  `level` smallint(6) DEFAULT '1',
  `is_ecommerce` tinyint(3) DEFAULT '0' COMMENT '电商平台标识 0代表非电商 1代表电商平台',
  `user_role` int(11) DEFAULT '1' COMMENT '规则标识：1允许人群定向',
  `top_sale_man_id` bigint(20) DEFAULT '0' COMMENT '一代对应销售',
  `second_sale_man_id` bigint(20) DEFAULT '0' COMMENT '二代对应销售',
  `top_operation_id` bigint(20) DEFAULT '0' COMMENT '一代对应运营',
  `second_operation_id` bigint(20) DEFAULT '0' COMMENT '二代对应运营',
  `vip_level` tinyint(3) DEFAULT '4' COMMENT '0代表普通，n代表n级vip',
  `is_sensitive` tinyint(3) DEFAULT '0' COMMENT '是否为敏感客户1代表是，0代表否',
  `sensitive_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '设置敏感客户时间',
  `product` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '推广产品',
  `product_url` varchar(2048) COLLATE utf8_bin DEFAULT '' COMMENT '推广链接',
  `custom_person_package` tinyint(4) DEFAULT '1' COMMENT '自定义人群权限：0 没有权限，1 有权限',
  `ad_convert` tinyint(4) DEFAULT '0' COMMENT '转化追踪显示权限：0 没有权限，1 有权限',
  `history_freezen_reason` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `has_deeplink` tinyint(4) DEFAULT '0' COMMENT '创意支持deeplink权限：0 没有权限 1 有权限',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  KEY `mail_index` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=19324 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户信息表';

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `login_type` tinyint(4) DEFAULT NULL COMMENT '登陆类型',
  `ip` varchar(20) DEFAULT NULL COMMENT '登陆ip',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5366714 DEFAULT CHARSET=utf8 COMMENT='用户登陆日志表';

-- ----------------------------
-- Table structure for yx_tag_mapping_online
-- ----------------------------
DROP TABLE IF EXISTS `yx_tag_mapping_online`;
CREATE TABLE `yx_tag_mapping_online` (
  `yx_first_tag_code_old` varchar(12) NOT NULL COMMENT '易效一级分类编码-old',
  `yx_first_tag_name_old` varchar(24) NOT NULL COMMENT '易效一级分类名称-old',
  `yx_second_tag_code_old` varchar(12) DEFAULT NULL COMMENT '易效二级分类编码-old',
  `yx_second_tag_name_old` varchar(24) DEFAULT NULL COMMENT '易效二级分类名称-old',
  `yx_first_tag_code_new` varchar(12) NOT NULL COMMENT '易效一级分类编码-new',
  `yx_first_tag_name_new` varchar(24) NOT NULL COMMENT '易效一级分类-new',
  `yx_second_tag_code_new` varchar(12) DEFAULT NULL COMMENT '易效二级分类编码-new',
  `yx_second_tag_name_new` varchar(24) DEFAULT NULL COMMENT '易效二级分类名称-new',
  `comment` varchar(48) NOT NULL COMMENT '备注',
  `create_time` date NOT NULL,
  `update-time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bus_code` varchar(24) NOT NULL,
  `uv` bigint(20) NOT NULL COMMENT '广告行为uv',
  `ext_uv` bigint(20) NOT NULL COMMENT '关键词uv'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for obc
-- ----------------------------
DROP VIEW IF EXISTS `obc`;
CREATE ALGORITHM=UNDEFINED DEFINER=`adcpm`@`61.135.255.84` SQL SECURITY DEFINER VIEW `obc` AS select `agent_account_info`.`id` AS `id`,`agent_account_info`.`agent_info_id` AS `agent_info_id`,`agent_account_info`.`name` AS `name`,`agent_account_info`.`password` AS `password`,`agent_account_info`.`mail` AS `mail`,`agent_account_info`.`status` AS `status`,`agent_account_info`.`role` AS `role`,`agent_account_info`.`login_time` AS `login_time`,`agent_account_info`.`create_time` AS `create_time`,`agent_account_info`.`update_time` AS `update_time` from `agent_account_info` where (`agent_account_info`.`agent_info_id` = 1) WITH CASCADED CHECK OPTION;

-- ----------------------------
-- Procedure structure for agent
-- ----------------------------
DROP PROCEDURE IF EXISTS `agent`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `agent`(num INT)
BEGIN
DECLARE i INT;
SET i=0;
WHILE i<num DO
INSERT INTO `p4p`.`agent_info` (
	
	`agent_account_id`,
	`agent_name`,
	`short_agent_name`,
	`agent_code`,
	`agent_url`,
	`saler_name`,
	`saler_mail`,
	`saler_mobile`,
	`contactor`,
	`mobile`,
	`mail`,
	`province`,
	`city`,
	`address`,
	`available_balance`,
	`recharge`,
	`available_reward_balance`,
	`reward_recharge`,
	`status`,
	`create_time`,
	`update_time`,
	`pid`,
	`salesman_id`,
	`level`
)
VALUES
	(
		
		NULL,
		CONCAT('zyl二代代理商test',i),
		CONCAT('zyl二代代理商test公司',i),
		NULL,
		'http://www.163.com',
		NULL,
		NULL,
		NULL,
		'zhaoyanling',
		'15567890876',
		'zhaoyanling021@163.com',
		'安庆市',
		'ffffffffffffffffff',
		'ffffffffffffffffff',
		'0.00',
		'0.00',
		'0.00',
		'0.00',
		'1',
		'2017-02-16 17:57:01',
		'2017-02-16 17:57:25',
		'54',
		'146',
		'2'
	);
SET i=i+1;
END WHILE;
END;
;;
delimiter ;

-- ----------------------------
-- Procedure structure for HelloWorld
-- ----------------------------
DROP PROCEDURE IF EXISTS `HelloWorld`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `HelloWorld`()
BEGIN
	SELECT "hello world" AS message;
END;
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_user_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_user_info`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `insert_user_info`(n INT)
BEGIN
	DECLARE i INT DEFAULT 2;
	DECLARE email_suffix VARCHAR(50) DEFAULT '';
	DECLARE email_prefix VARCHAR(20) DEFAULT '';
	DECLARE email VARCHAR(100) DEFAULT '';
	DECLARE user_name VARCHAR(200) DEFAULT '';
	DECLARE company_name VARCHAR(200) DEFAULT '';
	DECLARE company_url VARCHAR(200) DEFAULT '';
	DECLARE create_time TIMESTAMP DEFAULT NULL;
	WHILE i<=n DO
		SET email_suffix='@test.163.com';
		SET email_prefix='siwufeiwu';
		SET user_name='二代客户有限公司';
		SET company_name='二代客户';
		SET company_url='http://www.abc';
		SET create_time=CURRENT_TIMESTAMP();
		SET email_prefix = CONCAT(SUBSTR(email_prefix,1),i);
		SET email = CONCAT(email_prefix,email_suffix);
		SET user_name = CONCAT(user_name, i);
		SET company_name = CONCAT(company_name, i);
		SET company_url = CONCAT(company_url, i);
		SET company_url = CONCAT(company_url, '.com');
		#SELECT * FROM user_info WHERE id=10296;
		#SELECT email, user_name, company_name, company_url, create_time;
		#/*
		INSERT INTO user_info
		(`user_name`, `user_type`, `account_status`, `qq`, `bussiness_nature`, `company_name`, `company_url`, `industry_level_1_id`, `industry_level_2_id`, `city`, `province`, `address`, `budget`, `agent_info_id`, `salesman_id`, `escrow`, `escrow_id`, `create_time`) 
		VALUES 
		(user_name, 1, 10, 88888888, 1, company_name, company_url, 1, 20, '北京市', '北京市', '海淀区', 10000, 63, 161, 1, 0, create_time);
		#*/
		SET i=i+1;
	END WHILE;
END;
;;
delimiter ;

-- ----------------------------
-- Procedure structure for plan
-- ----------------------------
DROP PROCEDURE IF EXISTS `plan`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `plan`(num INT)
BEGIN
DECLARE i INT;
SET i=0;
WHILE i<num DO
INSERT INTO `p4p`.`ad_plan` (
    `name`,
    `cast_speed`,
    `budget`,
    `start_date`,
    `end_date`,
    `turn`,
    `ask_type`,
    `status`,
    `creater`,
    `create_time`
)
VALUES
    (
        CONCAT('zhaoyanlingtest',i),
        1,
        50,
        '20171111',
        '20171111',
        1,
        0,
        1,
        10057,
    '20171111121221'
    );
SET i=i+1;
END WHILE;
END;
;;
delimiter ;

-- ----------------------------
-- Procedure structure for plannew
-- ----------------------------
DROP PROCEDURE IF EXISTS `plannew`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `plannew`(num INT)
BEGIN
DECLARE i INT;
SET i=0;
WHILE i<num DO
INSERT INTO `p4p`.`ad_plan` (
    `name`,
    `cast_speed`,
    `budget`,
    `start_date`,
    `end_date`,
    `turn`,
    `ask_type`,
    `status`,
    `creater`,
    `create_time`
)
VALUES
    (
        CONCAT('200zhaoyanlingtest',i),
        1,
        50,
        '20170111',
        '20171111',
        1,
        0,
        1,
        110492,
    '20171111121221'
    );
SET i=i+1;
END WHILE;
END;
;;
delimiter ;

-- ----------------------------
-- Procedure structure for scheduling
-- ----------------------------
DROP PROCEDURE IF EXISTS `scheduling`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `scheduling`(num INT)
BEGIN
DECLARE i INT;
SET i=0;
WHILE i<num do
INSERT INTO `p4p`.`scheduling_info` (
    `name`,
    `ad_plan_id`,
    `turn`,
    `device`,
    `system`,
    `network`,
    `platform`,
    `cast_way`,
    `pay`,
    `creater`,
    `create_time`
)
VALUES
    (
        CONCAT('zhaoyanlingtestgroup',i),
        330,
        1,
        0,
        0,
        0,
        0,
        0,
        6,
        10057,
        '20171011');
SET i=i+1;
END WHILE;
END;
;;
delimiter ;

-- ----------------------------
-- Procedure structure for scheduling1
-- ----------------------------
DROP PROCEDURE IF EXISTS `scheduling1`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `scheduling1`(num INT)
BEGIN
DECLARE i INT;
SET i=0;
WHILE i<num do
INSERT INTO `p4p`.`scheduling_info` (
    `name`,
    `ad_plan_id`,
    `turn`,
    `device`,
    `system`,
    `network`,
    `platform`,
    `cast_way`,
    `pay`,
    `creater`,
    `create_time`
)
VALUES
    (
        CONCAT('zhaoyanlingtestgroup',i),
        506,
        1,
        0,
        0,
        0,
        0,
        0,
        6,
        10057,
        '20171011');
SET i=i+1;
END WHILE;
END;
;;
delimiter ;

-- ----------------------------
-- Procedure structure for test_add
-- ----------------------------
DROP PROCEDURE IF EXISTS `test_add`;
delimiter ;;
CREATE DEFINER=`adcpm`@`61.135.255.84` PROCEDURE `test_add`(a int, b int)
BEGIN
	DECLARE c INT;
	IF a IS NULL THEN
		SET a=0;
	END IF;
	IF b IS NULL THEN
		SET b=0;
	END IF;
	SET c=a+b;
	SELECT c AS sum;
END;
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
