ALTER USER 'q_writer'@'%' IDENTIFIED WITH mysql_native_password BY 'Qwriter$2018~';
CREATE USER 'q_writer'@'%.%.%.%' IDENTIFIED WITH mysql_native_password BY 'Qwriter$2018~';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'Luxx2019~';
CREATE USER 'root'@'%.%.%.%' IDENTIFIED WITH mysql_native_password BY 'Luxx2018~';
GRANT ALL PRIVILEGES ON *.* TO 'q_writer'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'q_writer'@'%.%.%.%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%.%.%.%';
FLUSH PRIVILEGES;

-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 35.202.35.138    Database: luxx
-- ------------------------------------------------------
-- Server version	5.7.14-google-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

-- -----------------------------------------------------
-- Schema luxx
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `luxx` ;

-- -----------------------------------------------------
-- Schema luxx
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `luxx` DEFAULT CHARACTER SET utf8mb4 ;
USE `luxx` ;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `email` varchar(128) NOT NULL,
                      `firstName` varchar(64) DEFAULT NULL,
                      `lastName` varchar(64) DEFAULT NULL,
                      `password` varchar(512) DEFAULT NULL,
                      `phone` varchar(14) DEFAULT NULL,
                      `emailValid` tinyint(1) NOT NULL DEFAULT '0',
                      `smsVerificationId` varchar(16) DEFAULT NULL,
                      `failedLoginAttempt` int(11) NOT NULL DEFAULT '0',
                      `status` varchar(4) NOT NULL DEFAULT 'lite',
                      `sessionTimeout` int(11) NOT NULL DEFAULT '30',
                      `referrerId` int(11) DEFAULT NULL,
                      PRIMARY KEY (`id`),
                      UNIQUE KEY `email_UNIQUE` (`email`),
                      UNIQUE KEY `phone_UNIQUE` (`phone`),
                      CONSTRAINT `User_ibfk1` FOREIGN KEY (`status`) REFERENCES `SysUserStatus` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
  /*                    CONSTRAINT `User_ibfk2` FOREIGN KEY (`referrerId`) REFERENCES `SysRole` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
  */) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES
      (0, 'luxxcorp2017@gmail.com','Luxx','Digital','','',1,'',0,'bill','30',0);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysPermission`
--

DROP TABLE IF EXISTS `SysPermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysPermission` (
                          `code` char(4) NOT NULL,
                          `label` varchar(64) NOT NULL,
                          `description` varchar(256) DEFAULT NULL,
                          `active` tinyint(1) NOT NULL DEFAULT '1',
                          `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                          `lastModifiedUser` int(11) DEFAULT '0',
                          PRIMARY KEY (`code`),
                          CONSTRAINT `SysPermission_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysPermission`
--

LOCK TABLES `SysPermission` WRITE;
/*!40000 ALTER TABLE `SysPermission` DISABLE KEYS */;
INSERT INTO `SysPermission` VALUES
    ('crea','Create','',1,'2018-05-01 17:16:05.416',NULL),
    ('read','Read','',1,'2018-05-01 17:16:05.416',NULL),
    ('upda','Update','',1,'2018-05-01 17:16:05.416',NULL),
    ('dele','Delete','',1,'2018-05-01 17:16:05.416',NULL);
/*!40000 ALTER TABLE `SysPermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysFeature`
--

DROP TABLE IF EXISTS `SysFeature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysFeature` (
                          `code` char(4) NOT NULL,
                          `label` varchar(64) NOT NULL,
                          `description` varchar(256) DEFAULT NULL,
                          `active` tinyint(1) NOT NULL DEFAULT '1',
                          `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                          `lastModifiedUser` int(11) DEFAULT '0',
                          PRIMARY KEY (`code`),
                          CONSTRAINT `SysFeature_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysFeature`
--

LOCK TABLES `SysFeature` WRITE;
/*!40000 ALTER TABLE `SysFeature` DISABLE KEYS */;
INSERT INTO `SysFeature` VALUES
    ('reg','Registration','',1,'2018-05-01 17:16:05.416',NULL),
    ('pay','Payments','',1,'2018-05-01 17:16:05.416',NULL),
    ('expe','Experience','',1,'2018-05-01 17:16:05.416',NULL),
    ('revw','Review','',1,'2018-05-01 17:16:05.416',NULL),
    ('expl','Explore','',1,'2018-05-01 17:16:05.416',NULL);
/*!40000 ALTER TABLE `SysFeature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysService`
--

DROP TABLE IF EXISTS `SysService`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysService` (
                          `code` char(4) NOT NULL,
                          `label` varchar(64) NOT NULL,
                          `description` varchar(256) DEFAULT NULL,
                          `active` tinyint(1) NOT NULL DEFAULT '1',
                          `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                          `lastModifiedUser` int(11) DEFAULT '0',
                          PRIMARY KEY (`code`),
                          CONSTRAINT `SysService_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysService`
--

LOCK TABLES `SysService` WRITE;
/*!40000 ALTER TABLE `SysService` DISABLE KEYS */;
INSERT INTO `SysService` VALUES
    ('evnt','Hosted Event','Hosted event is hosted by a preferred vendor',1,'2018-05-01 17:16:06.589',NULL),
    ('meet','Private Event','Private event is hosted by a group of users at a location not managed by one of our preferred vendors',1,'2018-05-01 17:16:06.630',NULL),
    ('ride','Ride Event','Ride event is a private transportation event',1,'2018-05-01 17:16:06.499',NULL),
    ('rout','Routed Event','Routed event is a transportation event hosted by a preferred vendor',1,'2018-05-01 17:16:06.544',NULL);
/*!40000 ALTER TABLE `SysService` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `SysRole`
--

DROP TABLE IF EXISTS `SysRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysRole` (
                          `code` char(4) NOT NULL,
                          `label` varchar(64) NOT NULL,
                          `active` tinyint(4) NOT NULL DEFAULT '1',
                          `description` varchar(256) DEFAULT NULL,
                          `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                          `lastModifiedUser` int(11) DEFAULT '0',
                          PRIMARY KEY (`code`),
                          CONSTRAINT `SysRole_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysRole`
--

LOCK TABLES `SysRole` WRITE;
/*!40000 ALTER TABLE `SysRole` DISABLE KEYS */;
INSERT INTO `SysRole` VALUES
    ('admn','Platform Administrator',1,NULL,'2018-05-01 17:16:05.416',NULL),
    ('bill','Back Office Billing User',1,NULL,'2018-05-01 17:16:05.375',NULL),
    ('boss','Back Office Adminstrator',1,NULL,'2018-05-01 17:16:05.457',NULL),
    ('drvr','Driver of Vehicle',1,NULL,'2018-05-01 17:16:05.290',NULL),
    ('gest','Guest of Passenger',1,NULL,'2018-05-01 17:16:05.497',NULL),
    ('cust','Experience Customer',1,NULL,'2018-05-01 17:16:05.334',NULL);
/*!40000 ALTER TABLE `SysRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysSetting`
--

DROP TABLE IF EXISTS `SysSetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysSetting` (
                          `code` varchar(4) NOT NULL,
                          `description` varchar(64) NOT NULL,
                          `value` varchar(64) NOT NULL,
                          `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                          `lastModifiedUser` int(11) DEFAULT '0',
                          PRIMARY KEY (`code`),
                          CONSTRAINT `SysSetting_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysSetting`
--

LOCK TABLES `SysSetting` WRITE;
/*!40000 ALTER TABLE `SysSetting` DISABLE KEYS */;
INSERT INTO `SysSetting` VALUES
    ('expr','Token Expiration','900','2018-05-01 17:16:05.416',NULL),
    ('snch','Sinch API Key','b72eef3b-50c1-4bb2-a537-ec9f998fe289','2018-05-01 17:16:05.416',NULL),
    ('auth','Authorize.NET API Key','replace me','2018-05-01 17:16:05.416',NULL),
    ('gmap','Google Maps API Key','AIzaSyAvcDy5ZYc2ujCS6TTtI3RYX5QmuoV8Ffw','2018-05-01 17:16:05.416',NULL),
    ('retr','Login Retry Count','3','2018-05-01 17:16:05.416',NULL),
    ('conf','Email Confirmation URL Path','confirm','2018-05-01 17:16:05.416',NULL),
    ('veri','SMS Verification URL Path','verify','2018-05-01 17:16:05.416',NULL);
/*!40000 ALTER TABLE `SysSetting` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `SysTokenType`
--

DROP TABLE IF EXISTS `SysTokenType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysTokenType` (
                               `code` char(4) NOT NULL,
                               `label` varchar(64) NOT NULL,
                               `description` varchar(256) DEFAULT NULL,
                               `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                               `lastModifiedUser` int(11) DEFAULT '0',
                               PRIMARY KEY (`code`),
                               CONSTRAINT `SysTokenType_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysTokenType`
--

LOCK TABLES `SysTokenType` WRITE;
/*!40000 ALTER TABLE `SysTokenType` DISABLE KEYS */;
INSERT INTO `SysTokenType` VALUES
    ('nusr','New User Token','','2018-05-01 17:16:05.416',NULL),
    ('rset','Forgot E-mail/Username Token','','2018-05-01 17:16:05.416',NULL),
    ('pass','Forgot Password Token','','2018-05-01 17:16:05.416',NULL),
    ('refr','Authentication Refresh Token','','2018-05-01 17:16:05.416',NULL),
    ('paym','Payment Profile Token','','2018-05-01 17:16:05.416',NULL),
    ('rfrl','Referral Token','','2018-05-01 17:16:05.416',NULL),
    ('auth','Authentication Initialization Token','','2018-05-01 17:16:05.416',NULL);
/*!40000 ALTER TABLE `SysTokenType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysUserState`
--

DROP TABLE IF EXISTS `SysUserState`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysUserState` (
                        `code` varchar(4) NOT NULL,
                        `label` varchar(64) NOT NULL,
                        `description` varchar(256) DEFAULT NULL,
                        `active` tinyint(4) NOT NULL DEFAULT '1',
                        `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                        `lastModifiedUser` int(11) DEFAULT '0',
                        PRIMARY KEY (`code`),
                        UNIQUE KEY `code_UNIQUE` (`code`),
                        CONSTRAINT `SysUserState_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysUserState`
--

LOCK TABLES `SysUserState` WRITE;
/*!40000 ALTER TABLE `SysUserState` DISABLE KEYS */;
INSERT INTO `SysUserState` VALUES
    ('anon','Anonymous','Anonymous Visitor Identifiable by Session ID',1,'2018-05-01 17:16:05.416',NULL),
    ('part','Partially Registered','Registered User without email confirmation or sms verification',1,'2018-05-01 17:16:05.416',NULL),
    ('conf','Confirmed','Registered User with confirmed email only',1,'2018-05-01 17:16:05.416',NULL),
    ('veri','Verified','Registered User with verified sms only',1,'2018-05-01 17:16:05.416',NULL),
    ('full','Fully Registered','Registered User with confirmed email and verified sms',1,'2018-05-01 17:16:05.416',NULL),
    ('bill','Billable User','Billable User who has authorized payment info',1,'2018-05-01 17:16:05.416',NULL);
/*!40000 ALTER TABLE `SysUserState` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysUserStatus`
--

DROP TABLE IF EXISTS `SysUserStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysUserStatus` (
                        `code` varchar(4) NOT NULL,
                        `label` varchar(64) NOT NULL,
                        `description` varchar(256) DEFAULT NULL,
                        `active` tinyint(4) NOT NULL DEFAULT '1',
                        `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                        `lastModifiedUser` int(11) DEFAULT '0',
                        PRIMARY KEY (`code`),
                        UNIQUE KEY `code_UNIQUE` (`code`),
                        CONSTRAINT `SysUserStatus_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysUserStatus`
--

LOCK TABLES `SysUserStatus` WRITE;
/*!40000 ALTER TABLE `SysUserStatus` DISABLE KEYS */;
INSERT INTO `SysUserStatus` VALUES
    ('actv','Active','User is Active',1,'2018-05-01 17:16:05.416',NULL),
    ('susp','Suspended','User is Suspended',1,'2018-05-01 17:16:05.416',NULL),
    ('disa','Disabled','User is Disabled',1,'2018-05-01 17:16:05.416',NULL),
    ('lock','Locked','User is Locked',1,'2018-05-01 17:16:05.416',NULL),
    ('lite','Active','User is not fully registered',1,'2018-05-01 17:16:05.416',NULL);
/*!40000 ALTER TABLE `SysUserStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysRolePermission`
--

DROP TABLE IF EXISTS `SysRolePermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysRolePermission` (
                                   `role` char(4) NOT NULL,
                                   `permission` char(4) NOT NULL,
                                   `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                   `lastModifiedUser` int(11) DEFAULT '0',
                                   PRIMARY KEY (`role`,`permission`),
                                   CONSTRAINT `SysRolePermission_ibfk1` FOREIGN KEY (`role`) REFERENCES `SysRole` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                   CONSTRAINT `SysRolePermission_ibfk2` FOREIGN KEY (`permission`) REFERENCES `SysPermission` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                   CONSTRAINT `SysRolePermission_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysRolePermission`
--

LOCK TABLES `SysRolePermission` WRITE;
/*!40000 ALTER TABLE `SysRolePermission` DISABLE KEYS */;
INSERT INTO `SysRolePermission` VALUES
    ('cust','crea','2018-05-01 17:16:05.334',NULL),
    ('cust','read','2018-05-01 17:16:05.334',NULL),
    ('cust','upda','2018-05-01 17:16:05.334',NULL),
    ('cust','dele','2018-05-01 17:16:05.334',NULL);
/*!40000 ALTER TABLE `SysRolePermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
                           `code` char(4) NOT NULL,
                           `label` varchar(64) NOT NULL,
                           `description` varchar(256) DEFAULT NULL,
                           `active` tinyint(4) NOT NULL DEFAULT '1',
                           `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                           `lastModifiedUser` int(11) DEFAULT '0',
                           PRIMARY KEY (`code`),
                           CONSTRAINT `Category_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES
('trsp','Transportation','Transportation Category displayed to Vendors and Consumers',1,'2018-05-01 17:16:06.589',NULL),
('limo','Limo','Limo Category displayed to Vendors and Consumers',1,'2018-05-01 17:16:06.589',NULL),
('rlim','Personal Limo','Personal Limo',1,'2018-05-01 17:16:05.663',NULL),
('slim','Stretch Limo','Car Stretch Limo',1,'2018-05-01 17:16:05.703',NULL),
('xlim','SUV Limo','SUV Stretch Limo',1,'2018-05-01 17:16:05.703',NULL),
('busg','Bus','Bus Category displayed to Vendors and Consumers',1,'2018-05-01 17:16:06.589',NULL),
('vang','Van','Van Category displayed to Vendors and Consumers',1,'2018-05-01 17:16:06.589',NULL),
('suvg','SUV','SUV Category displayed to Vendors and Consumers',1,'2018-05-01 17:16:06.589',NULL),
('bsuv','Black SUV','Black SUV',1,'2018-05-01 17:16:05.787',NULL),
('pbus','Party Bus','Party Bus',1,'2018-05-01 17:16:05.746',NULL),
('svan','Sprinter Van','Sprinter Van',1,'2018-05-01 17:16:05.828',NULL),
('lodg','Lodging','Lodging Vendor',1,'2018-05-01 17:16:06.589',NULL),
('venu','Venue','Venue Vendor',1,'2018-05-01 17:16:06.589',NULL),
('bar','Bar','Bar Vendor',1,'2018-05-01 17:16:06.589',NULL),
('rstr','Restaurant','Restaurant Vendor',1,'2018-05-01 17:16:06.589',NULL);
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubCategory`
--

DROP TABLE IF EXISTS `SubCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SubCategory` (
                 `parentCategory` char(4) NOT NULL,
                 `childCategory` char(4) NOT NULL,
                 `active` tinyint(4) NOT NULL DEFAULT '1',
                 `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                 `lastModifiedUser` int(11) DEFAULT '0',
                 PRIMARY KEY (`parentCategory`,`childCategory`),
                 CONSTRAINT `SubCategory_ibfk1` FOREIGN KEY (`parentCategory`) REFERENCES `Category` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                 CONSTRAINT `SubCategory_ibfk2` FOREIGN KEY (`childCategory`) REFERENCES `Category` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                 CONSTRAINT `SubCategory_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysRolePermission`
--

LOCK TABLES `SubCategory` WRITE;
/*!40000 ALTER TABLE `SubCategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `SubCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SysAddressType`
--

DROP TABLE IF EXISTS `SysAddressType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SysAddressType` (
                              `code` char(4) NOT NULL,
                              `label` varchar(64) NOT NULL,
                              `description` varchar(256) DEFAULT NULL,
                              `active` tinyint(4) NOT NULL DEFAULT '1',
                              `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                              `lastModifiedUser` int(11) DEFAULT '0',
                              PRIMARY KEY (`code`),
                              CONSTRAINT `SysAddressType_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SysTokenType`
--

LOCK TABLES `SysAddressType` WRITE;
/*!40000 ALTER TABLE `SysAddressType` DISABLE KEYS */;
INSERT INTO `SysAddressType` VALUES
('bill','Billing Address','',1,'2018-05-01 17:16:05.416',NULL),
('home','Home Address','',1,'2018-05-01 17:16:05.416',NULL),
('vend','Vendor Address','',1,'2018-05-01 17:16:05.416',NULL),
('dest','Destination Address','',1,'2018-05-01 17:16:05.416',NULL);
/*!40000 ALTER TABLE `SysAddressType` ENABLE KEYS */;
UNLOCK TABLES;
