
SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `survey`
-- ----------------------------
DROP TABLE IF EXISTS `survey`;
CREATE TABLE `survey` (
  `survey_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '问卷ID',
  `survey_name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '问卷名',
  `survey_title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '问卷标题',
  `survey_status` tinyint(1) unsigned DEFAULT '0' COMMENT '问卷状态: 0编辑中 1已发布',
  `uid` int(11) DEFAULT NULL COMMENT '创建人uid',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`survey_id`),
  UNIQUE KEY `survey_name` (`survey_name`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='问卷基础表';

-- ----------------------------
--  Table structure for `survey_answer`
-- ----------------------------
DROP TABLE IF EXISTS `survey_answer`;
CREATE TABLE `survey_answer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) unsigned DEFAULT '0' COMMENT '用户ID',
  `survey_id` int(11) NOT NULL COMMENT '问卷ID',
  `question_id` int(11) NOT NULL DEFAULT '0' COMMENT '问题ID',
  `question_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '问题类型',
  `choice` tinyint(1) DEFAULT '0' COMMENT '答案选项(单选题,多选题)',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '回答内容',
  `cols` tinyint(4) DEFAULT '0' COMMENT '列数',
  `rows` tinyint(4) DEFAULT '0' COMMENT '行数',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='答卷表';

-- ----------------------------
--  Table structure for `survey_content`
-- ----------------------------
DROP TABLE IF EXISTS `survey_content`;
CREATE TABLE `survey_content` (
  `survey_id` int(11) unsigned NOT NULL COMMENT '问卷ID',
  `survey_content` mediumtext COLLATE utf8_bin COMMENT '问卷内容',
  `survey_logic` mediumtext COLLATE utf8_bin COMMENT '联动逻辑',
  PRIMARY KEY (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='问卷内容';

SET FOREIGN_KEY_CHECKS = 1;
