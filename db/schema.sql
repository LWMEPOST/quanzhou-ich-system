-- 数据库初始化脚本
-- 字符集：utf8mb4
-- 排序规则：utf8mb4_general_ci

CREATE DATABASE IF NOT EXISTS `quanzhou_ich` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE `quanzhou_ich`;

-- 1. 用户表 (SysUser)
CREATE TABLE IF NOT EXISTS `sys_user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(100) NOT NULL COMMENT '密码 (加密)',
    `nickname` VARCHAR(50) COMMENT '昵称',
    `email` VARCHAR(100) COMMENT '邮箱',
    `phone` VARCHAR(20) COMMENT '手机号',
    `avatar` VARCHAR(255) COMMENT '头像 URL',
    `role` VARCHAR(20) DEFAULT 'USER' COMMENT '角色：USER, MASTER, ADMIN',
    `preference_tags` JSON COMMENT '偏好标签权重 JSON',
    `is_deleted` TINYINT(1) DEFAULT 0 COMMENT '逻辑删除：0 未删，1 已删',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    INDEX `idx_role` (`role`)
) ENGINE=InnoDB COMMENT='系统用户表';

-- 2. 非遗分类表 (IchCategory)
CREATE TABLE IF NOT EXISTS `ich_category` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
    `description` VARCHAR(255) COMMENT '描述',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `is_deleted` TINYINT(1) DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='非遗分类表';

-- 3. 非遗项目表 (IchItem)
CREATE TABLE IF NOT EXISTS `ich_item` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `category_id` BIGINT NOT NULL COMMENT '分类 ID',
    `name` VARCHAR(100) NOT NULL COMMENT '项目名称',
    `level` VARCHAR(20) COMMENT '级别 (国家级/省级/市级)',
    `inheritor` VARCHAR(100) COMMENT '代表性传承人',
    `region` VARCHAR(50) COMMENT '所属地区',
    `description` TEXT COMMENT '详细介绍',
    `cover_img` VARCHAR(255) COMMENT='封面图',
    `video_url` VARCHAR(255) COMMENT='视频链接',
    `view_count` BIGINT DEFAULT 0 COMMENT '浏览量',
    `like_count` BIGINT DEFAULT 0 COMMENT '点赞量',
    `status` VARCHAR(20) DEFAULT 'AUDITING' COMMENT '状态：PUBLISHED, AUDITING, REJECTED',
    `audit_remark` VARCHAR(255) COMMENT '审核备注',
    `creator_id` BIGINT COMMENT '创作者 ID',
    `is_deleted` TINYINT(1) DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX `idx_category` (`category_id`),
    INDEX `idx_name` (`name`),
    INDEX `idx_status` (`status`),
    INDEX `idx_creator` (`creator_id`)
) ENGINE=InnoDB COMMENT='非遗项目表';

-- 4. 传承大师表 (IchMaster)
CREATE TABLE IF NOT EXISTS `ich_master` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '关联用户 ID',
    `name` VARCHAR(50) NOT NULL COMMENT '大师姓名',
    `avatar` VARCHAR(255) COMMENT '头像',
    `category_id` BIGINT COMMENT '非遗分类 ID',
    `level` VARCHAR(20) COMMENT '大师级别',
    `introduction` TEXT COMMENT '个人简介',
    `achievements` TEXT COMMENT '主要成就',
    `is_deleted` TINYINT(1) DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user` (`user_id`),
    INDEX `idx_category` (`category_id`)
) ENGINE=InnoDB COMMENT='传承大师表';

-- 5. 传承人认证申请表 (IchMasterCertification)
CREATE TABLE IF NOT EXISTS `ich_master_certification` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '申请用户 ID',
    `real_name` VARCHAR(50) NOT NULL COMMENT '真实姓名',
    `id_card` VARCHAR(20) NOT NULL COMMENT '身份证号',
    `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系电话',
    `project_name` VARCHAR(100) COMMENT '申报项目名称',
    `category_id` BIGINT COMMENT '申报项目分类 ID',
    `level` VARCHAR(20) COMMENT '申报级别',
    `evidence_url` VARCHAR(255) COMMENT '证明材料 URL',
    `introduction` TEXT COMMENT '个人简介/传承经历',
    `status` VARCHAR(20) DEFAULT 'PENDING' COMMENT '状态：PENDING, APPROVED, REJECTED',
    `audit_remark` VARCHAR(255) COMMENT '审核意见',
    `is_deleted` TINYINT(1) DEFAULT 0 COMMENT '逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX `idx_user` (`user_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB COMMENT='传承人认证申请表';

-- 6. 社区活动表 (IchActivity)
CREATE TABLE IF NOT EXISTS `ich_activity` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `title` VARCHAR(100) NOT NULL COMMENT '活动标题',
    `cover_img` VARCHAR(255) COMMENT='封面图',
    `description` TEXT COMMENT='活动介绍',
    `location` VARCHAR(100) COMMENT='活动地点',
    `start_time` DATETIME COMMENT='活动开始时间',
    `end_time` DATETIME COMMENT='活动结束时间',
    `max_participants` INT COMMENT='最大参与人数',
    `current_participants` INT DEFAULT 0 COMMENT='当前参与人数',
    `status` VARCHAR(20) DEFAULT 'AUDITING' COMMENT='状态：PUBLISHED, AUDITING, REJECTED',
    `audit_remark` VARCHAR(255) COMMENT='审核备注',
    `creator_id` BIGINT COMMENT='创建者 ID',
    `is_deleted` TINYINT(1) DEFAULT 0 COMMENT='逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX `idx_status` (`status`),
    INDEX `idx_creator` (`creator_id`)
) ENGINE=InnoDB COMMENT='社区活动表';

-- 7. 活动报名表 (ActivityRegistration)
CREATE TABLE IF NOT EXISTS `activity_registration` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `activity_id` BIGINT NOT NULL COMMENT '活动 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `status` VARCHAR(20) DEFAULT 'REGISTERED' COMMENT='状态：REGISTERED, CANCELLED',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '报名时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_activity_user` (`activity_id`, `user_id`),
    INDEX `idx_activity` (`activity_id`),
    INDEX `idx_user` (`user_id`)
) ENGINE=InnoDB COMMENT='活动报名表';

-- 8. 用户行为记录表 (UserBehavior)
CREATE TABLE IF NOT EXISTS `user_behavior` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `item_id` BIGINT COMMENT '非遗项目 ID',
    `activity_id` BIGINT COMMENT '活动 ID',
    `behavior_type` VARCHAR(20) NOT NULL COMMENT='行为类型：VIEW, LIKE, COLLECT, SHARE, REGISTER',
    `behavior_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT='行为时间',
    `score` DECIMAL(3,2) DEFAULT 1.0 COMMENT='行为权重',
    `is_deleted` TINYINT(1) DEFAULT 0 COMMENT='逻辑删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX `idx_user` (`user_id`),
    INDEX `idx_item` (`item_id`),
    INDEX `idx_behavior_type` (`behavior_type`)
) ENGINE=InnoDB COMMENT='用户行为记录表';
