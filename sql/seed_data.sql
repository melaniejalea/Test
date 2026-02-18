/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: magi_db
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `eva_units`
--

DROP TABLE IF EXISTS `eva_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `eva_units` (
  `unit_id` varchar(10) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL CHECK (`status` in ('operational','maintenance','destroyed')),
  `activation_count` int(11) DEFAULT 0,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eva_units`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `eva_units` WRITE;
/*!40000 ALTER TABLE `eva_units` DISABLE KEYS */;
INSERT INTO `eva_units` VALUES
('EVA-00','Unit-00 Prototype','operational',19),
('EVA-01','Unit-01 Test Type','operational',8),
('EVA-02','Unit-02 Production Type','operational',40),
('EVA-03','Unit-03 Experimental','maintenance',36),
('EVA-04','Unit-04 Mass Production','destroyed',33),
('EVA-05','Unit-05 Advanced Type','operational',22);
/*!40000 ALTER TABLE `eva_units` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pilot_medical`
--

DROP TABLE IF EXISTS `pilot_medical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pilot_medical` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `pilot_id` varchar(10) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `heart_rate_avg` int(11) DEFAULT NULL,
  `neural_stress` decimal(5,2) DEFAULT NULL,
  `recovery_hours` decimal(5,2) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `record_date` datetime NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `fk_medical_pilot` (`pilot_id`),
  KEY `fk_medical_session` (`session_id`),
  CONSTRAINT `fk_medical_pilot` FOREIGN KEY (`pilot_id`) REFERENCES `pilots` (`pilot_id`),
  CONSTRAINT `fk_medical_session` FOREIGN KEY (`session_id`) REFERENCES `sync_sessions` (`session_id`),
  CONSTRAINT `chk_neural_stress` CHECK (`neural_stress` is null or `neural_stress` between 0 and 100)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilot_medical`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pilot_medical` WRITE;
/*!40000 ALTER TABLE `pilot_medical` DISABLE KEYS */;
INSERT INTO `pilot_medical` VALUES
(1,'PILOT-001',1,170,70.11,19.15,'Caso crítico! Reposo obligatorio.','2025-03-04 17:36:00'),
(2,'PILOT-001',3,73,31.56,4.81,'Sin complicaciones','2025-03-16 17:10:00'),
(3,'PILOT-001',4,70,5.67,3.29,'Sin complicaciones','2025-03-17 08:38:00'),
(4,'PILOT-001',5,98,19.81,6.66,'Sin complicaciones','2025-03-23 18:17:00'),
(5,'PILOT-001',6,72,6.67,4.52,'Sin complicaciones','2025-04-14 07:14:00'),
(6,'PILOT-001',7,94,7.20,7.02,'Sin complicaciones','2025-04-17 12:58:00'),
(7,'PILOT-001',8,99,5.58,5.09,'Sin complicaciones','2025-04-19 20:09:00'),
(8,'PILOT-001',9,74,15.19,2.01,'Sin complicaciones','2025-04-22 19:57:00'),
(9,'PILOT-001',10,91,11.56,6.01,'Sin complicaciones','2025-05-03 21:05:00'),
(10,'PILOT-001',11,111,42.03,13.26,'Sesión interrumpida.','2025-05-19 19:38:00'),
(11,'PILOT-001',12,97,24.40,4.34,'Sin complicaciones','2025-05-21 14:35:00'),
(12,'PILOT-001',13,160,78.54,29.20,'Caso crítico! Reposo obligatorio.','2025-06-10 16:07:00'),
(13,'PILOT-001',14,87,32.60,4.07,'Sin complicaciones','2025-06-19 14:32:00'),
(14,'PILOT-001',15,71,32.00,6.41,'Sin complicaciones','2025-06-20 15:53:00'),
(15,'PILOT-001',16,67,17.33,4.03,'Sin complicaciones','2025-06-21 11:34:00'),
(16,'PILOT-001',17,94,39.33,4.87,'Sin complicaciones','2025-06-28 09:59:00'),
(17,'PILOT-001',18,73,7.21,6.66,'Sin complicaciones','2025-07-14 08:05:00'),
(18,'PILOT-001',19,109,46.05,15.91,'Sesión interrumpida.','2025-07-21 21:35:00'),
(19,'PILOT-001',21,84,23.04,7.93,'Sin complicaciones','2025-08-22 18:42:00'),
(20,'PILOT-001',22,81,6.28,5.88,'Sin complicaciones','2025-08-24 13:14:00'),
(21,'PILOT-001',23,68,35.30,3.99,'Sin complicaciones','2025-08-31 13:00:00'),
(22,'PILOT-001',24,111,53.11,12.00,'Sesión interrumpida.','2025-09-11 16:04:00'),
(23,'PILOT-001',25,89,16.87,3.12,'Sin complicaciones','2025-10-01 10:46:00'),
(24,'PILOT-001',26,88,37.35,5.12,'Sin complicaciones','2025-10-03 19:12:00'),
(25,'PILOT-001',27,92,7.76,5.61,'Sin complicaciones','2025-10-16 20:55:00'),
(26,'PILOT-001',28,99,15.28,2.62,'Sin complicaciones','2025-10-22 07:25:00'),
(27,'PILOT-001',29,83,15.73,5.62,'Sin complicaciones','2025-11-14 12:34:00'),
(28,'PILOT-001',30,93,17.30,2.25,'Sin complicaciones','2025-11-30 08:28:00'),
(29,'PILOT-001',32,92,14.61,7.88,'Sin complicaciones','2025-12-13 07:10:00'),
(30,'PILOT-001',34,90,17.72,6.81,'Sin complicaciones','2025-12-28 21:09:00'),
(31,'PILOT-001',35,66,10.00,5.65,'Sin complicaciones','2026-01-03 07:47:00'),
(32,'PILOT-001',36,67,9.42,3.42,'Sin complicaciones','2026-01-04 11:03:00'),
(33,'PILOT-001',37,88,18.40,5.40,'Sin complicaciones','2026-01-27 13:25:00'),
(34,'PILOT-001',38,93,38.21,4.23,'Sin complicaciones','2026-02-10 08:26:00'),
(35,'PILOT-001',39,73,23.53,4.39,'Sin complicaciones','2026-02-21 12:42:00'),
(36,'PILOT-001',40,80,38.62,2.16,'Sin complicaciones','2026-02-23 15:29:00'),
(37,'PILOT-002',41,98,18.54,5.37,'Sin complicaciones','2025-03-05 07:05:00'),
(38,'PILOT-002',42,81,29.64,3.29,'Sin complicaciones','2025-04-05 10:40:00'),
(39,'PILOT-002',43,96,12.01,2.81,'Sin complicaciones','2025-04-07 06:07:00'),
(40,'PILOT-002',44,76,36.45,4.67,'Sin complicaciones','2025-04-21 10:27:00'),
(41,'PILOT-002',45,85,28.37,6.26,'Sin complicaciones','2025-04-23 07:57:00'),
(42,'PILOT-002',46,83,36.20,7.11,'Sin complicaciones','2025-04-24 19:39:00'),
(43,'PILOT-002',47,76,32.78,5.05,'Sin complicaciones','2025-04-29 11:56:00'),
(44,'PILOT-002',48,77,32.72,3.42,'Sin complicaciones','2025-05-07 19:51:00'),
(45,'PILOT-002',49,88,24.39,4.21,'Sin complicaciones','2025-05-08 09:24:00'),
(46,'PILOT-002',50,100,9.54,7.31,'Sin complicaciones','2025-05-19 17:19:00'),
(47,'PILOT-002',51,90,39.99,6.31,'Sin complicaciones','2025-05-20 12:25:00'),
(48,'PILOT-002',52,169,79.33,35.25,'Caso crítico! Reposo obligatorio.','2025-06-13 18:43:00'),
(49,'PILOT-002',53,140,87.48,31.50,'Caso crítico! Reposo obligatorio.','2025-06-16 14:02:00'),
(50,'PILOT-002',54,87,9.49,6.97,'Sin complicaciones','2025-06-18 19:38:00'),
(51,'PILOT-002',55,76,31.87,2.77,'Sin complicaciones','2025-07-04 07:45:00'),
(52,'PILOT-002',56,68,34.10,5.11,'Sin complicaciones','2025-07-14 12:23:00'),
(53,'PILOT-002',57,75,16.29,6.26,'Sin complicaciones','2025-07-18 16:42:00'),
(54,'PILOT-002',58,98,36.32,7.08,'Sin complicaciones','2025-07-23 19:20:00'),
(55,'PILOT-002',59,100,14.61,5.75,'Sin complicaciones','2025-07-24 18:43:00'),
(56,'PILOT-002',60,70,22.59,3.01,'Sin complicaciones','2025-08-01 06:19:00'),
(57,'PILOT-002',62,86,34.49,5.38,'Sin complicaciones','2025-08-23 11:42:00'),
(58,'PILOT-002',63,66,7.84,7.69,'Sin complicaciones','2025-08-26 08:52:00'),
(59,'PILOT-002',64,81,27.79,6.60,'Sin complicaciones','2025-09-06 10:01:00'),
(60,'PILOT-002',65,66,22.43,5.76,'Sin complicaciones','2025-10-11 08:29:00'),
(61,'PILOT-002',66,84,21.90,6.83,'Sin complicaciones','2025-10-21 21:25:00'),
(62,'PILOT-002',67,84,20.87,6.13,'Sin complicaciones','2025-11-15 09:49:00'),
(63,'PILOT-002',68,91,21.95,3.22,'Sin complicaciones','2025-11-26 20:03:00'),
(64,'PILOT-002',69,85,35.15,3.92,'Sin complicaciones','2025-12-01 20:42:00'),
(65,'PILOT-002',71,90,9.58,4.22,'Sin complicaciones','2025-12-09 20:57:00'),
(66,'PILOT-002',72,85,13.46,2.74,'Sin complicaciones','2025-12-14 13:53:00'),
(67,'PILOT-002',73,74,8.39,3.74,'Sin complicaciones','2026-01-04 13:17:00'),
(68,'PILOT-002',74,91,13.69,7.19,'Sin complicaciones','2026-01-08 16:57:00'),
(69,'PILOT-002',75,85,37.68,6.33,'Sin complicaciones','2026-01-13 10:45:00'),
(70,'PILOT-002',76,75,22.44,5.09,'Sin complicaciones','2026-01-29 19:03:00'),
(71,'PILOT-002',77,84,22.41,2.54,'Sin complicaciones','2026-02-03 06:54:00'),
(72,'PILOT-002',78,94,38.83,3.29,'Sin complicaciones','2026-02-05 15:48:00'),
(73,'PILOT-002',79,68,14.85,5.59,'Sin complicaciones','2026-02-15 13:31:00'),
(74,'PILOT-002',80,95,15.00,2.05,'Sin complicaciones','2026-02-24 18:46:00'),
(75,'PILOT-003',81,73,35.89,6.37,'Sin complicaciones','2025-03-10 09:36:00'),
(76,'PILOT-003',82,88,6.58,2.31,'Sin complicaciones','2025-03-11 09:49:00'),
(77,'PILOT-003',83,88,24.36,2.44,'Sin complicaciones','2025-03-14 15:36:00'),
(78,'PILOT-003',84,100,14.79,7.93,'Sin complicaciones','2025-03-16 08:37:00'),
(79,'PILOT-003',85,127,69.50,20.90,'Caso crítico! Reposo obligatorio.','2025-03-21 09:50:00'),
(80,'PILOT-003',86,86,24.52,4.19,'Sin complicaciones','2025-03-26 17:04:00'),
(81,'PILOT-003',87,158,82.82,33.00,'Caso crítico! Reposo obligatorio.','2025-03-27 09:27:00'),
(82,'PILOT-003',88,73,29.98,6.82,'Sin complicaciones','2025-04-05 19:11:00'),
(83,'PILOT-003',89,74,26.22,5.09,'Sin complicaciones','2025-04-11 21:29:00'),
(84,'PILOT-003',90,85,10.69,7.94,'Sin complicaciones','2025-04-12 08:17:00'),
(85,'PILOT-003',91,84,25.78,5.04,'Sin complicaciones','2025-05-05 18:21:00'),
(86,'PILOT-003',92,96,29.81,3.80,'Sin complicaciones','2025-05-09 17:51:00'),
(87,'PILOT-003',93,88,16.59,2.66,'Sin complicaciones','2025-06-02 14:35:00'),
(88,'PILOT-003',94,84,32.89,6.35,'Sin complicaciones','2025-06-11 19:31:00'),
(89,'PILOT-003',95,66,25.89,3.59,'Sin complicaciones','2025-06-17 21:28:00'),
(90,'PILOT-003',96,79,30.25,5.50,'Sin complicaciones','2025-06-23 13:19:00'),
(91,'PILOT-003',97,89,10.17,6.08,'Sin complicaciones','2025-07-05 19:47:00'),
(92,'PILOT-003',98,72,11.68,4.65,'Sin complicaciones','2025-07-08 14:14:00'),
(93,'PILOT-003',99,91,29.17,4.46,'Sin complicaciones','2025-07-12 11:12:00'),
(94,'PILOT-003',100,95,35.55,6.42,'Sin complicaciones','2025-07-21 15:06:00'),
(95,'PILOT-003',101,73,23.15,5.37,'Sin complicaciones','2025-08-15 10:17:00'),
(96,'PILOT-003',103,89,15.98,3.04,'Sin complicaciones','2025-08-27 11:03:00'),
(97,'PILOT-003',105,87,28.66,7.21,'Sin complicaciones','2025-09-18 15:05:00'),
(98,'PILOT-003',106,81,26.35,3.15,'Sin complicaciones','2025-10-02 13:49:00'),
(99,'PILOT-003',107,100,15.45,7.65,'Sin complicaciones','2025-10-06 19:19:00'),
(100,'PILOT-003',109,122,46.22,15.05,'Sesión interrumpida.','2025-10-23 08:10:00'),
(101,'PILOT-003',110,87,24.62,7.61,'Sin complicaciones','2025-10-26 07:14:00'),
(102,'PILOT-003',111,83,9.27,6.06,'Sin complicaciones','2025-10-27 13:59:00'),
(103,'PILOT-003',112,90,33.64,7.73,'Sin complicaciones','2025-11-29 12:27:00'),
(104,'PILOT-003',113,83,6.47,7.73,'Sin complicaciones','2025-12-02 10:04:00'),
(105,'PILOT-003',114,93,27.96,6.48,'Sin complicaciones','2025-12-14 15:28:00'),
(106,'PILOT-003',115,99,14.49,5.37,'Sin complicaciones','2025-12-29 14:32:00'),
(107,'PILOT-003',116,103,58.47,13.87,'Sesión interrumpida.','2026-01-13 16:38:00'),
(108,'PILOT-003',117,98,12.90,3.40,'Sin complicaciones','2026-01-24 06:48:00'),
(109,'PILOT-003',118,110,61.52,9.01,'Sesión interrumpida.','2026-01-27 20:58:00'),
(110,'PILOT-003',119,65,38.76,7.87,'Sin complicaciones','2026-01-28 21:05:00'),
(111,'PILOT-003',120,95,21.71,3.20,'Sin complicaciones','2026-02-03 11:21:00'),
(112,'PILOT-004',122,68,36.78,2.54,'Sin complicaciones','2025-05-13 19:03:00'),
(113,'PILOT-004',123,99,30.85,7.10,'Sin complicaciones','2025-06-11 20:48:00'),
(114,'PILOT-004',124,76,19.63,7.03,'Sin complicaciones','2025-06-25 20:56:00'),
(115,'PILOT-004',126,126,51.91,12.95,'Sesión interrumpida.','2025-07-19 09:41:00'),
(116,'PILOT-005',131,71,37.50,4.01,'Sin complicaciones','2025-04-08 18:29:00'),
(117,'PILOT-005',132,99,23.35,7.34,'Sin complicaciones','2025-05-02 19:02:00'),
(118,'PILOT-005',133,97,21.38,3.16,'Sin complicaciones','2025-05-14 18:42:00'),
(119,'PILOT-005',134,75,30.59,5.89,'Sin complicaciones','2025-05-15 16:55:00'),
(120,'PILOT-005',135,120,90.78,41.72,'Caso crítico! Reposo obligatorio.','2025-05-24 10:26:00'),
(121,'PILOT-006',136,77,11.14,7.14,'Sin complicaciones','2025-03-15 19:36:00'),
(122,'PILOT-006',138,97,16.48,4.40,'Sin complicaciones','2025-03-24 20:40:00'),
(123,'PILOT-006',139,73,21.71,7.61,'Sin complicaciones','2025-03-29 20:57:00'),
(124,'PILOT-006',140,89,13.24,6.52,'Sin complicaciones','2025-04-05 17:37:00'),
(125,'PILOT-006',142,65,14.15,4.16,'Sin complicaciones','2025-04-11 15:44:00'),
(126,'PILOT-006',143,72,21.29,2.96,'Sin complicaciones','2025-04-16 06:36:00'),
(127,'PILOT-006',144,84,29.16,5.83,'Sin complicaciones','2025-04-20 21:53:00'),
(128,'PILOT-006',146,79,12.67,2.80,'Sin complicaciones','2025-05-19 10:40:00'),
(129,'PILOT-006',147,88,19.55,5.30,'Sin complicaciones','2025-05-25 17:46:00'),
(130,'PILOT-006',148,99,33.07,6.95,'Sin complicaciones','2025-06-25 11:12:00'),
(131,'PILOT-006',149,70,23.39,5.17,'Sin complicaciones','2025-06-29 14:53:00'),
(132,'PILOT-006',150,72,7.16,5.29,'Sin complicaciones','2025-07-14 15:47:00'),
(133,'PILOT-006',151,99,10.24,3.97,'Sin complicaciones','2025-07-26 13:55:00'),
(134,'PILOT-006',152,72,28.81,6.30,'Sin complicaciones','2025-08-01 17:05:00'),
(135,'PILOT-006',153,97,20.59,2.33,'Sin complicaciones','2025-08-10 17:43:00'),
(136,'PILOT-006',154,91,20.99,2.35,'Sin complicaciones','2025-08-14 17:06:00'),
(137,'PILOT-006',155,139,90.31,29.88,'Caso crítico! Reposo obligatorio.','2025-08-16 13:41:00'),
(138,'PILOT-006',156,78,25.24,2.27,'Sin complicaciones','2025-08-21 19:07:00'),
(139,'PILOT-006',157,124,83.94,19.81,'Caso crítico! Reposo obligatorio.','2025-09-11 13:56:00'),
(140,'PILOT-006',160,138,79.31,41.07,'Caso crítico! Reposo obligatorio.','2025-10-14 20:15:00'),
(141,'PILOT-006',161,91,18.11,7.35,'Sin complicaciones','2025-10-27 17:03:00'),
(142,'PILOT-006',162,89,18.15,6.10,'Sin complicaciones','2025-11-05 20:05:00'),
(143,'PILOT-006',163,99,9.65,7.16,'Sin complicaciones','2025-11-29 07:50:00'),
(144,'PILOT-006',164,117,51.79,9.27,'Sesión interrumpida.','2025-12-03 12:37:00'),
(145,'PILOT-006',166,66,39.25,4.78,'Sin complicaciones','2026-01-14 06:08:00'),
(146,'PILOT-006',167,92,23.62,6.94,'Sin complicaciones','2026-01-15 06:11:00'),
(147,'PILOT-006',168,87,10.43,3.13,'Sin complicaciones','2026-01-18 08:30:00'),
(148,'PILOT-006',170,67,33.33,4.52,'Sin complicaciones','2026-01-27 15:29:00'),
(149,'PILOT-006',171,66,13.42,2.40,'Sin complicaciones','2026-02-09 19:43:00'),
(150,'PILOT-006',172,93,25.92,6.22,'Sin complicaciones','2026-02-14 08:20:00'),
(151,'PILOT-006',173,167,66.55,31.17,'Caso crítico! Reposo obligatorio.','2026-02-18 15:29:00'),
(152,'PILOT-006',174,124,65.91,8.56,'Sesión interrumpida.','2026-02-19 12:27:00'),
(153,'PILOT-006',175,83,13.20,7.50,'Sin complicaciones','2026-02-24 19:46:00'),
(154,'PILOT-007',176,85,13.29,7.26,'Sin complicaciones','2025-03-18 17:51:00'),
(155,'PILOT-007',178,91,15.52,2.37,'Sin complicaciones','2025-04-09 19:55:00'),
(156,'PILOT-007',182,92,24.45,2.28,'Sin complicaciones','2025-06-18 06:38:00'),
(157,'PILOT-007',183,161,88.50,41.57,'Caso crítico! Reposo obligatorio.','2025-06-30 15:58:00'),
(158,'PILOT-007',184,91,19.29,3.80,'Sin complicaciones','2025-08-18 18:04:00'),
(159,'PILOT-007',185,99,21.57,7.10,'Sin complicaciones','2025-08-23 12:24:00'),
(160,'PILOT-008',186,74,33.20,7.49,'Sin complicaciones','2025-03-24 10:48:00'),
(161,'PILOT-008',187,146,84.51,22.02,'Caso crítico! Reposo obligatorio.','2025-03-26 11:08:00'),
(162,'PILOT-008',188,78,16.56,2.47,'Sin complicaciones','2025-03-27 17:04:00'),
(163,'PILOT-008',189,88,8.24,6.35,'Sin complicaciones','2025-03-29 08:55:00'),
(164,'PILOT-008',190,82,18.20,5.63,'Sin complicaciones','2025-04-11 19:18:00'),
(165,'PILOT-008',191,69,11.59,6.57,'Sin complicaciones','2025-04-13 20:53:00'),
(166,'PILOT-008',192,100,12.60,3.25,'Sin complicaciones','2025-04-26 19:37:00'),
(167,'PILOT-008',194,129,40.46,17.37,'Sesión interrumpida.','2025-05-19 12:57:00'),
(168,'PILOT-008',196,95,37.01,6.17,'Sin complicaciones','2025-06-19 08:11:00'),
(169,'PILOT-008',197,90,37.03,5.31,'Sin complicaciones','2025-06-21 20:43:00'),
(170,'PILOT-008',198,89,21.32,5.89,'Sin complicaciones','2025-07-18 16:09:00'),
(171,'PILOT-008',199,88,22.95,4.98,'Sin complicaciones','2025-07-24 14:37:00'),
(172,'PILOT-008',200,166,81.43,43.19,'Caso crítico! Reposo obligatorio.','2025-08-05 07:23:00'),
(173,'PILOT-008',202,91,6.60,7.18,'Sin complicaciones','2025-08-14 20:58:00'),
(174,'PILOT-008',203,66,14.13,7.61,'Sin complicaciones','2025-08-22 10:03:00'),
(175,'PILOT-008',204,91,15.33,3.18,'Sin complicaciones','2025-08-24 08:32:00'),
(176,'PILOT-008',205,80,22.48,5.93,'Sin complicaciones','2025-09-06 20:33:00'),
(177,'PILOT-008',206,81,31.72,4.93,'Sin complicaciones','2025-09-19 18:26:00'),
(178,'PILOT-008',207,96,21.13,6.40,'Sin complicaciones','2025-09-29 16:04:00'),
(179,'PILOT-008',208,73,30.21,4.93,'Sin complicaciones','2025-10-04 10:21:00'),
(180,'PILOT-008',210,161,98.50,33.72,'Caso crítico! Reposo obligatorio.','2025-10-13 16:52:00'),
(181,'PILOT-008',211,69,38.08,6.01,'Sin complicaciones','2025-10-19 08:41:00'),
(182,'PILOT-008',212,91,9.81,5.78,'Sin complicaciones','2025-11-04 11:13:00'),
(183,'PILOT-008',213,74,5.32,5.03,'Sin complicaciones','2025-11-05 10:04:00'),
(184,'PILOT-008',214,95,28.07,2.09,'Sin complicaciones','2025-11-18 07:42:00'),
(185,'PILOT-008',215,146,65.41,33.88,'Caso crítico! Reposo obligatorio.','2025-11-25 11:53:00'),
(186,'PILOT-008',216,83,5.60,6.88,'Sin complicaciones','2025-12-16 20:02:00'),
(187,'PILOT-008',217,76,8.75,2.58,'Sin complicaciones','2025-12-29 15:48:00'),
(188,'PILOT-008',218,77,26.69,3.51,'Sin complicaciones','2025-12-31 21:57:00'),
(189,'PILOT-008',219,90,7.77,7.76,'Sin complicaciones','2026-01-01 20:49:00'),
(190,'PILOT-008',220,80,39.66,3.36,'Sin complicaciones','2026-01-05 11:52:00'),
(191,'PILOT-008',221,70,27.88,7.15,'Sin complicaciones','2026-01-11 21:55:00'),
(192,'PILOT-008',222,102,52.16,11.77,'Sesión interrumpida.','2026-02-02 11:17:00'),
(193,'PILOT-008',223,65,29.60,2.50,'Sin complicaciones','2026-02-05 13:52:00'),
(194,'PILOT-008',224,86,24.80,7.15,'Sin complicaciones','2026-02-09 17:15:00'),
(195,'PILOT-008',225,98,37.17,3.38,'Sin complicaciones','2026-02-11 09:53:00');
/*!40000 ALTER TABLE `pilot_medical` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pilots`
--

DROP TABLE IF EXISTS `pilots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pilots` (
  `pilot_id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `status` varchar(20) NOT NULL CHECK (`status` in ('active','inactive','suspended')),
  `assigned_unit` varchar(10) DEFAULT NULL,
  `recruitment_date` date NOT NULL,
  PRIMARY KEY (`pilot_id`),
  KEY `fk_pilot_unit` (`assigned_unit`),
  CONSTRAINT `fk_pilot_unit` FOREIGN KEY (`assigned_unit`) REFERENCES `eva_units` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilots`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pilots` WRITE;
/*!40000 ALTER TABLE `pilots` DISABLE KEYS */;
INSERT INTO `pilots` VALUES
('PILOT-001','Carlos Muñoz',17,'active','EVA-01','2025-03-01'),
('PILOT-002','Valentina Peña',20,'active','EVA-00','2025-03-15'),
('PILOT-003','Diego Fernández',18,'active','EVA-02','2025-04-01'),
('PILOT-004','Sofía Herrera',17,'inactive','EVA-03','2025-05-10'),
('PILOT-005','Matías Contreras',19,'suspended','EVA-04','2025-06-01'),
('PILOT-006','Camila Torres',16,'active','EVA-05','2025-04-20'),
('PILOT-007','Tomás Vargas',32,'inactive','EVA-03','2025-07-01'),
('PILOT-008','Isidora Pizarro',17,'active','EVA-01','2025-02-01');
/*!40000 ALTER TABLE `pilots` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `sync_sessions`
--

DROP TABLE IF EXISTS `sync_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_sessions` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `pilot_id` varchar(10) NOT NULL,
  `unit_id` varchar(10) NOT NULL,
  `sync_rate` decimal(5,2) NOT NULL,
  `session_date` datetime NOT NULL,
  `duration_min` int(11) NOT NULL,
  `mental_contamination` decimal(5,2) DEFAULT 0.00,
  `status` varchar(20) NOT NULL CHECK (`status` in ('completed','aborted','critical')),
  PRIMARY KEY (`session_id`),
  KEY `fk_session_pilot` (`pilot_id`),
  KEY `fk_session_unit` (`unit_id`),
  CONSTRAINT `fk_session_pilot` FOREIGN KEY (`pilot_id`) REFERENCES `pilots` (`pilot_id`),
  CONSTRAINT `fk_session_unit` FOREIGN KEY (`unit_id`) REFERENCES `eva_units` (`unit_id`),
  CONSTRAINT `chk_sync_rate` CHECK (`sync_rate` between 0 and 100),
  CONSTRAINT `chk_mental_contamination` CHECK (`mental_contamination` between 0 and 100)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_sessions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `sync_sessions` WRITE;
/*!40000 ALTER TABLE `sync_sessions` DISABLE KEYS */;
INSERT INTO `sync_sessions` VALUES
(1,'PILOT-001','EVA-04',7.88,'2025-03-04 17:36:00',39,83.18,'critical'),
(2,'PILOT-001','EVA-01',4.58,'2025-03-14 08:54:00',44,80.92,'aborted'),
(3,'PILOT-001','EVA-04',27.80,'2025-03-16 17:10:00',62,25.43,'completed'),
(4,'PILOT-001','EVA-01',67.02,'2025-03-17 08:38:00',96,28.07,'completed'),
(5,'PILOT-001','EVA-01',72.91,'2025-03-23 18:17:00',96,6.54,'completed'),
(6,'PILOT-001','EVA-01',21.96,'2025-04-14 07:14:00',120,12.97,'completed'),
(7,'PILOT-001','EVA-01',31.55,'2025-04-17 12:58:00',87,10.71,'completed'),
(8,'PILOT-001','EVA-03',21.26,'2025-04-19 20:09:00',48,19.97,'completed'),
(9,'PILOT-001','EVA-01',74.50,'2025-04-22 19:57:00',89,21.56,'completed'),
(10,'PILOT-001','EVA-01',21.93,'2025-05-03 21:05:00',111,39.90,'completed'),
(11,'PILOT-001','EVA-01',10.96,'2025-05-19 19:38:00',23,81.68,'aborted'),
(12,'PILOT-001','EVA-01',59.59,'2025-05-21 14:35:00',16,18.72,'completed'),
(13,'PILOT-001','EVA-01',11.46,'2025-06-10 16:07:00',52,80.74,'critical'),
(14,'PILOT-001','EVA-01',45.37,'2025-06-19 14:32:00',112,38.15,'completed'),
(15,'PILOT-001','EVA-01',91.26,'2025-06-20 15:53:00',96,34.82,'completed'),
(16,'PILOT-001','EVA-01',19.89,'2025-06-21 11:34:00',114,14.96,'completed'),
(17,'PILOT-001','EVA-00',59.89,'2025-06-28 09:59:00',61,19.54,'completed'),
(18,'PILOT-001','EVA-03',23.95,'2025-07-14 08:05:00',108,9.63,'completed'),
(19,'PILOT-001','EVA-01',6.92,'2025-07-21 21:35:00',36,55.14,'aborted'),
(20,'PILOT-001','EVA-01',87.24,'2025-08-20 12:59:00',84,16.93,'completed'),
(21,'PILOT-001','EVA-01',68.99,'2025-08-22 18:42:00',98,28.52,'completed'),
(22,'PILOT-001','EVA-01',89.96,'2025-08-24 13:14:00',23,18.06,'completed'),
(23,'PILOT-001','EVA-01',58.83,'2025-08-31 13:00:00',24,9.20,'completed'),
(24,'PILOT-001','EVA-01',5.89,'2025-09-11 16:04:00',80,86.22,'aborted'),
(25,'PILOT-001','EVA-01',66.90,'2025-10-01 10:46:00',88,8.57,'completed'),
(26,'PILOT-001','EVA-01',24.30,'2025-10-03 19:12:00',27,18.92,'completed'),
(27,'PILOT-001','EVA-01',43.11,'2025-10-16 20:55:00',108,16.94,'completed'),
(28,'PILOT-001','EVA-01',65.35,'2025-10-22 07:25:00',108,25.85,'completed'),
(29,'PILOT-001','EVA-01',86.17,'2025-11-14 12:34:00',72,9.95,'completed'),
(30,'PILOT-001','EVA-01',18.35,'2025-11-30 08:28:00',118,18.51,'completed'),
(31,'PILOT-001','EVA-05',9.79,'2025-12-05 13:10:00',67,88.76,'aborted'),
(32,'PILOT-001','EVA-01',21.37,'2025-12-13 07:10:00',63,16.04,'completed'),
(33,'PILOT-001','EVA-01',39.04,'2025-12-27 20:18:00',69,37.06,'completed'),
(34,'PILOT-001','EVA-01',73.05,'2025-12-28 21:09:00',39,31.33,'completed'),
(35,'PILOT-001','EVA-01',96.87,'2026-01-03 07:47:00',55,23.17,'completed'),
(36,'PILOT-001','EVA-01',58.42,'2026-01-04 11:03:00',80,20.11,'completed'),
(37,'PILOT-001','EVA-01',18.58,'2026-01-27 13:25:00',30,23.80,'completed'),
(38,'PILOT-001','EVA-05',24.62,'2026-02-10 08:26:00',99,23.78,'completed'),
(39,'PILOT-001','EVA-01',52.28,'2026-02-21 12:42:00',106,37.39,'completed'),
(40,'PILOT-001','EVA-01',26.56,'2026-02-23 15:29:00',55,5.24,'completed'),
(41,'PILOT-002','EVA-00',26.40,'2025-03-05 07:05:00',96,19.54,'completed'),
(42,'PILOT-002','EVA-00',27.67,'2025-04-05 10:40:00',48,0.14,'completed'),
(43,'PILOT-002','EVA-00',44.18,'2025-04-07 06:07:00',24,28.23,'completed'),
(44,'PILOT-002','EVA-02',54.56,'2025-04-21 10:27:00',31,33.38,'completed'),
(45,'PILOT-002','EVA-00',36.47,'2025-04-23 07:57:00',60,37.32,'completed'),
(46,'PILOT-002','EVA-00',24.95,'2025-04-24 19:39:00',110,4.11,'completed'),
(47,'PILOT-002','EVA-00',92.99,'2025-04-29 11:56:00',67,34.58,'completed'),
(48,'PILOT-002','EVA-00',73.66,'2025-05-07 19:51:00',100,13.29,'completed'),
(49,'PILOT-002','EVA-02',26.68,'2025-05-08 09:24:00',19,31.49,'completed'),
(50,'PILOT-002','EVA-02',19.96,'2025-05-19 17:19:00',120,36.74,'completed'),
(51,'PILOT-002','EVA-00',22.76,'2025-05-20 12:25:00',57,0.95,'completed'),
(52,'PILOT-002','EVA-00',6.94,'2025-06-13 18:43:00',83,64.05,'critical'),
(53,'PILOT-002','EVA-00',2.76,'2025-06-16 14:02:00',28,57.14,'critical'),
(54,'PILOT-002','EVA-00',34.57,'2025-06-18 19:38:00',80,31.46,'completed'),
(55,'PILOT-002','EVA-00',89.95,'2025-07-04 07:45:00',70,7.60,'completed'),
(56,'PILOT-002','EVA-00',92.56,'2025-07-14 12:23:00',70,21.54,'completed'),
(57,'PILOT-002','EVA-00',66.42,'2025-07-18 16:42:00',30,13.21,'completed'),
(58,'PILOT-002','EVA-00',30.03,'2025-07-23 19:20:00',66,12.37,'completed'),
(59,'PILOT-002','EVA-00',55.44,'2025-07-24 18:43:00',110,7.67,'completed'),
(60,'PILOT-002','EVA-05',56.91,'2025-08-01 06:19:00',51,16.24,'completed'),
(61,'PILOT-002','EVA-00',78.58,'2025-08-02 16:29:00',71,24.27,'completed'),
(62,'PILOT-002','EVA-00',21.37,'2025-08-23 11:42:00',25,18.93,'completed'),
(63,'PILOT-002','EVA-00',66.39,'2025-08-26 08:52:00',111,24.77,'completed'),
(64,'PILOT-002','EVA-00',31.04,'2025-09-06 10:01:00',20,32.26,'completed'),
(65,'PILOT-002','EVA-00',47.51,'2025-10-11 08:29:00',68,33.99,'completed'),
(66,'PILOT-002','EVA-05',19.44,'2025-10-21 21:25:00',46,27.85,'completed'),
(67,'PILOT-002','EVA-00',68.76,'2025-11-15 09:49:00',69,35.71,'completed'),
(68,'PILOT-002','EVA-00',80.41,'2025-11-26 20:03:00',86,27.84,'completed'),
(69,'PILOT-002','EVA-00',84.83,'2025-12-01 20:42:00',82,18.26,'completed'),
(70,'PILOT-002','EVA-05',31.73,'2025-12-04 20:39:00',119,30.21,'completed'),
(71,'PILOT-002','EVA-00',50.48,'2025-12-09 20:57:00',35,33.22,'completed'),
(72,'PILOT-002','EVA-00',47.47,'2025-12-14 13:53:00',96,10.37,'completed'),
(73,'PILOT-002','EVA-00',77.77,'2026-01-04 13:17:00',71,19.38,'completed'),
(74,'PILOT-002','EVA-00',28.57,'2026-01-08 16:57:00',84,10.87,'completed'),
(75,'PILOT-002','EVA-00',15.08,'2026-01-13 10:45:00',42,15.32,'completed'),
(76,'PILOT-002','EVA-00',40.76,'2026-01-29 19:03:00',41,21.70,'completed'),
(77,'PILOT-002','EVA-04',90.48,'2026-02-03 06:54:00',112,23.36,'completed'),
(78,'PILOT-002','EVA-00',47.70,'2026-02-05 15:48:00',64,37.71,'completed'),
(79,'PILOT-002','EVA-04',53.82,'2026-02-15 13:31:00',43,29.39,'completed'),
(80,'PILOT-002','EVA-00',48.56,'2026-02-24 18:46:00',36,15.55,'completed'),
(81,'PILOT-003','EVA-02',23.85,'2025-03-10 09:36:00',42,18.94,'completed'),
(82,'PILOT-003','EVA-02',25.62,'2025-03-11 09:49:00',119,14.76,'completed'),
(83,'PILOT-003','EVA-02',31.10,'2025-03-14 15:36:00',101,23.15,'completed'),
(84,'PILOT-003','EVA-04',39.67,'2025-03-16 08:37:00',103,28.60,'completed'),
(85,'PILOT-003','EVA-01',10.19,'2025-03-21 09:50:00',87,84.01,'critical'),
(86,'PILOT-003','EVA-02',34.72,'2025-03-26 17:04:00',79,17.14,'completed'),
(87,'PILOT-003','EVA-02',1.27,'2025-03-27 09:27:00',61,82.89,'critical'),
(88,'PILOT-003','EVA-02',82.87,'2025-04-05 19:11:00',108,28.29,'completed'),
(89,'PILOT-003','EVA-02',65.05,'2025-04-11 21:29:00',70,24.64,'completed'),
(90,'PILOT-003','EVA-05',26.84,'2025-04-12 08:17:00',72,34.07,'completed'),
(91,'PILOT-003','EVA-02',46.47,'2025-05-05 18:21:00',18,24.41,'completed'),
(92,'PILOT-003','EVA-02',32.50,'2025-05-09 17:51:00',48,19.50,'completed'),
(93,'PILOT-003','EVA-02',88.03,'2025-06-02 14:35:00',16,28.05,'completed'),
(94,'PILOT-003','EVA-02',19.11,'2025-06-11 19:31:00',86,9.65,'completed'),
(95,'PILOT-003','EVA-02',69.06,'2025-06-17 21:28:00',116,25.84,'completed'),
(96,'PILOT-003','EVA-02',29.42,'2025-06-23 13:19:00',99,16.18,'completed'),
(97,'PILOT-003','EVA-02',47.33,'2025-07-05 19:47:00',85,21.24,'completed'),
(98,'PILOT-003','EVA-02',70.29,'2025-07-08 14:14:00',30,10.84,'completed'),
(99,'PILOT-003','EVA-02',31.55,'2025-07-12 11:12:00',42,29.72,'completed'),
(100,'PILOT-003','EVA-02',27.65,'2025-07-21 15:06:00',39,23.58,'completed'),
(101,'PILOT-003','EVA-02',36.09,'2025-08-15 10:17:00',20,12.09,'completed'),
(102,'PILOT-003','EVA-05',29.21,'2025-08-20 21:06:00',16,37.76,'completed'),
(103,'PILOT-003','EVA-02',46.94,'2025-08-27 11:03:00',47,17.62,'completed'),
(104,'PILOT-003','EVA-04',11.41,'2025-09-11 08:36:00',95,66.03,'aborted'),
(105,'PILOT-003','EVA-02',15.17,'2025-09-18 15:05:00',46,32.45,'completed'),
(106,'PILOT-003','EVA-02',76.44,'2025-10-02 13:49:00',81,24.25,'completed'),
(107,'PILOT-003','EVA-02',90.85,'2025-10-06 19:19:00',87,11.89,'completed'),
(108,'PILOT-003','EVA-02',60.96,'2025-10-19 12:40:00',42,29.60,'completed'),
(109,'PILOT-003','EVA-02',8.12,'2025-10-23 08:10:00',15,56.95,'aborted'),
(110,'PILOT-003','EVA-02',68.94,'2025-10-26 07:14:00',51,18.80,'completed'),
(111,'PILOT-003','EVA-02',70.30,'2025-10-27 13:59:00',48,18.16,'completed'),
(112,'PILOT-003','EVA-02',62.51,'2025-11-29 12:27:00',29,26.45,'completed'),
(113,'PILOT-003','EVA-02',64.76,'2025-12-02 10:04:00',22,36.34,'completed'),
(114,'PILOT-003','EVA-02',30.76,'2025-12-14 15:28:00',30,29.96,'completed'),
(115,'PILOT-003','EVA-02',30.41,'2025-12-29 14:32:00',84,16.10,'completed'),
(116,'PILOT-003','EVA-02',8.04,'2026-01-13 16:38:00',47,85.58,'aborted'),
(117,'PILOT-003','EVA-02',22.89,'2026-01-24 06:48:00',101,26.97,'completed'),
(118,'PILOT-003','EVA-05',4.02,'2026-01-27 20:58:00',50,68.82,'aborted'),
(119,'PILOT-003','EVA-02',58.53,'2026-01-28 21:05:00',75,25.39,'completed'),
(120,'PILOT-003','EVA-02',33.33,'2026-02-03 11:21:00',67,26.81,'completed'),
(121,'PILOT-004','EVA-03',25.24,'2025-03-10 18:55:00',80,4.64,'completed'),
(122,'PILOT-004','EVA-00',65.77,'2025-05-13 19:03:00',39,21.70,'completed'),
(123,'PILOT-004','EVA-03',62.26,'2025-06-11 20:48:00',21,19.94,'completed'),
(124,'PILOT-004','EVA-03',54.92,'2025-06-25 20:56:00',104,37.11,'completed'),
(125,'PILOT-004','EVA-03',2.89,'2025-07-05 15:35:00',16,78.39,'aborted'),
(126,'PILOT-004','EVA-03',9.32,'2025-07-19 09:41:00',34,68.46,'aborted'),
(127,'PILOT-004','EVA-03',71.66,'2025-08-17 14:26:00',76,20.35,'completed'),
(128,'PILOT-004','EVA-01',45.68,'2025-08-25 12:58:00',91,5.79,'completed'),
(129,'PILOT-004','EVA-03',87.93,'2025-09-11 14:49:00',116,34.56,'completed'),
(130,'PILOT-004','EVA-02',93.42,'2025-09-25 06:18:00',107,20.31,'completed'),
(131,'PILOT-005','EVA-03',53.86,'2025-04-08 18:29:00',56,13.80,'completed'),
(132,'PILOT-005','EVA-01',57.18,'2025-05-02 19:02:00',55,9.34,'completed'),
(133,'PILOT-005','EVA-04',70.52,'2025-05-14 18:42:00',116,32.46,'completed'),
(134,'PILOT-005','EVA-01',49.53,'2025-05-15 16:55:00',27,1.48,'completed'),
(135,'PILOT-005','EVA-03',9.97,'2025-05-24 10:26:00',98,50.61,'critical'),
(136,'PILOT-006','EVA-05',37.48,'2025-03-15 19:36:00',102,5.82,'completed'),
(137,'PILOT-006','EVA-05',17.00,'2025-03-19 18:39:00',102,3.16,'completed'),
(138,'PILOT-006','EVA-05',91.28,'2025-03-24 20:40:00',47,5.72,'completed'),
(139,'PILOT-006','EVA-05',66.68,'2025-03-29 20:57:00',51,35.96,'completed'),
(140,'PILOT-006','EVA-05',15.80,'2025-04-05 17:37:00',53,17.67,'completed'),
(141,'PILOT-006','EVA-05',42.43,'2025-04-08 15:12:00',64,10.00,'completed'),
(142,'PILOT-006','EVA-00',23.72,'2025-04-11 15:44:00',52,22.88,'completed'),
(143,'PILOT-006','EVA-05',83.00,'2025-04-16 06:36:00',102,15.83,'completed'),
(144,'PILOT-006','EVA-05',97.36,'2025-04-20 21:53:00',51,36.42,'completed'),
(145,'PILOT-006','EVA-05',23.01,'2025-04-21 13:40:00',39,32.08,'completed'),
(146,'PILOT-006','EVA-05',67.78,'2025-05-19 10:40:00',27,28.84,'completed'),
(147,'PILOT-006','EVA-00',30.89,'2025-05-25 17:46:00',31,17.63,'completed'),
(148,'PILOT-006','EVA-05',29.51,'2025-06-25 11:12:00',31,29.90,'completed'),
(149,'PILOT-006','EVA-05',87.65,'2025-06-29 14:53:00',36,14.63,'completed'),
(150,'PILOT-006','EVA-05',82.47,'2025-07-14 15:47:00',58,19.27,'completed'),
(151,'PILOT-006','EVA-03',96.29,'2025-07-26 13:55:00',101,5.63,'completed'),
(152,'PILOT-006','EVA-05',97.99,'2025-08-01 17:05:00',116,38.69,'completed'),
(153,'PILOT-006','EVA-05',26.45,'2025-08-10 17:43:00',110,4.94,'completed'),
(154,'PILOT-006','EVA-05',58.46,'2025-08-14 17:06:00',101,32.90,'completed'),
(155,'PILOT-006','EVA-05',2.50,'2025-08-16 13:41:00',23,86.61,'critical'),
(156,'PILOT-006','EVA-05',46.43,'2025-08-21 19:07:00',32,28.04,'completed'),
(157,'PILOT-006','EVA-05',3.72,'2025-09-11 13:56:00',83,54.64,'critical'),
(158,'PILOT-006','EVA-05',45.36,'2025-09-20 19:37:00',110,26.82,'completed'),
(159,'PILOT-006','EVA-05',88.54,'2025-10-09 21:39:00',67,26.20,'completed'),
(160,'PILOT-006','EVA-02',3.27,'2025-10-14 20:15:00',61,58.69,'critical'),
(161,'PILOT-006','EVA-05',68.57,'2025-10-27 17:03:00',65,21.78,'completed'),
(162,'PILOT-006','EVA-05',96.82,'2025-11-05 20:05:00',99,37.96,'completed'),
(163,'PILOT-006','EVA-05',63.95,'2025-11-29 07:50:00',57,38.84,'completed'),
(164,'PILOT-006','EVA-05',12.59,'2025-12-03 12:37:00',42,52.74,'aborted'),
(165,'PILOT-006','EVA-01',32.86,'2026-01-11 06:17:00',33,5.90,'completed'),
(166,'PILOT-006','EVA-04',25.07,'2026-01-14 06:08:00',16,6.98,'completed'),
(167,'PILOT-006','EVA-05',78.84,'2026-01-15 06:11:00',48,23.55,'completed'),
(168,'PILOT-006','EVA-05',74.17,'2026-01-18 08:30:00',72,21.04,'completed'),
(169,'PILOT-006','EVA-05',51.32,'2026-01-19 13:39:00',20,4.36,'completed'),
(170,'PILOT-006','EVA-05',90.88,'2026-01-27 15:29:00',97,26.36,'completed'),
(171,'PILOT-006','EVA-00',99.86,'2026-02-09 19:43:00',28,33.89,'completed'),
(172,'PILOT-006','EVA-05',90.97,'2026-02-14 08:20:00',92,2.94,'completed'),
(173,'PILOT-006','EVA-05',12.62,'2026-02-18 15:29:00',79,65.24,'critical'),
(174,'PILOT-006','EVA-05',9.92,'2026-02-19 12:27:00',72,84.11,'aborted'),
(175,'PILOT-006','EVA-03',33.89,'2026-02-24 19:46:00',27,18.14,'completed'),
(176,'PILOT-007','EVA-00',43.19,'2025-03-18 17:51:00',31,29.78,'completed'),
(177,'PILOT-007','EVA-03',58.65,'2025-03-24 16:42:00',30,22.46,'completed'),
(178,'PILOT-007','EVA-03',87.36,'2025-04-09 19:55:00',107,37.65,'completed'),
(179,'PILOT-007','EVA-03',28.76,'2025-05-05 09:36:00',79,12.50,'completed'),
(180,'PILOT-007','EVA-03',65.67,'2025-05-20 09:22:00',86,8.97,'completed'),
(181,'PILOT-007','EVA-03',76.26,'2025-06-04 19:54:00',86,22.96,'completed'),
(182,'PILOT-007','EVA-05',61.36,'2025-06-18 06:38:00',99,25.71,'completed'),
(183,'PILOT-007','EVA-02',2.90,'2025-06-30 15:58:00',58,78.11,'critical'),
(184,'PILOT-007','EVA-03',18.14,'2025-08-18 18:04:00',33,5.73,'completed'),
(185,'PILOT-007','EVA-03',97.18,'2025-08-23 12:24:00',68,3.67,'completed'),
(186,'PILOT-008','EVA-01',30.14,'2025-03-24 10:48:00',47,8.45,'completed'),
(187,'PILOT-008','EVA-01',12.00,'2025-03-26 11:08:00',63,79.88,'critical'),
(188,'PILOT-008','EVA-01',23.01,'2025-03-27 17:04:00',65,22.35,'completed'),
(189,'PILOT-008','EVA-00',43.62,'2025-03-29 08:55:00',55,18.39,'completed'),
(190,'PILOT-008','EVA-01',57.34,'2025-04-11 19:18:00',29,28.38,'completed'),
(191,'PILOT-008','EVA-01',96.62,'2025-04-13 20:53:00',103,6.87,'completed'),
(192,'PILOT-008','EVA-00',43.67,'2025-04-26 19:37:00',66,4.23,'completed'),
(193,'PILOT-008','EVA-01',39.58,'2025-04-28 16:14:00',57,12.41,'completed'),
(194,'PILOT-008','EVA-01',7.64,'2025-05-19 12:57:00',114,71.22,'aborted'),
(195,'PILOT-008','EVA-01',72.74,'2025-05-20 10:15:00',28,32.76,'completed'),
(196,'PILOT-008','EVA-01',19.73,'2025-06-19 08:11:00',113,24.10,'completed'),
(197,'PILOT-008','EVA-01',46.40,'2025-06-21 20:43:00',87,22.55,'completed'),
(198,'PILOT-008','EVA-01',98.65,'2025-07-18 16:09:00',71,12.93,'completed'),
(199,'PILOT-008','EVA-01',44.22,'2025-07-24 14:37:00',22,12.11,'completed'),
(200,'PILOT-008','EVA-01',7.42,'2025-08-05 07:23:00',51,68.08,'critical'),
(201,'PILOT-008','EVA-01',86.43,'2025-08-07 18:29:00',89,34.21,'completed'),
(202,'PILOT-008','EVA-01',79.18,'2025-08-14 20:58:00',118,35.84,'completed'),
(203,'PILOT-008','EVA-01',18.82,'2025-08-22 10:03:00',72,24.20,'completed'),
(204,'PILOT-008','EVA-01',89.91,'2025-08-24 08:32:00',97,13.74,'completed'),
(205,'PILOT-008','EVA-01',24.77,'2025-09-06 20:33:00',81,17.51,'completed'),
(206,'PILOT-008','EVA-01',36.39,'2025-09-19 18:26:00',114,36.72,'completed'),
(207,'PILOT-008','EVA-01',59.79,'2025-09-29 16:04:00',57,31.57,'completed'),
(208,'PILOT-008','EVA-01',67.84,'2025-10-04 10:21:00',25,11.37,'completed'),
(209,'PILOT-008','EVA-01',14.14,'2025-10-07 18:08:00',91,62.41,'critical'),
(210,'PILOT-008','EVA-01',8.47,'2025-10-13 16:52:00',31,75.74,'critical'),
(211,'PILOT-008','EVA-01',82.90,'2025-10-19 08:41:00',100,29.55,'completed'),
(212,'PILOT-008','EVA-01',36.18,'2025-11-04 11:13:00',58,14.50,'completed'),
(213,'PILOT-008','EVA-04',19.20,'2025-11-05 10:04:00',52,40.00,'completed'),
(214,'PILOT-008','EVA-00',50.77,'2025-11-18 07:42:00',58,21.59,'completed'),
(215,'PILOT-008','EVA-05',13.10,'2025-11-25 11:53:00',103,56.17,'critical'),
(216,'PILOT-008','EVA-01',80.90,'2025-12-16 20:02:00',67,6.62,'completed'),
(217,'PILOT-008','EVA-01',71.96,'2025-12-29 15:48:00',110,38.78,'completed'),
(218,'PILOT-008','EVA-01',23.40,'2025-12-31 21:57:00',39,9.57,'completed'),
(219,'PILOT-008','EVA-01',94.71,'2026-01-01 20:49:00',51,39.38,'completed'),
(220,'PILOT-008','EVA-01',50.29,'2026-01-05 11:52:00',40,16.75,'completed'),
(221,'PILOT-008','EVA-02',87.30,'2026-01-11 21:55:00',62,2.09,'completed'),
(222,'PILOT-008','EVA-01',10.26,'2026-02-02 11:17:00',72,61.40,'aborted'),
(223,'PILOT-008','EVA-02',83.10,'2026-02-05 13:52:00',72,3.67,'completed'),
(224,'PILOT-008','EVA-00',41.49,'2026-02-09 17:15:00',64,15.86,'completed'),
(225,'PILOT-008','EVA-03',22.45,'2026-02-11 09:53:00',106,12.75,'completed');
/*!40000 ALTER TABLE `sync_sessions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-02-17 23:40:41
