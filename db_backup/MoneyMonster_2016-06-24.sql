# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: d1b2884d0e5debfaa34c758e2355b84c5f1874c3.rackspaceclouddb.com (MySQL 5.6.27)
# Database: MoneyMonster
# Generation Time: 2016-06-24 20:42:38 +0000
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
	(11,'lowell.list@gmail.com',1,1,14),
	(12,'dummybearish@gmail.com',0,1,15),
	(14,'ryangrover113@gmail.com',0,1,17),
	(15,'ryan@gml.com',0,1,18),
	(16,'rnelson@flyingrhino.com',0,1,19),
	(17,'tom@moneymonster101.org',1,1,20);

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
	(11,'2016-06-02 19:12:41','2016-06-02 19:12:42','0bac0pfudw1wnx8wur8nrcxzko8cujc98z54ji1mybrargrttqkpf7gcnthdnspr',11),
	(12,'2016-06-02 19:23:38','2016-06-02 19:23:40','61rxwvqjpwdhqo0kq4rrvdr1mhww7mqo2o7fuueowmiztgj8dwxfxam1f8sulsxb',12),
	(14,'2016-06-02 23:46:11','2016-06-02 23:46:12','dqyy6jlskkhqyoiw6opfw0s5p2tqcmhi6comacghknkaw5qumy5ewgvslzdazykm',14),
	(15,'2016-06-03 19:04:23','2016-06-03 19:04:24','yfvovbdvxs7qfhonlw2fesgflchhnmyujgu9so7ln1l9vempbncrrqdrvvuuhdb4',15),
	(16,'2016-06-03 21:09:51','2016-06-03 21:09:52','udvj2pg0fmhccfgz6cgsjrldgcmlus8qc5psdsjfb0mz4zayxmeug9d4eccqoeig',16),
	(17,'2016-06-08 20:33:45','2016-06-08 20:33:46','cufnq2xoppw3c3g6edws6rpk0lp37blhriatbkcxln3egaquxnrnbqt4g3mbffyh',17);

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
	(19,'Can add video',7,'add_video'),
	(20,'Can change video',7,'change_video'),
	(21,'Can delete video',7,'delete_video'),
	(22,'Can add video status',8,'add_videostatus'),
	(23,'Can change video status',8,'change_videostatus'),
	(24,'Can delete video status',8,'delete_videostatus'),
	(25,'Can add comments',9,'add_comments'),
	(26,'Can change comments',9,'change_comments'),
	(27,'Can delete comments',9,'delete_comments'),
	(28,'Can add comment info',10,'add_commentinfo'),
	(29,'Can change comment info',10,'change_commentinfo'),
	(30,'Can delete comment info',10,'delete_commentinfo'),
	(31,'Can add comment likes',11,'add_commentlikes'),
	(32,'Can change comment likes',11,'change_commentlikes'),
	(33,'Can delete comment likes',11,'delete_commentlikes'),
	(34,'Can add to dos',12,'add_todos'),
	(35,'Can change to dos',12,'change_todos'),
	(36,'Can delete to dos',12,'delete_todos'),
	(37,'Can add quizzes',13,'add_quizzes'),
	(38,'Can change quizzes',13,'change_quizzes'),
	(39,'Can delete quizzes',13,'delete_quizzes'),
	(40,'Can add quiz questions',14,'add_quizquestions'),
	(41,'Can change quiz questions',14,'change_quizquestions'),
	(42,'Can delete quiz questions',14,'delete_quizquestions'),
	(46,'Can add quiz results',16,'add_quizresults'),
	(47,'Can change quiz results',16,'change_quizresults'),
	(48,'Can delete quiz results',16,'delete_quizresults'),
	(49,'Can add profile',17,'add_profile'),
	(50,'Can change profile',17,'change_profile'),
	(51,'Can delete profile',17,'delete_profile'),
	(52,'Can add site',18,'add_site'),
	(53,'Can change site',18,'change_site'),
	(54,'Can delete site',18,'delete_site'),
	(55,'Can add Token',19,'add_token'),
	(56,'Can change Token',19,'change_token'),
	(57,'Can delete Token',19,'delete_token'),
	(58,'Can add email address',20,'add_emailaddress'),
	(59,'Can change email address',20,'change_emailaddress'),
	(60,'Can delete email address',20,'delete_emailaddress'),
	(61,'Can add email confirmation',21,'add_emailconfirmation'),
	(62,'Can change email confirmation',21,'change_emailconfirmation'),
	(63,'Can delete email confirmation',21,'delete_emailconfirmation'),
	(64,'Can add social application',22,'add_socialapp'),
	(65,'Can change social application',22,'change_socialapp'),
	(66,'Can delete social application',22,'delete_socialapp'),
	(67,'Can add social account',23,'add_socialaccount'),
	(68,'Can change social account',23,'change_socialaccount'),
	(69,'Can delete social account',23,'delete_socialaccount'),
	(70,'Can add social application token',24,'add_socialtoken'),
	(71,'Can change social application token',24,'change_socialtoken'),
	(72,'Can delete social application token',24,'delete_socialtoken');

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
	(1,'pbkdf2_sha256$24000$qAvBOBUKjqPu$1/MG/e9Apf1jYbVvZDDZ94Qmbx6rPVPZy7ty3SQy18k=','2016-05-18 18:12:05',1,'admin','','','',1,1,'2016-05-16 19:21:54'),
	(2,'pbkdf2_sha256$24000$V0qdjdn4fWLl$iVuioR7N5pae6DmlBZLkhcvA+UaC6eakfC04nju1pCQ=',NULL,0,'ryan','','','',0,1,'2016-05-16 19:27:42'),
	(3,'pbkdf2_sha256$24000$QFo64JHX5Pbk$CpXKPxilGK7we15q/dQ1rZGWtLFtRl28/mPSSLermfg=','2016-06-22 22:27:57',1,'root','','','',1,1,'2016-05-31 18:13:45'),
	(14,'pbkdf2_sha256$24000$MUC3IlRrMbF2$bYu3tcILphjv0TGclwwZ2FL3WISyRsrUNHTVl5gxmfE=','2016-06-02 19:12:42',0,'lowell','','','lowell.list@gmail.com',0,1,'2016-06-02 19:12:41'),
	(15,'!MnfbI23ZfkJuoELGzwcJp4wYpAnEbGCDZaJFIZyU','2016-06-03 05:48:50',0,'jimmy','Jimmy','Bear','dummybearish@gmail.com',0,1,'2016-06-02 19:23:38'),
	(17,'pbkdf2_sha256$24000$BSlY9LUc5Tbj$O5Qt7pD8jpVmeMEpg1znEryZyaEypPF5YG22NU2AXiQ=','2016-06-02 23:46:12',0,'kingmoney','','','ryangrover113@gmail.com',0,1,'2016-06-02 23:46:11'),
	(18,'pbkdf2_sha256$24000$tBxZsK7xzNVY$HYfJd+fAz+K2unNOTvV3yNVQ5SIds+PrB/7gPVwmS+I=','2016-06-03 19:04:24',0,'ryan113','','','ryan@gml.com',0,1,'2016-06-03 19:04:23'),
	(19,'pbkdf2_sha256$24000$0Dr2Z2YwoBBp$J4dQc8aQ9pvncmGiotc8a8BBnScZzg0unSisNR56zC8=','2016-06-03 21:09:52',0,'rhinoray','','','rnelson@flyingrhino.com',0,1,'2016-06-03 21:09:51'),
	(20,'pbkdf2_sha256$24000$3WM30FHDKPk2$dDyhWqAv15HeR0c4j2E5VCjy3PZy1EYg5TL1dHmdAkY=','2016-06-08 20:33:46',0,'itslit','','','tom@moneymonster101.org',0,1,'2016-06-08 20:33:45');

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
	('2784398e3269afa373d43f87889c7d641ab4ec2a','2016-06-08 20:33:45',20),
	('3c70b7afd6b097dc8f31c115fcdd653372e14b23','2016-06-02 19:23:40',15),
	('a50e7fcf421c477dddd116d937a7305ac4d1ea30','2016-06-03 19:04:23',18),
	('bb13f27905cabac96cee8209d3a7f39b61745c97','2016-06-02 23:46:11',17),
	('c61ad6e024c306fae7a72ec07a552f63d070ec23','2016-06-03 21:09:51',19),
	('eee6c5b1f645a814d20663843fe212239f1facab','2016-06-02 19:12:41',14);

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
	(1,'2016-05-16 19:27:42','2','ryan',1,'Added.',4,1),
	(2,'2016-05-17 20:38:34','1','Mcfinn Inside Outside Music Video video',2,'Changed thumbnail_filename.',7,1),
	(3,'2016-05-17 20:39:10','10','giraffe video',3,'',7,1),
	(4,'2016-05-17 20:39:10','9','wolf video',3,'',7,1),
	(5,'2016-05-17 20:39:10','8','rhinos video',3,'',7,1),
	(6,'2016-05-17 20:39:10','7','trees video',3,'',7,1),
	(7,'2016-05-17 20:39:10','6','mouses video',3,'',7,1),
	(8,'2016-05-17 20:39:10','5','cats video',3,'',7,1),
	(9,'2016-05-17 20:39:10','4','dogs video',3,'',7,1),
	(10,'2016-05-17 20:40:17','11','Bank Accounts video',1,'Added.',7,1),
	(11,'2016-05-17 20:40:41','12','Budget video',1,'Added.',7,1),
	(12,'2016-05-17 20:41:06','13','Cash Is King video',1,'Added.',7,1),
	(13,'2016-05-17 20:47:45','1','Inside Outside video',2,'Changed title.',7,1),
	(14,'2016-05-18 18:13:38','1','Inside Outside video',2,'Changed rtmp_server_url and rtmp_stream_name.',7,1),
	(15,'2016-05-19 18:24:16','3','How to spend mom and dads money wisely video',3,'',7,1),
	(16,'2016-05-19 18:24:16','2','Do dogs make money? video',3,'',7,1),
	(17,'2016-05-19 18:27:05','14','Closer video',1,'Added.',7,1),
	(18,'2016-05-19 18:27:18','14','Closer video',2,'Changed thumbnail_filename.',7,1),
	(19,'2016-05-19 18:29:09','1','Inside Outside video',3,'',7,1),
	(20,'2016-05-19 18:41:40','15','Credit Bureaus video',1,'Added.',7,1),
	(21,'2016-05-19 18:42:55','16','Establishing Good Credit video',1,'Added.',7,1),
	(22,'2016-05-19 18:43:52','17','Introduction video',1,'Added.',7,1),
	(23,'2016-05-19 18:44:35','18','Large Purchases video',1,'Added.',7,1),
	(24,'2016-05-19 18:45:25','19','Needs vs. Wants video',1,'Added.',7,1),
	(25,'2016-05-19 18:46:06','20','Pay Yourself First video',1,'Added.',7,1),
	(26,'2016-05-19 18:46:54','21','Retirement video',1,'Added.',7,1),
	(27,'2016-05-19 18:47:30','22','Wrap Up video',1,'Added.',7,1),
	(28,'2016-05-19 18:52:18','16','Establishing Good Credit video',3,'',7,1),
	(29,'2016-05-19 18:52:18','13','Cash Is King video',3,'',7,1),
	(30,'2016-05-19 18:52:18','12','Budget video',3,'',7,1),
	(31,'2016-05-19 18:52:18','11','Bank Accounts video',3,'',7,1),
	(32,'2016-05-31 18:14:52','1','mm.fraboom.com',2,'Changed domain and name.',18,3),
	(33,'2016-05-31 23:33:46','6','groover',3,'',4,3),
	(34,'2016-05-31 23:33:46','4','lowell',3,'',4,3),
	(35,'2016-05-31 23:33:46','5','lowell2',3,'',4,3),
	(36,'2016-06-01 16:53:31','7','lowell',3,'',4,3),
	(37,'2016-06-01 17:31:17','8','lowell',3,'',4,3),
	(38,'2016-06-01 17:33:00','9','lowell',3,'',4,3),
	(39,'2016-06-01 21:05:21','3','Video:Closer - Quiz: How to make money quiz',1,'Added. Added quiz questions \"Question: How to make money quiz: what is money?\". Added quiz questions \"Question: How to make money quiz: do dogs spend money?\".',13,3),
	(40,'2016-06-01 21:06:59','3','Video:Closer - Quiz: How to make money quiz',2,'No fields changed.',13,3),
	(41,'2016-06-01 21:22:25','14','Closer 2 video',2,'Changed title.',7,3),
	(42,'2016-06-01 21:22:41','14','Closer video',2,'Changed title.',7,3),
	(43,'2016-06-01 21:23:59','4','Video:Credit Bureaus - Quiz: Credit Quiz',1,'Added. Added quiz questions \"Question: Credit Quiz: What is credit?\". Added quiz questions \"Question: Credit Quiz: What isnt credit?\". Added quiz questions \"Question: Credit Quiz: asdf\".',13,3),
	(44,'2016-06-01 22:04:58','23','Test Video video',1,'Added. Added video status \"VideoStatus object\".',7,3),
	(45,'2016-06-01 22:05:40','5','Video:Test Video - Quiz: Test Quiz',1,'Added. Added quiz questions \"Question: Test Quiz: This is a test question\". Added quiz questions \"Question: Test Quiz: test question 2\".',13,3),
	(46,'2016-06-01 22:36:11','6','Video:Retirement - Quiz: retirement quiz',1,'Added. Added quiz questions \"Question: retirement quiz: questions 1\". Added quiz questions \"Question: retirement quiz: questions 2\".',13,3),
	(47,'2016-06-02 16:03:01','1','Money Monster',1,'Added.',22,3),
	(48,'2016-06-02 18:19:54','11','jimmy',3,'',4,3),
	(49,'2016-06-02 18:19:54','10','lowell',3,'',4,3),
	(50,'2016-06-02 19:11:51','13','jimmy',3,'',4,3),
	(51,'2016-06-02 19:11:51','12','lowell',3,'',4,3),
	(52,'2016-06-02 19:29:04','16','lowbelly',3,'',4,3),
	(53,'2016-06-03 22:14:27','17','Introduction video',3,'',7,3),
	(54,'2016-06-14 23:38:36','18','ryan113',2,'Changed password.',4,3),
	(55,'2016-06-22 22:28:42','23','Test Video video',3,'',7,3),
	(56,'2016-06-22 22:33:07','24','Bank Accounts video',1,'Added.',7,3),
	(57,'2016-06-22 22:36:06','24','Bank Accounts video',2,'Changed thumbnail_filename.',7,3),
	(58,'2016-06-22 22:38:26','25','Budget video',1,'Added.',7,3),
	(59,'2016-06-22 22:44:30','26','Cash is King video',1,'Added.',7,3),
	(60,'2016-06-22 22:47:20','27','Establishing Good Credit video',1,'Added.',7,3),
	(61,'2016-06-22 22:49:37','28','Investments video',1,'Added.',7,3),
	(62,'2016-06-22 23:02:24','29','Lenders video',1,'Added.',7,3),
	(63,'2016-06-22 23:04:07','30','Taxes and Inflation video',1,'Added.',7,3),
	(64,'2016-06-22 23:05:05','30','Taxes and Inflation video',2,'Changed hls_url and rtmp_stream_name.',7,3),
	(65,'2016-06-22 23:09:50','31','Credit 2 video',1,'Added.',7,3),
	(66,'2016-06-22 23:10:56','27','Establishing Good Credit video',2,'Changed thumbnail_filename.',7,3);

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
	(20,'account','emailaddress'),
	(21,'account','emailconfirmation'),
	(1,'admin','logentry'),
	(3,'auth','group'),
	(2,'auth','permission'),
	(4,'auth','user'),
	(19,'authtoken','token'),
	(5,'contenttypes','contenttype'),
	(10,'MoneyMonsterData','commentinfo'),
	(11,'MoneyMonsterData','commentlikes'),
	(9,'MoneyMonsterData','comments'),
	(17,'MoneyMonsterData','profile'),
	(14,'MoneyMonsterData','quizquestions'),
	(16,'MoneyMonsterData','quizresults'),
	(13,'MoneyMonsterData','quizzes'),
	(12,'MoneyMonsterData','todos'),
	(7,'MoneyMonsterData','video'),
	(8,'MoneyMonsterData','videostatus'),
	(6,'sessions','session'),
	(18,'sites','site'),
	(23,'socialaccount','socialaccount'),
	(22,'socialaccount','socialapp'),
	(24,'socialaccount','socialtoken');

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
	(1,'contenttypes','0001_initial','2016-05-16 19:00:06'),
	(2,'auth','0001_initial','2016-05-16 19:00:07'),
	(3,'MoneyMonsterData','0001_initial','2016-05-16 19:00:08'),
	(4,'MoneyMonsterData','0002_auto_20160405_1929','2016-05-16 19:00:08'),
	(5,'MoneyMonsterData','0003_video_thumbnail','2016-05-16 19:00:08'),
	(6,'MoneyMonsterData','0004_auto_20160411_2122','2016-05-16 19:00:08'),
	(7,'MoneyMonsterData','0005_auto_20160425_1848','2016-05-16 19:00:09'),
	(8,'MoneyMonsterData','0006_haps','2016-05-16 19:00:09'),
	(9,'MoneyMonsterData','0007_auto_20160425_2147','2016-05-16 19:00:09'),
	(10,'MoneyMonsterData','0008_auto_20160502_2323','2016-05-16 19:00:09'),
	(11,'MoneyMonsterData','0009_auto_20160516_1730','2016-05-16 19:00:09'),
	(12,'MoneyMonsterData','0010_auto_20160516_1746','2016-05-16 19:00:09'),
	(13,'admin','0001_initial','2016-05-16 19:00:09'),
	(14,'admin','0002_logentry_remove_auto_add','2016-05-16 19:00:09'),
	(15,'contenttypes','0002_remove_content_type_name','2016-05-16 19:00:09'),
	(16,'auth','0002_alter_permission_name_max_length','2016-05-16 19:00:09'),
	(17,'auth','0003_alter_user_email_max_length','2016-05-16 19:00:09'),
	(18,'auth','0004_alter_user_username_opts','2016-05-16 19:00:09'),
	(19,'auth','0005_alter_user_last_login_null','2016-05-16 19:00:10'),
	(20,'auth','0006_require_contenttypes_0002','2016-05-16 19:00:10'),
	(21,'auth','0007_alter_validators_add_error_messages','2016-05-16 19:00:10'),
	(22,'sessions','0001_initial','2016-05-16 19:00:10'),
	(23,'account','0001_initial','2016-05-31 17:56:14'),
	(24,'account','0002_email_max_length','2016-05-31 17:56:14'),
	(25,'authtoken','0001_initial','2016-05-31 17:56:14'),
	(26,'authtoken','0002_auto_20160226_1747','2016-05-31 17:56:14'),
	(27,'sites','0001_initial','2016-05-31 17:56:14'),
	(28,'sites','0002_alter_domain_unique','2016-05-31 17:56:14'),
	(29,'socialaccount','0001_initial','2016-05-31 17:56:15'),
	(30,'socialaccount','0002_token_max_lengths','2016-05-31 17:56:15'),
	(31,'socialaccount','0003_extra_data_default_dict','2016-05-31 17:56:15'),
	(32,'MoneyMonsterData','0011_auto_20160601_2354','2016-06-02 23:07:56');

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
	('02pka3sylo4r50eo3op9jp0x1cg6ojry','ZTY3OGJlMzA2ZmFiNmQ2MzdjZWIwYzkzNzdlZDVjMmVjMTkxNWYyMzp7Il9hdXRoX3VzZXJfaGFzaCI6ImE2N2ViMzE1NGFhMTY4YWJlZjUwNTVmYTVmNmIyOWY0ZTRjMzFhY2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMTQifQ==','2016-06-16 19:12:42'),
	('2c834y2ydk2l69sqn2ubh0un06bvfe2z','MzAwNjc5ODgwOTdlMzYxY2M4Njc1NmRmNmE1N2I5ZDdiM2YzMDdjYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImZiOTU4MGEwYThmZDcyNjhlNjNlZjU4ZjZlNTJkNWY5MTBkZWNlY2EiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMTgifQ==','2016-06-17 19:04:24'),
	('34v7qrsc63yvsp1l9q79jmbooe6n9zu8','OWQ3OTljNzE5N2Y1YzYyMWU4MWY5YzIyZDAxZDEyNmE2OWQxZDkyMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjAwZGZiNTNiYTFhOTlhZGQ1ZWRlN2FmYjJlYWM1MTJmMDUzZDQ3ZjEiLCJfYXV0aF91c2VyX2lkIjoiMTEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQifQ==','2016-06-16 16:56:11'),
	('76gsouc9s931zfi122vq1xnkmk4nce1u','OWQ3OTljNzE5N2Y1YzYyMWU4MWY5YzIyZDAxZDEyNmE2OWQxZDkyMjp7Il9hdXRoX3VzZXJfaGFzaCI6IjAwZGZiNTNiYTFhOTlhZGQ1ZWRlN2FmYjJlYWM1MTJmMDUzZDQ3ZjEiLCJfYXV0aF91c2VyX2lkIjoiMTEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQifQ==','2016-06-16 17:49:25'),
	('d7mqthd9r99ipzm19wqnq8ii60fdupi4','ZDY1YzJmNmY4MTM2MjU2ZWM5YjNkZWUzODNlZjZjZGZjYzNiNTQzMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjY3ZDFiOGY4NjUxZDkxY2UyN2I4NTY5ODBlOTM0MzIyNWIzMTI4MWIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-15 21:02:33'),
	('dghoacq8nop99h05scq8d1pf2mkyg0zx','NzNiNzc1ZTYyMTU4NGNiMjg0YTJiNjA1MmMzNWE0Njg3ZDVkOTVmODp7Il9hdXRoX3VzZXJfaGFzaCI6IjAwZGZiNTNiYTFhOTlhZGQ1ZWRlN2FmYjJlYWM1MTJmMDUzZDQ3ZjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMTEifQ==','2016-06-16 17:03:30'),
	('g980zellyfu6pln2q98ev6pwzpzk9ci4','YTM3OWM3MGY1NWNiN2RkOTMyYTkxZWZiOGQ3MDliYjI4N2M3ODlhZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjZiMzUwYzAxODQxOWI4YzdhMGZhMTJiN2UzMTdiZTE3OTkxYmEzYjUiLCJhY2NvdW50X3VzZXIiOiJrIiwiX2F1dGhfdXNlcl9pZCI6IjIwIiwiYWNjb3VudF92ZXJpZmllZF9lbWFpbCI6bnVsbH0=','2016-06-22 20:33:46'),
	('lka1yxj2u0s9z03kt46milptnobgoovl','NGI2MjhlM2E1NjBiYjY1ZDI0OGY3MTA5MGRmYjkwYzdhNDEzNTkyNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImE5NTYwZGQzMDYxODM4Mjk0MjBkZGIyY2E1ZTg4NjAwMjQ3MzE3M2MiLCJfYXV0aF91c2VyX2lkIjoiMTUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQifQ==','2016-06-17 05:48:50'),
	('mbsepw5k6r1j7px5i3hmhwzke2k6ywnl','ZmJkNDAxNjQxODc4OTQ5YmI0MmY2MjI1NTc0ODJlODIyMjVjZWI3Yjp7Il9hdXRoX3VzZXJfaGFzaCI6ImE5NTYwZGQzMDYxODM4Mjk0MjBkZGIyY2E1ZTg4NjAwMjQ3MzE3M2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMTUifQ==','2016-06-16 21:05:55'),
	('oku73mjczi07rexojgm6q622khh8uus7','NmZjMWQyZjhlZmJhZWE2ZTI3NGRlZDMzM2VjYjdjYzJiOGZkY2VlMzp7Il9hdXRoX3VzZXJfaGFzaCI6IjBkYjk1NjdjOWNlMDI0M2RjMmY0MThkMjdjNGY0NTRmN2Q3ZWQwYzYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhbGxhdXRoLmFjY291bnQuYXV0aF9iYWNrZW5kcy5BdXRoZW50aWNhdGlvbkJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMTAifQ==','2016-06-15 17:33:22'),
	('pjwzeuljyazelkxe342t65a16arhhevp','ZDY1YzJmNmY4MTM2MjU2ZWM5YjNkZWUzODNlZjZjZGZjYzNiNTQzMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjY3ZDFiOGY4NjUxZDkxY2UyN2I4NTY5ODBlOTM0MzIyNWIzMTI4MWIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-07-06 22:27:57'),
	('rklh168ecmmvhomnekhdf5ysklqvxr0c','MTdhYTY4NGQzMDNkMjQ0YjBiYWI2N2QwYzkzNjY3MWFjZTkzYzY1Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjBiN2RmYzYwZmEwODA2MWUxMzQ5MWYyOTc1ZWQzYWY1ZDcxMTdmNjUiLCJhY2NvdW50X3VzZXIiOiJqIiwiX2F1dGhfdXNlcl9pZCI6IjE5IiwiYWNjb3VudF92ZXJpZmllZF9lbWFpbCI6bnVsbH0=','2016-06-17 21:09:52'),
	('rksr0b8ttq5ecagu25phdwb7mp8kogdz','MWNlODA4NmEwNzMyNjEzYjUwYWZmNzEzMzc4ZTIxNWRlOTgzN2I3Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjAwZGZiNTNiYTFhOTlhZGQ1ZWRlN2FmYjJlYWM1MTJmMDUzZDQ3ZjEiLCJhY2NvdW50X3VzZXIiOiJiIiwiX2F1dGhfdXNlcl9pZCI6IjExIiwiYWNjb3VudF92ZXJpZmllZF9lbWFpbCI6bnVsbH0=','2016-06-16 16:35:15'),
	('ukyr5dqdeyf660mm6c03dhtf5zyepo82','ZDY1YzJmNmY4MTM2MjU2ZWM5YjNkZWUzODNlZjZjZGZjYzNiNTQzMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjY3ZDFiOGY4NjUxZDkxY2UyN2I4NTY5ODBlOTM0MzIyNWIzMTI4MWIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-14 23:24:22'),
	('weo7c1xdfxlz27z6dtkvrmagcjj2hek2','MmVlNjFkZjczZGE2NzhkMTE5ZmY5YmZjOGQwZTk2MjJiMDNlOGE3Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImYyMDAwZjJjNzg0MTExZWFkY2I2ZTYxZTZkMjAyY2E4ZmNkOWE1MDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-01 18:12:05'),
	('x48gfbhcydiol7hftrcshxew9dv31vfv','MmVlNjFkZjczZGE2NzhkMTE5ZmY5YmZjOGQwZTk2MjJiMDNlOGE3Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImYyMDAwZjJjNzg0MTExZWFkY2I2ZTYxZTZkMjAyY2E4ZmNkOWE1MDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-05-30 19:26:41');

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


# Dump of table MoneyMonsterData_commentinfo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_commentinfo`;

CREATE TABLE `MoneyMonsterData_commentinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` longtext NOT NULL,
  `date_added` datetime NOT NULL,
  `comment_id_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_commentinfo_9630bb79` (`comment_id_id`),
  KEY `MoneyMonsterData_commentinfo_5e7b1936` (`owner_id`),
  CONSTRAINT `MoneyMons_comment_id_id_ee6dad7b_fk_MoneyMonsterData_comments_id` FOREIGN KEY (`comment_id_id`) REFERENCES `MoneyMonsterData_comments` (`id`),
  CONSTRAINT `MoneyMonsterData_commentinfo_owner_id_5e381799_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MoneyMonsterData_commentlikes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_commentlikes`;

CREATE TABLE `MoneyMonsterData_commentlikes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `liked` tinyint(1) NOT NULL,
  `comment_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_commentlikes_9630bb79` (`comment_id_id`),
  KEY `MoneyMonsterData_commentlikes_18624dd3` (`user_id_id`),
  CONSTRAINT `MoneyMons_comment_id_id_55a6691b_fk_MoneyMonsterData_comments_id` FOREIGN KEY (`comment_id_id`) REFERENCES `MoneyMonsterData_comments` (`id`),
  CONSTRAINT `MoneyMonsterData_commentlike_user_id_id_9004f57a_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MoneyMonsterData_comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_comments`;

CREATE TABLE `MoneyMonsterData_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_comments_ba7d1c56` (`parent_id_id`),
  CONSTRAINT `MoneyMonsterD_parent_id_id_78f59642_fk_MoneyMonsterData_video_id` FOREIGN KEY (`parent_id_id`) REFERENCES `MoneyMonsterData_video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MoneyMonsterData_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_profile`;

CREATE TABLE `MoneyMonsterData_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `passed` int(11) NOT NULL,
  `failed` int(11) NOT NULL,
  `tasks` int(11) NOT NULL,
  `discussions` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_haps_user_id_id_8ba0597e_uniq` (`user_id_id`),
  CONSTRAINT `MoneyMonsterData_haps_user_id_id_8ba0597e_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_profile` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_profile` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_profile` (`id`, `passed`, `failed`, `tasks`, `discussions`, `user_id_id`)
VALUES
	(1,24,92,4,6,2),
	(2,23,34,34,2,1),
	(3,0,0,0,0,20);

/*!40000 ALTER TABLE `MoneyMonsterData_profile` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_quizquestions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_quizquestions`;

CREATE TABLE `MoneyMonsterData_quizquestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_text` longtext NOT NULL,
  `quiz_id_id` int(11) NOT NULL,
  `answer` tinyint(1) NOT NULL,
  `correct_answer` longtext NOT NULL,
  `false_answer` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_quizquestions_6101a899` (`quiz_id_id`),
  CONSTRAINT `MoneyMonsterD_quiz_id_id_ff1afb06_fk_MoneyMonsterData_quizzes_id` FOREIGN KEY (`quiz_id_id`) REFERENCES `MoneyMonsterData_quizzes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_quizquestions` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_quizquestions` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_quizquestions` (`id`, `question_text`, `quiz_id_id`, `answer`, `correct_answer`, `false_answer`)
VALUES
	(5,'what is money?',3,1,'green paper','purple canadian money'),
	(6,'do dogs spend money?',3,0,'duh','you should know this...'),
	(7,'What is credit?',4,0,'asdf','asdf'),
	(8,'What isnt credit?',4,0,'dfsg','asdf'),
	(9,'asdf',4,1,'sdf','asdf'),
	(12,'questions 1',6,0,'asdf','asdf'),
	(13,'questions 2',6,1,'sdf','fda');

/*!40000 ALTER TABLE `MoneyMonsterData_quizquestions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_quizresults
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_quizresults`;

CREATE TABLE `MoneyMonsterData_quizresults` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `quiz_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  `passed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_quizresults_6101a899` (`quiz_id_id`),
  KEY `MoneyMonsterData_quizresults_18624dd3` (`user_id_id`),
  CONSTRAINT `MoneyMonsterD_quiz_id_id_b00539c9_fk_MoneyMonsterData_quizzes_id` FOREIGN KEY (`quiz_id_id`) REFERENCES `MoneyMonsterData_quizzes` (`id`),
  CONSTRAINT `MoneyMonsterData_quizresults_user_id_id_34d51256_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table MoneyMonsterData_quizzes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_quizzes`;

CREATE TABLE `MoneyMonsterData_quizzes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `video_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_quizzes_0722f419` (`video_id_id`),
  CONSTRAINT `MoneyMonsterDa_video_id_id_d9873fb4_fk_MoneyMonsterData_video_id` FOREIGN KEY (`video_id_id`) REFERENCES `MoneyMonsterData_video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_quizzes` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_quizzes` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_quizzes` (`id`, `title`, `video_id_id`)
VALUES
	(3,'How to make money quiz',14),
	(4,'Credit Quiz',15),
	(6,'retirement quiz',21);

/*!40000 ALTER TABLE `MoneyMonsterData_quizzes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_todos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_todos`;

CREATE TABLE `MoneyMonsterData_todos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon_id` varchar(255) NOT NULL,
  `text` longtext NOT NULL,
  `date_added` datetime NOT NULL,
  `date_completed` datetime NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_todos_user_id_id_9a350de0_fk_auth_user_id` (`user_id_id`),
  CONSTRAINT `MoneyMonsterData_todos_user_id_id_9a350de0_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_todos` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_todos` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_todos` (`id`, `icon_id`, `text`, `date_added`, `date_completed`, `user_id_id`)
VALUES
	(1,'blah','get a job','2016-04-30 01:05:43','2016-04-30 01:05:43',1),
	(2,'cat','yayayya','2016-04-30 01:55:06','2016-04-30 01:55:06',1),
	(3,'woof','barkb bar','2016-04-30 01:56:41','2016-04-30 01:56:41',1),
	(4,'cat','fasdfasdfasdfa','2016-04-30 01:56:50','2016-04-30 01:56:50',1),
	(5,'fasd','fasdf','2016-04-30 01:56:58','2016-04-30 01:56:58',1),
	(6,'asdf','asdfasdf','2016-04-30 01:57:21','2016-04-30 01:57:21',2),
	(7,'asdfasdfasdf','gsdfgsdfg','2016-04-30 01:57:27','2016-04-30 01:57:27',2),
	(8,'AppMobileTheme.BTN_TRASH','Share Money Monster 101!','2016-06-08 20:33:45','2016-06-08 20:33:45',20);

/*!40000 ALTER TABLE `MoneyMonsterData_todos` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `MoneyMonsterData_video` WRITE;
/*!40000 ALTER TABLE `MoneyMonsterData_video` DISABLE KEYS */;

INSERT INTO `MoneyMonsterData_video` (`id`, `title`, `description`, `thumbnail_filename`, `hls_url`, `rtmp_server_url`, `rtmp_stream_name`)
VALUES
	(14,'Closer','TODO','Wrap_Up','http://eoge7bvk.rtmphost.com/hls-vod/videos/CLOSER.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:CLOSER_600k.mp4'),
	(15,'Credit Bureaus','TODO','Credit_Bueareu','http://eoge7bvk.rtmphost.com/hls-vod/videos/CREDIT_BUREAUS.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:CREDIT_BUREAUS_600k.mp4'),
	(18,'Large Purchases','TODO','Large_Purchases','http://eoge7bvk.rtmphost.com/hls-vod/videos/LARGE_PURCHASES.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:LARGE_PURCHASES_600k.mp4'),
	(19,'Needs vs. Wants','TODO','Wants_vs_Needs','http://eoge7bvk.rtmphost.com/hls-vod/videos/NEEDS_VS_WANTS.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:NEEDS_VS_WANTS_600k.mp4'),
	(20,'Pay Yourself First','TODO','Pay_Yourself_First','http://eoge7bvk.rtmphost.com/hls-vod/videos/PAY_YOURSELF_FIRST.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:PAY_YOURSELF_FIRST_600k.mp4'),
	(21,'Retirement','TODO','Retirement_1','http://eoge7bvk.rtmphost.com/hls-vod/videos/RETIREMENT.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:RETIREMENT_600k.mp4'),
	(22,'Wrap Up','TODO','Wrap_Up','http://eoge7bvk.rtmphost.com/hls-vod/videos/WRAP_UP.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:WRAP_UP_600k.mp4'),
	(24,'Bank Accounts','Bank Accounts','Bank_Accounts','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_BANK_ACCOUNTS_TC_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_BANK_ACCOUNTS_TC_V1_600k.mp4'),
	(25,'Budget','Budget','Budget','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_101_Budget_V3_FINAL.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_101_Budget_V3_FINAL_600k.mp4'),
	(26,'Cash is King','Cash is King','Cash_Is_King','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM05_Cash_is_King_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM05_Cash_is_King_V1_600k.mp4'),
	(27,'Establishing Good Credit','Establishing Good Credit','Good_Credit_1','http://eoge7bvk.rtmphost.com/hls-vod/videos/EST_GOOD_CREDIT .m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:EST_GOOD_CREDIT _600k.mp4'),
	(28,'Investments','Investments','Investments','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_07_Establishing_Credit_FINAL_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_07_Establishing_Credit_FINAL_V1_600k.mp4'),
	(29,'Lenders','Lenders','Lenders','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_LENDER_OPTIONS_TC_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_LENDER_OPTIONS_TC_V1_2_600k.mp4'),
	(30,'Taxes and Inflation','Taxes and Inflation','Taxes_and_Inflation','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_TAXES_AND_INFLATION_FINAL_SFX.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_TAXES_AND_INFLATION_FINAL_SFX_600k.mp4'),
	(31,'Credit 2','Credit 2','Establishing_Credit','http://eoge7bvk.rtmphost.com/hls-vod/videos/MM_07_Establishing_Credit_FINAL_V1.m3u8','rtmp://eoge7bvk.rtmphost.com/McFinnWeb/','mp4:MM_07_Establishing_Credit_FINAL_V1_600k.mp4');

/*!40000 ALTER TABLE `MoneyMonsterData_video` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table MoneyMonsterData_videostatus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MoneyMonsterData_videostatus`;

CREATE TABLE `MoneyMonsterData_videostatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` int(11) NOT NULL,
  `eye_status` tinyint(1) NOT NULL,
  `check_status` tinyint(1) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  `video_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `MoneyMonsterData_videostatus_user_id_id_d3adbf2e_fk_auth_user_id` (`user_id_id`),
  KEY `MoneyMonsterDa_video_id_id_a5013413_fk_MoneyMonsterData_video_id` (`video_id_id`),
  CONSTRAINT `MoneyMonsterDa_video_id_id_a5013413_fk_MoneyMonsterData_video_id` FOREIGN KEY (`video_id_id`) REFERENCES `MoneyMonsterData_video` (`id`),
  CONSTRAINT `MoneyMonsterData_videostatus_user_id_id_d3adbf2e_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



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
	(3,'facebook','683528788451692','2016-06-03 05:48:50','2016-06-02 19:23:38','{\"first_name\": \"Jimmy\", \"last_name\": \"Bear\", \"verified\": true, \"name\": \"Jimmy Bear\", \"locale\": \"en_US\", \"gender\": \"male\", \"email\": \"dummybearish@gmail.com\", \"link\": \"https://www.facebook.com/app_scoped_user_id/683528788451692/\", \"timezone\": -7, \"updated_time\": \"2013-07-02T21:50:08+0000\", \"id\": \"683528788451692\"}',15);

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
	(3,'EAAD6pspVmlUBALa6qFIFkVn9ZAq7b621EgJCYm75xPVt3Guzxf5gDy9yX0536Akp8noQZChVba1iVDwNNwyIknBCFgwX5KjkXTfBaOeAi7nrfMfVZCdLN2NZAa7SuLVUbuklyOgkheSiTWX7nZC6MfLQkLQwQINuvpUxDfkVKgzu8eFhC8h3KAYrRvzz9ZC0QZD','',NULL,3,1);

/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
