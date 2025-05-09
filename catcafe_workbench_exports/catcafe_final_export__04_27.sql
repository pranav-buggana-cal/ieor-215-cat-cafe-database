-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (x86_64)
--
-- Host: localhost    Database: catcafe
-- ------------------------------------------------------
-- Server version	9.3.0-commercial

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adoption_request`
--

DROP TABLE IF EXISTS `adoption_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adoption_request` (
  `adoption_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` bigint unsigned NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `adoption_fee` decimal(10,2) DEFAULT NULL,
  `adoption_date` date DEFAULT NULL,
  `adoption_status` enum('PENDING','APPROVED','REJECTED','RETURNED') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `return_reason` text COLLATE utf8mb4_unicode_ci,
  `payment_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`adoption_id`),
  KEY `cat_id` (`cat_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `adoption_request_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`),
  CONSTRAINT `adoption_request_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adoption_request`
--

LOCK TABLES `adoption_request` WRITE;
/*!40000 ALTER TABLE `adoption_request` DISABLE KEYS */;
INSERT INTO `adoption_request` VALUES (1,19,11,165.42,'2024-09-10','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/297ca4ff-f75d-499f-ab2d-5b0987079ad4'),(2,13,44,181.86,'2025-02-13','RETURNED','2025-04-12','Moving to new home that doesn\'t allow pets','https://catcafe.pay/adoption/0d5ba7cd-4000-45f0-9f7d-0dd7236e1608'),(3,26,33,84.60,'2024-12-12','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/ef2ddcc4-8df6-41da-9f07-c1a5dfc620ce'),(4,21,48,268.53,'2024-06-01','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/1feae1e0-d9e6-44b3-8412-a335d88c656d'),(5,4,37,261.47,NULL,'REJECTED',NULL,NULL,NULL),(6,10,30,240.78,'2024-08-06','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/73069588-45d5-468d-a90a-3abbc35b9fea'),(7,29,44,86.84,'2025-03-17','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/177a8a5f-6ffe-43b3-94bf-7a4b25b8a42f'),(8,30,8,254.18,NULL,'REJECTED',NULL,NULL,NULL),(9,30,25,153.72,'2025-03-31','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/e27718c5-737d-4fb6-9113-76e038d77b9a'),(10,12,8,146.54,NULL,'PENDING',NULL,NULL,'https://catcafe.pay/adoption/6a36af18-06d3-4b93-ae33-688d597e6845'),(11,8,25,129.67,NULL,'PENDING',NULL,NULL,'https://catcafe.pay/adoption/5fbbf0b1-8083-49c8-a57e-01c90da23e5c'),(12,23,42,133.82,NULL,'PENDING',NULL,NULL,'https://catcafe.pay/adoption/14e4180c-fe99-46a3-a2db-c8503c5bf3a7'),(13,2,18,279.35,'2024-09-07','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/195d82f8-ee4a-4b5d-9195-54e307374c86'),(14,27,17,239.71,'2025-02-21','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/25637cc3-ca97-4bf5-95d5-96afa663d2cd'),(15,20,25,276.46,NULL,'PENDING',NULL,NULL,'https://catcafe.pay/adoption/eada79a3-4970-4d9a-89ce-3cfb2339ba19'),(16,7,31,87.38,'2025-02-17','RETURNED','2025-04-06','Not compatible with existing pets','https://catcafe.pay/adoption/781799ff-b49e-44cc-8243-69e72387eaf6'),(17,17,28,77.80,'2024-10-04','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/04dd7054-1448-43f7-a7e6-46c701582463'),(18,10,34,61.94,'2024-07-26','APPROVED',NULL,NULL,'https://catcafe.pay/adoption/f0b2a5d1-8c7e-4f42-a646-eaf9d5c0244d'),(19,26,33,164.28,NULL,'PENDING',NULL,NULL,'https://catcafe.pay/adoption/6c5a6c93-871c-4884-9bdf-90f2ba2c0f19'),(20,29,48,199.18,NULL,'PENDING',NULL,NULL,'https://catcafe.pay/adoption/3cd5fd7f-49c1-4669-86b3-3fe61c76bdf6');
/*!40000 ALTER TABLE `adoption_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `behaviorist`
--

DROP TABLE IF EXISTS `behaviorist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `behaviorist` (
  `person_id` int unsigned NOT NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `behaviorist_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `care_specialist` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `behaviorist`
--

LOCK TABLES `behaviorist` WRITE;
/*!40000 ALTER TABLE `behaviorist` DISABLE KEYS */;
INSERT INTO `behaviorist` VALUES (16),(23),(24),(26),(50);
/*!40000 ALTER TABLE `behaviorist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `care_specialist`
--

DROP TABLE IF EXISTS `care_specialist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `care_specialist` (
  `person_id` int unsigned NOT NULL,
  `shelter_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`person_id`),
  KEY `shelter_id` (`shelter_id`),
  CONSTRAINT `care_specialist_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `employee` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `care_specialist_ibfk_2` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `care_specialist`
--

LOCK TABLES `care_specialist` WRITE;
/*!40000 ALTER TABLE `care_specialist` DISABLE KEYS */;
INSERT INTO `care_specialist` VALUES (6,2),(16,2),(24,2),(3,3),(9,3),(15,3),(32,3),(50,3),(23,4),(26,4);
/*!40000 ALTER TABLE `care_specialist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat`
--

DROP TABLE IF EXISTS `cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat` (
  `cat_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shelter_id` bigint unsigned DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `breed` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `energy_level` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_day_in_cafe` date DEFAULT NULL,
  `last_day_in_cafe` date DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  KEY `shelter_id` (`shelter_id`),
  CONSTRAINT `cat_ibfk_1` FOREIGN KEY (`shelter_id`) REFERENCES `shelter` (`shelter_id`),
  CONSTRAINT `cat_chk_1` CHECK ((`gender` in (_utf8mb4'M',_utf8mb4'F')))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat`
--

LOCK TABLES `cat` WRITE;
/*!40000 ALTER TABLE `cat` DISABLE KEYS */;
INSERT INTO `cat` VALUES (1,NULL,'Luna','F','Persian','A calm Persian with beautiful white fur.','High','2023-12-20',NULL),(2,NULL,'Oliver','F','Abyssinian','A friendly Abyssinian with beautiful calico fur.','Variable','2023-08-11',NULL),(3,NULL,'Leo','M','Ragdoll','A sweet Ragdoll with beautiful calico fur.','Variable','2025-02-06',NULL),(4,3,'Bella','M','Russian Blue','A calm Russian Blue with striking calico fur.','High','2023-04-29',NULL),(5,NULL,'Charlie','M','Maine Coon','A friendly Maine Coon with sleek tuxedo fur.','High','2025-01-07',NULL),(6,4,'Lucy','M','Norwegian Forest Cat','A calm Norwegian Forest Cat with striking calico fur.','Very High','2023-08-09',NULL),(7,5,'Max','M','Maine Coon','A friendly Maine Coon with striking tabby fur.','Low','2023-07-30',NULL),(8,2,'Lily','F','Persian','A sweet Persian with soft gray fur.','Low','2023-10-25',NULL),(9,2,'Simon','M','Bengal','A shy Bengal with sleek tabby fur.','Medium','2023-08-31',NULL),(10,4,'Sophie','M','Devon Rex','A energetic Devon Rex with beautiful white fur.','High','2024-08-17',NULL),(11,2,'Jack','M','Ragdoll','A playful Ragdoll with beautiful orange fur.','Low','2023-05-15','2023-05-25'),(12,4,'Chloe','F','Bengal','A calm Bengal with striking white fur.','Low','2024-11-18',NULL),(13,5,'Milo','M','Burmese','A calm Burmese with soft calico fur.','Variable','2023-10-16',NULL),(14,NULL,'Zoe','M','Maine Coon','A calm Maine Coon with striking tabby fur.','High','2023-12-17',NULL),(15,NULL,'Oscar','F','Russian Blue','A calm Russian Blue with sleek tabby fur.','Variable','2023-08-31',NULL),(16,5,'Cleo','M','Ragdoll','A sweet Ragdoll with sleek black fur.','Variable','2023-06-03',NULL),(17,1,'Felix','M','Bengal','A energetic Bengal with beautiful calico fur.','High','2024-10-15',NULL),(18,5,'Stella','F','Scottish Fold','A calm Scottish Fold with sleek gray fur.','Very High','2024-05-11','2025-01-27'),(19,5,'Simba','F','Norwegian Forest Cat','A energetic Norwegian Forest Cat with striking tabby fur.','Variable','2024-04-05',NULL),(20,3,'Ruby','F','Ragdoll','A playful Ragdoll with sleek tuxedo fur.','Variable','2024-11-10',NULL),(21,3,'Sam','F','Norwegian Forest Cat','A playful Norwegian Forest Cat with sleek tuxedo fur.','Medium','2024-05-02',NULL),(22,NULL,'Molly','F','Maine Coon','A playful Maine Coon with soft white fur.','Medium','2023-07-14','2024-06-07'),(23,NULL,'Jasper','F','Abyssinian','A sweet Abyssinian with sleek orange fur.','Variable','2025-03-11',NULL),(24,1,'Daisy','F','Sphynx','A playful Sphynx with striking calico fur.','Low','2023-05-28',NULL),(25,NULL,'Loki','M','Persian','A friendly Persian with sleek black fur.','Variable','2024-11-14',NULL),(26,5,'Willow','F','Persian','A energetic Persian with soft tuxedo fur.','Very High','2025-01-13',NULL),(27,3,'Tigger','F','Devon Rex','A playful Devon Rex with sleek orange fur.','High','2024-05-08',NULL),(28,2,'Pepper','F','Norwegian Forest Cat','A playful Norwegian Forest Cat with soft orange fur.','Low','2024-03-23',NULL),(29,NULL,'Gizmo','F','Devon Rex','A shy Devon Rex with beautiful white fur.','Medium','2025-03-24',NULL),(30,1,'Shadow','M','Maine Coon','A energetic Maine Coon with sleek gray fur.','Variable','2023-06-10',NULL);
/*!40000 ALTER TABLE `cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumable_contains_ingredient`
--

DROP TABLE IF EXISTS `consumable_contains_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumable_contains_ingredient` (
  `product_id` bigint unsigned NOT NULL,
  `ingredient_id` bigint unsigned NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  PRIMARY KEY (`product_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `consumable_contains_ingredient_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `consumable_product` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `consumable_contains_ingredient_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumable_contains_ingredient`
--

LOCK TABLES `consumable_contains_ingredient` WRITE;
/*!40000 ALTER TABLE `consumable_contains_ingredient` DISABLE KEYS */;
INSERT INTO `consumable_contains_ingredient` VALUES (4,3,152.76),(4,4,209.18),(4,5,346.75),(4,8,69.02),(4,11,255.46),(4,22,91.60),(5,6,322.67),(5,14,346.75),(5,16,499.95),(5,18,244.87),(5,21,277.50),(6,6,309.74),(6,11,432.77),(6,15,475.93),(8,5,326.57),(8,7,204.63),(8,13,245.91),(8,17,221.98),(8,18,355.10),(13,1,16.44),(13,3,397.96),(13,19,110.34),(15,6,386.30),(15,10,282.87),(15,18,390.39),(16,4,183.49),(16,9,20.90),(16,17,411.66),(16,18,387.58),(16,19,411.32),(17,4,499.66),(17,7,375.70),(17,14,148.92),(17,18,415.05),(17,24,224.92),(18,3,405.96),(18,4,368.83),(18,15,105.02),(18,25,344.60),(19,5,298.47),(19,6,285.08),(19,7,84.27),(19,14,402.74),(19,20,266.19),(19,21,406.78),(21,9,47.70),(21,10,492.75),(21,17,481.39),(21,19,339.68),(23,2,433.05),(23,5,414.26),(23,9,124.91),(23,21,355.73),(23,23,380.76),(24,5,187.65),(24,9,384.47),(24,16,313.94),(24,19,37.85),(24,21,397.32),(25,9,291.02),(25,12,423.60),(25,17,227.40),(25,23,434.47),(25,24,244.07),(26,15,348.67),(26,24,317.46),(27,13,214.88),(27,18,108.99),(28,9,168.94),(28,11,289.01),(28,16,414.19),(29,2,464.72),(29,4,228.31),(29,11,418.37),(29,16,313.13),(29,22,8.24),(29,23,79.08),(30,5,137.08),(30,7,79.57),(30,10,125.27),(30,21,327.33),(30,23,466.37),(31,2,117.15),(31,6,349.75),(31,21,152.82),(31,22,198.23),(32,4,238.46),(32,23,0.64),(33,8,4.74),(33,17,347.83),(33,19,340.02),(36,14,66.17),(36,23,35.51),(39,3,440.51),(39,4,386.75),(39,11,376.60),(39,12,66.66),(39,24,68.65);
/*!40000 ALTER TABLE `consumable_contains_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumable_product`
--

DROP TABLE IF EXISTS `consumable_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumable_product` (
  `product_id` bigint unsigned NOT NULL,
  `requires_refrigeration` tinyint(1) DEFAULT '0',
  `is_made_to_order` tinyint(1) DEFAULT '0',
  `preparation_time` time DEFAULT NULL,
  `shelf_life_days` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `consumable_product_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumable_product`
--

LOCK TABLES `consumable_product` WRITE;
/*!40000 ALTER TABLE `consumable_product` DISABLE KEYS */;
INSERT INTO `consumable_product` VALUES (4,0,0,'00:01:00',11),(5,0,1,'00:14:00',4),(6,1,1,'00:14:00',2),(8,1,1,'00:05:00',11),(13,1,0,'00:01:00',5),(15,0,1,'00:15:00',7),(16,0,1,'00:12:00',8),(17,1,1,'00:11:00',1),(18,1,0,'00:01:00',2),(19,0,1,'00:05:00',11),(21,0,1,'00:15:00',6),(23,1,0,'00:01:00',1),(24,0,1,'00:06:00',9),(25,0,1,'00:08:00',7),(26,1,0,'00:01:00',6),(27,0,1,'00:04:00',5),(28,1,0,'00:01:00',2),(29,0,1,'00:07:00',6),(30,1,0,'00:01:00',9),(31,1,1,'00:10:00',2),(32,1,1,'00:08:00',2),(33,1,0,'00:01:00',13),(36,0,0,'00:01:00',14),(39,1,0,'00:01:00',11);
/*!40000 ALTER TABLE `consumable_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `person_id` int unsigned NOT NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1),(4),(5),(7),(8),(10),(11),(12),(17),(18),(19),(20),(21),(22),(25),(27),(28),(30),(31),(33),(34),(35),(36),(37),(39),(42),(43),(44),(46),(48);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `person_id` int unsigned NOT NULL,
  `ssn` char(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position_title` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_time_flag` tinyint(1) DEFAULT NULL,
  `work_hours` decimal(4,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `supervisor_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `ssn` (`ssn`),
  KEY `supervisor_id` (`supervisor_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`supervisor_id`) REFERENCES `employee` (`person_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (2,'878-78-3060','Manager',1,40.00,'2025-02-26',NULL),(3,'662-31-5342','Receptionist',1,40.00,'2021-10-17',NULL),(6,'316-79-4295','Cleaner',1,40.00,'2024-09-02',NULL),(9,'508-95-7118','Cat Attendant',1,40.00,'2024-05-04',2),(13,'353-38-2049','Assistant Manager',0,21.77,'2022-08-29',3),(14,'702-38-1117','Barista',0,14.58,'2020-09-10',2),(15,'980-52-2160','Receptionist',0,15.57,'2024-02-02',9),(16,'319-79-3167','Cleaner',1,40.00,'2021-06-12',3),(23,'903-70-7669','Manager',0,11.94,'2023-09-13',15),(24,'462-64-7735','Cat Attendant',0,23.47,'2023-09-10',3),(26,'162-61-6559','Barista',0,13.83,'2022-04-22',23),(29,'559-27-7912','Manager',1,40.00,'2024-07-19',16),(32,'355-19-8260','Receptionist',0,11.01,'2023-02-08',23),(38,'956-11-2528','Manager',0,18.13,'2020-10-07',16),(40,'318-61-1960','Manager',1,40.00,'2022-04-16',2),(41,'499-43-8454','Assistant Manager',1,40.00,'2021-08-22',29),(45,'848-81-8973','Manager',0,15.93,'2020-12-07',3),(47,'693-79-1998','Cleaner',1,40.00,'2022-02-28',3),(49,'151-84-8811','Receptionist',0,11.14,'2024-01-24',45),(50,'182-33-2122','Receptionist',0,23.50,'2021-08-17',16);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_type` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Spring Adoption Festival','Adoption Day','2024-10-13'),(2,'Summer Kitten Party','Kitten Socialization','2025-01-05'),(3,'Holiday Cat Celebration','Kitten Socialization','2024-12-13'),(4,'Valentine\'s Day Cat Speed Dating','Kitten Socialization','2025-02-17'),(5,'Halloween Cat Costume Contest','Senior Cat Meet & Greet','2024-05-19'),(6,'Meow & Meditation','Educational Workshop','2025-02-04'),(7,'Paws & Paint Night','Senior Cat Meet & Greet','2024-10-10'),(8,'Whiskers & Wine','Cat Yoga','2024-08-11'),(9,'Senior Cat Appreciation Day','Senior Cat Meet & Greet','2024-05-12'),(10,'Kitten Kindergarten','Kitten Socialization','2024-07-08'),(11,'Cat Health Workshop','Senior Cat Meet & Greet','2024-05-11'),(12,'Feline Behavior Seminar','Adoption Day','2025-04-02'),(13,'Cat Photography Session','Kitten Socialization','2024-10-31'),(14,'Adopter Reunion','Educational Workshop','2025-04-23'),(15,'Cat Cafe Anniversary','Senior Cat Meet & Greet','2024-11-10');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_attendance`
--

DROP TABLE IF EXISTS `event_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_attendance` (
  `event_id` bigint unsigned NOT NULL,
  `customer_id` int unsigned NOT NULL,
  PRIMARY KEY (`event_id`,`customer_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `event_attendance_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  CONSTRAINT `event_attendance_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_attendance`
--

LOCK TABLES `event_attendance` WRITE;
/*!40000 ALTER TABLE `event_attendance` DISABLE KEYS */;
INSERT INTO `event_attendance` VALUES (5,1),(8,1),(14,1),(1,4),(2,4),(6,4),(7,4),(11,4),(13,4),(15,4),(1,5),(3,5),(5,5),(6,5),(12,5),(13,5),(14,5),(3,7),(5,7),(12,7),(14,7),(15,7),(2,8),(3,8),(8,8),(13,8),(3,10),(5,10),(12,10),(2,11),(3,11),(5,11),(6,11),(9,11),(11,11),(3,12),(9,12),(10,12),(12,12),(15,12),(2,17),(3,17),(5,17),(8,17),(10,17),(12,17),(13,17),(14,17),(15,17),(5,18),(7,18),(10,18),(13,18),(14,18),(1,19),(2,19),(3,19),(4,19),(10,19),(2,20),(3,20),(10,20),(13,20),(14,20),(15,20),(2,21),(4,21),(5,21),(7,21),(3,22),(11,22),(13,22),(15,22),(2,25),(9,25),(15,25),(1,27),(7,27),(8,27),(9,27),(14,27),(10,28),(12,28),(1,30),(2,30),(3,30),(6,30),(7,30),(10,30),(11,30),(14,30),(2,31),(9,31),(10,31),(11,31),(12,31),(13,31),(14,31),(15,31),(2,33),(5,33),(10,33),(15,33),(3,34),(5,34),(8,34),(13,34),(3,35),(5,35),(14,35),(2,36),(4,36),(6,36),(7,36),(12,36),(13,36),(15,36),(2,37),(5,37),(6,37),(7,37),(10,37),(14,37),(15,37),(1,39),(2,39),(13,39),(15,39),(1,42),(7,42),(10,42),(11,42),(12,42),(14,42),(15,42),(1,43),(2,43),(3,43),(7,43),(8,43),(9,43),(13,43),(1,44),(3,44),(4,44),(8,44),(10,44),(11,44),(13,44),(7,46),(9,46),(12,46),(14,46),(4,48),(5,48),(9,48),(10,48);
/*!40000 ALTER TABLE `event_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_features_cat`
--

DROP TABLE IF EXISTS `event_features_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_features_cat` (
  `event_id` bigint unsigned NOT NULL,
  `cat_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`event_id`,`cat_id`),
  KEY `cat_id` (`cat_id`),
  CONSTRAINT `event_features_cat_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  CONSTRAINT `event_features_cat_ibfk_2` FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_features_cat`
--

LOCK TABLES `event_features_cat` WRITE;
/*!40000 ALTER TABLE `event_features_cat` DISABLE KEYS */;
INSERT INTO `event_features_cat` VALUES (12,1),(14,1),(1,2),(5,2),(12,2),(15,2),(5,3),(12,3),(7,4),(8,4),(14,4),(6,5),(8,5),(14,5),(5,6),(10,6),(2,7),(6,7),(10,7),(12,7),(4,8),(8,8),(10,8),(12,8),(8,9),(14,9),(4,10),(9,10),(11,10),(13,10),(14,10),(6,11),(10,11),(6,12),(7,12),(12,12),(14,12),(4,13),(6,13),(9,13),(12,13),(14,13),(15,13),(2,14),(5,14),(14,14),(5,15),(6,15),(8,15),(11,15),(12,15),(3,16),(4,16),(11,16),(13,16),(7,17),(11,17),(12,17),(7,18),(14,18),(1,19),(2,19),(10,19),(12,19),(15,19),(2,20),(6,20),(13,20),(1,21),(2,21),(3,21),(4,21),(4,22),(5,23),(6,23),(14,23),(10,24),(1,25),(2,25),(6,25),(7,25),(4,26),(10,26),(10,27),(6,28),(8,28),(9,28),(10,28),(3,29),(8,29),(11,29),(2,30),(5,30),(8,30);
/*!40000 ALTER TABLE `event_features_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_organisation`
--

DROP TABLE IF EXISTS `event_organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_organisation` (
  `employee_id` int unsigned NOT NULL,
  `event_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`employee_id`,`event_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `event_organisation_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `event_organisation_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_organisation`
--

LOCK TABLES `event_organisation` WRITE;
/*!40000 ALTER TABLE `event_organisation` DISABLE KEYS */;
INSERT INTO `event_organisation` VALUES (16,1),(26,1),(3,2),(45,2),(47,3),(16,4),(32,4),(50,4),(40,5),(40,6),(49,6),(41,7),(9,8),(26,8),(2,9),(9,9),(3,10),(38,10),(2,11),(6,11),(47,11),(24,12),(45,12),(50,12),(15,13),(26,13),(40,13),(3,14),(16,14),(26,15),(47,15);
/*!40000 ALTER TABLE `event_organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groomer`
--

DROP TABLE IF EXISTS `groomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groomer` (
  `person_id` int unsigned NOT NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `groomer_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `care_specialist` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groomer`
--

LOCK TABLES `groomer` WRITE;
/*!40000 ALTER TABLE `groomer` DISABLE KEYS */;
INSERT INTO `groomer` VALUES (3),(6),(23),(24),(26);
/*!40000 ALTER TABLE `groomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `ingredient_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_of_measure` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allergen_flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (1,'Coffee Beans','ml',0),(2,'Milk','l',1),(3,'Sugar','lb',1),(4,'Flour','ml',0),(5,'Eggs','cup',1),(6,'Butter','oz',0),(7,'Chocolate','cup',0),(8,'Vanilla Extract','ml',0),(9,'Baking Powder','cup',0),(10,'Salt','pinch',0),(11,'Cinnamon','oz',0),(12,'Whipped Cream','cup',1),(13,'Caramel Syrup','l',0),(14,'Coconut Milk','kg',0),(15,'Almond Milk','lb',1),(16,'Honey','tbsp',1),(17,'Lemon','kg',0),(18,'Blueberries','oz',0),(19,'Strawberries','unit',0),(20,'Bananas','cup',0),(21,'Oats','pinch',1),(22,'Almonds','tbsp',0),(23,'Walnuts','pinch',1),(24,'Peanut Butter','unit',0),(25,'Cream Cheese','tsp',0);
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interaction`
--

DROP TABLE IF EXISTS `interaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interaction` (
  `interaction_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `adoption_id` bigint unsigned NOT NULL,
  `interaction_notes` text COLLATE utf8mb4_unicode_ci,
  `start_datetime` timestamp NULL DEFAULT NULL,
  `end_datetime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`interaction_id`),
  KEY `adoption_id` (`adoption_id`),
  CONSTRAINT `interaction_ibfk_1` FOREIGN KEY (`adoption_id`) REFERENCES `adoption_request` (`adoption_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interaction`
--

LOCK TABLES `interaction` WRITE;
/*!40000 ALTER TABLE `interaction` DISABLE KEYS */;
INSERT INTO `interaction` VALUES (1,1,'Discussion about cat\'s medical history','2024-08-15 07:59:08','2024-08-15 08:47:08'),(2,1,'Home environment assessment','2024-05-15 00:48:30','2024-05-15 02:12:30'),(3,2,'Post-adoption check-in','2024-09-27 13:24:30','2024-09-27 14:39:30'),(4,3,'Post-adoption check-in','2025-02-10 20:28:11','2025-02-10 21:51:11'),(5,3,'Follow-up discussion about cat\'s needs','2024-10-11 03:22:18','2024-10-11 05:17:18'),(6,4,'Post-adoption check-in','2024-06-07 00:29:14','2024-06-07 01:45:14'),(7,5,'Post-adoption check-in','2025-03-23 07:58:16','2025-03-23 09:37:16'),(8,6,'Final adoption paperwork review','2024-12-01 00:56:37','2024-12-01 02:26:37'),(9,7,'Discussion about cat\'s medical history','2024-05-03 15:04:05','2024-05-03 16:23:05'),(10,8,'Home environment assessment','2024-11-01 08:41:06','2024-11-01 09:13:06'),(11,8,'Home environment assessment','2024-07-24 18:21:33','2024-07-24 18:59:33'),(12,8,'Home environment assessment','2024-06-18 22:30:30','2024-06-18 23:30:30'),(13,9,'Training session for special needs','2024-09-30 23:41:51','2024-10-01 01:25:51'),(14,10,'Follow-up discussion about cat\'s needs','2024-12-07 14:54:43','2024-12-07 15:29:43'),(15,10,'Home environment assessment','2024-07-24 06:20:56','2024-07-24 07:59:56'),(16,10,'Home environment assessment','2024-09-26 08:55:41','2024-09-26 10:47:41'),(17,11,'Training session for special needs','2024-12-25 16:10:07','2024-12-25 18:07:07'),(18,11,'Final adoption paperwork review','2024-05-28 19:48:39','2024-05-28 21:47:39'),(19,12,'Discussion about cat\'s medical history','2025-04-17 15:35:23','2025-04-17 16:28:23'),(20,12,'Training session for special needs','2024-05-22 07:01:50','2024-05-22 07:48:50'),(21,12,'Initial meeting with cat','2024-11-05 07:04:47','2024-11-05 08:32:47'),(22,12,'Initial meeting with cat','2024-10-29 10:19:52','2024-10-29 11:26:52'),(23,13,'Initial meeting with cat','2025-04-22 15:09:03','2025-04-22 16:04:03'),(24,13,'Initial meeting with cat','2024-11-15 12:39:27','2024-11-15 13:49:27'),(25,14,'Post-adoption check-in','2024-09-16 20:38:49','2024-09-16 21:58:49'),(26,14,'Training session for special needs','2024-10-15 21:12:08','2024-10-15 22:51:08'),(27,14,'Final adoption paperwork review','2024-12-15 05:16:32','2024-12-15 06:18:32'),(28,15,'Training session for special needs','2025-04-19 23:24:19','2025-04-20 01:16:19'),(29,16,'Home environment assessment','2024-07-29 00:44:38','2024-07-29 01:59:38'),(30,16,'Training session for special needs','2024-05-03 13:22:47','2024-05-03 13:58:47'),(31,17,'Home environment assessment','2025-02-08 21:26:49','2025-02-08 22:11:49'),(32,17,'Training session for special needs','2024-08-31 05:34:29','2024-08-31 06:51:29'),(33,17,'Final adoption paperwork review','2025-01-19 15:35:19','2025-01-19 16:56:19'),(34,18,'Final adoption paperwork review','2024-12-12 12:27:57','2024-12-12 13:40:57'),(35,18,'Follow-up discussion about cat\'s needs','2025-02-02 16:40:26','2025-02-02 18:13:26'),(36,18,'Discussion about cat\'s medical history','2025-01-20 11:13:20','2025-01-20 12:46:20'),(37,18,'Home environment assessment','2024-08-26 18:11:31','2024-08-26 19:47:31'),(38,19,'Training session for special needs','2024-05-13 18:57:58','2024-05-13 19:37:58'),(39,19,'Discussion about cat\'s medical history','2024-11-12 13:30:55','2024-11-12 14:54:55'),(40,19,'Initial meeting with cat','2025-02-17 23:53:36','2025-02-18 01:18:36'),(41,20,'Post-adoption check-in','2024-06-30 09:58:53','2024-06-30 11:05:53'),(42,20,'Home environment assessment','2025-02-05 11:28:18','2025-02-05 12:11:18');
/*!40000 ALTER TABLE `interaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_record`
--

DROP TABLE IF EXISTS `medical_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_record` (
  `medical_record_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` bigint unsigned NOT NULL,
  `record_id` int NOT NULL,
  `recorded_at` timestamp NOT NULL,
  `weight_kg` decimal(5,2) DEFAULT NULL,
  `vaccinations` text COLLATE utf8mb4_unicode_ci,
  `allergies` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`medical_record_id`),
  KEY `idx_cat_record` (`cat_id`,`record_id`),
  CONSTRAINT `medical_record_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_record`
--

LOCK TABLES `medical_record` WRITE;
/*!40000 ALTER TABLE `medical_record` DISABLE KEYS */;
INSERT INTO `medical_record` VALUES (1,1,4,'2024-04-12 06:54:54',7.52,NULL,'None known','Recovering well from procedure'),(2,1,4,'2024-02-15 19:35:42',5.38,'FVRCP','Fish','Regular grooming needed'),(3,1,4,'2024-09-10 13:57:58',5.69,NULL,NULL,'Minor dental issues noted'),(4,1,4,'2024-04-20 12:47:33',4.10,'Rabies booster','Dairy','Healthy checkup, no concerns'),(5,2,3,'2025-02-20 23:04:21',6.34,'Rabies booster','Chicken','Regular grooming needed'),(6,2,2,'2023-06-21 02:02:17',7.90,NULL,'None known','Regular grooming needed'),(7,2,5,'2023-06-26 10:00:51',5.82,'FVRCP, Rabies','None known',NULL),(8,2,4,'2024-07-15 18:00:45',3.68,'Rabies booster','Chicken','Healthy checkup, no concerns'),(9,3,4,'2023-06-15 09:08:37',4.64,'Rabies booster','Fish','Slightly overweight, diet recommended'),(10,3,4,'2023-11-15 08:04:58',4.39,'Rabies booster','Fish','Healthy checkup, no concerns'),(11,3,4,'2024-08-02 20:25:53',3.10,NULL,'None known','Slightly overweight, diet recommended'),(12,4,1,'2024-06-01 23:09:21',6.91,'FVRCP, Rabies','None known','Minor dental issues noted'),(13,4,2,'2023-12-21 23:37:45',7.20,NULL,'Chicken','Minor dental issues noted'),(14,5,4,'2025-04-23 22:58:14',6.35,NULL,'Chicken','Regular grooming needed'),(15,5,3,'2024-05-19 23:06:07',6.83,'FVRCP, Rabies, FeLV',NULL,'Recovering well from procedure'),(16,6,1,'2024-03-24 19:57:18',6.89,'FVRCP, Rabies, FeLV','Fish','Healthy checkup, no concerns'),(17,6,5,'2024-07-13 15:41:10',3.13,'FVRCP',NULL,NULL),(18,6,4,'2023-07-09 20:23:00',4.98,'FVRCP, Rabies, FeLV','None known','Recovering well from procedure'),(19,6,2,'2024-09-22 00:53:39',3.51,'FVRCP',NULL,'Healthy checkup, no concerns'),(20,6,5,'2025-01-10 09:23:14',6.91,'FVRCP',NULL,'Regular grooming needed'),(21,6,3,'2024-08-15 21:11:34',3.34,'FVRCP','None known','Regular grooming needed'),(22,7,1,'2024-11-10 03:43:11',5.17,'FVRCP','Dairy',NULL),(23,7,2,'2024-10-05 23:03:13',5.18,NULL,'Fish','Recovering well from procedure'),(24,7,5,'2023-10-02 11:18:55',6.87,'Rabies booster','Dairy',NULL),(25,7,5,'2024-03-23 06:04:42',4.34,'FVRCP, Rabies, FeLV','None known','Slightly overweight, diet recommended'),(26,8,2,'2023-10-12 07:28:26',6.75,NULL,NULL,NULL),(27,8,4,'2024-01-01 00:37:14',4.68,'Rabies booster','Fish','Minor dental issues noted'),(28,8,4,'2024-03-24 16:09:33',4.06,'FVRCP','Fish','Slightly overweight, diet recommended'),(29,8,5,'2024-02-26 07:33:54',6.51,'FVRCP',NULL,'Healthy checkup, no concerns'),(30,9,2,'2023-07-06 20:38:00',3.43,'Rabies booster','Dairy','Recovering well from procedure'),(31,9,2,'2024-03-05 04:27:21',6.45,'Rabies booster','Dairy','Healthy checkup, no concerns'),(32,9,1,'2024-08-26 05:59:09',4.47,'Rabies booster','Chicken','Slightly overweight, diet recommended'),(33,9,5,'2024-01-26 20:42:00',4.85,NULL,NULL,'Slightly overweight, diet recommended'),(34,9,4,'2023-08-17 21:37:36',7.98,NULL,'Fish','Slightly overweight, diet recommended'),(35,10,4,'2025-03-02 15:57:53',4.35,'FVRCP','Chicken','Healthy checkup, no concerns'),(36,10,2,'2023-06-16 10:34:59',4.58,NULL,'Chicken','Minor dental issues noted'),(37,10,2,'2024-12-26 00:51:35',6.69,'FVRCP',NULL,'Recovering well from procedure'),(38,10,5,'2023-07-05 12:05:58',4.41,'FVRCP, Rabies','Chicken','Slightly overweight, diet recommended'),(39,10,2,'2023-07-07 22:33:20',4.80,'FVRCP','None known',NULL),(40,10,5,'2024-10-19 01:51:04',3.63,'FVRCP, Rabies','None known','Recovering well from procedure'),(41,11,2,'2024-12-11 10:11:01',6.19,'Rabies booster','None known','Healthy checkup, no concerns'),(42,11,5,'2024-06-07 19:39:32',4.42,'Rabies booster','Dairy','Slightly overweight, diet recommended'),(43,11,2,'2024-06-29 19:15:31',7.83,'FVRCP','Dairy','Healthy checkup, no concerns'),(44,12,4,'2024-06-11 15:05:51',5.46,NULL,'None known','Minor dental issues noted'),(45,13,5,'2023-12-25 05:49:45',7.75,'FVRCP, Rabies','Chicken','Healthy checkup, no concerns'),(46,13,5,'2023-07-26 16:32:04',6.82,NULL,NULL,'Recovering well from procedure'),(47,14,5,'2024-01-11 17:44:45',4.90,'Rabies booster','Fish','Recovering well from procedure'),(48,14,4,'2024-08-26 10:03:53',4.53,NULL,'None known','Recovering well from procedure'),(49,15,1,'2024-10-27 11:15:27',7.74,'FVRCP, Rabies, FeLV','Chicken','Slightly overweight, diet recommended'),(50,15,1,'2025-01-21 13:36:33',3.79,'FVRCP, Rabies, FeLV',NULL,'Healthy checkup, no concerns'),(51,15,2,'2024-10-06 02:55:26',3.01,'Rabies booster',NULL,'Regular grooming needed'),(52,15,3,'2025-04-04 19:08:03',3.16,'FVRCP','Fish',NULL),(53,15,4,'2024-07-09 23:44:08',3.36,'FVRCP, Rabies, FeLV','Fish',NULL),(54,15,5,'2024-01-10 07:31:35',6.31,'FVRCP, Rabies, FeLV','Dairy','Healthy checkup, no concerns'),(55,16,2,'2024-06-23 13:25:27',6.24,'FVRCP','Chicken','Healthy checkup, no concerns'),(56,16,1,'2023-09-30 19:16:08',3.83,'FVRCP',NULL,NULL),(57,16,5,'2024-08-20 03:13:11',7.61,'Rabies booster','None known','Regular grooming needed'),(58,16,3,'2023-10-09 04:59:15',6.50,'FVRCP',NULL,'Recovering well from procedure'),(59,16,4,'2023-07-16 10:52:01',5.19,NULL,'None known','Regular grooming needed'),(60,17,3,'2025-01-04 23:18:55',6.02,'FVRCP, Rabies','None known','Minor dental issues noted'),(61,17,5,'2024-01-21 22:32:17',5.94,'FVRCP, Rabies','Fish','Recovering well from procedure'),(62,17,1,'2024-11-05 12:16:12',6.82,'FVRCP, Rabies, FeLV','Dairy','Recovering well from procedure'),(63,17,4,'2024-06-20 18:28:48',7.58,'FVRCP, Rabies, FeLV',NULL,'Regular grooming needed'),(64,17,4,'2024-12-08 02:27:06',7.85,'Rabies booster','Fish','Regular grooming needed'),(65,17,3,'2025-01-04 19:29:20',4.61,'FVRCP, Rabies','Chicken','Slightly overweight, diet recommended'),(66,18,4,'2025-04-09 06:55:03',4.44,'Rabies booster',NULL,'Healthy checkup, no concerns'),(67,18,4,'2024-12-16 06:54:04',3.44,'FVRCP','Fish','Healthy checkup, no concerns'),(68,18,4,'2024-07-19 14:30:23',7.32,'FVRCP, Rabies',NULL,'Regular grooming needed'),(69,18,4,'2024-08-09 21:07:39',3.27,NULL,'Fish','Recovering well from procedure'),(70,19,4,'2023-05-17 13:54:13',6.80,'FVRCP, Rabies, FeLV','Fish','Recovering well from procedure'),(71,19,2,'2025-03-07 02:53:38',7.64,'Rabies booster','Dairy','Healthy checkup, no concerns'),(72,19,1,'2024-12-24 08:20:33',7.87,NULL,'Chicken',NULL),(73,19,2,'2023-11-09 19:23:58',4.55,'FVRCP, Rabies',NULL,'Regular grooming needed'),(74,20,2,'2023-09-07 04:36:08',7.96,'FVRCP, Rabies','Dairy','Healthy checkup, no concerns'),(75,21,2,'2024-09-22 17:00:42',5.49,'FVRCP',NULL,NULL),(76,21,3,'2023-12-10 03:36:20',5.08,'Rabies booster','Dairy','Minor dental issues noted'),(77,21,4,'2024-01-01 16:16:37',5.76,'Rabies booster','Chicken','Recovering well from procedure'),(78,21,5,'2023-05-02 20:40:41',6.73,'FVRCP, Rabies, FeLV','None known','Slightly overweight, diet recommended'),(79,21,4,'2025-01-22 20:38:59',4.70,NULL,'Fish','Healthy checkup, no concerns'),(80,21,3,'2024-06-15 02:06:14',6.63,NULL,NULL,NULL),(81,22,2,'2024-02-15 04:59:34',5.23,'Rabies booster','Fish','Slightly overweight, diet recommended'),(82,22,5,'2023-08-10 00:54:45',6.81,'Rabies booster','Dairy','Slightly overweight, diet recommended'),(83,22,2,'2024-08-02 22:06:07',7.90,'FVRCP, Rabies, FeLV',NULL,'Regular grooming needed'),(84,22,2,'2023-05-20 19:05:59',7.28,'Rabies booster','None known','Slightly overweight, diet recommended'),(85,23,4,'2024-10-24 10:06:27',6.53,'Rabies booster','Dairy',NULL),(86,23,2,'2023-10-02 13:14:26',5.48,'FVRCP, Rabies','Chicken','Recovering well from procedure'),(87,23,5,'2024-02-29 02:56:09',4.66,'FVRCP, Rabies','Dairy','Healthy checkup, no concerns'),(88,23,5,'2024-01-02 11:03:32',7.55,'FVRCP, Rabies','Chicken','Regular grooming needed'),(89,23,2,'2024-01-23 18:13:38',3.37,'FVRCP','Fish','Recovering well from procedure'),(90,23,4,'2024-10-06 12:18:30',6.25,'FVRCP',NULL,'Regular grooming needed'),(91,24,4,'2024-11-15 21:44:36',7.36,'FVRCP, Rabies',NULL,'Healthy checkup, no concerns'),(92,24,2,'2024-06-16 00:24:43',6.16,'FVRCP','Chicken',NULL),(93,24,1,'2023-06-29 11:03:37',5.17,'FVRCP, Rabies','None known','Regular grooming needed'),(94,25,3,'2023-06-05 19:56:49',7.52,'FVRCP, Rabies','Fish','Healthy checkup, no concerns'),(95,25,3,'2023-08-21 09:16:08',4.79,'Rabies booster','Chicken','Minor dental issues noted'),(96,26,4,'2024-07-22 17:16:36',5.83,'FVRCP, Rabies, FeLV','Chicken','Minor dental issues noted'),(97,26,1,'2024-09-01 17:19:48',6.05,'Rabies booster',NULL,NULL),(98,26,2,'2023-11-13 05:00:38',5.49,NULL,'Chicken','Minor dental issues noted'),(99,26,4,'2024-08-23 22:25:32',6.19,'Rabies booster','Fish',NULL),(100,26,1,'2024-04-17 04:01:19',7.49,'Rabies booster','Fish',NULL),(101,27,2,'2024-03-16 07:20:26',3.37,'FVRCP',NULL,'Slightly overweight, diet recommended'),(102,27,4,'2023-11-13 23:39:51',6.45,'Rabies booster','Fish','Minor dental issues noted'),(103,27,4,'2024-10-30 20:56:06',7.27,'FVRCP, Rabies','Chicken','Regular grooming needed'),(104,27,5,'2023-07-20 13:01:41',4.79,'FVRCP','Fish','Healthy checkup, no concerns'),(105,27,4,'2024-03-07 11:40:25',4.37,NULL,'None known','Recovering well from procedure'),(106,28,4,'2023-11-21 08:22:31',7.16,'FVRCP','Chicken','Recovering well from procedure'),(107,28,3,'2024-09-05 00:31:46',4.10,'FVRCP, Rabies, FeLV',NULL,'Slightly overweight, diet recommended'),(108,28,2,'2024-04-17 21:02:46',6.14,'FVRCP, Rabies','Fish','Regular grooming needed'),(109,28,1,'2024-08-27 17:28:55',5.90,'FVRCP, Rabies, FeLV','None known','Slightly overweight, diet recommended'),(110,28,3,'2023-05-31 13:52:10',6.74,'FVRCP, Rabies, FeLV','Chicken','Minor dental issues noted'),(111,28,5,'2024-02-11 04:12:08',7.38,'FVRCP',NULL,'Recovering well from procedure'),(112,29,2,'2024-07-09 04:42:42',4.28,'Rabies booster','Fish',NULL),(113,29,3,'2023-05-04 00:24:02',7.02,'Rabies booster','None known','Minor dental issues noted'),(114,29,2,'2023-12-04 14:58:25',7.30,'Rabies booster',NULL,'Slightly overweight, diet recommended'),(115,30,4,'2023-09-29 16:53:13',3.07,NULL,'None known','Regular grooming needed');
/*!40000 ALTER TABLE `medical_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_record_reference`
--

DROP TABLE IF EXISTS `medical_record_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_record_reference` (
  `reference_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` bigint unsigned NOT NULL,
  `record_id` int NOT NULL,
  PRIMARY KEY (`reference_id`),
  UNIQUE KEY `uk_cat_record_ref` (`cat_id`,`record_id`),
  CONSTRAINT `medical_record_reference_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_record_reference`
--

LOCK TABLES `medical_record_reference` WRITE;
/*!40000 ALTER TABLE `medical_record_reference` DISABLE KEYS */;
INSERT INTO `medical_record_reference` VALUES (58,1,4),(7,2,2),(59,2,3),(18,2,4),(65,2,5),(63,3,4),(55,4,1),(11,4,2),(12,5,3),(45,5,4),(36,6,1),(9,6,2),(61,6,3),(20,6,4),(67,6,5),(10,7,1),(43,7,2),(25,7,5),(13,8,2),(22,8,4),(69,8,5),(15,9,1),(46,9,2),(71,9,4),(28,9,5),(70,10,2),(78,10,4),(49,10,5),(29,11,2),(6,11,5),(1,12,4),(30,13,5),(64,14,4),(39,14,5),(72,15,1),(31,15,2),(79,15,3),(35,15,4),(8,15,5),(33,16,1),(60,16,2),(37,16,3),(66,16,4),(42,16,5),(76,17,1),(4,17,3),(40,17,4),(14,17,5),(48,18,4),(57,19,1),(16,19,2),(23,19,4),(62,20,2),(21,21,2),(68,21,3),(26,21,4),(73,21,5),(44,22,2),(27,22,5),(74,23,2),(2,23,4),(54,23,5),(19,24,1),(47,24,2),(50,24,4),(52,25,3),(51,26,1),(32,26,2),(38,26,4),(75,27,2),(3,27,4),(56,27,5),(77,28,1),(34,28,2),(5,28,3),(41,28,4),(17,28,5),(80,29,2),(53,29,3),(24,30,4);
/*!40000 ALTER TABLE `medical_record_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `transaction_id` bigint unsigned NOT NULL,
  `order_comment` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`transaction_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (2,NULL),(3,'Custom order'),(4,'Custom order'),(7,'Special request: extra whipped cream'),(8,'Birthday celebration order'),(9,NULL),(12,'To-go order'),(13,'To-go order'),(15,'Birthday celebration order'),(16,NULL),(18,'Special request: extra whipped cream'),(20,'Birthday celebration order'),(25,NULL),(26,'Regular order'),(27,'Birthday celebration order'),(28,'Custom order'),(30,'Special request: extra whipped cream'),(32,'Regular order'),(33,'Regular order'),(34,'Regular order'),(35,'Custom order'),(36,'To-go order'),(37,'To-go order'),(38,NULL),(39,'Birthday celebration order'),(40,'Custom order'),(42,'Regular order'),(44,'Regular order'),(48,'Special request: extra whipped cream'),(49,'Regular order'),(50,'To-go order'),(52,'Birthday celebration order'),(54,'Custom order'),(55,'Special request: extra whipped cream'),(56,'To-go order'),(58,NULL),(59,'To-go order'),(61,'Regular order'),(62,'Special request: extra whipped cream'),(65,'Special request: extra whipped cream'),(66,NULL),(68,'Regular order'),(69,'Special request: extra whipped cream'),(70,'Birthday celebration order'),(75,NULL),(76,NULL),(77,'Special request: extra whipped cream'),(79,'Regular order');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`transaction_id`) ON DELETE CASCADE,
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `order_item_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (2,4,2,17.53),(2,39,3,6.08),(3,32,2,8.71),(4,11,2,22.68),(4,22,3,8.90),(7,18,1,5.49),(7,25,3,18.98),(7,26,3,21.71),(7,30,2,17.27),(8,6,2,11.18),(8,12,1,19.37),(8,15,3,9.47),(8,22,2,12.25),(8,23,1,13.35),(9,10,2,3.85),(9,26,3,17.98),(9,40,2,18.19),(12,23,2,15.58),(12,27,2,3.82),(12,35,2,11.43),(13,11,1,19.15),(13,13,3,24.67),(13,23,1,8.03),(13,26,3,14.10),(15,3,3,7.89),(15,25,1,10.55),(15,26,3,24.88),(15,38,3,17.04),(16,7,1,21.46),(16,16,3,4.20),(16,28,3,22.63),(16,34,2,10.61),(16,40,3,17.11),(18,24,3,17.31),(20,2,1,11.19),(25,7,1,3.21),(26,1,2,19.65),(26,3,3,7.19),(26,25,2,23.90),(26,31,3,7.39),(27,5,1,5.20),(27,6,2,24.75),(27,10,2,17.18),(27,32,3,18.92),(27,33,2,8.81),(28,22,2,9.84),(30,12,2,19.48),(30,29,2,10.57),(30,31,3,4.99),(30,36,1,21.78),(30,38,1,11.50),(32,20,2,17.56),(33,2,1,23.20),(33,4,3,11.73),(33,12,3,7.38),(33,13,2,21.12),(33,37,1,3.73),(34,7,3,20.15),(35,7,1,9.56),(35,9,2,6.67),(35,20,2,14.07),(36,7,3,12.75),(36,9,2,16.31),(36,15,2,8.93),(36,20,1,7.13),(37,9,2,7.37),(37,18,1,14.25),(37,27,1,20.12),(37,39,1,20.26),(37,40,3,5.59),(38,1,3,19.68),(38,18,3,20.20),(38,21,3,16.71),(38,30,1,15.47),(38,34,1,12.12),(39,2,1,18.29),(39,4,2,12.77),(39,7,2,18.44),(39,39,1,15.04),(39,40,1,18.17),(40,30,3,10.43),(40,34,3,24.90),(40,39,2,24.92),(42,5,3,14.15),(42,20,1,20.17),(44,25,3,8.63),(48,31,2,22.73),(49,7,3,13.62),(49,27,3,17.92),(50,24,2,7.02),(52,5,2,12.09),(52,13,1,10.54),(52,31,1,6.02),(52,38,3,5.64),(52,40,3,11.40),(54,1,2,4.40),(54,7,2,18.06),(54,26,2,15.35),(54,38,3,16.40),(54,40,3,24.99),(55,27,3,22.08),(55,32,1,14.34),(56,31,1,17.24),(58,11,2,18.95),(58,20,2,5.81),(58,23,3,22.28),(58,33,1,9.46),(59,16,1,18.26),(61,11,1,22.95),(61,13,1,15.06),(61,19,1,3.28),(61,23,1,18.14),(61,27,2,10.27),(62,6,1,15.68),(62,10,1,9.90),(62,12,2,7.61),(62,21,1,3.10),(62,30,2,10.32),(65,14,3,3.44),(65,15,2,17.33),(66,17,1,14.38),(66,18,3,9.57),(66,21,3,18.64),(68,6,3,12.45),(68,32,1,16.52),(69,1,3,7.93),(69,21,3,15.69),(69,34,3,22.21),(70,31,1,19.53),(70,33,2,22.13),(75,1,3,24.27),(75,15,3,9.06),(75,17,2,21.73),(75,20,2,9.65),(75,39,2,8.54),(76,3,2,20.64),(76,19,2,12.37),(77,31,1,22.53),(77,32,2,4.01),(79,25,3,22.36),(79,40,2,16.45);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `person_id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Danielle','Johnson','(754) 214-1409','john21@example.net','600 Jeffery Parkways, New Jamesside, MT 29394'),(2,'Shane','Ramirez','(859) 381-5012','blakeerik@example.com','51161 Abbott Rapids, Lindsaymouth, ND 16862'),(3,'Teresa','Gray','(328) 242-2679','maria95@example.net','34131 Ramirez Roads, Franciscostad, IL 88342'),(4,'Joseph','Zuniga','(792) 858-9935','lynchgeorge@example.net','4835 Jeremy Bypass Suite 641, New Nancy, MD 28370'),(5,'Diana','Foster','(189) 704-7912','ithomas@example.org','969 Cox Dam Suite 101, Lake Ernest, TX 55834'),(6,'Candace','Cruz','(132) 130-2535','jrice@example.org','845 Kelly Estate, Smithview, NY 23917'),(7,'William','Rodriguez','(323) 338-9279','meagan89@example.org','809 Burns Creek, Natashaport, IA 08093'),(8,'John','Bradley','(716) 127-4257','millertodd@example.org','Unit 8227 Box 8248, DPO AP 55962'),(9,'Tamara','Hickman','(833) 765-9928','jenniferross@example.net','713 Caleb Brooks Apt. 930, Lake Crystalbury, CA 04618'),(10,'Michele','Jones','(529) 325-8359','joshuawashington@example.net','76311 Gomez Loop Suite 010, Chandlerville, IA 25613'),(11,'James','West','(703) 384-1106','dwhite@example.org','8108 Tanya Terrace, East Richard, NJ 28517'),(12,'Michelle','Barrera','(877) 925-3615','nicholasgalloway@example.com','PSC 7468, Box 7234, APO AE 08166'),(13,'Beth','Daniels','(814) 532-6574','brian97@example.net','PSC 8208, Box 1219, APO AE 89002'),(14,'Michelle','Powell','(384) 259-4527','bethwilliams@example.org','3534 Anderson Rue Suite 751, South Christineshire, CT 10103'),(15,'Amanda','Wagner','(881) 444-2674','sarahibarra@example.org','8498 Elizabeth Plaza, Sarahville, FM 18102'),(16,'Joseph','Preston','(194) 489-2584','josephjacobs@example.net','740 Cynthia Village Suite 005, Lake Tina, GA 97655'),(17,'Scott','Thornton','(467) 967-6635','rodriguezsierra@example.net','PSC 8059, Box 8262, APO AE 40905'),(18,'Michael','Fitzpatrick','(718) 370-1711','nolanjason@example.org','692 Michelle Union Apt. 602, Kimberlychester, AS 88307'),(19,'Michelle','Cochran','(847) 570-9785','erik16@example.org','75433 Donna Locks, Joshualand, WI 37086'),(20,'Michael','Hicks','(227) 487-2291','sheila14@example.org','19655 Obrien Pass Apt. 693, Bradleychester, AL 68647'),(21,'Sara','Ryan','(665) 400-6925','michaeljones@example.net','PSC 9514, Box 8465, APO AA 91885'),(22,'Kenneth','Martinez','(691) 296-2139','yortega@example.net','946 Kevin Fords, Floydmouth, NH 58406'),(23,'Scott','Lewis','(146) 777-4733','yleon@example.net','8951 Emily Fork, East Andrew, IA 62778'),(24,'Cheryl','Mack','(891) 396-2307','operry@example.net','6320 Kimberly Forges Apt. 870, Port David, DC 61402'),(25,'Elizabeth','Travis','(975) 338-2654','stephanie79@example.net','727 Green Gateway Suite 873, Scottport, IA 36115'),(26,'Matthew','Orozco','(489) 384-8428','taylorjesse@example.net','66587 Brown Village, Priceshire, UT 03061'),(27,'Melissa','Cannon','(750) 954-6977','wwoods@example.com','893 Robinson Mews Suite 065, Ramseymouth, PW 17229'),(28,'Tina','Ferguson','(266) 479-6820','qvargas@example.org','72046 Lewis Islands Suite 646, Maryfort, AK 98677'),(29,'Amber','Cooke','(314) 786-5374','jeffrey10@example.org','USNS Combs, FPO AP 20474'),(30,'John','Wells','(818) 799-2169','elliottjeffery@example.net','99124 Beth Inlet Suite 631, North Heidi, ME 90188'),(31,'Caroline','Martinez','(723) 750-3803','reedross@example.com','67165 Zimmerman Mews Apt. 849, Marshallshire, KY 42746'),(32,'Melissa','Rivas','(646) 846-5010','ramirezshannon@example.com','0752 Lewis Union Suite 549, Angelahaven, ID 11722'),(33,'John','Russell','(267) 573-7216','hannahbrewer@example.com','43634 Kennedy Pines, Ronaldside, MA 46613'),(34,'Jacqueline','Nelson','(376) 755-4598','jerry35@example.org','37498 Hooper Village, West Jeremy, HI 40119'),(35,'Alexis','Ferguson','(801) 432-1916','brandon08@example.com','710 Harrison Mill, Jackton, KS 63117'),(36,'Danny','Jones','(334) 941-1525','ojones@example.net','413 Angela Mall, Port Alexandra, NV 58529'),(37,'Kenneth','Chapman','(924) 423-7572','ntorres@example.org','34123 Andrea Estate, South Shannonfort, LA 04779'),(38,'Jesse','Mann','(374) 167-4456','ojones@example.com','1832 Serrano Cliffs, East Laurashire, PW 38329'),(39,'Scott','Harrison','(680) 997-6155','holly48@example.net','065 Johnson Forks, Port Emilyview, OK 05774'),(40,'Kathryn','Thompson','(317) 771-9179','lmoon@example.net','75655 Mia Isle Suite 746, South Christopherview, MD 15695'),(41,'Tara','Powell','(505) 758-8517','sandovalamy@example.com','770 Joseph Curve Suite 771, Lake Chelseabury, VT 21259'),(42,'Lance','Smith','(246) 371-3287','hdavis@example.com','USNS Jimenez, FPO AP 38755'),(43,'William','Hill','(352) 862-9830','pbaird@example.com','98214 Morgan Turnpike Suite 044, Grimesmouth, ND 63984'),(44,'Michael','Arnold','(369) 864-8019','ugibson@example.org','Unit 3963 Box 6057, DPO AP 50469'),(45,'Paul','Alvarado','(697) 508-6930','tylerjohnson@example.net','Unit 5171 Box 8702, DPO AA 86324'),(46,'Tara','Jones','(324) 241-9348','matthew61@example.com','7809 Jimmy Spur Suite 316, Port Cynthiaville, NV 22306'),(47,'Heather','Berger','(605) 193-1771','nguyenbrian@example.com','86922 Christian Ways, Harveybury, NM 76936'),(48,'Douglas','Murray','(981) 212-3504','steve07@example.com','75946 Bryant Hollow, South Melissa, CT 31592'),(49,'Patrick','Howard','(742) 263-7916','victoria40@example.net','097 Parsons Forks, Jefferyborough, RI 33351'),(50,'Erica','Le','(710) 165-7304','courtneyberger@example.net','95214 Burgess Extensions Apt. 285, Mariaview, PW 63657');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `list_price` decimal(10,2) DEFAULT NULL,
  `cost_price` decimal(10,2) DEFAULT NULL,
  `product_type` enum('RETAIL','CONSUMABLE') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'PROD-0001','PawPerfect','Beds - Response','General there sister policy consider whom item treat area buy check clearly.',94.34,64.96,'RETAIL'),(2,'PROD-0002','FurEver','Beds - Future','Generation wait thus suffer economy play nearly by.',72.61,44.37,'RETAIL'),(3,'PROD-0003','CatLife','Collars - Floor','Move maybe collection walk child probably result painting successful nor stay agreement animal.',38.95,18.89,'RETAIL'),(4,'PROD-0004','WhiskerLicious','Pastry - Put','Enough decision occur peace air threat nation politics few each southern image law.',6.14,3.40,'CONSUMABLE'),(5,'PROD-0005','Cat Cafe House Brand','Cat Treat - Risk','Citizen indeed less future century technology.',8.63,5.63,'CONSUMABLE'),(6,'PROD-0006','WhiskerLicious','Pastry - From','Wish candidate have no five letter environment easy best face.',7.97,4.53,'CONSUMABLE'),(7,'PROD-0007','CatLife','Toys - If','Industry while total spend value return couple city you level these market bed.',33.47,22.77,'RETAIL'),(8,'PROD-0008','Purr Bites','Pastry - Increase','Lead drive on any example our successful pull experience account blue care.',4.83,2.41,'CONSUMABLE'),(9,'PROD-0009','CatLife','Carriers - Everything','Shake hand hundred now crime network available mean share evidence.',59.56,40.68,'RETAIL'),(10,'PROD-0010','FurEver','Scratchers - Price','Budget window hour some fund voice sense current meeting matter and case four.',67.75,37.07,'RETAIL'),(11,'PROD-0011','Whisker Essentials','Beds - Matter','Lead paper middle foreign party class wrong school federal from stock mother.',22.60,12.75,'RETAIL'),(12,'PROD-0012','Meow Market','Scratchers - Section','Feel staff happy purpose woman on someone rise read ago listen whose situation.',96.15,53.57,'RETAIL'),(13,'PROD-0013','Cat Cafe House Brand','Cat Treat - Stand','Officer return on color pick people subject challenge quite all way body affect.',3.58,1.44,'CONSUMABLE'),(14,'PROD-0014','CatLife','Toys - Former','Charge real improve simple turn their save artist catch debate foot.',73.65,29.66,'RETAIL'),(15,'PROD-0015','WhiskerLicious','Coffee - Recognize','Moment finish community treatment garden great sign return poor really particular court.',10.41,6.25,'CONSUMABLE'),(16,'PROD-0016','Purr Bites','Cat Treat - Employee','Newspaper different win father eye debate relate first give.',8.85,3.56,'CONSUMABLE'),(17,'PROD-0017','Cat Cafe House Brand','Coffee - World','Explain of myself time house generation significant chair among.',9.35,4.51,'CONSUMABLE'),(18,'PROD-0018','Cat Cafe House Brand','Salad - Send','Get kind either look dark Mrs usually.',12.76,7.68,'CONSUMABLE'),(19,'PROD-0019','Pawsome Treats','Coffee - Safe','Case past only drug prove most point appear including.',14.02,7.81,'CONSUMABLE'),(20,'PROD-0020','Meow Market','Collars - Series','Beyond side accept nearly upon imagine various there local current white fly.',32.72,16.57,'RETAIL'),(21,'PROD-0021','Cat Cafe House Brand','Pastry - Race','Traditional become off movement rich view.',14.51,7.80,'CONSUMABLE'),(22,'PROD-0022','CatLife','Grooming - White','Individual study value already structure small control see.',71.56,46.83,'RETAIL'),(23,'PROD-0023','Cat Cafe House Brand','Coffee - Turn','Theory across nothing blue work expect writer myself management.',7.86,4.03,'CONSUMABLE'),(24,'PROD-0024','Cat Cafe House Brand','Cat Treat - Wrong','Surface life cover both class learn either.',5.06,2.78,'CONSUMABLE'),(25,'PROD-0025','WhiskerLicious','Salad - Cultural','Say so nothing serious compare task.',14.73,10.20,'CONSUMABLE'),(26,'PROD-0026','Cat Cafe House Brand','Tea - Watch','Still middle beautiful protect continue cell food easy end dog send.',5.54,3.66,'CONSUMABLE'),(27,'PROD-0027','Purr Bites','Pastry - Girl','Old of end growth door property let civil rather.',3.56,1.50,'CONSUMABLE'),(28,'PROD-0028','Meow Munch','Salad - Wind','Real police wait happen determine whatever long lawyer writer.',10.90,4.95,'CONSUMABLE'),(29,'PROD-0029','Cat Cafe House Brand','Tea - Hour','Reduce tree serious soon stay seven quite other skin moment month.',10.04,6.28,'CONSUMABLE'),(30,'PROD-0030','Purr Bites','Coffee - High','True born stock total dark Mr.',6.59,3.75,'CONSUMABLE'),(31,'PROD-0031','Purr Bites','Cat Treat - Community','Take kind quite response major together knowledge argue car indeed.',13.76,6.87,'CONSUMABLE'),(32,'PROD-0032','Pawsome Treats','Cat Treat - Organization','Next pull final against effort able.',11.69,6.43,'CONSUMABLE'),(33,'PROD-0033','Cat Cafe House Brand','Coffee - Discover','Authority interest red must art thus worry line expert conference career political role.',8.25,5.38,'CONSUMABLE'),(34,'PROD-0034','Meow Market','Collars - Kitchen','Year him thank trade heart radio product much president girl.',45.70,28.89,'RETAIL'),(35,'PROD-0035','Whisker Essentials','Carriers - Could','Hotel camera without strong series without leg rest interest here discover leave.',54.15,27.44,'RETAIL'),(36,'PROD-0036','Purr Bites','Tea - Clear','Country themselves she allow produce past view threat drive.',11.16,6.68,'CONSUMABLE'),(37,'PROD-0037','Meow Market','Grooming - Audience','Order land public the each analysis keep.',81.82,50.23,'RETAIL'),(38,'PROD-0038','CatLife','Carriers - Notice','Senior simply cell year doctor trouble office officer.',74.05,43.70,'RETAIL'),(39,'PROD-0039','WhiskerLicious','Pastry - Spring','Down then worry miss including every news option same compare.',4.28,1.72,'CONSUMABLE'),(40,'PROD-0040','Whisker Essentials','Grooming - Respond','New another general poor high modern recent impact feel contain Mrs.',19.20,8.18,'RETAIL');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund`
--

DROP TABLE IF EXISTS `refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund` (
  `transaction_id` bigint unsigned NOT NULL,
  `refund_reason` text COLLATE utf8mb4_unicode_ci,
  `refund_comment` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`transaction_id`),
  CONSTRAINT `refund_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund`
--

LOCK TABLES `refund` WRITE;
/*!40000 ALTER TABLE `refund` DISABLE KEYS */;
INSERT INTO `refund` VALUES (1,'Product quality issue','Full refund provided'),(5,'Double charge','Full refund provided'),(17,'Reservation cancellation','Manager approved'),(23,'Customer dissatisfaction','Manager approved'),(24,'Service issue','Full refund provided'),(51,'Service issue','Partial refund'),(73,'Store credit','Manager approved'),(74,'Reservation cancellation','Refund with store credit');
/*!40000 ALTER TABLE `refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `transaction_id` bigint unsigned NOT NULL,
  `cat_id` bigint unsigned DEFAULT NULL,
  `visit_id` int DEFAULT NULL,
  `check_in_status` enum('SCHEDULED','CHECKED_IN','CANCELLED') COLLATE utf8mb4_unicode_ci DEFAULT 'SCHEDULED',
  PRIMARY KEY (`transaction_id`),
  KEY `idx_cat_visit` (`cat_id`,`visit_id`),
  CONSTRAINT `fk_reservation_visit` FOREIGN KEY (`cat_id`, `visit_id`) REFERENCES `visit_reference` (`cat_id`, `visit_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (6,19,1,'SCHEDULED'),(10,10,10,'CHECKED_IN'),(11,14,1,'SCHEDULED'),(14,20,2,'SCHEDULED'),(19,17,4,'CANCELLED'),(21,18,2,'CHECKED_IN'),(22,9,1,'CANCELLED'),(29,25,7,'SCHEDULED'),(31,19,10,'CHECKED_IN'),(41,6,3,'SCHEDULED'),(43,29,6,'SCHEDULED'),(45,18,7,'CHECKED_IN'),(46,9,10,'CHECKED_IN'),(47,18,6,'SCHEDULED'),(53,9,2,'CHECKED_IN'),(57,25,3,'SCHEDULED'),(60,12,10,'CHECKED_IN'),(63,27,3,'CHECKED_IN'),(64,26,1,'CANCELLED'),(67,6,3,'SCHEDULED'),(71,16,4,'CANCELLED'),(72,22,9,'CANCELLED'),(78,10,7,'CHECKED_IN'),(80,3,5,'SCHEDULED');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retail_product`
--

DROP TABLE IF EXISTS `retail_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retail_product` (
  `product_id` bigint unsigned NOT NULL,
  `weight_grams` decimal(10,2) DEFAULT NULL,
  `dimensions` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `retail_product_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retail_product`
--

LOCK TABLES `retail_product` WRITE;
/*!40000 ALTER TABLE `retail_product` DISABLE KEYS */;
INSERT INTO `retail_product` VALUES (1,2211.80,'40x40x21 cm','Accessories'),(2,606.14,'10x27x22 cm','Toys'),(3,3024.93,'25x29x5 cm','Grooming'),(7,2127.67,'10x40x12 cm','Carriers'),(9,2653.41,'48x29x10 cm','Beds'),(10,1417.70,'22x36x9 cm','Toys'),(11,919.32,'22x31x14 cm','Accessories'),(12,3935.07,'28x21x12 cm','Food Bowls'),(14,3162.67,'43x44x11 cm','Accessories'),(20,624.16,'24x5x17 cm','Grooming'),(22,4223.91,'29x26x19 cm','Grooming'),(34,2210.02,'46x43x9 cm','Grooming'),(35,1671.26,'49x17x20 cm','Grooming'),(37,970.42,'30x25x14 cm','Food Bowls'),(38,3505.29,'36x41x30 cm','Beds'),(40,1696.84,'22x30x16 cm','Toys');
/*!40000 ALTER TABLE `retail_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelter`
--

DROP TABLE IF EXISTS `shelter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelter` (
  `shelter_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`shelter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelter`
--

LOCK TABLES `shelter` WRITE;
/*!40000 ALTER TABLE `shelter` DISABLE KEYS */;
INSERT INTO `shelter` VALUES (1,'Whisker Haven','37098 Herman Forges Apt. 746, East Brandonton, ME 65070'),(2,'Paws & Claws Sanctuary','267 Santiago Summit, Matthewsberg, FM 54880'),(3,'Furry Friends Rescue','640 Robinson Mills Apt. 515, Bruceview, ID 16512'),(4,'Meow Manor','USCGC Davis, FPO AE 84610'),(5,'Cat\'s Cradle Shelter','53293 Maria Plaza, New Jason, VI 31040');
/*!40000 ALTER TABLE `shelter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int unsigned DEFAULT NULL,
  `employee_id` int unsigned DEFAULT NULL,
  `txn_datetime` timestamp NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_processor` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`person_id`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,17,6,'2024-07-24 15:39:49',55.40,'Credit Card','Google Pay'),(2,11,29,'2024-07-18 22:42:37',73.63,'Debit Card','Apple Pay'),(3,11,15,'2025-03-06 21:23:41',13.24,'Credit Card','PayPal'),(4,12,32,'2024-06-19 08:44:49',38.40,'Mobile Payment','Stripe'),(5,8,23,'2024-10-13 18:09:42',66.24,'Debit Card','Google Pay'),(6,21,50,'2024-05-18 16:30:42',32.07,'Credit Card','Stripe'),(7,33,45,'2024-09-25 08:49:34',22.92,'Mobile Payment','Stripe'),(8,27,16,'2024-09-26 18:24:08',52.01,'Credit Card','PayPal'),(9,33,6,'2024-11-07 06:10:31',55.19,'Credit Card','Stripe'),(10,17,32,'2024-09-16 12:10:56',86.78,'Gift Card','Apple Pay'),(11,4,14,'2024-07-29 18:37:29',77.46,'Credit Card','Square'),(12,25,23,'2024-08-26 06:24:01',25.50,'Credit Card','Apple Pay'),(13,42,45,'2024-05-26 12:30:24',77.88,'Mobile Payment','Apple Pay'),(14,NULL,47,'2024-10-08 22:07:03',56.08,'Debit Card','Stripe'),(15,NULL,6,'2024-09-10 04:10:13',53.57,'Debit Card','PayPal'),(16,19,49,'2024-11-09 07:38:48',65.26,'Credit Card','Stripe'),(17,21,16,'2025-02-24 14:46:14',10.50,'Credit Card','Apple Pay'),(18,33,50,'2024-05-16 11:09:07',10.23,'Debit Card','Square'),(19,NULL,13,'2024-09-12 09:33:29',71.64,'Debit Card','Apple Pay'),(20,44,45,'2024-12-04 15:24:40',79.38,'Cash','Cash Register'),(21,17,23,'2024-05-12 02:03:31',74.63,'Credit Card','Square'),(22,28,23,'2024-05-24 05:24:15',54.77,'Cash','Cash Register'),(23,12,6,'2025-02-15 13:46:06',52.13,'Gift Card','Stripe'),(24,NULL,49,'2024-11-28 07:00:42',20.85,'Debit Card','Stripe'),(25,7,49,'2024-12-28 22:10:06',69.04,'Credit Card','PayPal'),(26,25,3,'2024-07-15 21:42:32',86.58,'Credit Card','PayPal'),(27,NULL,29,'2024-07-12 22:27:57',41.38,'Debit Card','PayPal'),(28,20,3,'2025-03-24 22:13:34',57.52,'Mobile Payment','PayPal'),(29,28,26,'2024-08-16 09:04:03',30.77,'Credit Card','Google Pay'),(30,44,3,'2025-03-25 15:25:08',22.04,'Gift Card','Square'),(31,30,40,'2024-07-14 00:03:01',87.27,'Cash','Cash Register'),(32,46,40,'2024-07-06 01:05:47',5.76,'Debit Card','Stripe'),(33,18,50,'2025-01-23 11:59:16',28.05,'Cash','Cash Register'),(34,48,15,'2025-01-25 11:21:30',74.58,'Gift Card','PayPal'),(35,5,38,'2025-01-28 04:40:35',7.27,'Gift Card','Stripe'),(36,37,2,'2025-03-27 15:10:02',95.34,'Credit Card','Apple Pay'),(37,21,24,'2025-01-06 18:05:14',14.88,'Gift Card','PayPal'),(38,39,13,'2025-01-09 17:27:38',72.61,'Credit Card','Square'),(39,7,45,'2024-09-19 12:10:32',44.24,'Cash','Cash Register'),(40,21,6,'2024-07-24 01:18:43',60.17,'Gift Card','PayPal'),(41,19,6,'2024-08-23 02:35:39',61.23,'Credit Card','Apple Pay'),(42,17,16,'2024-08-09 00:37:23',32.71,'Cash','Cash Register'),(43,19,26,'2024-10-14 22:26:02',35.22,'Cash','Cash Register'),(44,1,13,'2024-12-20 14:55:47',79.09,'Gift Card','Square'),(45,36,40,'2024-08-18 06:57:00',49.28,'Mobile Payment','Square'),(46,10,15,'2024-09-05 23:57:09',47.93,'Mobile Payment','Stripe'),(47,30,14,'2025-03-16 01:54:43',81.72,'Cash','Cash Register'),(48,37,50,'2024-10-14 20:16:26',8.83,'Cash','Cash Register'),(49,37,16,'2025-02-14 21:41:31',97.00,'Mobile Payment','Google Pay'),(50,NULL,24,'2025-01-16 12:53:53',29.72,'Debit Card','Square'),(51,20,40,'2025-01-30 20:39:03',57.82,'Gift Card','PayPal'),(52,NULL,9,'2024-08-22 14:28:56',81.37,'Debit Card','Square'),(53,NULL,16,'2024-07-10 19:57:40',17.42,'Mobile Payment','Stripe'),(54,42,6,'2024-08-19 22:23:37',60.32,'Cash','Cash Register'),(55,30,2,'2024-05-14 08:07:29',99.73,'Debit Card','Apple Pay'),(56,30,26,'2025-03-09 06:45:16',16.64,'Mobile Payment','Square'),(57,12,38,'2025-01-23 10:02:05',83.06,'Mobile Payment','Apple Pay'),(58,NULL,38,'2024-05-03 13:34:26',21.42,'Debit Card','PayPal'),(59,11,13,'2024-11-15 18:35:26',8.29,'Gift Card','Google Pay'),(60,18,41,'2024-11-26 23:52:39',44.14,'Gift Card','Apple Pay'),(61,NULL,23,'2025-01-15 15:50:46',41.39,'Mobile Payment','PayPal'),(62,27,45,'2024-08-13 10:58:44',28.67,'Gift Card','Square'),(63,27,29,'2024-07-08 07:09:51',50.57,'Mobile Payment','Stripe'),(64,44,26,'2024-07-20 15:40:56',41.90,'Debit Card','Square'),(65,8,2,'2024-11-21 19:01:56',90.10,'Cash','Cash Register'),(66,NULL,41,'2024-07-26 09:24:16',55.30,'Gift Card','PayPal'),(67,34,16,'2024-11-14 19:11:40',67.40,'Cash','Cash Register'),(68,27,3,'2025-04-07 05:34:41',77.58,'Debit Card','Google Pay'),(69,27,32,'2024-08-28 22:24:06',38.71,'Debit Card','PayPal'),(70,22,29,'2025-01-31 11:49:49',91.83,'Credit Card','Stripe'),(71,12,13,'2024-10-23 02:31:46',58.50,'Debit Card','Apple Pay'),(72,36,41,'2025-01-16 22:55:46',8.61,'Credit Card','PayPal'),(73,25,45,'2025-01-22 19:29:54',50.41,'Cash','Cash Register'),(74,1,13,'2024-10-12 22:54:38',37.37,'Debit Card','Stripe'),(75,NULL,13,'2025-01-20 07:41:59',60.73,'Debit Card','Square'),(76,20,29,'2024-09-03 06:29:09',96.25,'Cash','Cash Register'),(77,4,32,'2024-06-17 18:14:13',60.67,'Cash','Cash Register'),(78,17,14,'2024-11-13 07:17:17',74.57,'Mobile Payment','Apple Pay'),(79,36,47,'2024-07-03 20:42:46',70.89,'Gift Card','Stripe'),(80,12,14,'2025-03-18 11:21:01',40.95,'Cash','Cash Register');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_visit`
--

DROP TABLE IF EXISTS `transaction_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_visit` (
  `transaction_id` bigint unsigned NOT NULL,
  `cat_id` bigint unsigned DEFAULT NULL,
  `visit_id` int DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `idx_cat_visit` (`cat_id`,`visit_id`),
  CONSTRAINT `fk_transaction_visit` FOREIGN KEY (`cat_id`, `visit_id`) REFERENCES `visit_reference` (`cat_id`, `visit_id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_visit_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_visit`
--

LOCK TABLES `transaction_visit` WRITE;
/*!40000 ALTER TABLE `transaction_visit` DISABLE KEYS */;
INSERT INTO `transaction_visit` VALUES (74,2,9),(41,5,2),(75,7,1),(79,11,5),(36,12,1),(67,12,2),(21,12,4),(61,13,5),(69,14,1),(3,14,5),(59,16,7),(1,18,2),(32,19,10),(60,20,4),(28,22,5),(80,23,1),(5,25,5),(66,27,4),(54,28,9),(64,28,9),(33,29,7),(40,30,4);
/*!40000 ALTER TABLE `transaction_visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinarian`
--

DROP TABLE IF EXISTS `veterinarian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinarian` (
  `person_id` int unsigned NOT NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `veterinarian_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `care_specialist` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinarian`
--

LOCK TABLES `veterinarian` WRITE;
/*!40000 ALTER TABLE `veterinarian` DISABLE KEYS */;
INSERT INTO `veterinarian` VALUES (3),(6),(9),(15),(32);
/*!40000 ALTER TABLE `veterinarian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit` (
  `visit_record_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` bigint unsigned NOT NULL,
  `visit_id` int NOT NULL,
  `customer_id` int unsigned DEFAULT NULL,
  `visit_datetime` timestamp NULL DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  PRIMARY KEY (`visit_record_id`),
  KEY `idx_cat_visit` (`cat_id`,`visit_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `visit_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`) ON DELETE CASCADE,
  CONSTRAINT `visit_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
INSERT INTO `visit` VALUES (1,1,5,12,'2024-06-16 18:21:42',60),(2,1,6,34,'2024-07-29 23:13:01',120),(3,1,4,48,'2024-08-25 11:38:10',15),(4,1,10,7,'2024-04-30 11:09:10',90),(5,1,6,5,'2025-01-25 12:32:26',90),(6,1,4,42,'2024-06-30 19:29:33',15),(7,2,5,42,'2024-09-13 12:12:05',60),(8,2,2,17,'2025-01-09 16:36:27',15),(9,2,1,18,'2024-10-27 08:34:26',60),(10,2,2,34,'2025-02-26 01:22:38',30),(11,2,9,17,'2025-02-16 03:21:05',60),(12,2,8,43,'2024-05-23 23:11:26',120),(13,2,9,28,'2025-03-08 10:24:49',90),(14,2,3,7,'2024-05-13 02:12:20',60),(15,3,8,33,'2024-05-04 11:40:41',60),(16,3,5,39,'2025-03-30 02:04:59',120),(17,4,4,11,'2025-03-08 13:26:37',60),(18,4,4,20,'2024-11-23 23:21:39',45),(19,4,2,4,'2024-11-23 02:40:41',45),(20,4,9,7,'2025-01-11 19:41:30',120),(21,4,6,39,'2024-09-27 04:47:57',60),(22,4,5,1,'2024-06-08 16:58:35',15),(23,5,2,4,'2024-05-05 06:13:04',30),(24,5,10,25,'2024-08-24 06:14:03',15),(25,5,6,8,'2025-02-14 08:35:31',30),(26,5,10,1,'2024-12-09 10:43:55',15),(27,5,9,1,'2025-02-25 13:44:01',90),(28,5,4,31,'2025-03-29 13:52:30',30),(29,5,6,10,'2024-05-29 19:55:10',30),(30,5,10,25,'2025-03-02 02:56:29',45),(31,6,3,46,'2024-07-25 12:14:53',45),(32,6,3,34,'2024-11-28 18:17:55',120),(33,6,1,17,'2024-11-05 01:19:27',15),(34,7,4,12,'2024-09-19 04:35:24',45),(35,7,1,36,'2024-08-18 23:11:11',45),(36,7,1,17,'2024-08-29 15:29:10',120),(37,7,7,44,'2024-08-27 06:59:38',15),(38,7,2,48,'2024-06-28 01:12:18',60),(39,7,6,44,'2024-10-31 02:10:05',90),(40,8,8,44,'2024-06-08 06:55:28',30),(41,8,10,39,'2024-10-30 21:30:42',120),(42,9,5,11,'2025-03-24 12:29:43',120),(43,9,1,39,'2024-09-02 05:56:02',60),(44,9,7,28,'2025-01-18 08:25:29',120),(45,9,2,48,'2025-02-20 19:06:04',120),(46,9,8,30,'2025-02-19 08:48:47',15),(47,9,6,33,'2024-07-22 22:28:13',30),(48,9,2,17,'2024-06-20 03:05:21',45),(49,9,10,42,'2024-07-08 16:37:53',90),(50,9,9,37,'2024-12-03 16:52:45',45),(51,10,10,44,'2025-01-30 08:15:32',45),(52,10,8,44,'2024-12-23 02:25:44',90),(53,10,7,34,'2024-07-01 08:12:53',120),(54,10,2,20,'2025-02-03 22:59:42',120),(55,10,9,21,'2024-10-25 02:42:20',30),(56,10,7,11,'2025-01-28 05:41:07',30),(57,10,7,22,'2025-01-30 05:17:42',60),(58,11,7,21,'2024-10-08 14:23:24',15),(59,11,6,28,'2025-03-31 04:18:31',45),(60,11,5,43,'2024-11-19 20:35:37',30),(61,11,8,30,'2024-12-15 17:16:00',15),(62,11,2,30,'2024-12-11 18:48:08',60),(63,11,2,21,'2025-03-09 08:10:29',120),(64,11,6,27,'2024-12-12 18:25:53',30),(65,12,1,12,'2024-06-21 18:39:02',90),(66,12,9,22,'2024-05-22 13:58:30',120),(67,12,2,28,'2024-10-06 03:41:02',45),(68,12,7,20,'2024-08-16 05:50:44',120),(69,12,1,18,'2024-08-05 23:07:03',90),(70,12,5,43,'2024-05-18 03:47:08',15),(71,12,10,44,'2024-10-29 22:35:15',30),(72,12,3,4,'2024-08-19 00:21:18',60),(73,12,4,20,'2024-10-09 16:45:45',15),(74,13,9,43,'2024-05-18 10:04:43',15),(75,13,5,12,'2025-02-25 10:50:50',30),(76,13,7,20,'2024-05-25 15:59:59',90),(77,13,10,33,'2025-03-09 08:12:09',120),(78,13,9,25,'2025-03-06 01:41:26',90),(79,13,5,25,'2024-12-08 07:24:36',30),(80,14,5,5,'2024-10-29 20:13:44',45),(81,14,6,25,'2024-10-13 15:24:49',30),(82,14,3,12,'2024-11-16 03:23:54',120),(83,14,7,30,'2025-02-10 21:16:44',30),(84,14,1,30,'2025-03-20 20:26:06',120),(85,15,4,19,'2024-10-08 21:39:07',60),(86,15,8,22,'2025-02-17 11:02:46',30),(87,15,6,18,'2024-12-21 18:14:41',120),(88,15,6,10,'2024-08-23 01:49:14',90),(89,15,10,30,'2024-10-18 08:38:39',15),(90,15,3,36,'2024-06-21 17:48:22',90),(91,15,1,4,'2024-05-20 05:45:51',15),(92,15,5,11,'2024-06-04 10:40:00',120),(93,15,7,48,'2025-03-22 00:55:27',90),(94,16,7,35,'2024-08-31 01:53:14',30),(95,16,9,34,'2025-01-13 13:54:46',45),(96,16,7,34,'2024-10-28 22:08:59',45),(97,16,10,48,'2024-06-29 16:00:15',90),(98,16,5,39,'2024-07-27 03:03:22',30),(99,16,7,33,'2024-10-04 12:40:41',15),(100,16,1,1,'2024-10-05 03:15:36',45),(101,16,4,10,'2024-11-04 14:40:41',30),(102,17,5,22,'2024-06-24 14:55:31',15),(103,17,1,48,'2024-09-10 19:43:31',120),(104,17,7,36,'2024-08-08 23:10:17',30),(105,17,7,46,'2024-09-23 22:34:07',120),(106,17,4,44,'2024-08-29 05:26:22',90),(107,18,2,19,'2024-12-02 01:19:05',120),(108,18,1,28,'2025-02-09 22:34:05',15),(109,18,8,5,'2024-12-20 02:31:03',15),(110,18,6,12,'2024-05-21 17:09:42',60),(111,18,10,19,'2024-06-01 03:48:38',120),(112,18,7,18,'2024-12-31 10:54:17',15),(113,19,1,22,'2024-08-09 10:09:30',30),(114,19,10,11,'2025-01-17 00:28:11',120),(115,19,6,30,'2024-12-23 11:40:39',60),(116,19,2,8,'2025-03-24 16:10:36',60),(117,19,10,19,'2025-03-12 14:21:15',90),(118,19,2,19,'2024-08-27 09:33:57',45),(119,19,6,8,'2024-11-26 12:32:56',45),(120,20,2,44,'2024-06-18 07:07:17',120),(121,20,2,44,'2024-09-02 09:50:21',90),(122,20,4,7,'2025-04-16 01:59:22',45),(123,21,3,8,'2025-01-07 19:06:07',15),(124,21,3,35,'2024-09-17 19:12:14',30),(125,21,3,33,'2024-12-01 00:22:58',30),(126,21,2,36,'2025-04-05 05:41:47',120),(127,21,8,11,'2024-08-18 17:06:53',90),(128,21,10,11,'2024-09-12 05:16:28',120),(129,22,10,22,'2025-02-10 19:54:46',120),(130,22,6,17,'2025-02-18 16:34:37',60),(131,22,2,48,'2024-12-28 10:28:25',60),(132,22,5,27,'2025-02-24 10:50:58',45),(133,22,10,39,'2025-01-22 12:18:56',45),(134,22,9,30,'2025-01-03 00:34:22',45),(135,22,8,11,'2024-11-05 22:37:55',15),(136,22,1,43,'2024-12-19 15:17:34',45),(137,22,2,42,'2024-09-29 06:52:22',15),(138,22,10,33,'2024-09-06 19:05:33',90),(139,23,8,12,'2024-09-07 01:50:18',90),(140,23,1,11,'2024-07-02 11:32:08',90),(141,23,4,22,'2024-07-14 20:57:20',90),(142,23,8,44,'2025-04-08 18:25:36',30),(143,23,1,11,'2024-10-22 05:55:42',15),(144,23,6,37,'2024-07-19 09:12:58',15),(145,23,9,42,'2024-06-16 21:15:33',30),(146,24,4,37,'2024-05-25 19:48:17',60),(147,25,9,44,'2025-03-02 02:27:03',90),(148,25,3,43,'2024-06-03 13:58:11',45),(149,25,5,19,'2025-02-03 05:41:49',60),(150,25,6,4,'2025-02-26 16:51:15',90),(151,25,1,27,'2025-03-16 09:32:24',120),(152,25,6,30,'2024-05-11 10:16:47',45),(153,25,2,46,'2024-08-28 15:23:23',120),(154,25,7,18,'2025-02-01 13:39:46',45),(155,26,3,22,'2024-06-14 12:08:19',15),(156,26,10,4,'2024-09-12 05:37:49',30),(157,26,6,18,'2024-06-25 21:36:51',120),(158,26,7,17,'2025-02-25 07:45:55',90),(159,26,2,18,'2025-02-03 07:39:09',90),(160,26,7,42,'2025-02-17 04:16:38',45),(161,26,3,4,'2024-06-27 02:28:15',120),(162,26,9,30,'2024-10-04 11:56:03',120),(163,26,7,44,'2024-09-24 16:52:56',45),(164,26,1,43,'2024-12-30 17:13:45',45),(165,27,4,22,'2024-07-23 09:31:37',60),(166,27,4,8,'2024-10-06 21:08:00',30),(167,27,3,30,'2024-08-09 17:00:15',45),(168,28,9,10,'2025-01-26 01:53:08',90),(169,28,9,39,'2024-10-08 14:35:20',120),(170,29,10,17,'2024-11-08 17:24:28',90),(171,29,7,17,'2024-08-18 16:06:56',30),(172,29,3,31,'2025-02-17 00:35:49',120),(173,29,10,27,'2024-10-15 22:40:21',30),(174,29,8,39,'2025-02-26 16:47:52',60),(175,29,6,4,'2024-09-08 23:47:59',120),(176,30,8,33,'2025-04-08 13:42:36',45),(177,30,8,8,'2025-04-22 04:45:26',90),(178,30,4,18,'2024-10-13 06:22:12',60),(179,30,4,43,'2024-08-08 13:20:15',120);
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_reference`
--

DROP TABLE IF EXISTS `visit_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_reference` (
  `reference_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` bigint unsigned NOT NULL,
  `visit_id` int NOT NULL,
  PRIMARY KEY (`reference_id`),
  UNIQUE KEY `uk_cat_visit_ref` (`cat_id`,`visit_id`),
  CONSTRAINT `visit_reference_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_reference`
--

LOCK TABLES `visit_reference` WRITE;
/*!40000 ALTER TABLE `visit_reference` DISABLE KEYS */;
INSERT INTO `visit_reference` VALUES (98,1,4),(47,1,5),(109,1,6),(28,1,10),(88,2,1),(8,2,2),(100,2,3),(111,2,5),(77,2,8),(134,2,9),(54,3,5),(25,3,8),(13,4,2),(56,4,4),(122,4,5),(74,4,6),(3,4,9),(55,5,2),(73,5,4),(82,5,6),(44,5,9),(5,5,10),(49,6,1),(103,6,3),(10,7,1),(65,7,2),(79,7,4),(128,7,6),(40,7,7),(84,8,8),(96,8,10),(17,9,1),(75,9,2),(34,9,5),(132,9,6),(45,9,7),(6,9,8),(59,9,9),(18,9,10),(123,10,2),(97,10,7),(46,10,8),(108,10,9),(60,10,10),(35,11,2),(7,11,5),(99,11,6),(19,11,7),(110,11,8),(69,12,1),(130,12,2),(81,12,3),(1,12,4),(94,12,5),(107,12,7),(119,12,9),(71,12,10),(36,13,5),(48,13,7),(61,13,9),(20,13,10),(31,14,1),(43,14,3),(57,14,5),(120,14,6),(72,14,7),(125,15,1),(135,15,3),(50,15,4),(9,15,5),(62,15,6),(21,15,7),(114,15,8),(126,15,10),(38,16,1),(112,16,4),(64,16,5),(78,16,7),(90,16,9),(39,16,10),(131,17,1),(58,17,4),(15,17,5),(26,17,7),(11,18,1),(66,18,2),(129,18,6),(41,18,7),(137,18,8),(12,18,10),(95,19,1),(16,19,2),(33,19,6),(101,19,10),(104,20,2),(116,20,4),(24,21,2),(118,21,3),(93,21,8),(106,21,10),(117,22,1),(68,22,2),(30,22,5),(92,22,6),(105,22,8),(52,22,9),(14,22,10),(70,23,1),(2,23,4),(42,23,6),(53,23,8),(121,23,9),(86,24,4),(76,25,1),(133,25,2),(89,25,3),(102,25,5),(51,25,6),(113,25,7),(124,25,9),(87,26,1),(37,26,2),(136,26,3),(63,26,6),(22,26,7),(29,26,9),(127,26,10),(83,27,3),(4,27,4),(32,28,9),(91,29,3),(23,29,6),(115,29,7),(67,29,8),(80,29,10),(27,30,4),(85,30,8);
/*!40000 ALTER TABLE `visit_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_registration`
--

DROP TABLE IF EXISTS `visit_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_registration` (
  `registration_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int unsigned DEFAULT NULL,
  `cat_id` bigint unsigned DEFAULT NULL,
  `visit_id` int DEFAULT NULL,
  `signed_waiver` tinyint(1) DEFAULT '0',
  `signature_recorded_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`registration_id`),
  KEY `idx_customer_cat_visit` (`customer_id`,`cat_id`,`visit_id`),
  KEY `idx_cat_visit` (`cat_id`,`visit_id`),
  CONSTRAINT `fk_visit_reg` FOREIGN KEY (`cat_id`, `visit_id`) REFERENCES `visit_reference` (`cat_id`, `visit_id`) ON DELETE CASCADE,
  CONSTRAINT `visit_registration_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_registration`
--

LOCK TABLES `visit_registration` WRITE;
/*!40000 ALTER TABLE `visit_registration` DISABLE KEYS */;
INSERT INTO `visit_registration` VALUES (1,43,1,5,1,'2024-07-29 03:52:55'),(2,44,1,6,1,'2025-01-27 19:33:42'),(3,31,1,4,1,'2024-07-06 10:33:40'),(4,34,1,10,1,'2024-09-05 00:32:39'),(5,43,1,6,1,'2025-02-06 21:03:50'),(6,43,1,4,1,'2025-03-09 20:46:27'),(7,44,2,5,1,'2024-08-26 20:57:59'),(8,39,2,2,1,'2024-06-12 02:30:44'),(9,48,2,1,1,'2024-09-09 01:21:43'),(10,7,2,2,1,'2025-03-18 12:25:10'),(11,33,2,9,1,'2025-01-24 04:03:04'),(12,33,2,8,1,'2025-03-20 09:34:18'),(13,22,2,9,1,'2024-09-15 20:37:46'),(14,48,2,3,1,'2025-04-18 06:49:17'),(15,31,3,8,0,NULL),(16,34,3,5,1,'2024-10-25 20:59:33'),(17,27,4,4,1,'2024-10-26 08:33:53'),(18,33,4,2,1,'2025-03-31 05:40:40'),(19,21,5,2,0,NULL),(20,44,5,10,1,'2024-11-03 07:14:30'),(21,31,5,6,1,'2025-02-14 07:03:58'),(22,12,5,9,1,'2025-01-18 05:48:52'),(23,25,5,4,1,'2024-05-26 11:14:58'),(24,28,5,6,1,'2024-12-03 17:21:19'),(25,10,5,10,1,'2025-02-22 00:50:26'),(26,20,6,3,1,'2024-11-12 21:53:31'),(27,17,6,3,1,'2024-08-22 23:03:23'),(28,4,6,1,1,'2024-05-26 21:15:32'),(29,36,7,4,1,'2024-12-25 01:51:12'),(30,46,7,1,1,'2024-08-17 14:03:48'),(31,37,7,2,1,'2024-12-03 18:49:51'),(32,8,7,6,1,'2024-09-30 06:37:31'),(33,18,8,8,1,'2025-01-04 14:42:25'),(34,48,9,5,1,'2024-09-03 00:58:14'),(35,5,9,1,1,'2024-05-13 02:40:10'),(36,12,9,2,1,'2025-03-11 09:55:52'),(37,19,9,8,1,'2024-09-03 09:50:40'),(38,18,9,10,1,'2025-04-27 04:56:34'),(39,5,9,9,1,'2024-08-05 22:04:50'),(40,48,10,10,1,'2025-04-20 14:04:41'),(41,46,10,7,1,'2025-04-08 20:29:47'),(42,33,10,2,1,'2024-05-25 01:11:13'),(43,39,10,9,1,'2024-12-16 12:40:34'),(44,42,10,7,1,'2024-09-07 08:05:32'),(45,22,10,7,1,'2025-02-14 06:36:33'),(46,10,11,7,1,'2024-12-31 19:56:40'),(47,42,11,8,1,'2025-04-10 15:19:02'),(48,1,11,2,1,'2024-06-18 18:57:53'),(49,18,11,6,1,'2024-12-05 14:13:57'),(50,12,12,9,1,'2025-02-07 01:11:15'),(51,5,12,1,1,'2024-05-10 08:26:01'),(52,5,12,10,0,NULL),(53,21,13,9,1,'2024-05-22 04:44:44'),(54,12,13,10,1,'2025-02-06 00:40:23'),(55,11,13,5,1,'2024-09-08 10:32:30'),(56,48,14,5,1,'2024-09-14 11:24:14'),(57,44,14,6,1,'2024-11-20 20:43:28'),(58,34,14,3,1,'2024-12-04 16:30:37'),(59,37,14,1,1,'2024-12-31 16:53:21'),(60,10,15,6,1,'2025-04-09 04:33:13'),(61,42,15,6,1,'2024-09-10 12:22:27'),(62,30,15,3,1,'2025-01-31 09:24:34'),(63,17,15,1,1,'2024-11-23 07:15:17'),(64,19,15,7,1,'2024-11-07 01:30:45'),(65,21,16,7,1,'2024-09-20 00:27:54'),(66,43,16,10,1,'2024-12-20 22:17:16'),(67,34,16,5,1,'2024-07-27 19:25:48'),(68,4,16,7,1,'2024-06-08 01:51:27'),(69,34,17,5,1,'2025-01-21 09:08:36'),(70,8,17,7,1,'2024-10-26 21:53:38'),(71,17,17,7,1,'2024-09-15 23:37:58'),(72,37,18,2,1,'2024-11-18 19:52:56'),(73,46,18,1,1,'2024-08-01 06:03:56'),(74,33,18,10,1,'2024-07-31 17:01:55'),(75,11,18,7,1,'2024-10-07 15:19:02'),(76,5,19,1,1,'2025-04-26 13:17:30'),(77,46,19,10,1,'2024-08-09 22:41:33'),(78,46,19,6,1,'2025-03-28 09:01:42'),(79,44,19,2,1,'2024-10-24 01:08:14'),(80,37,19,10,1,'2024-06-11 10:24:16'),(81,44,19,2,1,'2025-03-05 04:03:53'),(82,17,19,6,1,'2024-10-09 17:53:31'),(83,39,20,2,1,'2025-03-21 20:59:56'),(84,18,20,2,1,'2024-10-07 05:07:55'),(85,31,20,4,0,NULL),(86,30,21,3,0,NULL),(87,30,21,3,1,'2024-05-29 16:56:48'),(88,7,21,3,0,NULL),(89,28,21,8,1,'2025-01-01 18:01:21'),(90,42,21,10,1,'2025-03-02 12:01:49'),(91,28,22,10,1,'2024-08-22 08:49:26'),(92,5,22,2,1,'2024-09-01 12:50:27'),(93,4,22,5,1,'2024-05-21 08:38:04'),(94,20,22,9,1,'2024-11-11 16:56:18'),(95,46,22,8,1,'2025-03-19 04:35:38'),(96,8,22,1,1,'2025-03-04 15:13:46'),(97,21,23,8,1,'2025-01-12 15:56:31'),(98,31,23,1,1,'2025-04-01 08:05:52'),(99,17,23,4,1,'2024-12-16 14:19:10'),(100,27,23,6,1,'2025-02-11 13:44:46'),(101,5,23,9,1,'2024-10-30 11:01:30'),(102,1,24,4,0,NULL),(103,11,25,9,1,'2024-06-10 23:13:42'),(104,21,25,5,0,NULL),(105,46,25,6,1,'2024-07-10 01:08:24'),(106,44,25,6,1,'2024-06-17 08:45:20'),(107,5,25,2,1,'2025-02-10 08:36:53'),(108,33,25,7,1,'2024-05-07 05:47:37'),(109,7,26,10,1,'2024-11-16 00:48:47'),(110,8,26,6,1,'2024-09-09 09:10:51'),(111,46,26,7,1,'2025-02-15 05:06:00'),(112,28,26,3,1,'2024-11-15 03:59:56'),(113,43,26,9,1,'2024-12-07 04:35:12'),(114,27,26,7,1,'2024-05-29 03:08:18'),(115,28,26,1,1,'2024-08-18 14:33:45'),(116,10,27,4,1,'2025-04-27 17:36:16'),(117,8,27,4,1,'2025-01-15 05:49:59'),(118,28,29,10,1,'2024-11-05 16:30:58'),(119,8,29,7,1,'2025-02-02 14:42:22'),(120,30,29,3,1,'2025-02-22 09:35:23'),(121,21,29,8,1,'2024-05-24 13:52:31'),(122,19,29,6,1,'2025-04-17 19:02:29'),(123,20,30,8,0,NULL),(124,4,30,4,1,'2024-12-18 06:58:48'),(125,20,30,4,1,'2024-10-08 23:45:45');
/*!40000 ALTER TABLE `visit_registration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-27 14:24:27
