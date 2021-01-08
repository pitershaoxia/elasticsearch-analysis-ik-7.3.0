/*
 Navicat Premium Data Transfer

 Source Server         : 本地MySQL
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : dianpingdb

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 08/01/2021 11:10:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hot_words
-- ----------------------------
DROP TABLE IF EXISTS `hot_words`;
CREATE TABLE `hot_words`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热词\r\n',
  `flag` tinyint(1) NULL DEFAULT NULL COMMENT '0停止热词，1不停止',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hot_words
-- ----------------------------
INSERT INTO `hot_words` VALUES (1, '天下无贼', 0);
INSERT INTO `hot_words` VALUES (3, '菠萝吹雪', 1);
INSERT INTO `hot_words` VALUES (4, '亚索', 1);

SET FOREIGN_KEY_CHECKS = 1;
