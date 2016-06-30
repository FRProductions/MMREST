# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: d1b2884d0e5debfaa34c758e2355b84c5f1874c3.rackspaceclouddb.com (MySQL 5.6.27)
# Database: MoneyMonster
# Generation Time: 2016-06-30 20:39:04 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account_emailaddress
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_emailaddress`;

CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_auth_user_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;

INSERT INTO `account_emailaddress` (`id`, `email`, `verified`, `primary`, `user_id`)
VALUES
	(2,'dummybearish@gmail.com',0,1,3),
	(3,'tom@moneymonster101.org',1,1,4),
	(4,'lowell.list@gmail.com',1,1,5),
	(5,'rnelson@flyingrhino.com',1,1,6);

/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table account_emailconfirmation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_emailconfirmation`;

CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `sent` datetime DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_ema_email_address_id_5b7f8c58_fk_account_emailaddress_id` (`email_address_id`),
  CONSTRAINT `account_ema_email_address_id_5b7f8c58_fk_account_emailaddress_id` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;

INSERT INTO `account_emailconfirmation` (`id`, `created`, `sent`, `key`, `email_address_id`)
VALUES
	(2,'2016-06-24 22:16:57','2016-06-24 22:16:58','ec5pjsm8jqzp1qdr6e1y1zyeqleutfoc0epgv0ttnxpms4xjrtgzldwfkwxkpg8o',2),
	(3,'2016-06-27 20:31:26','2016-06-27 20:31:27','dfdrkgenq9vsnotku6phs5zut6xfspfhev0eecbc2bcd8ksbalsnrlc8npofnzlq',3),
	(4,'2016-06-30 14:51:35','2016-06-30 14:51:36','0pfdd43xd46il9gz1i2jagzwlbqnzevhvrllgamreqzay5lj0mia7d7tdmca2hzx',4),
	(5,'2016-06-30 15:23:34','2016-06-30 15:23:35','q5fuocglg0f0dwegq1pw1nzgvyx6xjyvtxphn5jbx3eie62sdunehkjepatfij35',5);

/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_group_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`)
VALUES
	(1,'Can add log entry',1,'add_logentry'),
	(2,'Can change log entry',1,'change_logentry'),
	(3,'Can delete log entry',1,'delete_logentry'),
	(4,'Can add permission',2,'add_permission'),
	(5,'Can change permission',2,'change_permission'),
	(6,'Can delete permission',2,'delete_permission'),
	(7,'Can add group',3,'add_group'),
	(8,'Can change group',3,'change_group'),
	(9,'Can delete group',3,'delete_group'),
	(10,'Can add user',4,'add_user'),
	(11,'Can change user',4,'change_user'),
	(12,'Can delete user',4,'delete_user'),
	(13,'Can add content type',5,'add_contenttype'),
	(14,'Can change content type',5,'change_contenttype'),
	(15,'Can delete content type',5,'delete_contenttype'),
	(16,'Can add session',6,'add_session'),
	(17,'Can change session',6,'change_session'),
	(18,'Can delete session',6,'delete_session'),
	(19,'Can add site',7,'add_site'),
	(20,'Can change site',7,'change_site'),
	(21,'Can delete site',7,'delete_site'),
	(22,'Can add Token',8,'add_token'),
	(23,'Can change Token',8,'change_token'),
	(24,'Can delete Token',8,'delete_token'),
	(25,'Can add email address',9,'add_emailaddress'),
	(26,'Can change email address',9,'change_emailaddress'),
	(27,'Can delete email address',9,'delete_emailaddress'),
	(28,'Can add email confirmation',10,'add_emailconfirmation'),
	(29,'Can change email confirmation',10,'change_emailconfirmation'),
	(30,'Can delete email confirmation',10,'delete_emailconfirmation'),
	(31,'Can add social application',11,'add_socialapp'),
	(32,'Can change social application',11,'change_socialapp'),
	(33,'Can delete social application',11,'delete_socialapp'),
	(34,'Can add social account',12,'add_socialaccount'),
	(35,'Can change social account',12,'change_socialaccount'),
	(36,'Can delete social account',12,'delete_socialaccount'),
	(37,'Can add social application token',13,'add_socialtoken'),
	(38,'Can change social application token',13,'change_socialtoken'),
	(39,'Can delete social application token',13,'delete_socialtoken'),
	(40,'Can add video',14,'add_video'),
	(41,'Can change video',14,'change_video'),
	(42,'Can delete video',14,'delete_video'),
	(43,'Can add video status',15,'add_videostatus'),
	(44,'Can change video status',15,'change_videostatus'),
	(45,'Can delete video status',15,'delete_videostatus'),
	(46,'Can add comment',16,'add_comment'),
	(47,'Can change comment',16,'change_comment'),
	(48,'Can delete comment',16,'delete_comment'),
	(49,'Can add comment like',17,'add_commentlike'),
	(50,'Can change comment like',17,'change_commentlike'),
	(51,'Can delete comment like',17,'delete_commentlike'),
	(52,'Can add to do',18,'add_todo'),
	(53,'Can change to do',18,'change_todo'),
	(54,'Can delete to do',18,'delete_todo'),
	(55,'Can add quiz',19,'add_quiz'),
	(56,'Can change quiz',19,'change_quiz'),
	(57,'Can delete quiz',19,'delete_quiz'),
	(58,'Can add quiz question',20,'add_quizquestion'),
	(59,'Can change quiz question',20,'change_quizquestion'),
	(60,'Can delete quiz question',20,'delete_quizquestion'),
	(61,'Can add quiz result',21,'add_quizresult'),
	(62,'Can change quiz result',21,'change_quizresult'),
	(63,'Can delete quiz result',21,'delete_quizresult');

/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`)
VALUES
	(1,'pbkdf2_sha256$24000$39aDzd6xRO8S$7a3V6Cg7sNxIa3Vi81KTxD4oPqw6g42pV8MD7n9oopw=','2016-06-30 18:05:45',1,'admin','','','apps@flyingrhino.com',1,1,'2016-06-24 21:10:26'),
	(3,'!4Vv54wTSycvEFKK9ElZWofrK9qEbHFwwXZSwgzOY','2016-06-24 22:16:58',0,'jimmy','Jimmy','Bear','dummybearish@gmail.com',0,1,'2016-06-24 22:16:57'),
	(4,'pbkdf2_sha256$24000$yR5WMDFIhFMY$AzZTQPvUCGg3G+J26H/dl+6ZET7iIHhfRFQMOeRnCRA=','2016-06-27 20:31:27',0,'Notsure','','','tom@moneymonster101.org',0,1,'2016-06-27 20:31:26'),
	(5,'pbkdf2_sha256$24000$ZE0oz5DMxq3o$ry8Pno9QWA8HdHrVyftGbfpWEXWSJSTUdA/otK80WPM=','2016-06-30 15:02:27',0,'lowell','','','lowell.list@gmail.com',0,1,'2016-06-30 14:51:35'),
	(6,'pbkdf2_sha256$24000$H33j50aBuf2g$1dX7qXFfIFarTWx9Q7TkWaZj5+LY8vxEt9CuXvKEyg4=','2016-06-30 15:23:35',0,'RhinoRay','','','rnelson@flyingrhino.com',0,1,'2016-06-30 15:23:34'),
	(7,'pbkdf2_sha256$24000$ywBmwVxJulbq$2O5b8TLOdX1gcPJZmHZ850gMwjWyXcihmTcFox/SzaQ=','2016-06-30 17:31:03',0,'tom','','','t.choquette@comcast.net',1,1,'2016-06-30 17:26:18');

/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_user_user_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;

INSERT INTO `auth_user_user_permissions` (`id`, `user_id`, `permission_id`)
VALUES
	(1,7,25),
	(2,7,40),
	(3,7,41),
	(4,7,42),
	(5,7,43),
	(6,7,44),
	(7,7,45),
	(8,7,46),
	(9,7,47),
	(10,7,48),
	(11,7,49),
	(12,7,50),
	(13,7,51),
	(14,7,52),
	(15,7,53),
	(16,7,54),
	(17,7,55),
	(18,7,56),
	(19,7,57),
	(20,7,58),
	(21,7,59),
	(22,7,60),
	(23,7,61),
	(24,7,62),
	(25,7,63);

/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table authtoken_token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `authtoken_token`;

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`)
VALUES
	('2a4d73e829c790a267046b12535537c6f0197e40','2016-06-30 14:51:35',5),
	('90a653c525ceb6b2c9306ee8c0ee97659dc7c5a9','2016-06-27 20:31:26',4),
	('c184241518c696125a2527a06dbf3758242eff78','2016-06-24 22:16:58',3),
	('caad2d4a8370f84dfcd0bf8ca2fa42b9d2e6bc20','2016-06-30 15:23:34',6);

/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`)
VALUES
	(1,'2016-06-24 21:28:08','1','mm.fraboom.com',2,'Changed domain and name.',7,1),
	(2,'2016-06-24 21:30:27','1','Money Monster',1,'Added.',11,1),
	(3,'2016-06-30 14:49:28','2','lowell',3,'',4,1),
	(4,'2016-06-30 17:10:09','9','Quiz(title:Bank Accounts)',2,'Changed statement for quiz question \"QuizQuestion(quiz:Bank Accounts, statement:Taking your money out of your checking account from an ATM is free.)\".',19,1),
	(5,'2016-06-30 17:11:08','9','Quiz(title:Bank Accounts)',2,'Changed statement for quiz question \"QuizQuestion(quiz:Bank Accounts, statement:Taking money out of your checking account from an ATM is free.)\".',19,1),
	(6,'2016-06-30 17:26:18','7','tom',1,'Added.',4,1),
	(7,'2016-06-30 17:27:31','7','tom',2,'Changed email and is_staff.',4,1),
	(8,'2016-06-30 17:30:33','7','tom',2,'Changed user_permissions.',4,1);

/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_content_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;

INSERT INTO `django_content_type` (`id`, `app_label`, `model`)
VALUES
	(9,'account','emailaddress'),
	(10,'account','emailconfirmation'),
	(1,'admin','logentry'),
	(3,'auth','group'),
	(2,'auth','permission'),
	(4,'auth','user'),
	(8,'authtoken','token'),
	(5,'contenttypes','contenttype'),
	(16,'MoneyMonsterData','comment'),
	(17,'MoneyMonsterData','commentlike'),
	(19,'MoneyMonsterData','quiz'),
	(20,'MoneyMonsterData','quizquestion'),
	(21,'MoneyMonsterData','quizresult'),
	(18,'MoneyMonsterData','todo'),
	(14,'MoneyMonsterData','video'),
	(15,'MoneyMonsterData','videostatus'),
	(6,'sessions','session'),
	(7,'sites','site'),
	(12,'socialaccount','socialaccount'),
	(11,'socialaccount','socialapp'),
	(13,'socialaccount','socialtoken');

/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`)
VALUES
	(1,'contenttypes','0001_initial','2016-06-24 20:58:33'),
	(2,'contenttypes','0002_remove_content_type_name','2016-06-24 20:58:33'),
	(3,'auth','0001_initial','2016-06-24 20:58:34'),
	(4,'MoneyMonsterData','0001_initial','2016-06-24 20:58:34'),
	(5,'MoneyMonsterData','0002_auto_20160617_2109','2016-06-24 20:58:34'),
	(6,'MoneyMonsterData','0003_auto_20160617_2113','2016-06-24 20:58:34'),
	(7,'MoneyMonsterData','0004_auto_20160624_2007','2016-06-24 20:58:35'),
	(8,'account','0001_initial','2016-06-24 20:58:35'),
	(9,'account','0002_email_max_length','2016-06-24 20:58:35'),
	(10,'admin','0001_initial','2016-06-24 20:58:35'),
	(11,'admin','0002_logentry_remove_auto_add','2016-06-24 20:58:35'),
	(12,'auth','0002_alter_permission_name_max_length','2016-06-24 20:58:35'),
	(13,'auth','0003_alter_user_email_max_length','2016-06-24 20:58:35'),
	(14,'auth','0004_alter_user_username_opts','2016-06-24 20:58:35'),
	(15,'auth','0005_alter_user_last_login_null','2016-06-24 20:58:35'),
	(16,'auth','0006_require_contenttypes_0002','2016-06-24 20:58:35'),
	(17,'auth','0007_alter_validators_add_error_messages','2016-06-24 20:58:35'),
	(18,'authtoken','0001_initial','2016-06-24 20:58:35'),
	(19,'authtoken','0002_auto_20160226_1747','2016-06-24 20:58:35'),
	(20,'sessions','0001_initial','2016-06-24 20:58:35'),
	(21,'sites','0001_initial','2016-06-24 20:58:35'),
	(22,'sites','0002_alter_domain_unique','2016-06-24 20:58:35'),
	(23,'socialaccount','0001_initial','2016-06-24 20:58:36'),
	(24,'socialaccount','0002_token_max_lengths','2016-06-24 20:58:36'),
	(25,'socialaccount','0003_extra_data_default_dict','2016-06-24 20:58:36'),
	(26,'MoneyMonsterData','0005_auto_20160629_1817','2016-06-30 14:15:56'),
	(27,'MoneyMonsterData','0006_auto_20160630_1415','2016-06-30 14:15:56');

/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`)
VALUES
	('18zrh41xuhfzolzs4vlk3tsgyb1qw9dj','NjA2MmE4OTczNjQ1ZDM1NTU5MzAzMjhlY2YwN2I0Y2E0NjY5YzFiNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImQwN2U2NWM3NDVkNmI4NDk5ZDg1ZmVhNzczOTQ5YTI5ODcwODhlYmUiLCJhY2NvdW50X3VzZXIiOiI0IiwiX2F1dGhfdXNlcl9pZCI6IjQiLCJhY2NvdW50X3ZlcmlmaWVkX2VtYWlsIjpudWxsfQ==','2016-07-11 20:31:27'),
	('3k8pu9nnunvm285quuxbor1iezakhgtm','ZDViNjdlNjE2NzgyYWFmYzlmMzQ5ZjYwYWFhYmE2MGFjZWIyYjMwYzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU0ZDU3MGRhMTYxMTU2MmIyOTZiZTBlY2U3ZDQxNjNmMWY1ODk3ODgiLCJhY2NvdW50X3VzZXIiOiIzIiwiX2F1dGhfdXNlcl9pZCI6IjMiLCJhY2NvdW50X3ZlcmlmaWVkX2VtYWlsIjpudWxsfQ==','2016-07-08 22:16:58'),
	('463uwp4drv1wkvcbrohajpq57dsxbw8x','NWQwZWJhOTI2MzQwMDBiMDQ3OGY3YTgwOThjMDQyNzg1YWY4ZjdhYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImNhMDY2MDdjYjY3ZmMzNjIwNjNiZGQyYTFjZmM4M2Q4ZjVhZGExMDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-07-14 18:05:45'),
	('gixnhrz6wanxr1ckh00r00xu3b4mkvt9','MzVkZDVhMDJkOTYwOWJkYzdjZmI5ZGY2MmI5OGZjYzhlNzA1YzExOTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijk5ZWY1MDY1Nzk3YjU4ZWNiNDgxMGYxOWU4M2VjMWJlNmZjZjQ3ODIiLCJhY2NvdW50X3VzZXIiOiI2IiwiX2F1dGhfdXNlcl9pZCI6IjYiLCJhY2NvdW50X3ZlcmlmaWVkX2VtYWlsIjpudWxsfQ==','2016-07-14 15:23:35'),
	('ivs7xmuv5t49em3qkti8llh7sdltmlbs','YjQ2OTA0NTVmOGEyZGQxMGNlMzBlMTljM2Q2ZDdlNGYzMjY1Y2U0MDp7Il9hdXRoX3VzZXJfaGFzaCI6IjI0NzUyNmVhZjg1NmQzMGYxZmNmMTM0ZjAwN2Y3MDQxMjAwM2YyOGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNSJ9','2016-07-14 14:51:36');

/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_site
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_site`;

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;

INSERT INTO `django_site` (`id`, `domain`, `name`)
VALUES
	(1,'mm.fraboom.com','Money Monster');

/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_comment`;

CREATE TABLE `MoneyMonsterData_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `text` longtext NOT NULL,
  `date_added` datetime NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterD_content_type_id_f8abbae8_fk_django_content_type_id` (`content_type_id`),
  KEY `MoneyMonsterData_comment_user_id_6f3843a6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `MoneyMonsterD_content_type_id_f8abbae8_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `MoneyMonsterData_comment_user_id_6f3843a6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_comment` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_comment` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_comment` (`id`, `object_id`, `text`, `date_added`, `content_type_id`, `user_id`)
VALUES
	(2,1,'Wow, my budget needs some work','2016-06-24 22:17:52',14,3),
	(3,1,'loved the animation in this video','2016-06-30 14:54:30',14,5),
	(4,1,'Awesome! I\'m making a budget now.','2016-06-30 15:30:30',14,6),
	(5,1,'very helpful','2016-06-30 16:52:40',14,5),
	(6,3,'5 stars, definitely, without a doubt','2016-06-30 17:13:14',14,5),
	(7,2,'lkfjslkfjlksdjf wlekrj this is a long paragraph lkjf lksj flksjf lkj erlkj wlkj lskfj lwkejr lkjf sldkfj','2016-06-30 17:15:42',14,5);

/*!40000 ALTER TABLE `MoneyMonsterData_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_commentlike
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_commentlike`;

CREATE TABLE `MoneyMonsterData_commentlike` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `MoneyMonsterData_commentlike_user_id_ffe1c80d_uniq` (`user_id`,`comment_id`),
  KEY `MoneyMonsterD_comment_id_ed9b13e2_fk_MoneyMonsterData_comment_id` (`comment_id`),
  CONSTRAINT `MoneyMonsterD_comment_id_ed9b13e2_fk_MoneyMonsterData_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `MoneyMonsterData_comment` (`id`),
  CONSTRAINT `MoneyMonsterData_commentlike_user_id_e7e2acc3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_commentlike` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_commentlike` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_commentlike` (`id`, `comment_id`, `user_id`)
VALUES
	(1,2,5),
	(5,4,5),
	(4,5,5),
	(6,6,5);

/*!40000 ALTER TABLE `MoneyMonsterData_commentlike` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_quiz
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_quiz`;

CREATE TABLE `MoneyMonsterData_quiz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_quiz` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_quiz` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_quiz` (`id`, `title`)
VALUES
	(3,'Taxes and Inflation'),
	(4,'Where to Invest'),
	(5,'Cash is King'),
	(6,'Lender Options'),
	(7,'Establishing Credit'),
	(8,'Budgets'),
	(9,'Bank Accounts'),
	(10,'Pay Yourself First'),
	(11,'Credit Bureaus'),
	(12,'Establishing Good Credit'),
	(13,'Large Purchases'),
	(14,'Needs Vs. Wants'),
	(15,'Retirement');

/*!40000 ALTER TABLE `MoneyMonsterData_quiz` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_quizquestion
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_quizquestion`;

CREATE TABLE `MoneyMonsterData_quizquestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `statement` longtext NOT NULL,
  `statement_is_true` tinyint(1) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `statement_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_qu_quiz_id_2ecbfc75_fk_MoneyMonsterData_quiz_id` (`quiz_id`),
  CONSTRAINT `MoneyMonsterData_qu_quiz_id_2ecbfc75_fk_MoneyMonsterData_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `MoneyMonsterData_quiz` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_quizquestion` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_quizquestion` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_quizquestion` (`id`, `statement`, `statement_is_true`, `quiz_id`, `statement_message`)
VALUES
	(3,'Taxes can be avoided with proper planning.',0,3,'Taxes are unavoidable and must be planned for.'),
	(4,'Employers are required to take taxes from their employees? paychecks and give the money to charity',0,3,'The money must be given to the government.'),
	(5,'Inflation is the gradual rise in the price of everything we buy',1,3,''),
	(6,'Historically the average rate of inflation has been about 7% per year.',0,3,'3% is the average rate of inflation.'),
	(7,'Investing is a way to take money you have and use it to make even more money.',1,4,''),
	(8,'Investments with low risk and high liquidity usually pay a higher interest rate.',0,4,'Low risk and high liquidity usually pay LOWER interest rates.'),
	(9,'Before investing your money you should get advice from a professional you trust.',1,4,''),
	(10,'The least expensive way to pay for something is with a low interest and no fee credit card.',0,5,'Cash is the least expensive way.'),
	(11,'A smart strategy for buying something you can\'t afford today, is to wait to buy it while you save up enough money to pay cash.',1,5,''),
	(12,'When you pay with cash you avoid expenses such as interest, annual fees, and late payment fees.',1,5,''),
	(13,'People who only pay with cash end up with lots of debt and other money problems.',0,5,'Paying with cash avoids debt and other money problems.'),
	(14,'The minimum payment trap refers to a common mistake people make with credit cards when they make such small payments monthly that interest costs pile up because it takes so long to pay off the credit card balance.',1,6,''),
	(15,'Deciding what lending source to use is a simple, straightforward process.',0,6,''),
	(16,'A key to successfully borrowing money is to pay back the loan on time.',1,6,''),
	(17,'If you aren\'t sure how you will pay back a lender you would be smart not to borrow the money.',1,6,''),
	(18,'Credit is your reputation as a borrower and is used by potential lenders to decide whether or not to let you borrow money from them.',1,7,''),
	(19,'Late payments don\'t lower your credit score as long as you pay back the money in the end.',0,7,'Late payments do lower your credit score even if you eventually pay off the debt.'),
	(20,'Getting a student credit card and using it properly can help build good credit.',1,7,''),
	(21,'Establishing good credit today can help you get a job, help you rent housing, and help you get lower interest rates on auto and home loans in the future.',1,7,''),
	(22,'A budget provides a monthly comparison of the money you receive and the money you spend.',1,8,''),
	(23,'A budget is essential even if you are a student with no income.',0,8,'If you aren\'t receiving any income then there really isn\'t any need for a budget yet.'),
	(24,'A budget can tell you how much money you have left over each month after paying for life\'s essentials like housing, utilities, and food.',1,8,''),
	(25,'Checking accounts and savings accounts are the exact same thing.',0,9,'Money is taken out of your checking account when you pay for something with your checks and debit card. A savings account is where you keep money to earn interest. You must go into the bank to remove money from your savings account.'),
	(26,'If you spend more money than you have with your debit card you may be charged large penalty fees.',1,9,''),
	(27,'Taking money out of your checking account from an ATM is free.',0,9,'Most ATMs charge a fee when you take money out of your checking account.'),
	(28,'Debit cards are the same as a credit card.',0,9,'A debit card simply allows you to spend money from your checking account while a credit card LOANS you money at a cost called interest.'),
	(29,'Your credit LIMIT is the highest amount you may spend using a credit card.',1,9,''),
	(30,'The bank PAYS you money for keeping your money in their bank.',1,9,'Banks pay interest to you for keeping your money in their bank.'),
	(31,'You should always pay for what you need first every month.',0,10,'You should pay yourself first by putting a pre-determined amount of money into savings.'),
	(32,'You can use direct deposit may be a valuable tool in helping you save money.',1,10,'Direct deposit can help you take a portion of your paycheck and put it into savings.'),
	(33,'Ryan and Leslie?s bank password is muscleguy85.',1,10,'We don?t know what their password is and you should always keep your password secret as well.'),
	(34,'A credit bureau is a company that gathers information about your credit history and sells it to other companies that may want to loan you money.',1,11,''),
	(35,'Your credit score is the total number of loans you have taken out in your life.',0,11,'How many loans you have taken out is PART of your credit score but other factors are considered. Have you paid all of your debt on time, do you have late payments, how many credit cards do you have and what is your debt to income ratio are some of the factors considered in creating your credit score.'),
	(36,'The three U.S. Credit Bureaus mentioned in this video are Equifax, Transunion and Expedia.',0,11,'The three U.S. Credit Bureaus mentioned in this video are Equifax, Transunion and Expeperian.'),
	(37,'Rule number one in establishing good credit is to pay your bills on time.',1,12,''),
	(38,'The total amount of debt you have does NOT factor into establishing good credit.',0,12,'The total amount of debt you have does factor into establishing good credit and creating a strong credit score.'),
	(39,'The numbers of times you simply apply for a loan doesn?t affect your credit score.',0,12,'Every time you apply for a loan or run a credit report it lowers your credit score and may give the impression that you rely on credit too much. Run your credit report sparingly.'),
	(40,'A large purchase is something that you do not buy every month and will take either multiple payments or credit to secure.',1,13,''),
	(41,'You should just put any large purchase on a credit card.',0,13,'You can use a credit card for a large purchase but you will end up paying more for that item due to interest and you may lower your credit score.'),
	(42,'The best way to make a large purchase is to set aside a portion of the total dollar amount you need to make the purchase every month until you have enough cash saved to make the actual purchase.',1,13,''),
	(43,'You should only budget and plan for the items you NEED every month.',0,14,'You need to plan and budget for both your needs and wants.'),
	(44,'Needs are the things like power, food and shelter. Needs are things you have to pay for every month in order to survive.',1,14,''),
	(45,'Life insurance is a need.',0,14,'While life insurance is a responsible thing to have if you can afford it, it is not an item that you need to have to survive.'),
	(46,'There are ways to set up a retirement plan so that it will not be taxed reducing the amount of money you give to the government.',1,15,''),
	(47,'Money is automatically taken out of your paycheck for retirement if you are self employed.',0,15,'It is up to you to take money out of your paycheck and invest it for your retirement.'),
	(48,'401K, IRAs and ROTH IRAs are all options for investing money for retirement.',1,15,'');

/*!40000 ALTER TABLE `MoneyMonsterData_quizquestion` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_quizresult
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_quizresult`;

CREATE TABLE `MoneyMonsterData_quizresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `percent_correct` double NOT NULL,
  `date` datetime NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `MoneyMonsterData_quizresult_quiz_id_4d269adb_uniq` (`quiz_id`,`user_id`),
  KEY `MoneyMonsterData_quizresult_user_id_133b9c45_fk_auth_user_id` (`user_id`),
  CONSTRAINT `MoneyMonsterData_qu_quiz_id_5eb15bf4_fk_MoneyMonsterData_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `MoneyMonsterData_quiz` (`id`),
  CONSTRAINT `MoneyMonsterData_quizresult_user_id_133b9c45_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_quizresult` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_quizresult` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_quizresult` (`id`, `percent_correct`, `date`, `quiz_id`, `user_id`)
VALUES
	(1,0.333333333333333,'2016-06-30 14:53:51',8,5),
	(2,0,'2016-06-30 14:55:41',14,5),
	(3,0.833333333333333,'2016-06-30 15:12:01',9,5),
	(4,0.333333333333333,'2016-06-30 15:39:20',11,5);

/*!40000 ALTER TABLE `MoneyMonsterData_quizresult` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_todo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_todo`;

CREATE TABLE `MoneyMonsterData_todo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) NOT NULL,
  `text` longtext NOT NULL,
  `date_added` datetime NOT NULL,
  `date_completed` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `completed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_todo_user_id_7d5ec434_fk_auth_user_id` (`user_id`),
  CONSTRAINT `MoneyMonsterData_todo_user_id_7d5ec434_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_todo` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_todo` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_todo` (`id`, `icon`, `text`, `date_added`, `date_completed`, `user_id`, `completed`)
VALUES
	(5,'todo-icon-share','Share Money Monster 101!','2016-06-30 14:51:35',NULL,5,0),
	(6,'todo-icon-calculator','Create a budget.','2016-06-30 14:54:03','2016-06-30 15:00:11',5,1),
	(7,'todo-icon-pie-chart','Create a budget and identify needs vs. wants.','2016-06-30 14:56:11',NULL,5,0),
	(8,'todo-icon-share','Share Money Monster 101!','2016-06-30 15:23:34',NULL,6,0),
	(9,'todo-icon-calculator','Create a budget.','2016-06-30 16:51:56','2016-06-30 16:53:48',5,1),
	(10,'todo-icon-pie-chart','Create a budget and identify needs vs. wants.','2016-06-30 17:14:35',NULL,5,0),
	(11,'todo-icon-share','Share Money Monster 101!','2016-06-30 17:26:18',NULL,7,0);

/*!40000 ALTER TABLE `MoneyMonsterData_todo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_video
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_video`;

CREATE TABLE `MoneyMonsterData_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `thumbnail_filename` varchar(255) NOT NULL,
  `hls_url` varchar(255) NOT NULL,
  `rtmp_server_url` varchar(255) NOT NULL,
  `rtmp_stream_name` varchar(255) NOT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `todo_icon` varchar(255) NOT NULL,
  `todo_text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_video_baedd54c` (`quiz_id`),
  CONSTRAINT `MoneyMonsterData_vi_quiz_id_53823957_fk_MoneyMonsterData_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `MoneyMonsterData_quiz` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_video` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_video` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_video` (`id`, `title`, `description`, `thumbnail_filename`, `hls_url`, `rtmp_server_url`, `rtmp_stream_name`, `quiz_id`, `sort_order`, `todo_icon`, `todo_text`)
VALUES
	(1,'Budget','TODO','Budget','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_101_Budget_V3_FINAL.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_101_Budget_V3_FINAL_600k.mp4',8,10,'todo-icon-calculator','Create a budget.'),
	(2,'Needs vs. Wants','TODO','Wants_vs_Needs','http://eoge7bvk.rtmphost.com/hls-vod/videos/NEEDS_VS_WANTS.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:NEEDS_VS_WANTS_600k.mp4',14,20,'todo-icon-pie-chart','Create a budget and identify needs vs. wants.'),
	(3,'Bank Accounts','TODO','Bank_Accounts','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_BANK_ACCOUNTS_TC_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_BANK_ACCOUNTS_TC_V1_600k.mp4',9,30,'todo-icon-bank-building','Open a checking and savings account at a local bank.'),
	(4,'Wrap Up','TODO','Wrap_Up','http://eoge7bvk.rtmphost.com/hls-vod/videos/WRAP_UP.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:WRAP_UP_600k.mp4',NULL,40,'todo-icon-half-star','Review and comment on at least one Money Monster 101 video.'),
	(5,'Credit Bureaus','TODO','Credit_Bueareu','http://eoge7bvk.rtmphost.com/hls-vod/videos/CREDIT_BUREAUS.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:CREDIT_BUREAUS_600k.mp4',11,50,'todo-icon-computer-screen','Find and explore two credit bureau web sites.'),
	(6,'Good Credit','TODO','Good_Credit_1','http://eoge7bvk.rtmphost.com/hls-vod/videos/EST_GOOD_CREDIT .m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:EST_GOOD_CREDIT _600k.mp4',12,60,'todo-icon-credit-card','Open a credit card, buy something and pay it off.'),
	(7,'Establishing Credit','TODO','Establishing_Credit','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_07_Establishing_Credit_FINAL_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_07_Establishing_Credit_FINAL_V1_600k.mp4',7,70,'todo-icon-credit-card','Open a credit card, buy something with it and pay the balance off.'),
	(8,'Large Purchases','TODO','Large_Purchases','http://eoge7bvk.rtmphost.com/hls-vod/videos/LARGE_PURCHASES.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:LARGE_PURCHASES_600k.mp4',13,80,'todo-icon-gift','Create a plan and budget to purchase a large item.'),
	(9,'Cash is King','TODO','Cash_Is_King','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM05_Cash_is_King_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM05_Cash_is_King_V1_600k.mp4',5,90,'todo-icon-dollar-sign','Create a budget that allows you to pay for a large item using cash.'),
	(10,'Pay Yourself First','TODO','Pay_Yourself_First','http://eoge7bvk.rtmphost.com/hls-vod/videos/PAY_YOURSELF_FIRST.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:PAY_YOURSELF_FIRST_600k.mp4',10,100,'todo-icon-circular-arrows','Direct deposit a budgeted amount into your savings account from your paycheck.'),
	(11,'Lenders','TODO','Lenders','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_LENDER_OPTIONS_TC_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_LENDER_OPTIONS_TC_V1_2_600k.mp4',6,110,'todo-icon-note-clipboard','Pre-apply for a loan at your bank.'),
	(12,'Investments','TODO','Investments','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_07_Establishing_Credit_FINAL_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_07_Establishing_Credit_FINAL_V1_600k.mp4',4,120,'todo-icon-binoculars','Explore investment opportunities that may work for your current financial situation.'),
	(13,'Retirement','TODO','Retirement_1','http://eoge7bvk.rtmphost.com/hls-vod/videos/RETIREMENT.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:RETIREMENT_600k.mp4',15,130,'todo-icon-calendar','Set up a retirement plan that works for your current financial situation.'),
	(14,'Taxes and Inflation','TODO','Taxes_and_Inflation','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_TAXES_AND_INFLATION_FINAL_SFX.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_TAXES_AND_INFLATION_FINAL_SFX_600k.mp4',3,140,'todo-icon-search','Review your tax returns and see if you can do something different this year to save money.'),
	(15,'Closer','TODO','Wrap_Up','http://eoge7bvk.rtmphost.com/hls-vod/videos/CLOSER.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:CLOSER_600k.mp4',NULL,150,'todo-icon-half-star','Review and comment on at least one Money Monster 101 video.');

/*!40000 ALTER TABLE `MoneyMonsterData_video` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_videostatus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_videostatus`;

CREATE TABLE `MoneyMonsterData_videostatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` int(11) DEFAULT NULL,
  `completed` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `MoneyMonsterData_videostatus_video_id_1b3e83de_uniq` (`video_id`,`user_id`),
  KEY `MoneyMonsterData_videostatus_user_id_9d41b3cc_fk_auth_user_id` (`user_id`),
  CONSTRAINT `MoneyMonsterData__video_id_a12dd4c9_fk_MoneyMonsterData_video_id` FOREIGN KEY (`video_id`) REFERENCES `MoneyMonsterData_video` (`id`),
  CONSTRAINT `MoneyMonsterData_videostatus_user_id_9d41b3cc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_videostatus` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_videostatus` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_videostatus` (`id`, `rating`, `completed`, `user_id`, `video_id`)
VALUES
	(2,NULL,1,4,1),
	(3,NULL,1,4,5),
	(4,5,1,5,1),
	(5,1,1,5,2),
	(6,NULL,1,6,1),
	(7,5,1,5,3);

/*!40000 ALTER TABLE `MoneyMonsterData_videostatus` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table socialaccount_socialaccount
# ------------------------------------------------------------

DROP TABLE IF EXISTS `socialaccount_socialaccount`;

CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;

INSERT INTO `socialaccount_socialaccount` (`id`, `provider`, `uid`, `last_login`, `date_joined`, `extra_data`, `user_id`)
VALUES
	(1,'facebook','683528788451692','2016-06-24 22:16:57','2016-06-24 22:16:57','{\"first_name\": \"Jimmy\", \"last_name\": \"Bear\", \"verified\": true, \"name\": \"Jimmy Bear\", \"locale\": \"en_US\", \"gender\": \"male\", \"email\": \"dummybearish@gmail.com\", \"link\": \"https://www.facebook.com/app_scoped_user_id/683528788451692/\", \"timezone\": -7, \"updated_time\": \"2013-07-02T21:50:08+0000\", \"id\": \"683528788451692\"}',3);

/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table socialaccount_socialapp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `socialaccount_socialapp`;

CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;

INSERT INTO `socialaccount_socialapp` (`id`, `provider`, `name`, `client_id`, `secret`, `key`)
VALUES
	(1,'facebook','Money Monster','275594266122837','765cb0abfc1175eaf491532ae1a53321','');

/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table socialaccount_socialapp_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;

CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccoun_socialapp_id_97fb6e7d_fk_socialaccount_socialapp_id` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;

INSERT INTO `socialaccount_socialapp_sites` (`id`, `socialapp_id`, `site_id`)
VALUES
	(1,1,1);

/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table socialaccount_socialtoken
# ------------------------------------------------------------

DROP TABLE IF EXISTS `socialaccount_socialtoken`;

CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialacco_account_id_951f210e_fk_socialaccount_socialaccount_id` (`account_id`),
  CONSTRAINT `socialacco_account_id_951f210e_fk_socialaccount_socialaccount_id` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_soci_app_id_636a42d7_fk_socialaccount_socialapp_id` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;

INSERT INTO `socialaccount_socialtoken` (`id`, `token`, `token_secret`, `expires_at`, `account_id`, `app_id`)
VALUES
	(1,'EAAD6pspVmlUBALPP5OeykDLFBOTYz3ip9m4Lxo65S3trywXCLtWBFrNPQDZCGBFzQb9yr8rsc4YJUXeriHu7ReldZCg0qqXfcrtHsBdJ7EHeK9WWQ8wTEuCaSZAP2rt1UXtIngiYq0GqNDcKPqKuXCJ8H6hlgQpxLL2mZCnbeNzqLZC92mFn8TxcSDynCjTQZD','',NULL,1,1);

/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
