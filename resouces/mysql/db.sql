CREATE TABLE `customer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `customer_code` varchar(64) NOT NULL DEFAULT '' COMMENT '客户编号',
  `customer_name` varchar(64) NOT NULL DEFAULT '' COMMENT '客户名称',
  `profile` varchar(1024) NOT NULL DEFAULT '' COMMENT '客户简历',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_code` (`customer_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb4 COMMENT='银行客户表';

CREATE TABLE `account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `customer_code` varchar(64) NOT NULL DEFAULT '' COMMENT '客户编号',
  `acc_number` varchar(64) NOT NULL DEFAULT '' COMMENT '银行帐号',
  `open_org` varchar(128) NOT NULL DEFAULT '' COMMENT '开户行名称',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '帐号余额',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_code` (`customer_code`,`acc_number`)
) ENGINE=InnoDB AUTO_INCREMENT=200001 DEFAULT CHARSET=utf8mb4 COMMENT='客户银行帐号表';

CREATE TABLE `trans` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `acc_number` varchar(64) NOT NULL DEFAULT '' COMMENT '银行卡帐号',
  `trans_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '交易时间',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '交易金额',
  `opp_acc_number` varchar(64) NOT NULL DEFAULT '' COMMENT '对方银行卡号',
  `opp_customer_name` varchar(64) NOT NULL DEFAULT '' COMMENT '对方名称',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=300001 DEFAULT CHARSET=utf8mb4 COMMENT='交易明细表'