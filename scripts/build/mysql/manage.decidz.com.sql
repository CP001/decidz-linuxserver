-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mvn
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

drop database IF EXISTS manage_prod;
CREATE DATABASE manage_prod;
GRANT ALL PRIVILEGES ON manage_prod.* TO "manage_prod_user"@"localhost" IDENTIFIED BY "zslkjf2o3wuhfwoihfj";
use manage_prod;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbdebuglog`
--

DROP TABLE IF EXISTS `tbdebuglog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbdebuglog` (
  `lgid` int(20) NOT NULL AUTO_INCREMENT,
  `edt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`lgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbdebuglog`
--

LOCK TABLES `tbdebuglog` WRITE;
/*!40000 ALTER TABLE `tbdebuglog` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbdebuglog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbguidhit`
--

DROP TABLE IF EXISTS `tbguidhit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbguidhit` (
  `ghid` int(20) NOT NULL AUTO_INCREMENT,
  `guid` varchar(256) DEFAULT NULL,
  `source` varchar(30) DEFAULT NULL,
  `hitdatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ghid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbguidhit`
--

LOCK TABLES `tbguidhit` WRITE;
/*!40000 ALTER TABLE `tbguidhit` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbguidhit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbpwdresetrequests`
--

DROP TABLE IF EXISTS `tbpwdresetrequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbpwdresetrequests` (
  `tid` int(20) NOT NULL AUTO_INCREMENT,
  `emailaddress` varchar(256) DEFAULT NULL,
  `requestdatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resetstatus` varchar(256) DEFAULT NULL,
  `resetguid` varchar(256) DEFAULT NULL,
  `useragent` varchar(1024) DEFAULT NULL,
  `ipaddress` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpwdresetrequests`
--

LOCK TABLES `tbpwdresetrequests` WRITE;
/*!40000 ALTER TABLE `tbpwdresetrequests` DISABLE KEYS */;
INSERT INTO `tbpwdresetrequests` VALUES (71,'cp004@m0.cm','2015-03-30 14:45:46','complete','hws0ensq2us2p1vyv75xwifedgsd5hnjhirzh1jaifb1yg3wvgd48oa4jz10p48n6oln6qtk5te369jl3gmjil707ruoi8ihmerd9zwbicw75tbss9qj63npc8ytvndjcsnmv9g3vvgczqegvojbmztuhiwqnqfno7runh53q47dw6z0v2i0a3da0yh68f1rda11w2c5l5r3wwku7cp8t1i5y29suk06l4l886woftiugfgq1sixt2mjm7yw9ex5','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(72,'cparker443@gmail.com','2015-03-31 02:50:30','complete','tni9lv9hcznzpc7s2ov3lew06l4j2j3nmxihmerefospsnlrpx871b5m9971b3bxjjt7e0llxob7wm2bzri0b6rzcgy7ue1urzh1j8f0ntxvezkimbfwyrov2hvnenv3lew1b11vwocceozmv8dsk4oriyzrlex83j1ei1hwwgarr7hjywdtr3wwkvdyg0i675xvbn26d0p5hmcibpccdkezlm0zmtxzu1cb93glf1o0rhukyv8bg1mqhy4hop8t','Mozilla/5.0 (Linux; Android 5.0.2; XT1032 Build/LXB22.46-28.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36','82.39.117.53'),(73,'cparker443@gmail.com','2015-04-21 10:39:37','complete','rpw7z36e48kpmpfotvjudxadnwco21p6jve5bqj776xu3sczrhtgjy0v05k038n8147iir0khgk3nlrq32q8odkdx73k9dnylt1fsczqej8bicxcnyigeej4sassbu1fpx9cje1rgnlswubn25aob4j07sz94laclm12x7yykpjajkvf7kt7aicyjjqrda147e3zgx17l2c7qq6imesitd20jf7jokgc344za5pp5gfk61ccb95onzn258kpjdyf','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36','82.39.117.53'),(74,'snow7374@gmail.com','2015-04-22 12:04:35','complete','pi4ujxswsx3efotufb0w706m96wofsgixu788afw038kubo7rx17m5ng1ov3nlqmlwf1tl9986xsuk1b11vyxg57bmwew2fkbicxetpqb0yg2rd7qrbyo5ir0khffkag3vve454wubpa15d1vwodj8ew3hvl18rrc1ydq8sx1341lkrunfx4jz4d5fdb3c4fc6mbep33zentvm5olodgwvg8qj8eybdo1uwofq32rb0uwpj7ag3y6quqvxodjcpb','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','86.72.82.36'),(75,'snow7374@gmail.com','2015-04-22 12:38:30','complete','tz80znyn11uucw74pvz36dyfx3j1ekbmu5xwgasul4k606ndmpekf42ow86xswvf46ajjs2q5e4aoccdh4vpoxex4nlqmjm7zxid1w3j0b4hqzh50dh2mlrumcg1nqhwvcpdcb95ptolpgtiue33vt53r6dyh8kplikxqkezjdxdp6ioln7t51i5y28qlg7gatwvf42tjwm5qtmdnv5vn96uf7n8zykodh3r6e5apdgum84nie5apekeyetl6wph','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','86.72.82.36'),(76,'cparker443@gmail.com','2015-05-27 09:13:14','complete','cgx2d8xo7rw00tpus7eyg3vry7yt0b7wkubo5hoo38lvg7kt54tirybeo0qb4e8vbmwdv06m96xpkbn1zkhjvkxob7xqmmzqhxxmzsotr3y6qw020msr58iiprhpx7yxighoqfj5vpjdw5s8lvbp9zw86y0w4putcw75te5gfgr58jm7xrow4r30eq5apgtgk6y0v3lcnwcqc7t3ul6wn7wm3d5jt8krvqus1oxfw3hq1p33wzwdsj1elezh2r9s','Mozilla/5.0 (Linux; Android 5.0; LG-D855 Build/LRX21R.A1421650137) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.111 Mobile Safari/537.36','82.132.234.244'),(77,'cparker443@gmail.com','2015-06-02 08:43:30','complete','xeybfw023y82c5k06nch3sfhtd1uuhjywf2tmfwzykodjajkvil5r2sgmg40gx146dw6xu63mkncgzb83j07pozo4c0sk873j4r3y6ud1ut7f3zdmn4fiwruoibn27kucrk9ew05gfi1ekdsoqd9zxfzgy82c3bzn23zeq5d0qb28oenss7g9sumbcjcrleuvjqtk3j1gthlckik1aztvofupp21ozmu3osmid1w3ivogwwlve2ut6bo4d38m3c1','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36','82.39.117.53'),(78,'cparker443@gmail.com','2015-06-15 10:21:25','complete','hgiujrybdje1uqwzzqehxxlwijs54ungy8zykph0gthonzqflh9n7ve1siuhl5uinh3uokjndnss9phy5l5tcw61c7vhis4y8zzo6m6tan6oje2wzymwg8jpoxcmty4hptptmg1mqhxyrkcqb0zmty0znwcp9whfdb3d6k05fc5hmdrfhwt4vpmpgr7jqsjxv7772j3pxbg1kg7gd4btxxlu63r6dyfx6wm2c22ya85t8hggnnzpb3eddftgk4s8','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36','82.39.117.53');
/*!40000 ALTER TABLE `tbpwdresetrequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbuserkvstore`
--

DROP TABLE IF EXISTS `tbuserkvstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbuserkvstore` (
  `ukvsid` int(20) NOT NULL AUTO_INCREMENT,
  `emailaddress` varchar(256) DEFAULT NULL,
  `kvkey` varchar(64) DEFAULT NULL,
  `kvvalue` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ukvsid`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbuserkvstore`
--

LOCK TABLES `tbuserkvstore` WRITE;
/*!40000 ALTER TABLE `tbuserkvstore` DISABLE KEYS */;
INSERT INTO `tbuserkvstore` VALUES (65,'cparker443@gmail.com','homescreenwelcomev1','yes');
/*!40000 ALTER TABLE `tbuserkvstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbusers`
--

DROP TABLE IF EXISTS `tbusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbusers` (
  `tid` int(20) NOT NULL AUTO_INCREMENT,
  `emailaddress` varchar(256) DEFAULT NULL,
  `usersid` varchar(128) DEFAULT NULL,
  `passwordhash` varchar(2048) DEFAULT NULL,
  `dateregistered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ruseragent` varchar(1024) DEFAULT NULL,
  `ripaddress` varchar(15) DEFAULT NULL,
  `userverified` tinyint(1) DEFAULT '0',
  `verificationguid` varchar(256) DEFAULT NULL,
  `daterverified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vuseragent` varchar(1024) DEFAULT NULL,
  `vipaddress` varchar(15) DEFAULT NULL,
  `adminaccess` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbusers`
--

LOCK TABLES `tbusers` WRITE;
/*!40000 ALTER TABLE `tbusers` DISABLE KEYS */;
INSERT INTO `tbusers` VALUES (169,'cparker443@gmail.com','bnzrmg2tk1','$2a$08$EkQKsyTeWJ/UG84Qro8.fuP9sOfr4ZDZi96mV/1PiOSIvOyKRJ3y6','2015-03-30 13:34:50','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53',1,'8vcrhvojaknbdkg8ob816kzxie344wvdyg1oxclpi2orlf0ljoh1kg6cw5vn95r0h2ouz27jqtmbfvwks0eow6z12x3iwqq5e340entte5fbyo6pozlqouyxjl036f58jl2da15e3550dgwve1tpp6ipshs8ksy7xpgvqsjxrr7lyrpyerd8xmztwsxzxdrfmh8jnftmcjdyg3wucv08xo8vgatxzw6yxlv8f0kjpnuy0v3k772gpzh4x136cuxt','2015-03-30 13:39:52','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53',1),(173,'snow7374@gmail.com','4aqleybdoz','$2a$08$KhFhURv/p5Gm6TKCYd/zr.aE.uJsEFVQW9he5rPgENS49ZBQBlosa','2015-03-30 15:47:02','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','86.72.82.36',1,'o23ybdje3zgx2c39rpxbeuqx3fi2j5yzv1b6po0rgq1q8rsgiyzsqzh53tfefmlt1j78bg0kg9rov08t4wu9jjvgbzo38pi4um6vkwkrx2c6mbdmqj4te8qq5ao7uctte7l3eekdsk75vl2b11tnh53r9rq33uqsjz26f6hivkwm26hj06ma84nlocentwt0djcrj4q0nv3qyfur0i79fzesglcnyjkzv61ej8dtoo0smfzfshpsj3nknbbdjdyh','2015-03-30 15:49:25','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','86.72.82.36',1);
/*!40000 ALTER TABLE `tbusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbverboselog`
--

DROP TABLE IF EXISTS `tbverboselog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbverboselog` (
  `elid` int(20) NOT NULL AUTO_INCREMENT,
  `edt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `errortype` varchar(30) DEFAULT NULL,
  `errorsummary` varchar(100) DEFAULT NULL,
  `errordescription` varchar(1024) DEFAULT NULL,
  `referrerurl` varchar(1024) DEFAULT NULL,
  `useragent` varchar(1024) DEFAULT NULL,
  `ipaddress` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`elid`)
) ENGINE=InnoDB AUTO_INCREMENT=877 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbverboselog`
--

LOCK TABLES `tbverboselog` WRITE;
/*!40000 ALTER TABLE `tbverboselog` DISABLE KEYS */;
INSERT INTO `tbverboselog` VALUES (847,'2015-03-30 13:34:50','registration','New user has registered successfully for manage.votenoodle.com - cparker443@gmail.com','Verification code sent to user - 8vcrhvojaknbdkg8ob816kzxie344wvdyg1oxclpi2orlf0ljoh1kg6cw5vn95r0h2ouz27jqtmbfvwks0eow6z12x3iwqq5e340entte5fbyo6pozlqouyxjl036f58jl2da15e3550dgwve1tpp6ipshs8ksy7xpgvqsjxrr7lyrpyerd8xmztwsxzxdrfmh8jnftmcjdyg3wucv08xo8vgatxzw6yxlv8f0kjpnuy0v3k772gpzh4x136cuxt','http://manage.votenoodle.com/security/?page=register','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(848,'2015-03-30 13:39:52','registration','Account verified cparker443@gmail.com','','','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(849,'2015-03-30 14:43:21','registration','Password for email address cp003@m0.cm not complex enough','','http://manage.votenoodle.com/security/?page=register','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0','82.39.117.53'),(850,'2015-03-30 14:43:32','registration','New user has registered successfully for manage.votenoodle.com - cp003@m0.cm','Verification code sent to user - 0jbo6m706kxrsasse9v9ie6gfgouvm5onxf0lksx29vco39qmmwhbty3byn12w2eforlew06kxofow6yypddfq7kvd0nv74te9u4um83j2j2j776z4c21p5hivkxn6rx4j2gr5brlex6ud0qc4hnjgbzo7qq8rr9rq2zdntwt0fseb0xdp7m5qx5r0i65xwgcxg551hxzu07t4y6omphxypcdh1lg57cpa0zkjry7xrr8n8zykpgx28rq6gd7pkg','http://manage.votenoodle.com/security/?page=register','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0','82.39.117.53'),(851,'2015-03-30 14:44:40','registration','Account verified cp003@m0.cm','','','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(852,'2015-03-30 14:44:50','registration','Verification failed for cp003@m0.cm','Account has already been verified.','','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(853,'2015-03-30 14:45:14','registration','New user has registered successfully for manage.votenoodle.com - cp004@m0.cm','Verification code sent to user - tptnid0o0vz0v2ixwg8lxlwikxqnpa15cwbjhgk86yzspx5td1vz0w4nnxifavajhjyymzrj4teawhbtwrtitapeljjt68g54zb82aymzspx71db4k2gr42rc1ydnv886y0uyxlt1h1gtglbjf5dyjil706ma84onykofsgk4r44zb7xpi1i3ottbuz5is7e2x6uf6infy6ucv2iy3av8euucwbg0i65y10qd90yh8jnci7ajhl71c6nfus1mm0x','http://manage.votenoodle.com/security/?page=register','Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0','82.39.117.53'),(854,'2015-03-30 14:45:28','registration','Account verified cp004@m0.cm','','','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(855,'2015-03-30 14:45:32','registration','Verification failed for cp004@m0.cm','Account has already been verified.','','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(856,'2015-03-30 14:45:46','password','Password reset email link sent to cp004@m0.cm','','http://manage.votenoodle.com/security/?page=passwordreminder','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(857,'2015-03-30 14:46:06','security','Password reset for email address cp004@m0.cm not complex enough','','http://manage.votenoodle.com/security/?page=resetpassword&guid=hws0ensq2us2p1vyv75xwifedgsd5hnjhirzh1jaifb1yg3wvgd48oa4jz10p48n6oln6qtk5te369jl3gmjil707ruoi8ihmerd9zwbicw75tbss9qj63npc8ytvndjcsnmv9g3vvgczqegvojbmztuhiwqnqfno7runh53q47dw6z0v2i0a3da0yh68f1rda11w2c5l5r3wwku7cp8t1i5y29suk06l4l886woftiugfgq1sixt2mjm7yw9ex5','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(858,'2015-03-30 14:46:19','security','Password successfully reset for email address cp004@m0.cm','','http://manage.votenoodle.com/security/?page=resetpassword&guid=hws0ensq2us2p1vyv75xwifedgsd5hnjhirzh1jaifb1yg3wvgd48oa4jz10p48n6oln6qtk5te369jl3gmjil707ruoi8ihmerd9zwbicw75tbss9qj63npc8ytvndjcsnmv9g3vvgczqegvojbmztuhiwqnqfno7runh53q47dw6z0v2i0a3da0yh68f1rda11w2c5l5r3wwku7cp8t1i5y29suk06l4l886woftiugfgq1sixt2mjm7yw9ex5','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(859,'2015-03-30 15:44:53','registration','New user has registered successfully for manage.votenoodle.com - cp005@m0.cm','Verification code sent to user - i2nnzsq0kheb11uucu0b5l7z38pfrbxiggk60b3byn0w6wqov4r43vqupnxg5675xyn3byn37jpntvndmn6qsfk5xxkpmqhy1354vruolob6rx3fk8aetnibpfmlvbkn94jz4d7nbbbdln6pq7ohz7xqmlrrav7873mh8lxlvbmvbkn7xqj9fzg0i3se7qow73j4r3zep340i3q2zdjctuhl6z0v3k7607rwzxf1p1ut8hfeei4scymwf2wzzp9x','http://manage.votenoodle.com/security/?page=register','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36','82.39.117.53'),(860,'2015-03-30 15:47:02','registration','New user has registered successfully for manage.votenoodle.com - snow7374@gmail.com','Verification code sent to user - o23ybdje3zgx2c39rpxbeuqx3fi2j5yzv1b6po0rgq1q8rsgiyzsqzh53tfefmlt1j78bg0kg9rov08t4wu9jjvgbzo38pi4um6vkwkrx2c6mbdmqj4te8qq5ao7uctte7l3eekdsk75vl2b11tnh53r9rq33uqsjz26f6hivkwm26hj06ma84nlocentwt0djcrj4q0nv3qyfur0i79fzesglcnyjkzv61ej8dtoo0smfzfshpsj3nknbbdjdyh','http://manage.votenoodle.com/security/?page=register','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','86.72.82.36'),(861,'2015-03-30 15:49:25','registration','Account verified snow7374@gmail.com','','','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','86.72.82.36'),(862,'2015-03-31 02:50:30','password','Password reset email link sent to cparker443@gmail.com','','http://manage.votenoodle.com/security/?page=passwordreminder','Mozilla/5.0 (Linux; Android 5.0.2; XT1032 Build/LXB22.46-28.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36','82.39.117.53'),(863,'2015-03-31 02:51:03','security','Password successfully reset for email address cparker443@gmail.com','','http://manage.votenoodle.com/security/?page=resetpassword&guid=tni9lv9hcznzpc7s2ov3lew06l4j2j3nmxihmerefospsnlrpx871b5m9971b3bxjjt7e0llxob7wm2bzri0b6rzcgy7ue1urzh1j8f0ntxvezkimbfwyrov2hvnenv3lew1b11vwocceozmv8dsk4oriyzrlex83j1ei1hwwgarr7hjywdtr3wwkvdyg0i675xvbn26d0p5hmcibpccdkezlm0zmtxzu1cb93glf1o0rhukyv8bg1mqhy4hop8t','Mozilla/5.0 (Linux; Android 5.0.2; XT1032 Build/LXB22.46-28.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36','82.39.117.53'),(864,'2015-04-21 10:39:37','password','Password reset email link sent to cparker443@gmail.com','','http://manage.decidz.com/security/?page=passwordreminder','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36','82.39.117.53'),(865,'2015-04-21 10:40:29','security','Password successfully reset for email address cparker443@gmail.com','','http://manage.decidz.com/security/?page=resetpassword&guid=rpw7z36e48kpmpfotvjudxadnwco21p6jve5bqj776xu3sczrhtgjy0v05k038n8147iir0khgk3nlrq32q8odkdx73k9dnylt1fsczqej8bicxcnyigeej4sassbu1fpx9cje1rgnlswubn25aob4j07sz94laclm12x7yykpjajkvf7kt7aicyjjqrda147e3zgx17l2c7qq6imesitd20jf7jokgc344za5pp5gfk61ccb95onzn258kpjdyf','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36','82.39.117.53'),(866,'2015-04-22 12:04:35','password','Password reset email link sent to snow7374@gmail.com','','http://manage.decidz.com/security/?page=passwordreminder','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','86.72.82.36'),(867,'2015-04-22 12:37:58','security','Password successfully reset for email address snow7374@gmail.com','','http://manage.decidz.com/security/?page=resetpassword&guid=pi4ujxswsx3efotufb0w706m96wofsgixu788afw038kubo7rx17m5ng1ov3nlqmlwf1tl9986xsuk1b11vyxg57bmwew2fkbicxetpqb0yg2rd7qrbyo5ir0khffkag3vve454wubpa15d1vwodj8ew3hvl18rrc1ydq8sx1341lkrunfx4jz4d5fdb3c4fc6mbep33zentvm5olodgwvg8qj8eybdo1uwofq32rb0uwpj7ag3y6quqvxodjcpb','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','86.72.82.36'),(868,'2015-04-22 12:38:26','security','invalid guid passed for resetpassword process','pi4ujxswsx3efotufb0w706m96wofsgixu788afw038kubo7rx17m5ng1ov3nlqmlwf1tl9986xsuk1b11vyxg57bmwew2fkbicxetpqb0yg2rd7qrbyo5ir0khffkag3vve454wubpa15d1vwodj8ew3hvl18rrc1ydq8sx1341lkrunfx4jz4d5fdb3c4fc6mbep33zentvm5olodgwvg8qj8eybdo1uwofq32rb0uwpj7ag3y6quqvxodjcpb','','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','86.72.82.36'),(869,'2015-04-22 12:38:30','password','Password reset email link sent to snow7374@gmail.com','','http://manage.decidz.com/security/?page=passwordreminder','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','86.72.82.36'),(870,'2015-04-22 12:40:03','security','Password successfully reset for email address snow7374@gmail.com','','http://manage.decidz.com/security/?page=resetpassword&guid=tz80znyn11uucw74pvz36dyfx3j1ekbmu5xwgasul4k606ndmpekf42ow86xswvf46ajjs2q5e4aoccdh4vpoxex4nlqmjm7zxid1w3j0b4hqzh50dh2mlrumcg1nqhwvcpdcb95ptolpgtiue33vt53r6dyh8kplikxqkezjdxdp6ioln7t51i5y28qlg7gatwvf42tjwm5qtmdnv5vn96uf7n8zykodh3r6e5apdgum84nie5apekeyetl6wph','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36','86.72.82.36'),(871,'2015-05-27 09:13:14','password','Password reset email link sent to cparker443@gmail.com','','http://manage.decidz.com/security/?page=passwordreminder','Mozilla/5.0 (Linux; Android 5.0; LG-D855 Build/LRX21R.A1421650137) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.111 Mobile Safari/537.36','82.132.234.244'),(872,'2015-05-27 09:14:26','security','Password successfully reset for email address cparker443@gmail.com','','http://manage.decidz.com/security/?page=resetpassword&guid=cgx2d8xo7rw00tpus7eyg3vry7yt0b7wkubo5hoo38lvg7kt54tirybeo0qb4e8vbmwdv06m96xpkbn1zkhjvkxob7xqmmzqhxxmzsotr3y6qw020msr58iiprhpx7yxighoqfj5vpjdw5s8lvbp9zw86y0w4putcw75te5gfgr58jm7xrow4r30eq5apgtgk6y0v3lcnwcqc7t3ul6wn7wm3d5jt8krvqus1oxfw3hq1p33wzwdsj1elezh2r9s','Mozilla/5.0 (Linux; Android 5.0; LG-D855 Build/LRX21R.A1421650137) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.111 Mobile Safari/537.36','82.132.234.244'),(873,'2015-06-02 08:43:30','password','Password reset email link sent to cparker443@gmail.com','','http://manage.decidz.com/security/?page=passwordreminder','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36','82.39.117.53'),(874,'2015-06-02 08:43:54','security','Password successfully reset for email address cparker443@gmail.com','','http://manage.decidz.com/security/?page=resetpassword&guid=xeybfw023y82c5k06nch3sfhtd1uuhjywf2tmfwzykodjajkvil5r2sgmg40gx146dw6xu63mkncgzb83j07pozo4c0sk873j4r3y6ud1ut7f3zdmn4fiwruoibn27kucrk9ew05gfi1ekdsoqd9zxfzgy82c3bzn23zeq5d0qb28oenss7g9sumbcjcrleuvjqtk3j1gthlckik1aztvofupp21ozmu3osmid1w3ivogwwlve2ut6bo4d38m3c1','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36','82.39.117.53'),(875,'2015-06-15 10:21:25','password','Password reset email link sent to cparker443@gmail.com','','http://manage.decidz.com/security/?page=passwordreminder','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36','82.39.117.53'),(876,'2015-06-15 10:21:56','security','Password successfully reset for email address cparker443@gmail.com','','http://manage.decidz.com/security/?page=resetpassword&guid=hgiujrybdje1uqwzzqehxxlwijs54ungy8zykph0gthonzqflh9n7ve1siuhl5uinh3uokjndnss9phy5l5tcw61c7vhis4y8zzo6m6tan6oje2wzymwg8jpoxcmty4hptptmg1mqhxyrkcqb0zmty0znwcp9whfdb3d6k05fc5hmdrfhwt4vpmpgr7jqsjxv7772j3pxbg1kg7gd4btxxlu63r6dyfx6wm2c22ya85t8hggnnzpb3eddftgk4s8','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36','82.39.117.53');
/*!40000 ALTER TABLE `tbverboselog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mvn'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_remove_accents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_remove_accents`( textvalue varchar(20000) ) RETURNS varchar(20000) CHARSET utf8
begin

set @textvalue = textvalue;


set @withaccents = 'ŠšŽžÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝŸÞàáâãäåæçèéêëìíîïñòóôõöøùúûüýÿþƒ';
set @withoutaccents = 'SsZzAAAAAAACEEEEIIIINOOOOOOUUUUYYBaaaaaaaceeeeiiiinoooooouuuuyybf';
set @count = length(@withaccents);

while @count > 0 do
    set @textvalue = replace(@textvalue, substring(@withaccents, @count, 1), substring(@withoutaccents, @count, 1));
    set @count = @count - 1;
end while;


set @special = '® !@#$%¨*()_=§¹²³£¢¬"`´{[^~}]<,>.:;?/°ºª*|\\''';
set @count = length(@special);
while @count > 0 do
    set @textvalue = replace(@textvalue, substring(@special, @count, 1), '');
    set @count = @count - 1;
end while;
return @textvalue;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getguid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getguid`(guidlength int) RETURNS varchar(1000) CHARSET utf8
    READS SQL DATA
begin
  declare tempguid nvarchar(1000);
  declare curidx int(3);
  declare tempintrc int(3);

  set tempguid = "";
  set curidx = 0;
  randomizeloop: LOOP
    set tempintrc = round(Rand() * 35);

    if (tempintrc < 26) then
      set tempintrc = tempintrc + 97;
    else
      set tempintrc = tempintrc + 22;
    end if;

    set tempguid = concat(tempguid, char(tempintrc));

    SET curidx = curidx + 1;
    if curidx >= guidlength then
      LEAVE randomizeloop;
    end IF;
  end LOOP randomizeloop;

  RETURN tempguid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `recordnewuserinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `recordnewuserinfo`(pemailaddress nvarchar(256), ppwdhash nvarchar(2048), pruseragent nvarchar(1024), pripaddress nvarchar(15)) RETURNS varchar(256) CHARSET utf8
    READS SQL DATA
begin
  declare numfound int(3);
  declare lusersid nvarchar(128);
  declare lverificationguid nvarchar(256);

  
  getusersidguidloop: LOOP
    
    set lusersid = getguid(10);
    
    select count(*) into numfound from tbusers where usersid = lusersid;
    if (numfound = 0) then
      LEAVE getusersidguidloop;
    end IF;
    
    insert into tbguidhit(guid, source)
    values (lusersid, 'usersid');
  end LOOP getusersidguidloop;

  
  getvguidloop: LOOP
    
    set lverificationguid = getguid(256);
    
    select count(*) into numfound from tbusers where verificationguid = lverificationguid;
    if (numfound = 0) then
      LEAVE getvguidloop;
    end IF;
    
    insert into tbguidhit(guid, source)
    values (lverificationguid, 'uservguid');
  end LOOP getvguidloop;

  insert into tbusers (emailaddress, passwordhash, usersid, ruseragent, ripaddress, verificationguid)
  values (pemailaddress, ppwdhash, lusersid, pruseragent, pripaddress, lverificationguid);

  return lverificationguid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `recordpasswordresetreq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `recordpasswordresetreq`(pemailaddress nvarchar(256), puseragent nvarchar(1024), pipaddress nvarchar(15)) RETURNS varchar(256) CHARSET utf8
    READS SQL DATA
begin
  declare numfound int(3);
  declare lresetguid nvarchar(256);

  getvguidloop: LOOP
    
    set lresetguid = getguid(256);
    
    select count(*) into numfound from tbpwdresetrequests where resetguid = lresetguid;
    if (numfound = 0) then
      LEAVE getvguidloop;
    end IF;
    
    insert into tbguidhit(guid, source)
    values (lresetguid, 'passwordresetguid');
  end LOOP getvguidloop;

  insert into tbpwdresetrequests (emailaddress, useragent, ipaddress, resetguid, resetstatus)
  values (pemailaddress, puseragent, pipaddress, lresetguid, "waiting");

  return lresetguid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fncbackupalltables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncbackupalltables`(datetimeprevalue nvarchar(200))
    READS SQL DATA
begin
  call fncexporttable(datetimeprevalue, "mvn", "tbusers");
  call fncexporttable(datetimeprevalue, "mvn", "tbuserkvstore");
  call fncexporttable(datetimeprevalue, "mvn", "tbdebuglog");
  call fncexporttable(datetimeprevalue, "mvn", "tbverboselog");
  call fncexporttable(datetimeprevalue, "mvn", "tbguidhit");
  call fncexporttable(datetimeprevalue, "mvn", "tbpwdresetrequests");
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fncexporttable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncexporttable`(datetimeprevalue nvarchar(200), pdatabasename nvarchar(200), ptablename nvarchar(200))
    READS SQL DATA
begin
  SET @SqlStatemntX1 = concat("select * from ", pdatabasename, ".", ptablename, " ");
  SET @SqlStatemntX1 = concat(@SqlStatemntX1, "INTO OUTFILE '/var/www/backups/", datetimeprevalue, "_", pdatabasename, "_", ptablename, ".txt' ");
  SET @SqlStatemntX1 = concat(@SqlStatemntX1, "FIELDS TERMINATED BY \',\' ");
  SET @SqlStatemntX1 = concat(@SqlStatemntX1, "ENCLOSED BY \'\"\' ");
  SET @SqlStatemntX1 = concat(@SqlStatemntX1, "LINES TERMINATED BY \'\n\';");

  
  PREPARE stmt FROM @SqlStatemntX1;
  EXECUTE stmt;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getuserkv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getuserkv`(pemailaddress nvarchar(256), pkvkey nvarchar(64))
    READS SQL DATA
begin
  select kvvalue from tbuserkvstore where emailaddress=pemailaddress and kvkey=pkvkey;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `logshit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `logshit`(pmessage nvarchar(1024))
    READS SQL DATA
begin
  insert into tbdebuglog(message)
  values (pmessage);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `logverbosedetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `logverbosedetails`(perrortype nvarchar(30), perrorsummary nvarchar(100), perrordescription nvarchar(1024), preferrerurl nvarchar(1024), puseragent nvarchar(1024), pipaddress nvarchar(15))
    READS SQL DATA
begin
  insert into tbverboselog(errortype, errorsummary, errordescription, referrerurl, useragent, ipaddress)
  values (perrortype, perrorsummary, perrordescription, preferrerurl, puseragent, pipaddress);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `recordnewuserintbinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `recordnewuserintbinfo`(pemailaddress nvarchar(256), pusersid nvarchar(128), pruseragent nvarchar(1024), pripaddress nvarchar(15), pverificationguid nvarchar(256))
    READS SQL DATA
begin
  insert into tbusers (emailaddress, usersid, ruseragent, ripaddress, verificationguid)
  values (pemailaddress, pusersid, pruseragent, pripaddress, pverificationguid);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `recorduserregistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `recorduserregistration`(pemailaddress nvarchar(256), puseragent nvarchar(1024), pipaddress nvarchar(15))
    READS SQL DATA
begin
  UPDATE tbbetausers
  SET userregistered=1, useragent=puseragent, dateregistered=CURRENT_TIMESTAMP, ipaddress=pipaddress
  WHERE emailaddress=pemailaddress;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateuserkv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateuserkv`(pemailaddress nvarchar(256), pkvkey nvarchar(64), pkvvalue nvarchar(256))
    READS SQL DATA
begin
  declare numfound int(3);

  select count(*) into numfound from tbuserkvstore where emailaddress=pemailaddress and kvkey=pkvkey;
  if (numfound=1) then
    
    UPDATE tbuserkvstore
    SET kvvalue=pkvvalue
    WHERE emailaddress=pemailaddress and kvkey=pkvkey;
  else
    
    insert into tbuserkvstore(emailaddress, kvkey, kvvalue)
    values (pemailaddress, pkvkey, pkvvalue);
  end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verifyregistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `verifyregistration`(puserverified tinyint(1),pverificationguid nvarchar(256), puseragent nvarchar(1024), pipaddress nvarchar(15))
    READS SQL DATA
begin
  UPDATE tbusers
  SET userverified=puserverified, daterverified=CURRENT_TIMESTAMP, vuseragent=puseragent, vipaddress=pipaddress
  WHERE verificationguid=pverificationguid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-03 18:40:57
