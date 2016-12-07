/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50168
Source Host           : localhost:3306
Source Database       : samp

Target Server Type    : MYSQL
Target Server Version : 50168
File Encoding         : 65001

Date: 2014-10-02 18:50:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `pId` int(255) NOT NULL AUTO_INCREMENT,
  `pName` varchar(20) DEFAULT NULL,
  `pPassword` varchar(20) DEFAULT NULL,
  `pLevel` int(1) DEFAULT '0',
  `pSex` int(1) DEFAULT NULL,
  `pSkin` int(3) DEFAULT NULL,
  PRIMARY KEY (`pId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES ('10', 'Clemente_Carraro2', '123', '0', '0', '0');
INSERT INTO `accounts` VALUES ('11', 'Tony_Starky', 'qwerty', '0', '0', '0');
