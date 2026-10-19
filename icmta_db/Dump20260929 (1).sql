-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: icmta_stage
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_users` (
  `admin_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `uq_admin_users_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (8,'admin','$2b$12$NIfbWyh2DQwMj5p13yZk3erUOIDA66TR1HTUq8e5mN7Tv0n8am/Iq',1,'2026-09-22 15:39:58','2026-09-22 15:39:58');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_applicant_info`
--

DROP TABLE IF EXISTS `application_applicant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_applicant_info` (
  `application_id` bigint unsigned NOT NULL,
  `academic_title` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `designation` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `institution` text COLLATE utf8mb4_unicode_ci,
  `college_address` text COLLATE utf8mb4_unicode_ci,
  `pin_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_province` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `highest_qualification` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`application_id`),
  CONSTRAINT `fk_application_applicant_info` FOREIGN KEY (`application_id`) REFERENCES `membership_applications` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_applicant_info`
--

LOCK TABLES `application_applicant_info` WRITE;
/*!40000 ALTER TABLE `application_applicant_info` DISABLE KEYS */;
INSERT INTO `application_applicant_info` VALUES (36,'Dr.','2026-09-23','professor','finance','anna university','17-2-92, Chakali street , VRC, Nellore','560001','Andhra Pradesh','India','Ph.D.'),(37,'Prof. Dr.',NULL,'Senior Professor & Dean','Advanced Quantitative Finance','Anna University Central Campus','Sardar Patel Road, Guindy','600025','Tamil Nadu','India','Ph.D. in Quantitative Finance'),(39,'Prof. Dr.',NULL,'Senior Professor & Dean','Advanced Quantitative Finance','Anna University Central Campus','Sardar Patel Road, Guindy','600025','Tamil Nadu','India','Ph.D. in Quantitative Finance'),(40,'Dr.',NULL,'Associate Professor','Management Studies','National Institute of Technology','NIT Campus, Tiruchirappalli','620015','Tamil Nadu','India','Ph.D. in Operations Research'),(41,'Prof. Dr.',NULL,'Senior Professor & Dean','Advanced Quantitative Finance','Anna University Central Campus','Sardar Patel Road, Guindy','600025','Tamil Nadu','India','Ph.D. in Quantitative Finance'),(42,'Dr.',NULL,'Associate Professor','Management Studies','National Institute of Technology','NIT Campus, Tiruchirappalli','620015','Tamil Nadu','India','Ph.D. in Operations Research'),(43,'Mr.','2026-09-08','finance','finance','abc','narayana collage of engineering','789065','Andhra Pradesh','India','MBA');
/*!40000 ALTER TABLE `application_applicant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_contact_info`
--

DROP TABLE IF EXISTS `application_contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_contact_info` (
  `application_id` bigint unsigned NOT NULL,
  `personal_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `professional_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_secondary` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_url` text COLLATE utf8mb4_unicode_ci,
  `google_scholar` text COLLATE utf8mb4_unicode_ci,
  `linkedin` text COLLATE utf8mb4_unicode_ci,
  `orcid` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expertise` text COLLATE utf8mb4_unicode_ci,
  `research_guideship` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`application_id`),
  CONSTRAINT `fk_application_contact_info` FOREIGN KEY (`application_id`) REFERENCES `membership_applications` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_contact_info`
--

LOCK TABLES `application_contact_info` WRITE;
/*!40000 ALTER TABLE `application_contact_info` DISABLE KEYS */;
INSERT INTO `application_contact_info` VALUES (36,'final@gmail.com','final@gmail.com','+919876543210','+919876543210',NULL,'/uploads/member_photos/9a8be3d64785463fb52ff05e6042280c.png','https://scholar.google.com/test','https://linkedin.com/in/test','0000-0002-1825-0097','Finance & Accounting','Yes'),(37,'final.personal@gmail.com','final@gmail.com','+91 94440 12345','+91 94440 12345',NULL,NULL,'https://scholar.google.com/citations?user=final382','https://linkedin.com/in/final382','0000-0002-1825-0099','Quantitative Finance, Econometrics, Portfolio Theory','Doctoral Supervisor in Financial Mathematics'),(39,'final.personal@gmail.com','final@gmail.com','+91 94440 12345','+91 94440 12345',NULL,NULL,'https://scholar.google.com/citations?user=final382','https://linkedin.com/in/final382','0000-0002-1825-0099','Quantitative Finance, Econometrics, Portfolio Theory','Doctoral Supervisor in Financial Mathematics'),(40,'mayakrish.personal@gmail.com','maya.krishnan@nitt.edu','+91 98401 77777',NULL,NULL,NULL,'https://scholar.google.com/citations?user=mayakrish',NULL,NULL,'Operations Research, Supply Chain Optimization',NULL),(41,'final.personal@gmail.com','final@gmail.com','+91 94440 12345','+91 94440 12345',NULL,NULL,'https://scholar.google.com/citations?user=final382','https://linkedin.com/in/final382','0000-0002-1825-0099','Quantitative Finance, Econometrics, Portfolio Theory','Doctoral Supervisor in Financial Mathematics'),(42,'mayakrish.personal@gmail.com','maya.krishnan@nitt.edu','+91 98401 77777',NULL,NULL,NULL,'https://scholar.google.com/citations?user=mayakrish',NULL,NULL,'Operations Research, Supply Chain Optimization',NULL),(43,'sankar@gmail.com','sankar@gmail.com','9848664044','9848664044',NULL,'/uploads/member_photos/ba011a522c994c228a73a936e199e64a.jpeg',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `application_contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_contacts`
--

DROP TABLE IF EXISTS `event_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_contacts` (
  `event_id` bigint unsigned NOT NULL,
  `speaker_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `speaker_designation` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `speaker_institution` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coordinator_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  CONSTRAINT `fk_event_contacts` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_contacts`
--

LOCK TABLES `event_contacts` WRITE;
/*!40000 ALTER TABLE `event_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_details`
--

DROP TABLE IF EXISTS `event_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_details` (
  `event_id` bigint unsigned NOT NULL,
  `short_description` text COLLATE utf8mb4_unicode_ci,
  `full_description` longtext COLLATE utf8mb4_unicode_ci,
  `poster_url` text COLLATE utf8mb4_unicode_ci,
  `organized_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_association_with` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registration_fee` decimal(10,2) DEFAULT NULL,
  `registration_link` text COLLATE utf8mb4_unicode_ci,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`event_id`),
  CONSTRAINT `fk_event_details` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_details`
--

LOCK TABLES `event_details` WRITE;
/*!40000 ALTER TABLE `event_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_date` date NOT NULL,
  `registration_deadline` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `event_mode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected','Published','Completed','Cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `reviewed_by` bigint unsigned DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_id`),
  KEY `idx_events_reviewed_by` (`reviewed_by`),
  CONSTRAINT `fk_event_reviewer` FOREIGN KEY (`reviewed_by`) REFERENCES `admin_users` (`admin_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_academic_profile`
--

DROP TABLE IF EXISTS `member_academic_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_academic_profile` (
  `member_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `qualification` text COLLATE utf8mb4_unicode_ci,
  `research_guideship` text COLLATE utf8mb4_unicode_ci,
  `expertise` text COLLATE utf8mb4_unicode_ci,
  `linkedin` text COLLATE utf8mb4_unicode_ci,
  `orcid` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_scholar` text COLLATE utf8mb4_unicode_ci,
  `photo_url` text COLLATE utf8mb4_unicode_ci,
  `source_record` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`member_id`),
  CONSTRAINT `fk_member_academic_profile` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_academic_profile`
--

LOCK TABLES `member_academic_profile` WRITE;
/*!40000 ALTER TABLE `member_academic_profile` DISABLE KEYS */;
INSERT INTO `member_academic_profile` VALUES ('ICMT001',NULL,'M Com MBA UGC-NET Ph D',NULL,'Finance, Academic Writing',NULL,NULL,NULL,NULL,NULL),('ICMT002',NULL,'MBA, Ph.D',NULL,'Logistics and Supply Chain Management',NULL,NULL,NULL,NULL,NULL),('ICMT003',NULL,'MBA',NULL,'Finance and Economics',NULL,NULL,NULL,NULL,NULL),('ICMT004',NULL,'MBA, UGC NET (Ph.D)',NULL,'HR, Corporate Governance, Operation Management, Industrial Laws & Business Laws',NULL,NULL,NULL,NULL,NULL),('ICMT005',NULL,'Ph.D','Banaras Hindu University','Finance, Corporate Governance, Securities Law & Capital Market, Sustainability, ESG & Ethics',NULL,NULL,NULL,NULL,NULL),('ICMT006','1988-06-15','MBA, LL.B',NULL,'Commerce, Management, Law',NULL,NULL,NULL,'/uploads/member_photos/cc9f2224f7164ddd9dee8b90111a04a5.jpg',NULL),('ICMT007',NULL,'MSW(IRand Labour Welfare), MBA (HR), Ph.D',NULL,'Core HR Activities and Organizational Development',NULL,NULL,NULL,NULL,NULL),('ICMT008',NULL,'MBA, Ph.D',NULL,'Marketing and Strategy',NULL,NULL,NULL,NULL,NULL),('ICMT009',NULL,'M.Com, Ph.D',NULL,'Senior Professor',NULL,NULL,NULL,NULL,NULL),('ICMT010',NULL,'MBA, APSET, (Ph.D)',NULL,'HRM',NULL,NULL,NULL,NULL,NULL),('ICMT011',NULL,'M.Com, MBA, MA.Eco, NET, KSET, (Ph.D)',NULL,'Research methodology, Quantitative techniques, Income tax, & GST',NULL,NULL,NULL,NULL,NULL),('ICMT012',NULL,'Ph.D(Social Work) & Ph.D(Management)',NULL,'HR, HRD, HRM, General Management, OB- +91 98809 86979 Organisational Behaviour, Cultural Studiest',NULL,NULL,NULL,NULL,NULL),('ICMT013',NULL,'Ph.D',NULL,'40+ years of experience in academics, mentor, and resource person',NULL,NULL,NULL,NULL,NULL),('ICMT014',NULL,'MBA',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT015',NULL,'Ph.D, MBA, M.Com, PGDHRM',NULL,'Financial Management & Human Resource Management',NULL,NULL,NULL,NULL,NULL),('ICMT016',NULL,'MA, MBA, Ph.D',NULL,'Entrepreneurship & Design Thinking',NULL,NULL,NULL,NULL,NULL),('ICMT017',NULL,'M.Com',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT018',NULL,'B. Sc, M. Sc, MBA, PGDMLE, M. Phil, Ph.D',NULL,'Hospital and Health systems Management',NULL,NULL,NULL,NULL,NULL),('ICMT019',NULL,'MA',NULL,'-',NULL,NULL,NULL,NULL,NULL),('ICMT020',NULL,'MBA,BL,M Phil.Ph.D., UGC NET',NULL,'Human Resource Management',NULL,NULL,NULL,NULL,NULL),('ICMT021',NULL,'Ph. D',NULL,'Entrepreneurship',NULL,NULL,NULL,NULL,NULL),('ICMT022',NULL,'MBA M.COM Ph.D',NULL,'Financial Markets and ED',NULL,NULL,NULL,NULL,NULL),('ICMT023',NULL,'MBA, Ph.D',NULL,'Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT024',NULL,'MBA, Ph.D',NULL,'Retail Management & Marketing Management',NULL,NULL,NULL,NULL,NULL),('ICMT025',NULL,'MBA',NULL,'Power BI, SPSS',NULL,NULL,NULL,NULL,NULL),('ICMT026',NULL,'MBA Ph. D., FDP(IIMA)',NULL,'Advertising and Brand Management',NULL,NULL,NULL,NULL,NULL),('ICMT027',NULL,'M.Com,(Ph.D)',NULL,'Accounts, Finance, and Taxation',NULL,NULL,NULL,NULL,NULL),('ICMT028',NULL,'M.Com, MBA, Ph.D',NULL,'Commerce and Management',NULL,NULL,NULL,NULL,NULL),('ICMT029',NULL,'Ph.D',NULL,'Financial Markets',NULL,NULL,NULL,NULL,NULL),('ICMT030',NULL,'PhD',NULL,'Finance and Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT031',NULL,'Ph.D',NULL,'Operations, Marketing, Supply Chain, IT & Analytics and Healthcare Management',NULL,NULL,NULL,NULL,NULL),('ICMT032',NULL,'M. Com, PGDHRM, (Ph D)',NULL,'Banking & Finance',NULL,NULL,NULL,NULL,NULL),('ICMT033',NULL,'M.Com, M. Phil, Ph.D',NULL,'Marking Management and HR',NULL,NULL,NULL,NULL,NULL),('ICMT034',NULL,'M. Com, PhD',NULL,'Finance',NULL,NULL,NULL,NULL,NULL),('ICMT035',NULL,'MBA, M.Com., Ph.D',NULL,'Finance',NULL,NULL,NULL,NULL,NULL),('ICMT036',NULL,'MBA (Finance), NET, Ph.D',NULL,'Financial Inclusion, Green Finance, Technology for Teachers, Higher Education',NULL,NULL,NULL,NULL,NULL),('ICMT037',NULL,'B.E.,MBA., MS (IBnE) Sweden., Ph.D',NULL,'Supply Chain Management, & Operations Management',NULL,NULL,NULL,NULL,NULL),('ICMT038',NULL,'MBA, M.Com, MPhil & PhD',NULL,'Taxation, Finance, & Management',NULL,NULL,NULL,NULL,NULL),('ICMT039',NULL,'MA, MBA, Ph.D',NULL,'HRM & IR',NULL,NULL,NULL,NULL,NULL),('ICMT040',NULL,'PhD (Management), PGCert (UK), FHEA (UK)',NULL,'HR, Strategy, Leadership, Teaching Andragogy, Academic Assessment',NULL,NULL,NULL,NULL,NULL),('ICMT041',NULL,'MBA, PGDCA, Ph.D',NULL,'Entrepreneurship, Strategy, HRM, Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT042',NULL,'M.Com, Ph.D',NULL,'GST, Taxation & Accounts',NULL,NULL,NULL,NULL,NULL),('ICMT043',NULL,'MBA, Ph.D',NULL,'Strategic Management, Marketing Management, HRM',NULL,NULL,NULL,NULL,NULL),('ICMT044',NULL,'RAHMANI',NULL,'Communication Skill, Managerial Skill',NULL,NULL,NULL,NULL,NULL),('ICMT045',NULL,'MCom',NULL,'Commerce',NULL,NULL,NULL,NULL,NULL),('ICMT046',NULL,'MBA, Ph.D',NULL,'Marketing Management, Entrepreneurship, Design Thinking, Innovation',NULL,NULL,NULL,NULL,NULL),('ICMT047',NULL,'Ph.D',NULL,'Finance and Accounting-',NULL,NULL,NULL,NULL,NULL),('ICMT048',NULL,'MBA, Ph.D, CS(Inter)',NULL,'Finance and Analytics',NULL,NULL,NULL,NULL,NULL),('ICMT049',NULL,'Ph.D',NULL,'Human Resource Management & Organisational Behavior',NULL,NULL,NULL,NULL,NULL),('ICMT050',NULL,'PhD',NULL,'Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT051',NULL,'MBA, Ph.D',NULL,'Human Resources, Design Thinking, Team Building, Leadership, Communication',NULL,NULL,NULL,NULL,NULL),('ICMT052',NULL,'MBA.,M.Phil.,Ph.D',NULL,'Human Resource Management',NULL,NULL,NULL,NULL,NULL),('ICMT053',NULL,'MBA, M.Sc., Ph.D',NULL,'Human Resources Management, Organizational Behaviour, Sustainable Development, Psychology',NULL,NULL,NULL,NULL,NULL),('ICMT054',NULL,'M.B.A., M.Phil., Ph.D',NULL,'Contemporary Marketing, Contemporary Digital Technology, Contemporary Business Management',NULL,NULL,NULL,NULL,NULL),('ICMT055',NULL,'M.Com',NULL,'-',NULL,NULL,NULL,NULL,NULL),('ICMT056',NULL,'MBA',NULL,'Marketing & Tourism',NULL,NULL,NULL,NULL,NULL),('ICMT057',NULL,'M.Com, CS, CMA, LLB, LLM, Ph.D. MFM',NULL,'Finance, Banking, Taxation, & Law',NULL,NULL,NULL,NULL,NULL),('ICMT058',NULL,'MBA,M.Com, Ph.D',NULL,'Marketing Management & Systems',NULL,NULL,NULL,NULL,NULL),('ICMT059',NULL,'MBA, Ph.D',NULL,'Behavioral Science',NULL,NULL,NULL,NULL,NULL),('ICMT060',NULL,'M.Com, MTTM, NET, JRF, KSET, Ph.D',NULL,'Accounts, taxation, social entrepreneurship',NULL,NULL,NULL,NULL,NULL),('ICMT061',NULL,'B.E., MBA, PhD',NULL,'Supply chain Management and Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT062',NULL,'Ph.D',NULL,'Commerce, Management, Finance, Entrepreneurship, Soft Skills, Corporate Grooming, Marketing, International Business, HRM',NULL,NULL,NULL,NULL,NULL),('ICMT063',NULL,'MMS, Ph.D',NULL,'ESG and Climate Finance',NULL,NULL,NULL,NULL,NULL),('ICMT064',NULL,'M. Com., MBA., M.Phil., Ph.d',NULL,'HRM, Marketing, Finance, and OB',NULL,NULL,NULL,NULL,NULL),('ICMT065',NULL,'Ph.D., M.Com.,MBA',NULL,'Finance & Financial Analytics, Statistics, Sustainability & Inclusive Economy',NULL,NULL,NULL,NULL,NULL),('ICMT066',NULL,'MCA,MBA HR,IT, SYSTEM PGDCA',NULL,'Agile Project Management & SPM, HR, IT,HRIS',NULL,NULL,NULL,NULL,NULL),('ICMT067',NULL,'Ph. D',NULL,'Management',NULL,NULL,NULL,NULL,NULL),('ICMT068',NULL,'MBA, M.Com, Ph.D',NULL,'Entrepreneurship, Marketing, General Management, & HR',NULL,NULL,NULL,NULL,NULL),('ICMT069',NULL,'Ph.D',NULL,'Research Methodology & Finance',NULL,NULL,NULL,NULL,NULL),('ICMT070',NULL,'MBA, MCom, Ph.D',NULL,'Personality Development, Marketing Management, Qualitative Research, Entrepreneurship. Startups, IIC',NULL,NULL,NULL,NULL,NULL),('ICMT071',NULL,'Ph.D, M.Phil, MBA,M.Com',NULL,'Finance and Accounting',NULL,NULL,NULL,NULL,NULL),('ICMT072',NULL,'MBA, Ph.D',NULL,'Tourism Management',NULL,NULL,NULL,NULL,NULL),('ICMT073',NULL,'M.com., M.Phil., MBA , SLET., Ph.D',NULL,'Income tax, Financial Management, IKS, OBE, Financial Inclusion, Financial Literacy, Indolog',NULL,NULL,NULL,NULL,NULL),('ICMT074',NULL,'MBA, Ph. D',NULL,'SPSS, R Programming, OB, Services Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT075',NULL,'M.COM., M.Phil.,M.F.M. PGDBA.,Ph.D.,UGC (NET)',NULL,'Finance, Banking, HRM and cooperation',NULL,NULL,NULL,NULL,NULL),('ICMT076',NULL,'MBA., M.Com (Gold Medalist), Ph.D',NULL,'15+ years of experience',NULL,NULL,NULL,NULL,NULL),('ICMT077',NULL,'MBA, M.Com, Ph.D',NULL,'Marketing and HR',NULL,NULL,NULL,NULL,NULL),('ICMT078',NULL,'MBA, M.Com, PhD',NULL,'HRM, Marketing, Finance, and OB',NULL,NULL,NULL,NULL,NULL),('ICMT079',NULL,'Ph.D',NULL,'Management and Commerce',NULL,NULL,NULL,NULL,NULL),('ICMT080',NULL,'MBA, Ph.D',NULL,'Quantitative Analysis (SPSS, AMOS, Smart PLS, Jamovi, R, Python), Qualitative Analysis (Nvivo, Organe, Vos Viewer)',NULL,NULL,NULL,NULL,NULL),('ICMT081',NULL,'M.COM,M.BA,MSW, B.ED,SET, TET, PGDCA, TALLY',NULL,'ACCOUNTING, FINANCE, SUSTAINABAILITY, HR, BANKING, INSURANCE',NULL,NULL,NULL,NULL,NULL),('ICMT082',NULL,'M.COM, NET, KSET',NULL,'-',NULL,NULL,NULL,NULL,NULL),('ICMT083',NULL,'MBA',NULL,'Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT084',NULL,'MBA.M.Com,SET',NULL,'Accounting',NULL,NULL,NULL,NULL,NULL),('ICMT085',NULL,'PhD, MCOM, MBA',NULL,'IKS and Blockchain',NULL,NULL,NULL,NULL,NULL),('ICMT086',NULL,'M.Com, Ph. D',NULL,'AI in Finance',NULL,NULL,NULL,NULL,NULL),('ICMT087',NULL,'MBA Ph.D',NULL,'NILL',NULL,NULL,NULL,NULL,NULL),('ICMT088',NULL,'Ph.D',NULL,'SPSS, AMOS and SMART PLS & IBM certified SSPS trainer',NULL,NULL,NULL,NULL,NULL),('ICMT089',NULL,'MBA. M.Com, Ph.D',NULL,'Investment',NULL,NULL,NULL,NULL,NULL),('ICMT090',NULL,'M.TECH',NULL,'Food Packaging',NULL,NULL,NULL,NULL,NULL),('ICMT091',NULL,'MBA, MPhil, PhD, UGC NET',NULL,'Digital marketing, Marketing, Business Analytics, Logistics and HRM',NULL,NULL,NULL,NULL,NULL),('ICMT092',NULL,'M.Com',NULL,'Research, Accounting and Finance',NULL,NULL,NULL,NULL,NULL),('ICMT093',NULL,'M.Com. , LL.B. , Ph.D. , ACMA , CS',NULL,'Organisational Behaviour, General, Strategic, Quality, Marketing, Human Resources, Cost & Management Accounting',NULL,NULL,NULL,NULL,NULL),('ICMT094',NULL,'MBA Ph. D PDF',NULL,'Finance',NULL,NULL,NULL,NULL,NULL),('ICMT095',NULL,'Ph.D',NULL,'Organisation behaviour, HR and Entrepreneurship Innovation',NULL,NULL,NULL,NULL,NULL),('ICMT096',NULL,'MBA,MA-HRM,Ph.D',NULL,'HRM and Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT097',NULL,'D.Litt.,Ph.D',NULL,'Finance & Accounting, Corporate Governance',NULL,NULL,NULL,NULL,NULL),('ICMT098',NULL,'MBA, Ph.D',NULL,'Finance (capital markets, derivatives, advanced financial instruments)',NULL,NULL,NULL,NULL,NULL),('ICMT099',NULL,'MBA',NULL,'SQL, Power BI, Oracle O2C, Soft Skills, Advanced Excel Employability',NULL,NULL,NULL,NULL,NULL),('ICMT100',NULL,'MBA, M.Phil, MA, Ph.D, Post Doctoral',NULL,'Finance, NBA, & NAAC',NULL,NULL,NULL,NULL,NULL),('ICMT101',NULL,'M.Com, LLB, Ph.D',NULL,'Happiness, Human Well-Being, HR, Strategy, Higher Education',NULL,NULL,NULL,NULL,NULL),('ICMT102',NULL,'PhD, MEd(ID)',NULL,'Applied Psychology and Behavioral Sciences',NULL,NULL,NULL,NULL,NULL),('ICMT103',NULL,'BBA, MBA, LLM, Ph.D',NULL,'Marketing & Marketing Analytics',NULL,NULL,NULL,NULL,NULL),('ICMT104',NULL,'BBM, PGDM (Marketing), (PhD)',NULL,'Sales and Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT105',NULL,'Ph.D',NULL,'Marketing',NULL,NULL,NULL,NULL,NULL),('ICMT106',NULL,'MBA, MPhil, PhD',NULL,'Services Marketing, Logistics management',NULL,NULL,NULL,NULL,NULL),('ICMT107',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. ANKIT KUMAR KATIYAR, Assistant Professor, College of management studies, Department of Business Administration, Ragendra Swarup Knowledge city, near Azad marg churaha, unnao, Uttar pradesh, 209862'),('ICMT108',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Ansha Gupta, Assistant Professor, MKES Institute of Management Studies and Research, Mumbai'),('ICMT109',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Anson C J, Assistant Professor, Madras Christian College'),('ICMT110',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. ANUJ SHEOPURI, Professor, Department of Management, HIMT, Knowledge Park - 1, Greater Noida, 201310'),('ICMT111',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. ANUSHKA KULKARNI, Associate Professor, School of Creative Studies, DY Patil Deemed to be University, Center of Excellence, Sector 7, Nerul East, Navi Mumbai, 400706'),('ICMT112',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. APARNA SAMUDRA, Associate Professor, Department of Economics, RTM Nagpur University, University Campus, Amravati Road Nagpur, 440033'),('ICMT113',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. ARINI ROYCHOUDHURY, Research Scholar, Guru Ghasidas Vishwavidyalaya, Bilaspur Chhattisgarh, 495009'),('ICMT114',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. ARLA NAGARAJESH, Assistant Professor, Siddartha Educational Academy Group of Institutions (Autonomous), C. Gollapalli, Tirupati, AP, 517505'),('ICMT115',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. ARUNA DESHPANDE, Professor, ADMIFMS, University of Mumbai, Kalina, Santacruz East, Mumbai, 400098'),('ICMT116',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Ashok Kumar, Assistant Professor, GDC Shri Renuka Ji at Dadhu, District Sirmour HP (Department of Higher Education HP (College Cadre), Department of Economics, 173022'),('ICMT117',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. AYUSHI TIWARI, Assistant Professor, SCOPE GLOBAL SKILLS UNIVERSITY - Scope Campus, NH-12, Near Misrod, Village- Bhairopur, Hoshangabad Road, Bhopal ., 462026'),('ICMT118',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. B. SAI SANDHYA, Assistant Professor, Sanskrithi School of Business, Department of Management Behind Sri Sathya Sai Super Speciality Hospital, Prashantigram, Puttaparthi Sri Sathya Sai District, Andhra Pradesh, 515134'),('ICMT119',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. B SARATH SIMHA, Associate Professor, KLH Global Business School'),('ICMT120',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. BHABANI SHANKAR PADHY, Associate Professor, Sanskrithi School of Business'),('ICMT121',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. BIKASH KUMAR AGARWALLA, Head of the Department, Euro School, Whitefield, Bengaluru, Karnataka'),('ICMT122',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Brindha Natarajan, Assistant Professor, Shrimati Indira Gandhi college, Trichy'),('ICMT123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DR CH KRISHNUDU, Assistant Professor, SKIM, SKU, ANANTHAPUR'),('ICMT124',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. CHACKO JOSE P, Professor, St Aloysius College, Elthuruth, Thrissur, Kerala, 680611'),('ICMT125',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mrs. CHARU GOYAL, Assistant Professor, Parul Institute of Business Administration, faculty of Management Studies, Parul University'),('ICMT126',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. D. ANJANEYULU, Principal, Dept. of Commerce, Sri Krishnadevaraya University, Ananthapuramu, Andhra Pradesh, 515003'),('ICMT127',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. D Asok, Assistant Professor, Sri Ramachandra Institute of Higher Education and Research, porur chennai'),('ICMT128',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. D. DHANASEKAR, Assistant Professor, Department of Management, Shrimati Indira Gandhi College, Tiruchirappalli, 620002, nt'),('ICMT129',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DANISH KHAN, Assistant Professor, St. Joseph’s College of Commerce (Autonomous), Bengaluru, Karnataka'),('ICMT130',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DASARI RAJESH BABU, Associate Professor, Mohan Babu University, SOCM, TIRUPATHI, Sree Sainath Nagar, Sree Vidyanikethan, Tirupati, Kotala, Andhra Pradesh, 517102'),('ICMT131',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DEBASIS MOHAPATRO, Assistant Professor, School of Management Studies'),('ICMT132',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DEBASRI DEY, Associate Professor, BRAINWARE UNIVERSITY, Department of Management, West Bengal, India'),('ICMT133',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. DEBAYAN KANTY BOSE, Assistant Professor, Presidency University, Bangalore'),('ICMT134',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. DEEP, Assistant Professor, Emeritus'),('ICMT135',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DEEPIKA CHAUDHARY, Assistant Professor, K R Mangalam University, School of Management and Commerce'),('ICMT136',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Deepika Gautam, Assistant Professor, Himachal Pradesh National Law University Shimla, 171014'),('ICMT137',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DEVANJALI DUTTA, Assistant Professor, K.M Agrawal College of Arts Commerce and Science, Maharashtra, 421301'),('ICMT138',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. DEVANSHU MONGA, Research Scholar, HPKV Business School, Central University of Himachal Pradesh, Dharamshala, India, 176215'),('ICMT139',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DEVRSHI UPADHAYAY, Associate Professor, GLS University, Ahmedabad'),('ICMT140',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. DHARAVATH POOLSINGH, Assistant Professor, Professional Jayashankar Telangana Agricultural University, School of Agribusiness management, Hyderabad, Rajendra Nagar, Telangana, 500030'),('ICMT141',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DILEEP KUMAR M, Professor, Hensard University, Bayelsa State, Nigeria. .'),('ICMT142',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Abhishek Kumar Singh, Research Scholar'),('ICMT143',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Sailaja Vasakarla, Assistant Professor, SKIM, Sri Krishnadevaraya University, Anantapur'),('ICMT144',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SUGANYA SUBRAMANIYAM, Assistant Professor, School of Management Studies, REVA University'),('ICMT145',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. DUSHAN KESHAWA DEEMANTHA PERERA, Head of the Department, Former Head of the Department (for International Programmes), Department of Management, Faculty of Management, Humanities and Social Sciences, Saegis Campus, Nugegoda, Colombo, Sri Lanka'),('ICMT146',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. ELIZABETH DIAS, Assistant Professor, NMIMS Centre for International Studies, Vile Parle, Mumbai'),('ICMT147',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. FATAI KAYODE WAHAB, Research Scholar, Centre for General Studies, Federal University of Medicine and Medical Sciences Abeokuta, Nigeria'),('ICMT148',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. G PRASANNA KUMAR, Assistant Professor, Department of Management Studies, Pragati Engineering college, Surampalem.'),('ICMT149',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. G RAMAKRISHNA REDDY, Professor, Sri Ramakrishna Degree &PG College (Autonomous), Nandyal'),('ICMT150',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. GAIKAR VILAS B., Professor, Dept of Economics and Business Economics, Smt. CHM College (Autonomous)Ulhasnagar, Dist-Thane Maharashtra'),('ICMT151',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Dr GANAPATHI JAGARAPU, Assistant Professor, Department of MBA Loyola academy Hyderabad'),('ICMT152',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. GAURAV, Assistant Professor, Bharati Vidyapeeth University, Finance, Pune Maharashtra, 411033'),('ICMT153',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. GAURAV MITRA, Research Scholar, Finance and Accouting area at FORE School of Management- Adhitam Kendra, B-18, Qutub Institutional Area New Delhi, 110016'),('ICMT154',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Gokul K, Assistant Professor, Center for Management Studies, Jain (deemed to be) University, Bengaluru'),('ICMT155',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Dr Gonjipalli Suneetha, Principal, MRM institute of management chintapalli guda village Ibrahimpatnam mandal range reddy district Telangana Hyderabad'),('ICMT156',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. GOVINDAPPA. D, Professor, School of Commerce and Management, Maharani Cluster University Bangalore -560 001'),('ICMT157',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Gowtham Aashirwad Kumar, Assistant Professor, Department of Management Studies, School of Commerce and Management, Bharath Institute of Higher Education and Research, NO-173, Agharam Main Road, Selaiyur, Chennai ., 600073'),('ICMT158',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. GOWTHAMI M, Assistant Professor'),('ICMT159',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mrs. GUDURI SWATHI, Assistant Professor, BIMS, Adoni'),('ICMT160',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. GURU BASAVA ARADHYA S`, Dean, Atria Institute of technology, Hebbala, Bangalore, 560024'),('ICMT161',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Gyan Prakash Mishra, Professor, Madan Mohan Malviya University of Technology, Gorakhpur UP'),('ICMT162',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. HUZAIFA NAXIR, Research Scholar, Department Of Management Studies University Of Kashmir South Campus Highground Fatehgarh Anantnag'),('ICMT163',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. J Rajesh, Dean, Srinath University Jamshedpur Jharkhand'),('ICMT164',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. J.SNEHA JAYALAKSHMI, Assistant Professor, Sanjivani University, kopargaon, Maharashtra, 423603'),('ICMT165',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. JAMSHI J, Assistant Professor, Sacred Heart College, Kochi'),('ICMT166',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. Jayasree S R, Assistant Professor, Meenakshi Sundararajan School of Management, No.363, Arcot road, Kodambakkam, Chennai-24.'),('ICMT167',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. JIGNESH N. VIDANI, Associate Professor, Swarrnim Institute of Management Studies, Urvasad Square, Sarkhej-Gandhinagar Highway, Post Adalaj, Ahmedabad - Gandhinagar Highway, Gujarat ., 382421'),('ICMT168',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. JOMON JOSE M, Associate Professor, Sahrdaya Institute of Management Studies (SIMS), Kodakara, Thrissur, Kerala 680684'),('ICMT169',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. JOY CHAKRABORTY, Assistant Professor, INDIAN INSTITUTE OF SOCIAL WELFARE & BUSINESS MANAGEMENT, DEPARTMENT OF MBA, KOLKATA, 700073'),('ICMT170',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. JYOTI KUKREJA, Assistant Professor, New Delhi Institute of Management'),('ICMT171',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Jyotsna, Associate Professor, Jagan institute of management studies sector-5 Rohini'),('ICMT172',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mrs., K.LALITHA PARAMESHWARI, Assistant Professor, hindusthan college of Arts & Science, Nava India, Coimbatore'),('ICMT173',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. K.Sharath Babu, Professor, Geethanjali College of Engineering and Technology, Department of Management Studies, Cheeryal (V), Keesara (M), Medchal ( Dist.), Hyderabad, Telangana, 501301'),('ICMT174',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KAILASH CHANDRA DASH, Assistant Professor, Parul University, FMS, PIBA, Vadodara, Gujarat'),('ICMT175',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr Kamal Agal, Associate Professor, Associate Professor School of Management Studies Gujarat Technological University Ahmedabad Gujarat'),('ICMT176',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Kamlesh Kumar Maurya, Assistant Professor, UPES Dehradun Uttarakhand'),('ICMT177',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KAUSIK MUKHERJEE, Dean, DEAN. AKS UNIVERSITY SATNA MP INDIA'),('ICMT178',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KAVITA DIVE, Head of the Department, Sanjivani University, Kopargoan SCM Commerce Department'),('ICMT179',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Keerthi jain, Assistant Professor, VIT-AP University School of Business'),('ICMT180',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Dr Kiran Kumar Thoti, Professor, Vidya Vikas Institute of Engineering and Technology, Mysore, Karnataka, India'),('ICMT181',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Kiran Maney, Associate Professor, Acharya Institute of Graduate Studies, Dept of MBA Dr. S. Radhakrishnan Road, Acharya P.O, Soladevanahalli, Bangalore, 560107'),('ICMT182',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KIRTI SINGH, Assistant Professor, Department of Commerce, Faculty of Commerce & Business Delhi School of Economics, University of Delhi'),('ICMT183',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KOLACHINA SRINIVAS, Director, Skyline University Nigeria'),('ICMT184',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KRISHN AWATAR GOYAL, Professor, Head, Department of Business Finance & Economics, Jai Narain Vyas University, Jodhpur, 342001'),('ICMT185',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. KRISHNA PRAKASH M, Research Scholar, SRMIST, Chennai, 603203'),('ICMT186',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Krishnan Sampath, Professor, Freelancer'),('ICMT187',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KULVINDER KAUR, Professor, KC College, HSNC University, Mumbai .'),('ICMT188',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Kumardatt Ganjre, Professor, Sankalp Business School, pune'),('ICMT189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KURUVA MADDILETI, Assistant Professor, Department of Commerce, Sri krishnadevaraya University, Anantapuramu, Andhra Pradesh a, 515003'),('ICMT190',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. KUSHAGRA SHARAN, Assistant Professor, IILM Lucknow'),('ICMT191',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. LAKSHMAN SINGH, Head of the Department, Hindustan Aeronautics Limited, Planning & Projects, Avionics Division-Korwa, Amethi, 227412'),('ICMT192',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. LAKSHMINARAYANA K, Assistant Professor, Visvesvaraya Technological University, Department of Master of Business Administration, Center for Post Graduate Studies-Muddenahalli, Chickballapura Tq and District Karnataka, 562101'),('ICMT193',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. LALY ANTONEY, Principal, VISAT Arts and Science. College'),('ICMT194',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. LATEEF OKIKIOLA OLANIPEKUN, Associate Professor, Accra Institute of Technology'),('ICMT195',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. LEENA, Assistant Professor, Jaipuria School of business, Indirapuram, Ghaziabad'),('ICMT196',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. LINET CHRISTILDA GNANALILLY R, Dean, Women\'s Christian College, PG Dept of Commerce, Chennai -06'),('ICMT197',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MAHENDER PAL, Assistant Professor, Department of Commerce, Govt. Post Graduate College, Hisar, Haryana (India), 125001'),('ICMT198',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Mahesh Bendigeri, Dean, Global Business School Hubli, Beside Bellad Hyundai Showroom, opp Hubballi Residency, Bhairidevarakoppa, Hubli, 580025'),('ICMT199',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MALATHI GOTTUMUKKALA, Assistant Professor, Central University of Andhra Pradesh, Management, Anantapur'),('ICMT200',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MALAY PATEL, Associate Professor, Karnavati University, Design Management, Gandhinagar'),('ICMT201',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MALIKA SUBHASHISH JAIN, Assistant Professor, MIT WPU'),('ICMT202',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MALLIKARJUN MARADI, Dean, Bagalkot University Jamkhandi and Department of Commerce'),('ICMT203',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. MANISHA KALRA, Assistant Professor, Guru Kashi University, Department Of Commerce & Management, Talwandi Sabo, Bathinda, Punjab, 151302'),('ICMT204',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. MANU G C, Research Scholar, IIM, Raipur'),('ICMT205',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MAYANK RAJ, Assistant Professor, Faculty of Commerce and Management, United University, Rawatpur, Prayagraj, 211012'),('ICMT206',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Michael Vijay Kiran C, Research Scholar, VIT-AP University, School of Business, Amaravati, Andhra Pradesh ., 522237'),('ICMT207',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. Minerva Das, Assistant Professor, PES University, FOMC, Bengaluru'),('ICMT208',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MOHAMED RIAZ, Head of the Department, Jamal Mohamed College of Engineering, Department of Management Studies, Dindigul .'),('ICMT209',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MOHAMMAD ZUBAIR AHMAD, Professor, Utkarsh College of Management Education'),('ICMT210',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MRITYUNJAY KUMAR, Assistant Professor, SOB, Indira University, Pune'),('ICMT211',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. MUHAMMED ALI KT, Dean, Sirajul Huda Institute of Management Studies, Kuttiady, Kozhikode'),('ICMT212',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. Muskaan arora, Assistant Professor, Jb knowledge park college, Faridabad Department of management'),('ICMT213',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. MUTHAMIL ARIVARASI THANGARAJ, Research Scholar, SRM Institute of Science and Technology, Faculty of Management, SRM Nagar, Kattankulathur, Chengalpattu, Tamil Nadu . India, 603203'),('ICMT214',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. N ANITHA, Associate Professor, Annai Women\'s College, Department of Commerce, Punnamchathram, Karur'),('ICMT215',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. N KAVIPRIYA, Assistant Professor, Sri Ramachandra Institute of Higher Education and Research, Chennai, 600110'),('ICMT216',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. N. KUMAR, Assistant Professor, Department of Economics, C. Kandaswami Naidu College for Men (Govt Aided & Affiliated to University of Madras), Anna Nagar East, Chennai Tamil Nadu, 600102'),('ICMT217',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Narayana Engineering College, Dean, Narayana Engineering College, MBA Department, Near Apollo Hospitals, Muthukur Road, Nellore (AP), 524004'),('ICMT218',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NAVJOT KAUR, Assistant Professor, University College Chunni Kalan'),('ICMT219',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NAZISH RAHAT, Assistant Professor, Jamia Hamdard, New Delhi'),('ICMT220',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NDUKA TRUST OBINNA, Associate Professor, Department of Accounting, Philomath University of Nigeria, Abuja'),('ICMT221',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NEENA SINHA, Professor, USMS GGS IP University Dwarka Sector 16 C Delhi, Not provided, 110078'),('ICMT222',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NEHA TYAGI, Associate Professor, NICE SBS, Shobhit University'),('ICMT223',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Nehal shaikh, Assistant Professor, Delhi technological university delhi school of Management'),('ICMT224',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NIDHI KHARE, Associate Professor, Institute of Management Research & Technology Management Park, Vipul Khand - VI, Gomti Nagar, Lucknow, Uttar Pradesh, 226010'),('ICMT225',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NIDHI KHURANA, Assistant Professor, St. Aloysius\' College, Department of Commerce, 1, Ahilya Bai Marg Sadar Pentinaka Jabalpur Madhya Pradesh India'),('ICMT226',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NISHANT KUMAR SINGH, Associate Professor, GNIOT INSTITUTE OF MANAGEMENT STUDIES GREATER NOIDA plot no7 knowlege park 2 greater Noida'),('ICMT227',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NITIN KISHORE SAXENA, Assistant Professor, Nirma University Ahmedabad'),('ICMT228',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NITIN UMAKANT DWIVEDi, Head of the Department, Shambhunath Institute of Engineering & Technology, Prayagraj, 211015'),('ICMT229',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NIYATI PATEL, Principal, Gyanmanjari Innovative University, Bhavnagar, Not provided, 364060'),('ICMT230',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NURADDEEN USMAN MIKO, Professor, Department of Procurement and Supply Chain Management'),('ICMT231',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. NVR Jyoti Kumar, Professor, Vice Chancellor, Sri Krishnadevaraya University, Ananthapuramu AP'),('ICMT232',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. P. CH. PRAVEEN KUMAR, Associate Professor, Sree Rama Engineering CollegeRami Reddy Nagar, Karakambadi Road, Mangalam (B.O), Tirupati, 517507'),('ICMT233',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. P R Jeyalakshmi, Assistant Professor, Dr.John Mathai centre, School of Management studies, Thrissur.'),('ICMT234',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PARVEZ MALEK, Assistant Professor, UKA TARSADIA UNIVERSITY, BARDOLI, GUJARAT'),('ICMT235',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PAWAN KUMAR, Assistant Professor, Faculty of Management and Commerce, SRM University Delhi NCR Sonepat Haryana'),('ICMT236',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PINKI RANI, Associate Professor, IGU Meerpur Rewari Haryana India'),('ICMT237',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PITESHVER RANE, Head of the Department, Mittal Institute of Technology Bhopal'),('ICMT238',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Piyush Ranjan Sahay, Dean, Xavier University Patna'),('ICMT239',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. POOJA ARVINDBHAI PANDYA, Assistant Professor, Department of Forensic Accounting and Fraud Investigation, NSIT-IFSCS (Affiliated to NFSU), Near Swaminarayan Temple, Jetalpur, Ahmedabad, 382427'),('ICMT240',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. POOJA GOYAL, Assistant Professor, Commerce Department, DAV Centenary College, NIT 3 Faridabad, Haryana, 121001'),('ICMT241',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. POOJA RANI, Assistant Professor, Lonza, haryana'),('ICMT242',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Poorva Ranjan, Dean, DMD College, IP University'),('ICMT243',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. PRABHAKARA S, Research Scholar, Symbiosis School for Online and Digital Learning Symbiosis International Deemed University Pune'),('ICMT244',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Prabhakaran Jagadeesan, Associate Professor, ACHARYA BANGALORE B SCHOOL, ANDHRAHALLI MAIN ROAD, BENGALURU KARNATAKA, 560091'),('ICMT245',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PRABIR CHANDRA PADHY, Dean, Faculty of Management, SRM University, Trichy, Tamil Nadu'),('ICMT246',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PRACHI PATHAK, Associate Professor, Doon University, Dehradun'),('ICMT247',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PRASHANT KALSHETTI, Head of the Department, Dr D Y Patil Vidyapeeth Global Business School and Research Centre, 87, Express Bypass, 88, Bengaluru - Mumbai Hwy, Tathawade, Pune, Pimpri-Chinchwad, Maharashtra, 411033'),('ICMT248',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PRASHANT PAREEK, Associate Professor, Shanti Business School, Opposite Vraj Gardens, off SP ring road, Bopal, Shela, Ahmedabad, Gujarat, 380058'),('ICMT249',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Preethi Inampudi, Associate Professor, Department of Management, Surana College, Bengaluru, 560041'),('ICMT250',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. PREETI SONKER, Assistant Professor, JIGYASA UNIVERSITY, School of Business Studies, Dehradun'),('ICMT251',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PREMENDRA SAHU, Associate Professor, MATS UNIVERSITY, RAIPUR'),('ICMT252',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PRIF DR PRIYA SACHDEVA, Professor, Amity University, Noida, Uttar, Pradesh, India'),('ICMT253',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. PRINCE, Research Scholar, Central University of Punjab, Department of Financial Administration, Bathinda (Punjab), 151401'),('ICMT254',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. PRIYADHARSHINI, Associate Professor, SAVEETHA SCHOOL OF MANAGEMENT, BUSINESS ADMINISTRATION, CHENNAI, 600116'),('ICMT255',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. R.Raghavendra Rao, Assistant Professor, Indian Institute of management and Commerce, Department of Business Administration, 6-1-91, Adj. To Telephone Bhavan, Khairatabad, Hyderabad-4'),('ICMT256',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. R S CH MURTHY CHODISETTY, Professor, Vardhaman College of Engineering'),('ICMT257',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RACHNA SINGH, Associate Professor, Professor part-time faculty Magalaytan university aligarh Uttar Pradesh'),('ICMT258',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Rahul Kumar, Assistant Professor, Indian Institute of Management Sambalpur, Basantpur, Near Gosala, Sambalpur, Odisha India, 768025'),('ICMT259',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Dr Raja Sekhar Koduru, Assistant Professor, Government Polytechnic for Women Kakinada'),('ICMT260',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Rajaprabakaran K, Research Scholar, Research Scholar in Management Studies, Bharath Institute higher Education and Education, Selaiyur Chennai, 600073'),('ICMT261',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Rajeshwari Jain, Associate Professor, Som-Lalit Institute of Management Studies, St. Xavier’s Corner, University Road, Navarangpura, Ahmedabad –'),('ICMT262',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RAJIB DUTTA, Professor, Bhawanipur Global Campus, 60 B L Saha Road, Kolkata - 53'),('ICMT263',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RAJJAT BHATTACHAARJEE, Assistant Professor, Nalbari Commerce College, Department of Finance, Nalbari, Assam, 781334'),('ICMT264',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RAJWINDER KAUR, Assistant Professor, School of Legal Studies, CGC University Mohali'),('ICMT265',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RAKESH KUMAR YADAV, Professor, IFTM University, NH-9, Delhi Road, Lodhipur Rajput, Moradabad (UP), 244102'),('ICMT266',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Ravi Kishor Ranjan, Assistant Professor, ASIAN BUSINESS SCHOOL, NOIDA'),('ICMT267',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RAVI KUMAR, Assistant Professor, SVGC GHUMARWIN, BILASPUR, HP, Not provided, 174021'),('ICMT268',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Ravi Rachapudy, Associate Professor, MBA, Dr.K.V.Subba Reddy School of Business Management, Kurnool (A.P)'),('ICMT269',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Reetika Dadheech, Assistant Professor, United World Institute of Management'),('ICMT270',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. REKHA DARBAR, Assistant Professor, Janardan Rai Nagar Rajasthan Vidyapeeth (Deemed-to-be University)'),('ICMT271',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. REKHA NARANG, Professor, Geeta University, School of Commerce and Business Management, Haryana -Panipat, 132145'),('ICMT272',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DR RENU AGARWAL, Assistant Professor, Dpt of Business Administration, SDNB Vaishnav college for Women, Chennai -44'),('ICMT273',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. RICHA GULATI, Assistant Professor, Career Point University Kota, School of Commerce and Management'),('ICMT274',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RICHA MEHTA, Assistant Professor, St Francis College for women, Uma Nagar, 500016'),('ICMT275',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Dr Richa Ramdev Purohit, Assistant Professor, Jai Narayan Vyas University jodhpur'),('ICMT276',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RICHA TIWARI, Professor, CDOE DSU'),('ICMT277',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. RUCHIKA JESWAL, Associate Professor, Amity School of Business, Amity University, NOIDA'),('ICMT278',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. RUPAM KUMAR SAHA, Assistant Professor, NSHM Knowledge Campus Durgapur, West Bengal, India'),('ICMT279',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mrs. S.Aishwarya, Research Scholar, Management Department, SRM Institute of Science and Technology, Kattankulathur, Chengalpattu, 603203'),('ICMT280',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. S Ismail Basha, Associate Professor, Siddhartha Educational Academy Group of Institutions'),('ICMT281',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DR. S. M. ANAS IQBAL, Director, Vishisht School of Management, Near MPEB Office, Pologround, Indore, MP, 452003'),('ICMT282',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. S PADMA, Professor, KL Business School, KLEF Deemed to be University, Vaddeswaram, Guntur, Andhra Pradesh, India'),('ICMT283',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Prof. S. S. Prasada Rao Ph.D, Professor, Dean - Centre for Teaching and Learning, SP Mandali\'s Prin. L.N. Welingkar Institute of Management Development and Research, Matunga, Mumbai, Maharashtra, 400019'),('ICMT284',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. S. VENKATA SIVA KUMAR, Associate Professor, Vardhaman College of Engineering'),('ICMT285',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. SACHIN, Assistant Professor, GJUST, HISAR'),('ICMT286',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. DR. SACHIN GUPTA, Assistant Professor, Department of Business Administration, Mohanlal Sukhadia University, Udaipur Rajasthan, 313001'),('ICMT287',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SAGAR ONKARRAO MANJARE, Professor, Mahatma Gandhi University Meghalaya'),('ICMT288',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SAGAR S TANNA, Assistant Professor, Tolani Motwane Institute of Management Studies, Adipur, 370205'),('ICMT289',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. SAHAR B KAPDI, Head of the Department, Terna Global Business School, Navi Mumbai'),('ICMT290',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SAJAD AHMAD MIR, Assistant Professor, Guru Kashi University Talwandi Sabo Bathinda'),('ICMT291',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. SAKSHI MITTAL, Assistant Professor, Inmantec Institutions, Commerce Dept, Ghaziabad'),('ICMT292',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SATULURI PADMA, Professor, Department of MBA, KL Business School, KLEF Deemed to be University, Vaddeswaram, Guntur, Andhra Pradesh, India. ., 522022'),('ICMT293',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Satya Narayan Singh, Associate Professor, Institute of Advanced Research Gandhinagar'),('ICMT294',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. SAURABH SHARMA, Research Scholar, Guru Ghasidas Vishwavidyalaya Bilaspur Chhattisgarh, 495009'),('ICMT295',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SEEMA VARSHNEY, Assistant Professor, Gulf College'),('ICMT296',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHAILESH TRIPATHI, Professor, Sri Balaji University Pune'),('ICMT297',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Dr. Shalini Singh, Associate Professor, Head, Department of MBA, Cambridge Institute of Technology, Ranchi'),('ICMT298',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHANTANU SAURABH, Assistant Professor, DAV PG College, Banaras Hindu University'),('ICMT299',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHAUNAK ROY, Assistant Professor, St. Xavier\'s College (Autonomous), Kolkata. 30, Mother Teresa Sarani, Kolkata ., 700016'),('ICMT300',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHIKHA MITTAL, Associate Professor, Raj kumar goel Institute of technology Ghaziabad'),('ICMT301',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHILPA TANDON, Associate Professor, AIMT'),('ICMT302',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHINKI K PANDEY, Assistant Professor, Kalinga University, Department of Management, Kotni, Naya Raipur, Raipur, CG, 492001'),('ICMT303',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHIVANI SHARMA, Assistant Professor, Prestige Institute of Management and Research Gwalior, Department of Management, Airport Road, Opposite Deendayal Nagar, Gwalior - 474 020'),('ICMT304',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. SHREEKANTHA JAYARAMA ACHARI, Assistant Professor, AITM'),('ICMT305',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHRIKRISHNA DHALE, Dean, Kalinga University, Naya Raipur'),('ICMT306',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SHRIPAD KARJATKAR, Assistant Professor, Management Bharati University pune'),('ICMT307',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. SHRIYA.K, Research Scholar, Faculty of Management Srm Institute of Science and Technology'),('ICMT308',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Shubham Singh Chandel, Assistant Professor, Kalinga University, Naya Raipur, Chhattisgarh'),('ICMT309',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. SIMRAN SINGH, Research Scholar, IBM, Not provided, Not provided, 9431314830, 6299747772, Simran97sin@gmail.com, Finance & Hunam Resource'),('ICMT310',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Sindhu P, Assistant Professor, SRM Trichy Arts and Science College, Not provided, Not provided, +919698355454, +919698355454, sindhubps@gmail.com, Management'),('ICMT311',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SIRAJ K K, Assistant Professor, Modern College of Business and Science, Not provided, Not provided, 00919497243430, 00919497243430, siraj@hotmail.co.in, Sustainable Finance'),('ICMT312',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. SIVARAMAN V S, Head of the Department, Jairam Public School, Salem, Not provided, 636008, +919894245950, 9894245950, vssivaraman86@gmail.com, CBSE ACCOUNTS, ECONOMICS'),('ICMT313',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SMITA IYER, Assistant Professor, St.Kabir Institute of Professional Studies, Off, Priyakant Parikh Marg, Near SAL Hospital, Ghosha Society, Thaltej, Ahmedabad, Gujarat, 380054, +919824547489, +919824547489, iyersmita14@gmail.com, HR,OB and general management'),('ICMT314',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SMRITI PATHAK, Associate Professor, PCCOER, BCA BBA Department, Ravet, Pune, 412101, +919730007082, +919730007082, smritiapathak@gmail.com, Finance, Data Analytics'),('ICMT315',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SONAL AGARWAL, Assistant Professor, DEPT OF MANAGEMENT STUDIES, INDIAN INSTITUTE OF INFORMATION TECHNOLOGY ALLAHABAD, DEVGHAT, JHALWA, PRAYAGRAJ U. P. INDIA, 211015, 91-9452598040, 91-9452598040, sonalhere@gmail.com, HRM, FINANCE'),('ICMT316',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. Sripriya, Assistant Professor, Ashoka school of Business, Not provided, Not provided, +91 9100710329, +91 9100710329, bsripriya1312@gmail.com, Management, human resources, entrepreneurship, Business communication, organizational behavior, Leadership'),('ICMT317',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SUBASH CHANDRA NATH, Professor, FMS'),('ICMT318',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Sudha Bishnoi, Assistant Professor, Gurmeet Singh Ghanshyam Dass Girls College, Padampur, Shri Ganganagar, Rajasthan, 335041'),('ICMT319',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SURENDAR GADE, Assistant Professor, SVKM\'s Narsee Monjee Institute of Management Studies (NMIMS) Deemed to be University, Hyderabad'),('ICMT320',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SURENDRA BHADU, Research Scholar, Department of Business Finance and Economics Jai Narain Vyas University, Jodhpur, 342001'),('ICMT321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Swati Khanna, Associate Professor, IILM Institute for Higher Education'),('ICMT322',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms., SWATI SHARMA, Research Scholar'),('ICMT323',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. SYED JAFFER, Assistant Professor, Gitam University, Accounting and finance department, Rudraram, Sangareddy District, Patancheru Mandal.Hyderabad.'),('ICMT324',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. T BHASKARA REDDY, Head of the Department, Department of Computer Science & Technology, Sri Krishnadevaraya University Anantapuram'),('ICMT325',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. TANVEER AHMED, Assistant Professor, Government Degree College Kilhotran University of jammu'),('ICMT326',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. TRINKUL KALITA, Assistant Professor, Assam down town University, Commerce and Management, Guwahati'),('ICMT327',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Tushar Dhiman, Assistant Professor, Faculty of Management Studies, Gurukula Knagri (Deemed to be University) Haridwar, Uttarakhand.'),('ICMT328',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. VAIBHAV PARMANAND GALLANI, Assistant Professor, Shri K.K. Shastri Government Commerce College/Department of Accountancy/Maninagar.'),('ICMT329',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. VANSHIKA THAKUR, Research Scholar, Guru Ghasidas Vishwavidyalaya, Department of Commerce, Bilaspur, Chhattisgarh-'),('ICMT330',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mrs. Varsha Jha, Assistant Professor, Oriental College of Technology, Management Department, Patel Nagar Bhopal-'),('ICMT331',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Varshini S K, Assistant Professor, Seshadripuram College, PG Department of Business Administration, Nagappa Street, Seshadripuram, Bangalore-'),('ICMT332',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. VIBHA BHANDARI, Assistant Professor, University of Technology and Applied Sciences, PO Box 477, PC 711, Nizwa, Oman'),('ICMT333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Vidhi Jalan, Assistant Professor, ALARD University, ASBM, ALARD Knowledge Park, Survey No. 47 and 50, Near Rajiv Gandhi IT Park, Marunji, Hinjawadi, Pune, 411057'),('ICMT334',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. VIKHYAT PANDEY, Assistant Professor, Prestige Institute Of Management and Research Gwalior Madhya Pradesh India'),('ICMT335',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. VIKHYAT PANDEY, Assistant Professor, Prestige Institute Of Management and Research, Gwalior, Madhya Pradesh India'),('ICMT336',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. VISHWAS GUPTA, Assistant Professor, Symbiosis Centre for Management Studies, Sector 62, Noida-'),('ICMT337',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mr. Vivek Kumar Singh Jha, Assistant Professor, Sandip University, Management, Sijoul Madhubani Bihar.'),('ICMT338',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ms. Vriti Bhatia, Assistant Professor, DAV institute of management.'),('ICMT339',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. VYOMKESH BHATT, Assistant Professor, Uttaranchal Institute of Management, Uttaranchal University, Dehradun, Uttarakhand-'),('ICMT340',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Yachna Ramesh Gharde, Associate Professor, Arihant Institute of business management, Arihant Institute Of Business Management, Near, Sr. No. 276/1/2, 277/1/2, 278/2, Mumbai Hwy, Near Crystal Honda Showroom, Uttam Nagar, Bhunde Vasti, Bavdhan, Pune, Maharashtra'),('ICMT341',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Yaduvamsi Sai Krishna C, Assistant Professor, ICFAILAWSCHOOL, IFHE (Deemed to be University under sec. of the UGC Act 1956), Donthanpally, ShankarpallyRoad, Hyderabad'),('ICMT342',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. YOGESH MEHTA, Professor, SOCM, SGT University, Gurugram, Haryana, 122505'),('ICMT343',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dr. Zertaj Fatima, Assistant Professor, Management Department'),('ICMT344',NULL,'Ph.D','NMIMS Mumbai','Finance','','','','',NULL),('ICMT345',NULL,'MBA, PhD','Kalasalingam Business School, Kalasalingam Academy of Research and Education (KARE) (Deemed to be University)','HRM','','','','',NULL),('ICMT346',NULL,'Ph.D* NET, MBA','Amity University','General Management','','','','',NULL),('ICMT347',NULL,'PHD','Alard university','Research publications','','','','',NULL),('ICMT348',NULL,'M.A ECONOMICS,  PH.D','Khalsa college of education,  Amritsar','Digital Bharat @ 2047 , Indian economy,  innovative teaching learning process, Starts ups growth in india','','','','',NULL),('ICMT349',NULL,'M.Sc.,MBA,PhD','NIST University, BPUT University','HR Analytics, Strategic HRM, Research Methodology','','','','',NULL),('ICMT350',NULL,'Ph.D','Institute of Technology & Management, Gwalior','Marketing, HR, Tourism etc','','','','',NULL),('ICMT351',NULL,'PhD','CT University','','','','','',NULL),('ICMT352',NULL,'MBA, MSW, MA(Tourism), PhD','Telangana University','Entrepreneurship, Marketing management, Ecommerce','','','','',NULL),('ICMT353',NULL,'MBA','Harcourt Butler Technical University, Kanpur.','Consumer Behaviour','','','','',NULL),('ICMT354',NULL,'MS','Universal AI university karjat','Business analytics','','','','',NULL),('ICMT355',NULL,'BE, MBA, Ph.D','FLAME University and Guglielmo Marconi University Italy','Marketing Research, consumer behaviour, new product development, technology marketing, B2B marketing, Sales Management','','','','',NULL),('ICMT356',NULL,'Ph.D','Birla Institute of technology, mesra','Marketing','','','','',NULL),('ICMT357',NULL,'Ph.D.','Galgotias University','Analytics','','','','',NULL),('ICMT358',NULL,'MBA','Jagannath university','Business Statistics, Research Methodology, Entrepreneurship','','','','',NULL),('ICMT359',NULL,'Ph.D','Madhav University','HOD','','','','',NULL),('ICMT360',NULL,'Ph.D, M.Com (Gold Medalist), UGC-Net, MP-SET','Rajiv Gandhi National Aviation University (RGNAU), India','Accounting & Finance Control, Direct & Indirect Taxation, Financial Market','','','','',NULL),('ICMT361',NULL,'MBA','FTU','Design Thinking, NLP, Classroom Innovation, Growth Mindset for teachers, Learning & Development (L&D), Game design, Leadership Development & Executive Coaching, Talent Management & Succession Planning, Organizational Development (OD), Human Resource Strategy & Transformation, Competency Mapping & Capability Building, Training Needs Analysis (TNA), Design Thinking & Innovation, Emotional Intelligence & Behavioral Excellence, Performance Management Systems, 360-Degree Feedback & Assessment Centers, Change Management & Culture Transformation, Employee Engagement & Experience, HR Digitization (HRMS, LMS & PMIS), Instructional Design & Learning Architecture, Facilitation, Training & Workshop Design, Communication, Presentation & Influencing Skills, Campus-to-Corporate & Employability Development, Internship & Early Career Talent Programs, Coaching, Mentoring & Career Development, Entrepreneurship & Startup Mentoring, Team Building & Collaboration, Learning Reinforcement & Knowledge Retention, Strategic HR Business Partnering, Learning Measurement, etc','','','','',NULL),('ICMT362',NULL,'PhD','DSU','Leadership, AI, Cross Cultural Awareness','','','','',NULL),('ICMT363',NULL,'Ph.D','Srm university','','','','','',NULL),('ICMT364',NULL,'MBA, M.Com, NET-Mgt., PGDIBO','Visvesvaraya Technological University','Finance, Accounts and Banking Services','','','','',NULL),('ICMT365',NULL,'B.com honours with C.B.A ,M.com ,pursuing Ph.D','CT university','AI in education','https://www.linkedin.com/in/lovejit-kaur','','','',NULL),('ICMT366',NULL,'M.Com., M.B A., Ph.D.','JNTUA','Finance','https://www.linkedin.com/in/dr-sudarsana-murthy-dakuru-73939861/','http://orcid.org/0000-0002-3970-0878','https://scholar.google.co.in/citations?user=_Tp3HpUAAAAJ&hl=en','',NULL),('ICMT367',NULL,'Ph.D (management)','University of Lucknow','Financial econometrics','','','','',NULL),('ICMT368',NULL,'M. Com, M. B. A, Ph. D.','Andhra university','Commerce and Management (Finance &Accountancy )','Kuberudu','','','',NULL),('ICMT369',NULL,'MBA,PHD','Not yet','ORGANISATIONS BEHAVIOUR, TALENT ACQUISITION, PERFORMANCE MANAGEMENT,AI IN HR,GREEN HR','https://www.linkedin.com/in/pallavi-singh-0b11a81b4','0000-0002-2382-4841','https://scholar.google.com/citations?hl=en&user=0PrdtJYAAAAJ','',NULL),('ICMT370',NULL,'MBA, M.Com, Ph.D','','FINANCE AND ECONOMICS AND EXCELL MODELLING','https://www.linkedin.com/in/dr-ashish-sharma-653994a/','','','',NULL),('ICMT371',NULL,'Post Doc , Phd','Jamia Hamdard , Manav Rachna','25 years','http://linkedin.com/in/dr-asjad-usmani-592794115','0000-0003-3953-212X','asjadusmani','',NULL),('ICMT372',NULL,'MBA, Ph.D.','Alliance University, Bengaluru','Quantitative Analysis, Qualitative Analysis, Artificial Intelligence Tools for Research, Machine Learning for Research, IBM SPSS, IBM AMOS, SmartPLS, NVivo, Bibliometrics, SLR.','https://www.linkedin.com/in/samuel-mores-geddam-7395373b/','0000-0003-1327-9840','https://scholar.google.com/citations?user=AyPHBWkAAAAJ&hl=en&authuser=1','',NULL),('ICMT373',NULL,'MPM, PhD','','CRT, Business Communications','www.linkedin.com/in/leenabgeorge','-','-','',NULL),('ICMT374',NULL,'M.Com, Ph.D','','Finance','Dr.Nitin Anvekar','0009-0005-7807-8558','https://scholar.google.com/citations?user=7DFwkrIAAAAJ&hl=en','',NULL),('ICMT375',NULL,'PhD','Global Humanistic University Curacao','International Business, Entrepreneurship and General Management','','','','',NULL),('ICMT376',NULL,'M.Com, MA Economics, PGDBA-Finance, CA Intermediate','Not applicable','','https://www.linkedin.com/in/rupesh-thakur-481412105?utm_source=share_via&utm_content=profile&utm_medium=member_ios','0009-0007-4045-3783','','',NULL),('ICMT377',NULL,'Phd','','Entrepreneurship, Design Thinking, Consumer Behavior','https://www.linkedin.com/in/varun-singh-134b8a18/','0000-0003-1729-4909','https://scholar.google.com/citations?user=FyDzb4IAAAAJ&hl=en&authuser=1','',NULL),('ICMT378',NULL,'MMS MARKETING','Nil','Marketing','https://www.linkedin.com/in/anuj-tiwari-8b6213195?utm_source=share_via&utm_content=profile&utm_medium=member_android','Nil','Nil','',NULL),('ICMT379',NULL,'M.Com, Ph.D','Mizoram University','Personal Finance, Investments','','','','',NULL),('ICMT380',NULL,'B.Tech, PGDBM, Honorary Doctorate in Business Administration and Management','Editor-in-Chief of Journal of Higher Education and Academic Development','Operations Management, Supply Chain Management, Strategy, Entrepreneurship, Sustainability, Industry 5.0, Career Guidance and Well Being, Mentoring','www.linkedin.com/in/prof-vineet-suri-51751216','0009-0002-3944-2968','','',NULL),('ICMT381','1995-05-10','Ph.D','Payment Test University','Finance and Management',NULL,NULL,NULL,NULL,'Membership Application #5'),('ICMT382','2026-09-23','Ph.D. in Quantitative Finance','Doctoral Supervisor in Financial Mathematics','Quantitative Finance, Econometrics, Portfolio Theory','https://linkedin.com/in/final382','0000-0002-1825-0099','https://scholar.google.com/citations?user=final382','/uploads/member_photos/9a8be3d64785463fb52ff05e6042280c.png',NULL),('ICMT383','2026-09-08','MBA',NULL,NULL,NULL,NULL,NULL,'/uploads/member_photos/ba011a522c994c228a73a936e199e64a.jpeg',NULL);
/*!40000 ALTER TABLE `member_academic_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_contact_info`
--

DROP TABLE IF EXISTS `member_contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_contact_info` (
  `member_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_secondary` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `professional_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `personal_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_province` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pin_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  CONSTRAINT `fk_member_contact_info` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_contact_info`
--

LOCK TABLES `member_contact_info` WRITE;
/*!40000 ALTER TABLE `member_contact_info` DISABLE KEYS */;
INSERT INTO `member_contact_info` VALUES ('ICMT001','+91 94401 21943',NULL,NULL,'sathishkumarananthula07@gmail.com',NULL,NULL,'Peddapalli','Telangana',NULL,'India'),('ICMT002','+91 97050 44811',NULL,NULL,'avrao.maxis@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT003','+91 84397 78746',NULL,NULL,'abidzaidi1100@gmail.com',NULL,NULL,'Aligarh','Uttar Pradesh',NULL,'India'),('ICMT004','+91 94236 19290',NULL,NULL,'alka.saraf0804@gmail.com',NULL,NULL,'Bangalore','Karnataka',NULL,'India'),('ICMT005','+91 89605 09889','+91 9999999999',NULL,'alok.kumar1@bhu.ac.in',NULL,'Department of Commerce, Banaras Hindu University, Varanasi, Uttar Pradesh, India 221005','Varanasi','Uttar Pradesh','524001','India'),('ICMT006','+91 92016 28282','+91 92016 28282',NULL,'anujverma02@gmail.com','anuj.approved@gmail.com','Sanskrithi Knowledge Hub','Puttaparthi','Andhra Pradesh','515134','India'),('ICMT007','+91 99033 64729',NULL,NULL,'ANUPRIYOMALLICK@GMAIL.COM',NULL,NULL,'Kolkata','West Bengal',NULL,'India'),('ICMT008','+91 81218 09419',NULL,NULL,'mohan.bdm@gmail.com',NULL,NULL,'Hyderabad','Telangana',NULL,'India'),('ICMT009','+91 98452 59913',NULL,NULL,'basavanayakanagaraju@gmail.com',NULL,NULL,'Mysore',NULL,NULL,NULL),('ICMT010','+91 75691 63325',NULL,NULL,'b.pawni2018@gmail.com',NULL,NULL,'Kadimetla','Andhra Pradesh',NULL,'India'),('ICMT011','+91 99163 65354',NULL,NULL,'mnbabitha@gmail.com',NULL,NULL,'Bangalore',NULL,NULL,NULL),('ICMT012','+91 98809 86979',NULL,NULL,'dr.mmbagali@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT013','+91 70947 84518',NULL,NULL,'drvenkatbarla@gmail.com',NULL,NULL,'Hyderabad','Telangana',NULL,'India'),('ICMT014','+91 99493 53965',NULL,NULL,'saisandhya1029@gmail.com',NULL,NULL,'Puttaparthi',NULL,NULL,NULL),('ICMT015','+91 90360 93507',NULL,NULL,'bhagyalakshmi@vtu.ac.in',NULL,NULL,'Mysuru',NULL,NULL,NULL),('ICMT016','+91 89033 11849',NULL,NULL,'bsreereddy7@gmail.com',NULL,NULL,'517325','Andhra Pradesh',NULL,'India'),('ICMT017','+91 99725 09967',NULL,NULL,'bhanumathidm028@gmail.com',NULL,NULL,'Kaggalipura','Karnataka',NULL,'India'),('ICMT018','+91 99402 82351',NULL,NULL,'bharathi.health@gmail.com',NULL,NULL,'Bangalore',NULL,NULL,NULL),('ICMT019','+91 99456 10063',NULL,NULL,'kalanandish71@gmail.com',NULL,NULL,'Bangalore',NULL,NULL,NULL),('ICMT020','+91 84285 12195',NULL,NULL,'cbnrao195@gmail.com',NULL,NULL,'Chennai',NULL,NULL,NULL),('ICMT021','+91 70050 69792',NULL,NULL,'nalinidevi72@gmail.com',NULL,NULL,'Aizawl','Mizoram',NULL,'India'),('ICMT022','+91 98660 87091',NULL,NULL,'chandbasha.ong@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL),('ICMT023','+91 99340 15211',NULL,NULL,'VEERCHANDAN@GMAIL.COM',NULL,NULL,'Tatisilwai','Jharkhand',NULL,'India'),('ICMT024','+91 99866 72809',NULL,NULL,'kmchiranth@gmail.com',NULL,NULL,'Mysuru',NULL,NULL,NULL),('ICMT025','+91 99665 52974',NULL,NULL,'ctmnagesh89@gmail.com',NULL,NULL,'Adoni',NULL,NULL,NULL),('ICMT026','+91 90439 33855',NULL,NULL,'Malinidh77@pondiuni.ac.in',NULL,NULL,'Karaikal','Puducherry',NULL,'India'),('ICMT027','+91 89040 85941',NULL,NULL,'Deepikagr2@gmail.com',NULL,NULL,'Kommaghatta','Karnataka',NULL,'India'),('ICMT028','+91 73306 92733',NULL,NULL,'drvasums999@gmail.com',NULL,NULL,'Tirupati','Andhra Pradesh',NULL,'India'),('ICMT029','+91 93913 19721',NULL,NULL,'deanmba@narayanagroup.com',NULL,NULL,'Nellore',NULL,NULL,NULL),('ICMT030','+91 93919 89091',NULL,NULL,'g.ramanjaneyulu.mba@gmail.com',NULL,NULL,'Bangalore',NULL,NULL,NULL),('ICMT031','+91 98494 71988',NULL,NULL,'acharyuluscm@gmail.com',NULL,NULL,'Hyderabad',NULL,NULL,NULL),('ICMT032','+91 80504 38707',NULL,NULL,'gangagowda116@gmail.com',NULL,NULL,'Rajajinagar',NULL,NULL,NULL),('ICMT033','+91 96775 07720',NULL,NULL,'gwrgnsh1983@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL),('ICMT034','+91 98496 23310',NULL,NULL,'gundaramesh3310@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL),('ICMT035','+91 98493 73286',NULL,NULL,'vaaugunda555@gmail.com',NULL,NULL,'Karimnagar','Telangana',NULL,'India'),('ICMT036','+91 86880 69917; +91 96521 68059',NULL,NULL,'gundupagimanjunath@gmail.com',NULL,NULL,'Kurnool','Andhra Pradesh',NULL,'India'),('ICMT037','+91 94005 22479',NULL,NULL,'hari.hvbs@gmail.com',NULL,NULL,'Coimbatore',NULL,NULL,NULL),('ICMT038','+91 96116 77399',NULL,NULL,'ignatius.inasi@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT039','+91 63048 22772',NULL,NULL,'ismail.b@gmail.com',NULL,NULL,'Bangalore','Karnataka',NULL,'India'),('ICMT040','+91 62922 71239',NULL,NULL,'sentindranil72@gmail.com',NULL,NULL,'MIT University of','Meghalaya',NULL,'India'),('ICMT041','+91 90191 30199',NULL,NULL,'janardhan.shetty@gmail.com',NULL,NULL,'Bangalore',NULL,NULL,NULL),('ICMT042','+91 94806 09032',NULL,NULL,'jesmon.n@stfranciscollege.edu.in',NULL,NULL,'Bengaluru',NULL,NULL,NULL),('ICMT043','+91 97416 33223',NULL,NULL,'ktrreddy@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT044','+91 98901 98919',NULL,NULL,'kamran.ambar@gmail.com',NULL,NULL,'Malegaon','Maharashtra',NULL,'India'),('ICMT045','+91 93986 85887',NULL,NULL,'sreenivasulukamsali2@gmail.com',NULL,NULL,'Kowthalam','Andhra Pradesh',NULL,'India'),('ICMT046','+91 98664 32203',NULL,NULL,'rajeshsam.sap@gmail.com',NULL,NULL,'Anantapur',NULL,NULL,NULL),('ICMT047','+91 96508 16838',NULL,NULL,'drknaikasachdeva07@gmail.com',NULL,NULL,'Gurugram','Haryana',NULL,'India'),('ICMT048','+91 96037 42715',NULL,NULL,'hema@kluniversity.in',NULL,NULL,'Guntur',NULL,NULL,'India'),('ICMT049','+91 88922 38322; +91 99866 91335',NULL,NULL,'kavitha@vtu.ac.in',NULL,NULL,'Mysuru','Karnataka',NULL,'India'),('ICMT050','+91 76967 00514',NULL,NULL,'Khushleen94@gmail.com',NULL,NULL,'Amritsar','Punjab',NULL,'India'),('ICMT051','+91 97426 66421',NULL,NULL,'Lakshmi.reganti@gmail.com',NULL,NULL,'Bangalore',NULL,NULL,NULL),('ICMT052','+91 96778 87143',NULL,NULL,'abdulsibril@thenewcollege.edu.in',NULL,NULL,'Chennai','Tamil Nadu',NULL,'India'),('ICMT053','+91 93909 79712',NULL,NULL,'drbalakoteswari@gmail.com',NULL,NULL,'Sri Sathya Sai','Andhra Pradesh',NULL,'India'),('ICMT054','+91 89037 65947',NULL,NULL,'madhavaiah.kcm@pondiuni.ac.in',NULL,NULL,'Sri Vijaya Puram - 744112','Andaman & Nicobar Islands',NULL,'India'),('ICMT055','+91 98865 61253',NULL,NULL,'mbiradar74@gmail.com',NULL,NULL,'Kalaburagi','Karnataka',NULL,'India'),('ICMT056','+91 94372 91670',NULL,NULL,'manmayatripathy92@gmail.com',NULL,NULL,'Burla','Odisha',NULL,'India'),('ICMT057','+91 98190 23705',NULL,NULL,'meghnachotaliya26@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL),('ICMT058','+91 81212 53858',NULL,NULL,'chandhanprashad@gmail.com',NULL,NULL,'Kurnool','Andhra Pradesh',NULL,'India'),('ICMT059','+91 98481 70274',NULL,NULL,'prof.nsrao@andhrauniversity.edu.in',NULL,NULL,'Visakhapatnam',NULL,NULL,NULL),('ICMT060','+91 99804 85603',NULL,NULL,'rajuhandpost@gmail.com',NULL,NULL,'Sathanur','Karnataka',NULL,'India'),('ICMT061','+91 99009 44552',NULL,NULL,'niju1972@gmail.com',NULL,NULL,'Bengaluru',NULL,NULL,NULL),('ICMT062','+91 98336 69949',NULL,NULL,'nital.kothari@jaihindcollege.edu.in',NULL,NULL,'Mumbai',NULL,NULL,NULL),('ICMT063','+91 86694 94564',NULL,NULL,'drnusrat.choudhary@slrtdc.in',NULL,NULL,'Mira Bhayandar','Maharashtra',NULL,'India'),('ICMT064','+91 94485 33326',NULL,NULL,'paramashivaiah@gmail.com',NULL,NULL,'Tumkur',NULL,NULL,NULL),('ICMT065','+91 99124 81918',NULL,NULL,'paduchuruviswa007@gmail.com',NULL,NULL,'Ananthapuramu','Andhra Pradesh',NULL,'India'),('ICMT066','+91 90494 10365',NULL,NULL,'poojavaidya88@gmail.com',NULL,NULL,'Chhatrapati Sambhajinagar','Maharashtra',NULL,'India'),('ICMT067','+91 88504 85966',NULL,NULL,'prashantgrm@gmail.com',NULL,NULL,'Kalyan East',NULL,NULL,NULL),('ICMT068','+91 99450 77994',NULL,NULL,'prashsp2004@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT069','+91 97313 81524',NULL,NULL,'praveensinha07@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT070','+91 93912 20011',NULL,NULL,'rvaraprasad@gmail.com',NULL,NULL,'Guntakal',NULL,NULL,NULL),('ICMT071','+91 98855 64417',NULL,NULL,'rajbooranitw@gmail.com',NULL,NULL,'Hanamkonda','Telangana',NULL,'India'),('ICMT072','+91 75984 54619',NULL,NULL,'rajeshrphd@gmail.com',NULL,NULL,'Management','Mizoram',NULL,'India'),('ICMT073','+91 88616 65484',NULL,NULL,'rakesh.sanatani@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT074','+91 98496 35938',NULL,NULL,'miryalaramesh@gmail.com',NULL,NULL,'Nalgonda','Telangana',NULL,'India'),('ICMT075','+91 94433 51831',NULL,NULL,'n.rammu@yahoo.com',NULL,NULL,'Annamalai Nagar',NULL,NULL,NULL),('ICMT076','+91 98857 38060',NULL,NULL,'gangineni.ranganath@gmail.com',NULL,NULL,'Central University of','Karnataka',NULL,'India'),('ICMT077','+91 98805 66856',NULL,NULL,'ranganath1326@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT078','+91 93465 91203',NULL,NULL,'nenuvijay@gmail.com',NULL,NULL,'Hyderabad','Andhra Pradesh',NULL,'India'),('ICMT079','+91 97433 08892',NULL,NULL,'sagargopal2020@gmail.com',NULL,NULL,'Bangalore',NULL,NULL,NULL),('ICMT080','+91 98661 18033',NULL,NULL,'samuelmores88@gmail.com',NULL,NULL,'Surampalem','Andhra Pradesh',NULL,'India'),('ICMT081','+91 99591 50970; +91 77807 54127',NULL,NULL,'sandaboinashivakumar@gmail.com',NULL,NULL,'Guntur',NULL,NULL,NULL),('ICMT082','+91 96115 60040',NULL,NULL,'santoshkh1994@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL),('ICMT083','+91 89173 79323',NULL,NULL,'hod.mgmt.studies@riteindia.edu.in',NULL,NULL,'Khurda',NULL,NULL,NULL),('ICMT084','+91 80804 97969',NULL,NULL,'prof.sanaali@gmail.com',NULL,NULL,'Mumbai','Maharashtra',NULL,'India'),('ICMT085','+91 98866 25363',NULL,NULL,'seemasinha2801@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT086','+91 97033 01578',NULL,NULL,'ashokreddyom@gmail.com',NULL,NULL,'Kurnool',NULL,NULL,NULL),('ICMT087','+91 98855 70767',NULL,NULL,'kuteja.ssb@gmail.com',NULL,NULL,'Puttaparthi',NULL,NULL,NULL),('ICMT088','+91 94680 90975',NULL,NULL,'shishpal007@gmail.com',NULL,NULL,'Sonipat','Delhi',NULL,'India'),('ICMT089','+91 91648 56510',NULL,NULL,'hulsoor.shiv@vtu.ac.in',NULL,NULL,'Mysuru',NULL,NULL,NULL),('ICMT090','+91 90297 40776',NULL,NULL,'st544@cornell.edu',NULL,NULL,NULL,NULL,NULL,NULL),('ICMT091','+91 93908 28622',NULL,NULL,'dr.sudhamadhav@gmail.com',NULL,NULL,'Armur','Telangana',NULL,'India'),('ICMT092','+91 90362 91481',NULL,NULL,'sudhakarant1608@gmail.com',NULL,NULL,'Bengaluru','Karnataka',NULL,'India'),('ICMT093','+91 98306 51820',NULL,NULL,'sudiptiban@yahoo.com',NULL,NULL,NULL,NULL,NULL,NULL),('ICMT094','+91 96769 43188',NULL,NULL,'sgovardhanmba@gmail.com',NULL,NULL,'Hyderabad',NULL,NULL,NULL),('ICMT095','+91 91600 21675',NULL,NULL,'swethathiruchanuru@sssihl.edu.in',NULL,NULL,'Anantapur','Andhra Pradesh',NULL,'India'),('ICMT096','+91 94915 15789',NULL,NULL,'nbabu@ksrmce.ac.in',NULL,NULL,'Kadapa',NULL,NULL,NULL),('ICMT097','+91 88742 00866',NULL,NULL,'twinkle.prusty@gmail.com',NULL,NULL,'Varanasi','Uttar Pradesh',NULL,'India'),('ICMT098','+91 99869 59441',NULL,NULL,'velchasekhar@gmail.com',NULL,NULL,'Vijayawada','Andhra Pradesh',NULL,'India'),('ICMT099','+91 96201 43417',NULL,NULL,'ranganatham008@gmail.com',NULL,NULL,'Sri Sathya Sai','Andhra Pradesh',NULL,'India'),('ICMT100','+91 98942 97331',NULL,NULL,'proftvv@gmail.com',NULL,NULL,'Selliampalayam','Tamil Nadu',NULL,'India'),('ICMT101','+91 93545 95439',NULL,NULL,'vkshro18@gmail.com',NULL,NULL,'Faculty of Commerce','Delhi',NULL,'India'),('ICMT102','+91 93155 70070',NULL,NULL,'vikasbhatheja@gmail.com',NULL,NULL,'Narnaul','Haryana',NULL,'India'),('ICMT103','+91 99267 67976',NULL,NULL,'drvikaskumarkhare@gmail.com',NULL,NULL,'Sahibzada Ajit Singh Nagar','Punjab',NULL,'India'),('ICMT104','+91 94810 24732',NULL,NULL,'vinayraobn2887@gmail.com',NULL,NULL,'Hebbagodi','Karnataka',NULL,'India'),('ICMT105','+91 98171 60854',NULL,NULL,'vipan.5797@gmail.com',NULL,NULL,'Shimla','Himachal Pradesh',NULL,'India'),('ICMT106','+91 76398 46101',NULL,NULL,'pusomys@gmail.com',NULL,NULL,'Management','Puducherry',NULL,'India'),('ICMT107',NULL,NULL,NULL,NULL,NULL,'Department of Business Administration, Ragendra Swarup Knowledge city, near Azad marg churaha, unnao, Uttar pradesh',NULL,'Uttar Pradesh','209862',NULL),('ICMT108',NULL,NULL,NULL,NULL,NULL,'Mumbai','Mumbai',NULL,NULL,NULL),('ICMT109',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT110',NULL,NULL,NULL,NULL,NULL,'HIMT, Knowledge Park - 1, Greater Noida','Greater Noida',NULL,'201310',NULL),('ICMT111',NULL,NULL,NULL,NULL,NULL,'DY Patil Deemed to be University, Center of Excellence, Sector 7, Nerul East, Navi Mumbai','Mumbai',NULL,'400706',NULL),('ICMT112',NULL,NULL,NULL,NULL,NULL,'RTM Nagpur University, University Campus, Amravati Road Nagpur','Nagpur',NULL,'440033',NULL),('ICMT113',NULL,NULL,NULL,NULL,NULL,'Bilaspur Chhattisgarh','Bilaspur','Chhattisgarh','495009',NULL),('ICMT114',NULL,NULL,NULL,NULL,NULL,'C. Gollapalli, Tirupati, AP','Tirupati',NULL,'517505',NULL),('ICMT115',NULL,NULL,NULL,NULL,NULL,'University of Mumbai, Kalina, Santacruz East, Mumbai','Mumbai',NULL,'400098',NULL),('ICMT116',NULL,NULL,NULL,NULL,NULL,'Department of Economics',NULL,NULL,'173022',NULL),('ICMT117',NULL,NULL,NULL,NULL,NULL,'NH-12, Near Misrod, Village- Bhairopur, Hoshangabad Road, Bhopal .','Bhopal',NULL,'462026',NULL),('ICMT118',NULL,NULL,NULL,NULL,NULL,'Department of Management Behind Sri Sathya Sai Super Speciality Hospital, Prashantigram, Puttaparthi Sri Sathya Sai District, Andhra Pradesh',NULL,'Andhra Pradesh','515134',NULL),('ICMT119',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT120',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT121',NULL,NULL,NULL,NULL,NULL,'Whitefield, Bengaluru, Karnataka','Bengaluru','Karnataka',NULL,NULL),('ICMT122',NULL,NULL,NULL,NULL,NULL,'Trichy',NULL,NULL,NULL,NULL),('ICMT123',NULL,NULL,NULL,NULL,NULL,'SKU, ANANTHAPUR',NULL,NULL,NULL,NULL),('ICMT124',NULL,NULL,NULL,NULL,NULL,'Elthuruth, Thrissur, Kerala','Thrissur','Kerala','680611',NULL),('ICMT125',NULL,NULL,NULL,NULL,NULL,'faculty of Management Studies, Parul University',NULL,NULL,NULL,NULL),('ICMT126',NULL,NULL,NULL,NULL,NULL,'Sri Krishnadevaraya University, Ananthapuramu, Andhra Pradesh',NULL,'Andhra Pradesh','515003',NULL),('ICMT127',NULL,NULL,NULL,NULL,NULL,'porur chennai','Chennai',NULL,NULL,NULL),('ICMT128',NULL,NULL,NULL,NULL,NULL,'Shrimati Indira Gandhi College, Tiruchirappalli, nt',NULL,NULL,'620002',NULL),('ICMT129',NULL,NULL,NULL,NULL,NULL,'Bengaluru, Karnataka','Bengaluru','Karnataka',NULL,NULL),('ICMT130',NULL,NULL,NULL,NULL,NULL,'SOCM, TIRUPATHI, Sree Sainath Nagar, Sree Vidyanikethan, Tirupati, Kotala, Andhra Pradesh','Tirupati','Andhra Pradesh','517102',NULL),('ICMT131',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT132',NULL,NULL,NULL,NULL,NULL,'West Bengal, India',NULL,'West Bengal',NULL,NULL),('ICMT133',NULL,NULL,NULL,NULL,NULL,'Bangalore','Bangalore',NULL,NULL,NULL),('ICMT134',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT135',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT136',NULL,NULL,NULL,NULL,NULL,NULL,'Shimla','Himachal Pradesh','171014',NULL),('ICMT137',NULL,NULL,NULL,NULL,NULL,'Maharashtra',NULL,'Maharashtra','421301',NULL),('ICMT138',NULL,NULL,NULL,NULL,NULL,'Central University of Himachal Pradesh, Dharamshala, India',NULL,'Himachal Pradesh','176215',NULL),('ICMT139',NULL,NULL,NULL,NULL,NULL,'Ahmedabad','Ahmedabad',NULL,NULL,NULL),('ICMT140',NULL,NULL,NULL,NULL,NULL,'Hyderabad, Rajendra Nagar, Telangana','Hyderabad','Telangana','500030',NULL),('ICMT141',NULL,NULL,NULL,NULL,NULL,'Bayelsa State, Nigeria. .',NULL,NULL,NULL,NULL),('ICMT142',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT143',NULL,NULL,NULL,NULL,NULL,'Sri Krishnadevaraya University, Anantapur','Anantapur',NULL,NULL,NULL),('ICMT144',NULL,NULL,NULL,NULL,NULL,'REVA University',NULL,NULL,NULL,NULL),('ICMT145',NULL,NULL,NULL,NULL,NULL,'Department of Management, Faculty of Management, Humanities and Social Sciences, Saegis Campus, Nugegoda, Colombo, Sri Lanka',NULL,NULL,NULL,NULL),('ICMT146',NULL,NULL,NULL,NULL,NULL,'Vile Parle, Mumbai','Mumbai',NULL,NULL,NULL),('ICMT147',NULL,NULL,NULL,NULL,NULL,'Federal University of Medicine and Medical Sciences Abeokuta, Nigeria',NULL,NULL,NULL,NULL),('ICMT148',NULL,NULL,NULL,NULL,NULL,'Pragati Engineering college, Surampalem.',NULL,NULL,NULL,NULL),('ICMT149',NULL,NULL,NULL,NULL,NULL,'Nandyal',NULL,NULL,NULL,NULL),('ICMT150',NULL,NULL,NULL,NULL,NULL,'Smt. CHM College (Autonomous)Ulhasnagar, Dist-Thane Maharashtra',NULL,'Maharashtra',NULL,NULL),('ICMT151',NULL,NULL,NULL,NULL,NULL,NULL,'Hyderabad',NULL,NULL,NULL),('ICMT152',NULL,NULL,NULL,NULL,NULL,'Finance, Pune Maharashtra','Pune','Maharashtra','411033',NULL),('ICMT153',NULL,NULL,NULL,NULL,NULL,'B-18, Qutub Institutional Area New Delhi','Delhi','Delhi','110016',NULL),('ICMT154',NULL,NULL,NULL,NULL,NULL,'Jain (deemed to be) University, Bengaluru','Bengaluru',NULL,NULL,NULL),('ICMT155',NULL,NULL,NULL,NULL,NULL,NULL,'Hyderabad','Telangana',NULL,NULL),('ICMT156',NULL,NULL,NULL,NULL,NULL,'Maharani Cluster University Bangalore -560 001','Bangalore',NULL,NULL,NULL),('ICMT157',NULL,NULL,NULL,NULL,NULL,'School of Commerce and Management, Bharath Institute of Higher Education and Research, NO-173, Agharam Main Road, Selaiyur, Chennai .','Chennai',NULL,'600073',NULL),('ICMT158',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT159',NULL,NULL,NULL,NULL,NULL,'Adoni','Adoni',NULL,NULL,NULL),('ICMT160',NULL,NULL,NULL,NULL,NULL,'Hebbala, Bangalore','Bangalore',NULL,'560024',NULL),('ICMT161',NULL,NULL,NULL,NULL,NULL,'Gorakhpur UP',NULL,NULL,NULL,NULL),('ICMT162',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT163',NULL,NULL,NULL,NULL,NULL,NULL,'Jamshedpur','Jharkhand',NULL,NULL),('ICMT164',NULL,NULL,NULL,NULL,NULL,'kopargaon, Maharashtra',NULL,'Maharashtra','423603',NULL),('ICMT165',NULL,NULL,NULL,NULL,NULL,'Kochi','Kochi',NULL,NULL,NULL),('ICMT166',NULL,NULL,NULL,NULL,NULL,'No.363, Arcot road, Kodambakkam, Chennai-24.','Chennai',NULL,NULL,NULL),('ICMT167',NULL,NULL,NULL,NULL,NULL,'Urvasad Square, Sarkhej-Gandhinagar Highway, Post Adalaj, Ahmedabad - Gandhinagar Highway, Gujarat .','Gandhinagar','Gujarat','382421',NULL),('ICMT168',NULL,NULL,NULL,NULL,NULL,'Kodakara, Thrissur, Kerala','Thrissur','Kerala','680684',NULL),('ICMT169',NULL,NULL,NULL,NULL,NULL,'DEPARTMENT OF MBA, KOLKATA','Kolkata',NULL,'700073',NULL),('ICMT170',NULL,NULL,NULL,NULL,NULL,NULL,'Delhi','Delhi',NULL,NULL),('ICMT171',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT172',NULL,NULL,NULL,NULL,NULL,'Nava India, Coimbatore','Coimbatore',NULL,NULL,NULL),('ICMT173',NULL,NULL,NULL,NULL,NULL,'Cheeryal (V), Keesara (M), Medchal ( Dist.), Hyderabad, Telangana','Hyderabad','Telangana','501301',NULL),('ICMT174',NULL,NULL,NULL,NULL,NULL,'FMS, PIBA, Vadodara, Gujarat','Vadodara','Gujarat',NULL,NULL),('ICMT175',NULL,NULL,NULL,NULL,NULL,NULL,'Ahmedabad','Gujarat',NULL,NULL),('ICMT176',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Uttarakhand',NULL,NULL),('ICMT177',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT178',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT179',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT180',NULL,NULL,NULL,NULL,NULL,'Mysore, Karnataka, India','Mysore','Karnataka',NULL,NULL),('ICMT181',NULL,NULL,NULL,NULL,NULL,'Dept of MBA Dr. S. Radhakrishnan Road, Acharya P.O, Soladevanahalli, Bangalore','Bangalore',NULL,'560107',NULL),('ICMT182',NULL,NULL,NULL,NULL,NULL,'Faculty of Commerce & Business Delhi School of Economics, University of Delhi','Delhi','Delhi',NULL,NULL),('ICMT183',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT184',NULL,NULL,NULL,NULL,NULL,'Jai Narain Vyas University, Jodhpur','Jodhpur',NULL,'342001',NULL),('ICMT185',NULL,NULL,NULL,NULL,NULL,'Chennai','Chennai',NULL,'603203',NULL),('ICMT186',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT187',NULL,NULL,NULL,NULL,NULL,'HSNC University, Mumbai .','Mumbai',NULL,NULL,NULL),('ICMT188',NULL,NULL,NULL,NULL,NULL,'pune','Pune',NULL,NULL,NULL),('ICMT189',NULL,NULL,NULL,NULL,NULL,'Sri krishnadevaraya University, Anantapuramu, Andhra Pradesh a','Anantapuramu','Andhra Pradesh','515003',NULL),('ICMT190',NULL,NULL,NULL,NULL,NULL,NULL,'Lucknow',NULL,NULL,NULL),('ICMT191',NULL,NULL,NULL,NULL,NULL,'Planning & Projects, Avionics Division-Korwa, Amethi',NULL,NULL,'227412',NULL),('ICMT192',NULL,NULL,NULL,NULL,NULL,'Center for Post Graduate Studies-Muddenahalli, Chickballapura Tq and District Karnataka',NULL,'Karnataka','562101',NULL),('ICMT193',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT194',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT195',NULL,NULL,NULL,NULL,NULL,'Indirapuram, Ghaziabad',NULL,NULL,NULL,NULL),('ICMT196',NULL,NULL,NULL,NULL,NULL,'PG Dept of Commerce, Chennai -06','Chennai',NULL,NULL,NULL),('ICMT197',NULL,NULL,NULL,NULL,NULL,'Govt. Post Graduate College, Hisar, Haryana (India)',NULL,'Haryana','125001',NULL),('ICMT198',NULL,NULL,NULL,NULL,NULL,'Beside Bellad Hyundai Showroom, opp Hubballi Residency, Bhairidevarakoppa, Hubli','Hubballi',NULL,'580025',NULL),('ICMT199',NULL,NULL,NULL,NULL,NULL,'Management, Anantapur','Anantapur','Andhra Pradesh',NULL,NULL),('ICMT200',NULL,NULL,NULL,NULL,NULL,'Design Management, Gandhinagar','Gandhinagar',NULL,NULL,NULL),('ICMT201',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT202',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT203',NULL,NULL,NULL,NULL,NULL,'Talwandi Sabo, Bathinda, Punjab','Bathinda','Punjab','151302',NULL),('ICMT204',NULL,NULL,NULL,NULL,NULL,'Raipur','Raipur',NULL,NULL,NULL),('ICMT205',NULL,NULL,NULL,NULL,NULL,'United University, Rawatpur, Prayagraj','Prayagraj',NULL,'211012',NULL),('ICMT206',NULL,NULL,NULL,NULL,NULL,'Amaravati, Andhra Pradesh .',NULL,'Andhra Pradesh','522237',NULL),('ICMT207',NULL,NULL,NULL,NULL,NULL,'FOMC, Bengaluru','Bengaluru',NULL,NULL,NULL),('ICMT208',NULL,NULL,NULL,NULL,NULL,'Dindigul .','Dindigul',NULL,NULL,NULL),('ICMT209',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT210',NULL,NULL,NULL,NULL,NULL,'Indira University, Pune','Pune',NULL,NULL,NULL),('ICMT211',NULL,NULL,NULL,NULL,NULL,'Kuttiady, Kozhikode',NULL,NULL,NULL,NULL),('ICMT212',NULL,NULL,NULL,NULL,NULL,NULL,'Faridabad',NULL,NULL,NULL),('ICMT213',NULL,NULL,NULL,NULL,NULL,'SRM Nagar, Kattankulathur, Chengalpattu, Tamil Nadu . India',NULL,'Tamil Nadu','603203',NULL),('ICMT214',NULL,NULL,NULL,NULL,NULL,'Punnamchathram, Karur',NULL,NULL,NULL,NULL),('ICMT215',NULL,NULL,NULL,NULL,NULL,'Chennai','Chennai',NULL,'600110',NULL),('ICMT216',NULL,NULL,NULL,NULL,NULL,'C. Kandaswami Naidu College for Men (Govt Aided & Affiliated to University of Madras), Anna Nagar East, Chennai Tamil Nadu','Chennai','Tamil Nadu','600102',NULL),('ICMT217',NULL,NULL,NULL,NULL,NULL,'Near Apollo Hospitals, Muthukur Road, Nellore (AP)','Nellore',NULL,'524004',NULL),('ICMT218',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT219',NULL,NULL,NULL,NULL,NULL,'New Delhi','Delhi','Delhi',NULL,NULL),('ICMT220',NULL,NULL,NULL,NULL,NULL,'Philomath University of Nigeria, Abuja',NULL,NULL,NULL,NULL),('ICMT221',NULL,NULL,NULL,NULL,NULL,'Not provided','Delhi','Delhi','110078',NULL),('ICMT222',NULL,NULL,NULL,NULL,NULL,'Shobhit University',NULL,NULL,NULL,NULL),('ICMT223',NULL,NULL,NULL,NULL,NULL,NULL,'Delhi','Delhi',NULL,NULL),('ICMT224',NULL,NULL,NULL,NULL,NULL,'Vipul Khand - VI, Gomti Nagar, Lucknow, Uttar Pradesh','Lucknow','Uttar Pradesh','226010',NULL),('ICMT225',NULL,NULL,NULL,NULL,NULL,'1, Ahilya Bai Marg Sadar Pentinaka Jabalpur Madhya Pradesh India','Jabalpur','Madhya Pradesh',NULL,NULL),('ICMT226',NULL,NULL,NULL,NULL,NULL,NULL,'Greater Noida',NULL,NULL,NULL),('ICMT227',NULL,NULL,NULL,NULL,NULL,NULL,'Ahmedabad',NULL,NULL,NULL),('ICMT228',NULL,NULL,NULL,NULL,NULL,'Prayagraj','Prayagraj',NULL,'211015',NULL),('ICMT229',NULL,NULL,NULL,NULL,NULL,'Bhavnagar, Not provided',NULL,NULL,'364060',NULL),('ICMT230',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT231',NULL,NULL,NULL,NULL,NULL,'Sri Krishnadevaraya University, Ananthapuramu AP',NULL,NULL,NULL,NULL),('ICMT232',NULL,NULL,NULL,NULL,NULL,'Karakambadi Road, Mangalam (B.O), Tirupati','Tirupati',NULL,'517507',NULL),('ICMT233',NULL,NULL,NULL,NULL,NULL,'Thrissur.','Thrissur',NULL,NULL,NULL),('ICMT234',NULL,NULL,NULL,NULL,NULL,'BARDOLI, GUJARAT',NULL,'Gujarat',NULL,NULL),('ICMT235',NULL,NULL,NULL,NULL,NULL,'SRM University Delhi NCR Sonepat Haryana','Sonepat','Haryana',NULL,NULL),('ICMT236',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Haryana',NULL,NULL),('ICMT237',NULL,NULL,NULL,NULL,NULL,NULL,'Bhopal',NULL,NULL,NULL),('ICMT238',NULL,NULL,NULL,NULL,NULL,NULL,'Patna',NULL,NULL,NULL),('ICMT239',NULL,NULL,NULL,NULL,NULL,'NSIT-IFSCS (Affiliated to NFSU), Near Swaminarayan Temple, Jetalpur, Ahmedabad','Ahmedabad',NULL,'382427',NULL),('ICMT240',NULL,NULL,NULL,NULL,NULL,'DAV Centenary College, NIT 3 Faridabad, Haryana','Faridabad','Haryana','121001',NULL),('ICMT241',NULL,NULL,NULL,NULL,NULL,'haryana',NULL,'Haryana',NULL,NULL),('ICMT242',NULL,NULL,NULL,NULL,NULL,'IP University',NULL,NULL,NULL,NULL),('ICMT243',NULL,NULL,NULL,NULL,NULL,NULL,'Pune',NULL,NULL,NULL),('ICMT244',NULL,NULL,NULL,NULL,NULL,'ANDHRAHALLI MAIN ROAD, BENGALURU KARNATAKA','Bengaluru','Karnataka','560091',NULL),('ICMT245',NULL,NULL,NULL,NULL,NULL,'SRM University, Trichy, Tamil Nadu',NULL,'Tamil Nadu',NULL,NULL),('ICMT246',NULL,NULL,NULL,NULL,NULL,'Dehradun',NULL,NULL,NULL,NULL),('ICMT247',NULL,NULL,NULL,NULL,NULL,'87, Express Bypass, 88, Bengaluru - Mumbai Hwy, Tathawade, Pune, Pimpri-Chinchwad, Maharashtra','Bengaluru','Maharashtra','411033',NULL),('ICMT248',NULL,NULL,NULL,NULL,NULL,'Opposite Vraj Gardens, off SP ring road, Bopal, Shela, Ahmedabad, Gujarat','Ahmedabad','Gujarat','380058',NULL),('ICMT249',NULL,NULL,NULL,NULL,NULL,'Surana College, Bengaluru','Bengaluru',NULL,'560041',NULL),('ICMT250',NULL,NULL,NULL,NULL,NULL,'Dehradun',NULL,NULL,NULL,NULL),('ICMT251',NULL,NULL,NULL,NULL,NULL,'RAIPUR','Raipur',NULL,NULL,NULL),('ICMT252',NULL,NULL,NULL,NULL,NULL,'Noida, Uttar, Pradesh, India','Noida',NULL,NULL,NULL),('ICMT253',NULL,NULL,NULL,NULL,NULL,'Bathinda (Punjab)','Bathinda','Punjab','151401',NULL),('ICMT254',NULL,NULL,NULL,NULL,NULL,'BUSINESS ADMINISTRATION, CHENNAI','Chennai',NULL,'600116',NULL),('ICMT255',NULL,NULL,NULL,NULL,NULL,'Department of Business Administration, 6-1-91, Adj. To Telephone Bhavan, Khairatabad, Hyderabad-4','Hyderabad',NULL,NULL,NULL),('ICMT256',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT257',NULL,NULL,NULL,NULL,NULL,NULL,'Aligarh','Uttar Pradesh',NULL,NULL),('ICMT258',NULL,NULL,NULL,NULL,NULL,'Basantpur, Near Gosala, Sambalpur, Odisha India','Sambalpur','Odisha','768025',NULL),('ICMT259',NULL,NULL,NULL,NULL,NULL,NULL,'Kakinada',NULL,NULL,NULL),('ICMT260',NULL,NULL,NULL,NULL,NULL,'Bharath Institute higher Education and Education, Selaiyur Chennai','Chennai',NULL,'600073',NULL),('ICMT261',NULL,NULL,NULL,NULL,NULL,'St. Xavier’s Corner, University Road, Navarangpura, Ahmedabad –','Ahmedabad',NULL,NULL,NULL),('ICMT262',NULL,NULL,NULL,NULL,NULL,'60 B L Saha Road, Kolkata - 53','Kolkata',NULL,NULL,NULL),('ICMT263',NULL,NULL,NULL,NULL,NULL,'Department of Finance, Nalbari, Assam',NULL,'Assam','781334',NULL),('ICMT264',NULL,NULL,NULL,NULL,NULL,'CGC University Mohali','Mohali',NULL,NULL,NULL),('ICMT265',NULL,NULL,NULL,NULL,NULL,'NH-9, Delhi Road, Lodhipur Rajput, Moradabad (UP)','Delhi','Delhi','244102',NULL),('ICMT266',NULL,NULL,NULL,NULL,NULL,'NOIDA','Noida',NULL,NULL,NULL),('ICMT267',NULL,NULL,NULL,NULL,NULL,'BILASPUR, HP, Not provided','Bilaspur',NULL,'174021',NULL),('ICMT268',NULL,NULL,NULL,NULL,NULL,'Dr.K.V.Subba Reddy School of Business Management, Kurnool (A.P)','Kurnool',NULL,NULL,NULL),('ICMT269',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT270',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Rajasthan',NULL,NULL),('ICMT271',NULL,NULL,NULL,NULL,NULL,'Haryana -Panipat','Panipat','Haryana','132145',NULL),('ICMT272',NULL,NULL,NULL,NULL,NULL,'SDNB Vaishnav college for Women, Chennai -44','Chennai',NULL,NULL,NULL),('ICMT273',NULL,NULL,NULL,NULL,NULL,NULL,'Kota',NULL,NULL,NULL),('ICMT274',NULL,NULL,NULL,NULL,NULL,'Uma Nagar',NULL,NULL,'500016',NULL),('ICMT275',NULL,NULL,NULL,NULL,NULL,NULL,'Jodhpur',NULL,NULL,NULL),('ICMT276',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT277',NULL,NULL,NULL,NULL,NULL,'Amity University, NOIDA','Noida',NULL,NULL,NULL),('ICMT278',NULL,NULL,NULL,NULL,NULL,'West Bengal, India','Durgapur','West Bengal',NULL,NULL),('ICMT279',NULL,NULL,NULL,NULL,NULL,'SRM Institute of Science and Technology, Kattankulathur, Chengalpattu',NULL,NULL,'603203',NULL),('ICMT280',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT281',NULL,NULL,NULL,NULL,NULL,'Near MPEB Office, Pologround, Indore, MP',NULL,NULL,'452003',NULL),('ICMT282',NULL,NULL,NULL,NULL,NULL,'KLEF Deemed to be University, Vaddeswaram, Guntur, Andhra Pradesh, India','Guntur','Andhra Pradesh',NULL,NULL),('ICMT283',NULL,NULL,NULL,NULL,NULL,'SP Mandali\'s Prin. L.N. Welingkar Institute of Management Development and Research, Matunga, Mumbai, Maharashtra','Mumbai','Maharashtra','400019',NULL),('ICMT284',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT285',NULL,NULL,NULL,NULL,NULL,'HISAR',NULL,NULL,NULL,NULL),('ICMT286',NULL,NULL,NULL,NULL,NULL,'Mohanlal Sukhadia University, Udaipur Rajasthan',NULL,'Rajasthan','313001',NULL),('ICMT287',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Meghalaya',NULL,NULL),('ICMT288',NULL,NULL,NULL,NULL,NULL,'Adipur',NULL,NULL,'370205',NULL),('ICMT289',NULL,NULL,NULL,NULL,NULL,'Navi Mumbai','Mumbai',NULL,NULL,NULL),('ICMT290',NULL,NULL,NULL,NULL,NULL,NULL,'Bathinda',NULL,NULL,NULL),('ICMT291',NULL,NULL,NULL,NULL,NULL,'Commerce Dept, Ghaziabad',NULL,NULL,NULL,NULL),('ICMT292',NULL,NULL,NULL,NULL,NULL,'KL Business School, KLEF Deemed to be University, Vaddeswaram, Guntur, Andhra Pradesh, India. .','Guntur','Andhra Pradesh','522022',NULL),('ICMT293',NULL,NULL,NULL,NULL,NULL,NULL,'Gandhinagar',NULL,NULL,NULL),('ICMT294',NULL,NULL,NULL,NULL,NULL,NULL,'Bilaspur','Chhattisgarh','495009',NULL),('ICMT295',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT296',NULL,NULL,NULL,NULL,NULL,NULL,'Pune',NULL,NULL,NULL),('ICMT297',NULL,NULL,NULL,NULL,NULL,'Cambridge Institute of Technology, Ranchi','Ranchi',NULL,NULL,NULL),('ICMT298',NULL,NULL,NULL,NULL,NULL,'Banaras Hindu University',NULL,NULL,NULL,NULL),('ICMT299',NULL,NULL,NULL,NULL,NULL,'Kolkata. 30, Mother Teresa Sarani, Kolkata .','Kolkata',NULL,'700016',NULL),('ICMT300',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT301',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT302',NULL,NULL,NULL,NULL,NULL,'Kotni, Naya Raipur, Raipur, CG','Raipur',NULL,'492001',NULL),('ICMT303',NULL,NULL,NULL,NULL,NULL,'Department of Management, Airport Road, Opposite Deendayal Nagar, Gwalior - 474 020','Gwalior',NULL,NULL,NULL),('ICMT304',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT305',NULL,NULL,NULL,NULL,NULL,'Naya Raipur','Raipur',NULL,NULL,NULL),('ICMT306',NULL,NULL,NULL,NULL,NULL,NULL,'Pune',NULL,NULL,NULL),('ICMT307',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT308',NULL,NULL,NULL,NULL,NULL,'Naya Raipur, Chhattisgarh','Raipur','Chhattisgarh',NULL,NULL),('ICMT309',NULL,NULL,NULL,NULL,NULL,'Not provided, Not provided, 9431314830, 6299747772, Simran97sin@gmail.com, Finance & Hunam Resource',NULL,NULL,NULL,NULL),('ICMT310',NULL,NULL,NULL,NULL,NULL,'Not provided, Not provided, +919698355454, +919698355454, sindhubps@gmail.com, Management',NULL,NULL,NULL,NULL),('ICMT311',NULL,NULL,NULL,NULL,NULL,'Not provided, Not provided, 00919497243430, 00919497243430, siraj@hotmail.co.in, Sustainable Finance',NULL,NULL,NULL,NULL),('ICMT312',NULL,NULL,NULL,NULL,NULL,'Salem, Not provided, +919894245950, 9894245950, vssivaraman86@gmail.com, CBSE ACCOUNTS, ECONOMICS','Salem',NULL,'636008',NULL),('ICMT313',NULL,NULL,NULL,NULL,NULL,'Off, Priyakant Parikh Marg, Near SAL Hospital, Ghosha Society, Thaltej, Ahmedabad, Gujarat, +919824547489, +919824547489, iyersmita14@gmail.com, HR, OB and general management','Ahmedabad','Gujarat','380054',NULL),('ICMT314',NULL,NULL,NULL,NULL,NULL,'Ravet, Pune, +919730007082, +919730007082, smritiapathak@gmail.com, Finance, Data Analytics','Pune',NULL,'412101',NULL),('ICMT315',NULL,NULL,NULL,NULL,NULL,'INDIAN INSTITUTE OF INFORMATION TECHNOLOGY ALLAHABAD, DEVGHAT, JHALWA, PRAYAGRAJ U. P. INDIA, 91-9452598040, 91-9452598040, sonalhere@gmail.com, HRM, FINANCE','Prayagraj',NULL,'211015',NULL),('ICMT316',NULL,NULL,NULL,NULL,NULL,'Not provided, Not provided, +91 9100710329, +91 9100710329, bsripriya1312@gmail.com, Management, human resources, entrepreneurship, Business communication, organizational behavior, Leadership',NULL,NULL,NULL,NULL),('ICMT317',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT318',NULL,NULL,NULL,NULL,NULL,'Padampur, Shri Ganganagar, Rajasthan',NULL,'Rajasthan','335041',NULL),('ICMT319',NULL,NULL,NULL,NULL,NULL,'Hyderabad','Hyderabad',NULL,NULL,NULL),('ICMT320',NULL,NULL,NULL,NULL,NULL,'Jodhpur','Jodhpur',NULL,'342001',NULL),('ICMT321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT322',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT323',NULL,NULL,NULL,NULL,NULL,'Rudraram, Sangareddy District, Patancheru Mandal.Hyderabad.','Hyderabad',NULL,NULL,NULL),('ICMT324',NULL,NULL,NULL,NULL,NULL,'Sri Krishnadevaraya University Anantapuram',NULL,NULL,NULL,NULL),('ICMT325',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT326',NULL,NULL,NULL,NULL,NULL,'Commerce and Management, Guwahati',NULL,'Assam',NULL,NULL),('ICMT327',NULL,NULL,NULL,NULL,NULL,'Gurukula Knagri (Deemed to be University) Haridwar, Uttarakhand.','Haridwar','Uttarakhand',NULL,NULL),('ICMT328',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT329',NULL,NULL,NULL,NULL,NULL,'Bilaspur, Chhattisgarh-','Bilaspur','Chhattisgarh',NULL,NULL),('ICMT330',NULL,NULL,NULL,NULL,NULL,'Patel Nagar Bhopal-','Bhopal',NULL,NULL,NULL),('ICMT331',NULL,NULL,NULL,NULL,NULL,'Nagappa Street, Seshadripuram, Bangalore-','Bangalore',NULL,NULL,NULL),('ICMT332',NULL,NULL,NULL,NULL,NULL,'PO Box 477, PC 711, Nizwa, Oman',NULL,NULL,NULL,NULL),('ICMT333',NULL,NULL,NULL,NULL,NULL,'ASBM, ALARD Knowledge Park, Survey No. 47 and 50, Near Rajiv Gandhi IT Park, Marunji, Hinjawadi, Pune','Pune',NULL,'411057',NULL),('ICMT334',NULL,NULL,NULL,NULL,NULL,NULL,'Gwalior','Madhya Pradesh',NULL,NULL),('ICMT335',NULL,NULL,NULL,NULL,NULL,'Gwalior, Madhya Pradesh India','Gwalior','Madhya Pradesh',NULL,NULL),('ICMT336',NULL,NULL,NULL,NULL,NULL,'Sector 62, Noida-','Noida',NULL,NULL,NULL),('ICMT337',NULL,NULL,NULL,NULL,NULL,'Management, Sijoul Madhubani Bihar.',NULL,'Bihar',NULL,NULL),('ICMT338',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT339',NULL,NULL,NULL,NULL,NULL,'Uttaranchal University, Dehradun, Uttarakhand-',NULL,'Uttarakhand',NULL,NULL),('ICMT340',NULL,NULL,NULL,NULL,NULL,'Near, Sr. No. 276/1/2, 277/1/2, 278/2, Mumbai Hwy, Near Crystal Honda Showroom, Uttam Nagar, Bhunde Vasti, Bavdhan, Pune, Maharashtra','Mumbai','Maharashtra',NULL,NULL),('ICMT341',NULL,NULL,NULL,NULL,NULL,'IFHE (Deemed to be University under sec. of the UGC Act 1956), Donthanpally, ShankarpallyRoad, Hyderabad','Hyderabad',NULL,NULL,NULL),('ICMT342',NULL,NULL,NULL,NULL,NULL,'SGT University, Gurugram, Haryana','Gurugram','Haryana','122505',NULL),('ICMT343',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ICMT344','-7697513908','-7697513908',NULL,'drabhaysinghchauhan@gmail.com','','Mumbai','','','',''),('ICMT345','-99440396687','-99440396687',NULL,'vigneshphd32@gmail.com','','','','','621105.0',''),('ICMT346','8126231825','8126231825',NULL,'Tyagi.amaresh@gmail.com','','Sikar, Raj.','','','332001.0',''),('ICMT347','8585028933','8585028933',NULL,'samratray@rocketmail.com','','','','','',''),('ICMT348','9.19988E+11','9.19988E+11',NULL,'amanrsohal@gmail.com','','Amritsar','','','',''),('ICMT349','-7978609016','-7978609016',NULL,'drp.amarnath@gmail.com','','Berhampur, Odisha-, Ganjam','','','761008.0',''),('ICMT350','+91 8871266146','+91 8871266146',NULL,'adarshlive9@gmail.com','','Gwalior ()','','','474001.0',''),('ICMT351','9622868185','9622868185',NULL,'caabhat@gmail.com','','Management Studies, Ludhiana Punjab','','','',''),('ICMT352','9.19849E+11','9.19849E+11',NULL,'anjaneyulu@telanganauniversity.ac.in','','Dichpally, Nizamabad, pin :','','','503001.0',''),('ICMT353','9.183E+11','9.183E+11',NULL,'adityapratap27196@gmail.com','','Kanpur.','','','',''),('ICMT354','9163812130','+91 9163812130',NULL,'amitmsdsm@gmail.com','','','','','',''),('ICMT355','9.19976E+11','9.19976E+11',NULL,'aakash4518@gmail.com','','Lavale, Pune','','','412115.0',''),('ICMT356','-6201972758','-6201972758',NULL,'akankshachoubey88@gmail.com','','Management, Anekal, Bangalore','','','',''),('ICMT357','9920367565','9920367565',NULL,'ak.ajit1985@gmail.com','','','','','',''),('ICMT358','91 8306141996','91 8306141996',NULL,'anjitakhandelwal19@gmail.com','','Faculty of management studies, sitapura industrial area, Jaipur','','','',''),('ICMT359','9466885252','9466885252',NULL,'amitsinghyadav1987@gmail.com','','Sirohi, Rajasthan','','','307026.0',''),('ICMT360','-9893939645','-9893939645',NULL,'ajayjai10@gmail.com','','Amethi, Uttar Pradesh, India, Pin Code','','','229302.0',''),('ICMT361','9.19938E+11','9.19938E+11',NULL,'drajitkar5@gmail.com','','Bhubaneswar, Odisha','','','',''),('ICMT362','0091 9986321964','0091 9986321964',NULL,'cap.nagaraj@gmail.com','','Bengaluru','','','',''),('ICMT363','+91 8950390933','+91 8950390933',NULL,'Aayushi.jain1018@gmail.com','','39, Rajiv Gandhi Education City, Delhi-NCR, Sonepat-, Haryana (India)','','','131029.0',''),('ICMT364','-9164070224','-9164070224',NULL,'skirang7@gmail.com','','2nd Phase, Stage 2, Mahalakshmipuram, Bengaluru, Karnataka','','','560086.0',''),('ICMT365','-9803681927','-9803681927',NULL,'lovejitk6@gmail.com','lovejitk6@gmail.com','','','Punjab','','India'),('ICMT366','9849983337','9849983337',NULL,'sudarsana.murthy@amceducation.in','profdsm2025@gmail.com','18th K.M. Bannerghatta Main Road, Kalkere, Bengaluru, Karnataka','','Andhra Pradesh','560083.0','India'),('ICMT367','8948540566','8948540566',NULL,'kumar_amit@lkouniv.ac.in','eco4nomistworld@gmail.com','Lucknow','','Uttar Pradesh','226007.0','India'),('ICMT368','91 9848337426','9.19848E+11',NULL,'kuberuduburlakanti@gmail.com& kuberbk@ya','kuberuduburlakanti@gmail.com','Andhra University, Visakhapatnam.','','Andhra Pradesh','','India'),('ICMT369','9.18881E+11','9.18881E+11',NULL,'yashpallavi27@gmail.com','yashpallavi27@gmail.com','','','Uttar Pradesh','221007.0','India'),('ICMT370','9.19267E+11','9.19267E+11',NULL,'198ashish@gmail.com','ASHISH.SHARMA11@SBI.CO.IN','INVESTMENT BANKING','','MAHARASHTRA','','INDIA'),('ICMT371','91-9891699297','91-9891699297',NULL,'asjadusmani@gmail.com','asjad.usmani@dbitdelhi.edu.in','','','New Delhi','110025.0','India'),('ICMT372','9.19866E+11','9.19866E+11',NULL,'samuel.geddam@alliance.edu.in','samuelmores88@gmail.com','Bengaluru, India','','Karnataka','','India'),('ICMT373','9.19948E+11','9.19948E+11',NULL,'leenaofficial81@gmail.com','leenaofficial81@gmail.com','','','Telangana','','India'),('ICMT374','+91 9448893668','+91 9448893668',NULL,'nitin@klesjgcc.edu.in','nitin.ane.13@gmail.com','Vidyanagar, Hubli','','Karnataka','580021.0','India'),('ICMT375','2.34803E+12','2.34803E+12',NULL,'mufutauakanmupopoola@ghu.edu.ai','mufutau20@gmail.com','','','Osun','','Nigeria'),('ICMT376','9418573693','9418573693',NULL,'thakurrupesh91@gmail.com','thakurrupesh91@gmail.com','Nihri, District Mandi, Himachal Pradesh','','Himachal Pradesh','175038.0','India'),('ICMT377','9.18884E+11','9.18884E+11',NULL,'varun@tulas.edu.in','singh.varun1707@gmail.com','Dhoolkot, Chkrata Raod, Dehradun','','Uttarakhand','248007.0','India'),('ICMT378','8425970400','8425970400',NULL,'','anujt2049@gmail.com','','','Maharashtra','','India'),('ICMT379','9.19436E+11','9.19436E+11',NULL,'','bsinghmzu@gmail.com','Aizawl - 796 004','','Mizoram','','India'),('ICMT380','-9323144789','-9323144789',NULL,'vineet.suri@sharda.ac.in','vineetsuri2001@gmail.com','Plot no 32-34, Knowledge Park III, Greater Noida, Uttar Pradesh','','Uttar Pradesh','201310.0','India'),('ICMT381','+91 9000000011','+91 9000000011',NULL,'payment.test@example.com','payment.personal@example.com','Nellore, Andhra Pradesh',NULL,'Andhra Pradesh','524001','India'),('ICMT382','+91 94440 12345','+91 94440 12345',NULL,'final@gmail.com','final.personal@gmail.com','Sardar Patel Road, Guindy',NULL,'Tamil Nadu','600025','India'),('ICMT383','9848664044','9848664044',NULL,'sankar@gmail.com','sankar@gmail.com','narayana collage of engineering',NULL,'Andhra Pradesh','789065','India');
/*!40000 ALTER TABLE `member_contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_images`
--

DROP TABLE IF EXISTS `member_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_images` (
  `image_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `member_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `idx_member_images_member_id` (`member_id`),
  CONSTRAINT `fk_member_images_member` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_images`
--

LOCK TABLES `member_images` WRITE;
/*!40000 ALTER TABLE `member_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `academic_title` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `designation` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `institution` text COLLATE utf8mb4_unicode_ci,
  `membership_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `my_status` enum('Active','Inactive','Pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES ('ICMT001',NULL,'Dr. A SATHISH KUMAR','Associate Professor',NULL,'Government Degree and PG College,, Peddakalwala, Peddapalli, Pincode-505174, Telangana',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-29 05:19:11'),('ICMT002',NULL,'DR. A V RAO','Dean',NULL,'NSB World Business School, Sy.No.85, Singena, Agrahara, Taluk, near Electronic City, Phase II, Huskur Post, Anekal, Bengaluru, Karnataka 560099','Annual Member (Faculty)',0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT003',NULL,'Mr. ABID ABBAS ZAIDI','Research Scholar',NULL,'Aligarh Muslim University,, Aligarh, Uttar Pradesh 202001',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT004',NULL,'Mrs. ALKA G. GUPTA','Assistant Professor',NULL,'International Institute of Business Studies, #75, Muthugadahalli, Bangalore North Jala Hobli, Near International Airport, Bangalore, Karnataka - 562157',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT005',NULL,'DR. ALOK KUMAR','Assistant Professor','Department of Commerce','Banaras Hindu University','Life Member (Faculty)',0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT006','Mr.','ANUJ VERMA','Assistant Professor','Approved Mgmt Department','Sanskrithi School of Business','Life Member (Faculty)',0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT007',NULL,'Dr. ANUPRIYO MALLICK','Professor',NULL,'Eastren Institute for Integrated Learning in, Management, Dn-9, Salt Lake Bypass, DN Block, Sector V, Bidhannagar, Kolkata, West Bengal 700091',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT008',NULL,'DR B. MOHAN KUMAR','Principal',NULL,'Badruka College of Commerce and Arts,, Kachiguda Station Rd, Rahamath Bagh, Chappal Bazar, Kachiguda, Hyderabad, Telangana 500027',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT009',NULL,'Dr. B NAGARAJU','Professor',NULL,'DOS in Commerce, University of Mysore,, Manasagangotri campus, Mysore',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT010',NULL,'Ms. B PAWNI','Assistant Professor','Dept. of MBA','Dept. of MBA, St. John’s College of, Engineering and Technology, Yerrakota, Yemmiganur, Kadimetla, Andhra Pradesh 518360',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT011',NULL,'MRS. BABITHA M N','Head of the Department',NULL,'Pinnacle Institute of Management and Science,, Behind Deepa complex, near Ambedkar college, Nagarabhavi, Bangalore 560072',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT012',NULL,'DR. BAGALI M M','Professor',NULL,'Dayananda Sagar University (DSU) - City, Campus, Address: Hosur Rd, Kudlu Gate, Srinivasa Nagar, Hal Layout, Singasandra, Bengaluru, Karnataka 560068',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT013',NULL,'DR. BARLA VENKATESWARLU','Professor',NULL,'Chaitanya Bharathi Institute of Techology,, Gandipet, Hyderabad, Telangana-500075',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT014',NULL,'MS. BESTHA SAI SANDHYA','Assistant Professor',NULL,'Sanskrithi School of Business, BBA,, Puttaparthi-515134',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT015',NULL,'Dr. BHAGYALAKSHMI K','Assistant Professor',NULL,'Centre for PG Studies, Mysuru, VTU Regional Centre Outer Ring Road, Hanchya Sathagalli layout Mysuru- 570029',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT016',NULL,'DR. BHANU SREE REDDY D','Dean',NULL,'School of Management,, MITS Deemed to be University, Madanapalle, 517325, Andhra Pradesh, India',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT017',NULL,'MS. BHANUMATHI S M','Assistant Professor',NULL,'Imperial Group of Instiutions,, 226/2, Kanakapura Main Rd, near Kagalipura, Saaluhunase village, Kaggalipura, Karnataka 560116',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT018',NULL,'Dr. BHARATHI THIYAGARAJAN','Assistant Professor','Department of hospital and health management','Institute of Health Management and Research, (Bangalore), Department of hospital and health management, 319, Hulimangala post, Electronic City Phase I, Bangalore- 560105',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT019',NULL,'MRS. C KALAVATHY','Professor',NULL,'RVD Institute of Information and Technology,, Bangalore',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT020',NULL,'Dr. CHALUVADI BALA NAGESWARA RAO','Dean','Dept of Mmanagement Sciences','RVR &JC College of Engineering, Dept of, Mmanagement Sciences,Chowdavaram, Guntur, 522019',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT021',NULL,'Dr. CHANAMBAM NALINI DEVI','Associate Professor',NULL,'Pachhunga University College, College Veng,, Aizawl, Mizoram 796001',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT022',NULL,'DR. CHAND BASHA','Professor',NULL,'St Ann\'s College of Engineering and Technology',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT023',NULL,'Dr. CHANDAN VEER','Assistant Professor',NULL,'Sarala Birla University, Sarla Birla university, campus, Ranchi, Tatisilwai, Jharkhand 835103',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT024',NULL,'Dr. CHIRANTH K M','Assistant Professor','Dept. of Mgmt. Studies','Dept. of Mgmt. Studies,, Centre for PG Studies, Mysuru VTU Regional Centre Outer Ring Road, Hanchya Sathagalli layout Mysuru- 570029',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT025',NULL,'Mr. CTM NAGESH','Assistant Professor',NULL,'BHEEMI REDDY INSTITUTE OF, MANAGEMENT SCIENCE, ALUR ROAD,ADONI-518301',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT026',NULL,'DR. D. H. MALINI','Head of the Department',NULL,'Pondicherry iniversity, Karaikal Campus,, R Venkat Raman Nagar, Kalapet Pondicherry - 605 014, India',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT027',NULL,'MS. DEEPIKA GR','Assistant Professor',NULL,'Padmashree Institute of Management and sciences, 149, Padmashree Campus, Tavarekere- Kengeri Road, Kommaghatta Main Rd, Kengeri, Kommaghatta, Karnataka 560060',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT028',NULL,'DR.M.S.VASU','Head of the Department','Department of MBA','Sree Rama Engineering College, Department of MBA,, Karakambadi Road, Tirupati - 517507, Andhra Pradesh',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT029',NULL,'DR G. DHANANJAY','Dean',NULL,'Narayana Engineering College,, MBA Department, Near Apollo Hospitals, Muthukur Road, Nellore- 524004 (AP)',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT030',NULL,'DR. G RAMANJANEYULU','Associate Professor',NULL,'International institute of Business studies, (IIBS),Address: #75, Muthugadahalli, Bangalore North Jala Hobli Near International Airport, Bangalore-562157',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT031',NULL,'Dr. G V R K ACHARYULU','Dean',NULL,'School of Management Studies, University of, Hyderabad, Hyderabad-500046',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT032',NULL,'MR. GANGADHARA. B','Associate Professor',NULL,'SRPA First Grade College,, Rajajinagar, Bangalore, Bangalore University',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT033',NULL,'Dr. GOWRI G','Assistant Professor','Department and Research','PG Department and Research, centre in Commerce, Rajapayam Rajus College, Rajapayam 626117',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT034',NULL,'DR GUNDA RAMESH BABU','Associate Professor',NULL,'Retired associate professor of commerce, from government of telengana',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT035',NULL,'DR. GUNDA SRINIVAS','Head of the Department',NULL,'Alphores Women’s Degree & PG College,, Karimnagar Rd, Suryanagar, Karimnagar, Telangana 505002',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT036',NULL,'DR. GUNDUPAGI MANJUNATH','Principal',NULL,'Bheemi Reddy Institute of Management, Science, Alur Road, Adoni - 518301, Kurnool District, Andhra Pradesh',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT037',NULL,'DR. HARIHARAN G','Assistant Professor','Department of Management Sciences','PSG College of Arts & Science, Department of, Management Sciences, PSG College of Arts & Science, Coimbatore-641014',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT038',NULL,'DR. IGNATIUS B','Principal',NULL,'RVD College of Management and Information, Technology, #11&12, Srinivas Nagar, 2nd Phase, Kathreguppe, Banashankari 3rd Stage, Bengaluru, Karnataka 560050',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT039',NULL,'Dr. IMAILZABIULLAH.B','Assistant Professor',NULL,'CMR University,, #2, 3rd ‘C’ Cross, 6th ‘A’ Main, 2nd Block, HRBR Layout, Kalyana Nagar, Bangalore 560043, Karnataka, India',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT040',NULL,'Dr. INDRANIL BOSE','Dean',NULL,'School of Business,, Adamas University, Kolkata, West Bengal, Pin-700125',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT041',NULL,'DR. JANARDHAN SHETTY','Dean',NULL,'East West Institutions, Banaglore',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT042',NULL,'DR. JESMON RAJ N','Associate Professor','Department of Commerce','Department of Commerce,, St. Francis College, Koramangala, Bengaluru 560034',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT043',NULL,'Dr. K THARAKA RAMI REDDY','Professor',NULL,'The Oxford College of Engineering,, 10th Milestone, Hosur Rd, Bommanahalli, Bengaluru, Karnataka 560068',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT044',NULL,'DR. KAMRAN AMBAR MOHD AYYUB RAHMANI','Associate Professor',NULL,'Anjuman Moinut Tulba Malegaon Senior, College of Arts Science & Commerce, Raunaqabad, Gulshanabad, Malegaon, Maharashtra 423203',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT045',NULL,'MR. KAMSALI SREENIVASULU','Principal',NULL,'Karthikeya Degree College, opp. GOVT SCHOOL, Kowthalam, Andhra Pradesh 518344',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT046',NULL,'Dr. KANDULA RAJESH SAM','Assistant Professor','Dept. of H&SS','JNTUACEA, Dept. of H&SS, Anantapur., 505002',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT047',NULL,'Dr. KANIKA SACHDEVA','Professor',NULL,'School of Business,, Sushant University, Golf Course Rd, Huda, Sushant Lok 2, Sector 55, Gurugram, Haryana 122011',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT048',NULL,'Dr. KANTAMANENI HEMA DIVYA','Associate Professor',NULL,'KLEF Deemed to be University,, Green Fields, Vaddeswaram, Guntur District, A.P., INDIA. Pincode: 522 302',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT049',NULL,'Dr. KAVITHA B N','Assistant Professor','Department of MBA','Visvesvarya Technological University,, Department of MBA, Sathagalli ringroad, Mysuru Karnataka 570019',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT050',NULL,'Dr. KHUSHLEEN KAUR','Assistant Professor','Dept. of MBA','Dept. of MBA,, Khalsa College Of Engineering And Technology, C Block, Ranjit Avenue, Amritsar, Punjab 143001',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT051',NULL,'DR. LAKSHMI R B','Assistant Professor',NULL,'Christ University, Yeshwantpur Campus,, Bangalore - 560073',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT052',NULL,'Dr. M ABDUL SIBIRIL','Assistant Professor','Department of Business Administration','Department of Business Administration, The, New College(Autonomous), Royapettah,Chennai-14, Tamilnadu, India',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT053',NULL,'DR. M. BALA KOTESWARI','Dean',NULL,'Sanskrithi School of Business, Management,, Behind Sri Sathya Sai Super Speciality Hospital, Prashanthigram, Puttaparthi - 515134, Sri Sathya Sai District, Andhra Pradesh',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT054',NULL,'DR. MADHAVAIAH CHENDRAGIRI','Professor','Department of Management Studies','Pondicherry University, Department of, Management Studies, Sri Vijaya Puram (Port Blair) Campus, Brookshabad, Sri Vijaya Puram - 744112, Andaman & Nicobar Islands',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT055',NULL,'MR. MALLIKARJUN','Assistant Professor',NULL,'AMTA GOVERNMENT FIRST GRADE COLLEGE ALAND,, KALABURAGI DISTRICT KARNATAKA 585302',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT056',NULL,'Mr. MANMAYA KUMAR TRIPATHY','Research Scholar',NULL,'Sambalpur University, Jyoti Vihar,, Burla, Odisha 768019',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT057',NULL,'Dr. MEGHNA CHOTALIYA','Associate Professor',NULL,'RD and SH National College and SWA, Science College',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT058',NULL,'DR. N CHANDAN PRASAD','Head of the Department',NULL,'Bheemi Reddy Institute of Management Science, Alur, Road, Adoni - 518301, Kurnool District, Andhra Pradesh',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT059',NULL,'DR. N. SAMBASIVA RAO','Professor','Department of Commerce and Management Studies Andhra University Visakhapatnam. Research Supervisor','ICSSR Senior Fellow, Department of, Commerce and Management Studies Andhra University Visakhapatnam',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT060',NULL,'Dr. NAGARAJU L G','Assistant Professor',NULL,'School of Management studies, REVA, University, Rukmini Knowledge Park, Yelahanka, Kattigenahalli, Bengaluru, Sathanur, Karnataka 560064',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT061',NULL,'Dr. NIJAGUNA G','Professor',NULL,'Acharya Institute of Technology, Business, Administration, Hesaraghatta Main Raod, Soldevanahalli, Bengaluru-560107',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT062',NULL,'DR. NITAL KOTHARI','Associate Professor','Department of Commerce','Jaihind College, Department of Commerce,, Churchgate, Mumbai 400020',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT063',NULL,'DR. NUSRAT CHOUDHARY','Head of the Department',NULL,'Shree L. R. Tiwari Degree, College of Arts, Commerce & Science, near by RIS, Shree L.R Tiwari Educational Campus, Kanakia Park, Mira Road East, Thane, Mira Bhayandar, Maharashtra 401105',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT064',NULL,'DR. P. PARAMASHIVAIAH','Dean','Department of Studies and Research in M. Com IS','Senior Professor & Chairman, Department of, Studies and Research in M. Com IS, Tumkur University, Tumkur-572 103',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT065',NULL,'Dr. PADUCHURU VISWANATH','Assistant Professor',NULL,'School of Management Studies, JNTUA,, Ananthapuramu, Andhra Pradesh 515002',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT066',NULL,'Ms. POOJA VAIDYA','Assistant Professor',NULL,'MGM\'s Dr. G.Y. Pathrikar College Of Computer, Science And Information Technology, N-6, M G M, Chhatrapati Sambhajinagar, Maharashtra 431003',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT067',NULL,'Dr. PRASHANT MISHRA','Assistant Professor',NULL,'PRAMOD RAM UJAGAR TIWARI SAKET, INSTITUTE OF MANAGEMENT, Chinchpada Road, Near Mahtre Naka, Kalyan East 421306',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT068',NULL,'Dr. PRASHANTH S','Principal',NULL,'Sitadevi Ratanchand Nahar Adarsh College,, #75, 5th main road, Chamarajpet, Bengaluru Karnataka 560018',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT069',NULL,'Dr. PRAVEEN KUMAR SINHA','Not Specified',NULL,NULL,NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT070',NULL,'DR. R VARA PRASAD','Associate Professor','Department of Management Studies','Department of Management Studies,, SSGS Degree College (Aided & Autonomous), Koya Nagar, Kasapuram Road, Guntakal 515801',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT071',NULL,'Dr. RAJ KUMAR BOORA','Assistant Professor','Dept. of Management Stuidies','Dept. of Management Stuidies,, National Institute of Technology Campus, Hanamkonda, Telangana 506004',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT072',NULL,'Dr. RAJESH R','Assistant Professor','Department of Tourism and Hospitality','Department of Tourism and Hospitality, Management, Mizoram University, Aizawl, Mizoram 796004',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT073',NULL,'Dr. RAKESH NADIG H S','Assistant Professor',NULL,'St. Joseph’s College of Commerce, (Autonomous), 163, Brigade Rd, Shanthala Nagar, Ashok Nagar, Bengaluru, Karnataka 560025',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT074',NULL,'Dr. RAMESH KUMAR MIRYALA','Associate Professor',NULL,'Mahatma Gandhi University, Nalgonda,, Telangana 508254',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT075',NULL,'Dr. RAMU NAGARAJUPILLAI','Professor','Department of Commerce','Department of Commerce,, Annamalai University, Annamalai Nagar-608 002',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT076',NULL,'Lt. DR. RANGANATHAM GANGINENI','Associate Professor','Dept. of Commerce','Dept. of Commerce, School of Business, Studies, Central University of Karnataka, Kalaburagi, Karnataka - 585367',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT077',NULL,'Dr. R.RANGANATH','Head of the Department',NULL,'Dr. Sri Sri Sri Shivakumara Mahaswamy College of, Engineering, Byranayakanahalli, Thymagondlu Hobli, Nelamangala, Bengaluru Rural, Karnataka 562132',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT078',NULL,'DR. S. VIJAY KUMAR','Associate Professor','Department of Business Management','Department of Business Management,, Stanley College of Engineering and Technology for Women, Hyderabad 500001',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT079',NULL,'DR. SAGAR G','Assistant Professor',NULL,'Canara Bank School of Management Studies,, Bangalore Unviersity, Bangalore',NULL,0,'Inactive','2026-09-19 06:41:23','2026-09-28 12:06:32'),('ICMT080',NULL,'DR. SAMUEL MORES G','Assistant Professor',NULL,'School of Business, Adithya University,, Aditya Nagar, ADB Rd, Surampalem, Andhra Pradesh 533437',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT081',NULL,'Dr. SANDABOINA SHIVAKUMAR YADAV','Assistant Professor','DEPARTMENT OF COMMERCE','KONERU LAKSHMAIAH EDUCATION, FOUNDATION DEEMED TO BE UNIVERSITY, DEPARTMENT OF COMMERCE, KL BUSINESS SCHOOL, GUNTUR 522302',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT082',NULL,'MR. SANTOSHKUMAR K HANGANAKATTI','Assistant Professor',NULL,'Government First Grade College, Anavatti, Soraba Taluk - 577413',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT083',NULL,'Ms. PROF. SASWATI MOHANTY','Head of the Department','Dept. of Business Studies','Dept. of Business Studies,, Radhakrishna Institute of Technology and Engineering, IDCO Plot No. 1, IDCO Industrial Estate Khurda – 752057',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT084',NULL,'MS. SAYYAD SANA ALI','Assistant Professor',NULL,'Sydenham College of Commerce and, Economics, B Rd, Churchgate, Mumbai, Maharashtra 400020',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT085',NULL,'DR. SEEMA SINHA','Associate Professor',NULL,'Christ University,, Hosur Main Road, Bhavani Nagar, Post, Bengaluru, Karnataka 560029',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT086',NULL,'Dr. SESHAGIRI ASHOK','Assistant Professor','Dept. of Commerce','Dept. of Commerce,, The Adoni Arts & Science College, Adoni. Kurnool District AP-518301',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT087',NULL,'Dr. SHEIK KUTHIJA','Associate Professor',NULL,'Sanskrithi School of Business,, Prashanthi Gram, Puttaparthi -515134',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT088',NULL,'DR. SHISH PAL','Associate Professor',NULL,'Gateway School of Business, Gateway, Campus, Delhi-NCR, Sonipat - 131001',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT089',NULL,'Dr. SHIVAKUMAR','Assistant Professor',NULL,'Centre for PG Studies, Mysuru, VTU Regional Centre Outer Ring Road, Hanchya Sathagalli layout Mysuru- 570029',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT090',NULL,'Mr. SREEDATH TULAMANDI','Not Specified',NULL,NULL,NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT091',NULL,'Dr. SUDHAKAR MADHAVEDI','Assistant Professor',NULL,'Kshatriya College of Engineering, NH 16, Chepur, Armur, Telangana 503223',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT092',NULL,'Mr. SUDHAKARAN T','Assistant Professor','Dept. of Comm. & Mgmt','Dept. of Comm. & Mgmt., Seshadripuram First, Grade College, Site No. 26, SH 9, Yelahanka New Town, Bengaluru, Karnataka 560064',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT093',NULL,'DR. SUDIPTI BANERJEE','Professor','Department of Commerce / former Head','Department of Commerce / former Head, , Department of Commerce / former Director, IQAC, University of Calcutta',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT094',NULL,'Dr. SURA GOVARDHAN','Assistant Professor',NULL,'St. Mary\'s Group of Institutions,, Hyderabad',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT095',NULL,'Dr. SWETHA THIRUCHANURU','Assistant Professor',NULL,'Sri Sathya Sai Institute of Higher learning,, DMC, Anantapur Campus, Anantapur, Andhra Pradesh, India 515001',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT096',NULL,'DR. T.NARESH BABU','Associate Professor','Department of Management Studies','Department of Management Studies,, KSRM College of Engineering(A), Kadapa- 516004',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT097',NULL,'Dr. TWINKLE PRUSTY','Professor',NULL,'Banaras Hindu University, Ajagara,, Varanasi, Uttar Pradesh 221005',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT098',NULL,'Dr. V CHANDRASEKHAR RAO','Not Specified',NULL,NULL,NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT099',NULL,'MR. V RANGANATHAM','Assistant Professor',NULL,'Sanskrithi School of Business,, Behind Sri Sathya Sai Super Speciality Hospital, Prashanthigram, Puttaparthi - 515134, Sri Sathya Sai District, Andhra Pradesh',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT100',NULL,'DR. VENKATESAN T','Associate Professor',NULL,'Knowledge Institute of Technology,, Knowledge College Rd, Kakapalayam, Selliampalayam, Tamil Nadu 637504',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT101',NULL,'DR. VIJAY KUMAR SHROTRYIA','Dean',NULL,'Faculty of Commerce,, Delhi School of Economics, University of Delhi',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT102',NULL,'Dr. VIKAS BHATHEJA','Associate Professor',NULL,'Dept.of Psychology, Santosh Memorial, Rehabilitation & Research centre,Canal Colony, Narnaul, Haryana 123001',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT103',NULL,'Dr. VIKAS KUMAR KHARE','Assistant Professor',NULL,'CGC University, Mohali, State Highway 12A,, Chandigarh-Sirhind Road, Sahibzada Ajit Singh Nagar, Punjab 140307',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT104',NULL,'Mr. VINAY RAO B N','Assistant Professor',NULL,'Symbiosis International University, Visiting, faculty at SCMS(UG) and SIBM (PG), Management Department, Symbiosis - CGI Rd, Electronic City Phase I, Electronic City, Hebbagodi, Karnataka 560100',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT105',NULL,'DR. VIPAN KUMAR BHULAL','Assistant Professor',NULL,'Himachal Pradesh University,, Shimla, India Pin: 171001',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT106',NULL,'Dr. YARLAGADDA SRINIVASULU','Professor',NULL,'Pondicherry University, School of, Management, Puducherry-605014',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT107',NULL,'Dr. ANKIT KUMAR KATIYAR','Assistant Professor','College of management studies','College of management studies',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT108',NULL,'Dr. Ansha Gupta','Assistant Professor','MKES Institute of Management Studies and Research','MKES Institute of Management Studies and Research',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT109',NULL,'Dr. Anson C J','Assistant Professor',NULL,'Madras Christian College',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT110',NULL,'Dr. ANUJ SHEOPURI','Professor','Department of Management','HIMT',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT111',NULL,'Dr. ANUSHKA KULKARNI','Associate Professor','School of Creative Studies','School of Creative Studies',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT112',NULL,'Dr. APARNA SAMUDRA','Associate Professor','Department of Economics','RTM Nagpur University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT113',NULL,'Ms. ARINI ROYCHOUDHURY','Research Scholar',NULL,'Guru Ghasidas Vishwavidyalaya',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT114',NULL,'Mr. ARLA NAGARAJESH','Assistant Professor',NULL,'Siddartha Educational Academy Group of Institutions (Autonomous)',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT115',NULL,'Dr. ARUNA DESHPANDE','Professor',NULL,'University of Mumbai',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT116',NULL,'Mr. Ashok Kumar','Assistant Professor','District Sirmour HP (Department of Higher Education HP (College Cadre)','District Sirmour HP (Department of Higher Education HP (College Cadre)',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT117',NULL,'Ms. AYUSHI TIWARI','Assistant Professor',NULL,'SCOPE GLOBAL SKILLS UNIVERSITY - Scope Campus',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT118',NULL,'Ms. B. SAI SANDHYA','Assistant Professor','Sanskrithi School of Business','Sanskrithi School of Business',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT119',NULL,'Dr. B SARATH SIMHA','Associate Professor',NULL,'KLH Global Business School',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT120',NULL,'Dr. BHABANI SHANKAR PADHY','Associate Professor',NULL,'Sanskrithi School of Business',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT121',NULL,'Mr. BIKASH KUMAR AGARWALLA','Head of the Department','Euro School','Euro School',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT122',NULL,'Dr. Brindha Natarajan','Assistant Professor',NULL,'Shrimati Indira Gandhi College',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT123',NULL,'Dr. DR CH KRISHNUDU','Assistant Professor',NULL,'SKIM',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT124',NULL,'Dr. CHACKO JOSE P','Professor',NULL,'St. Aloysius College',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT125',NULL,'Mrs. CHARU GOYAL','Assistant Professor','Parul Institute of Business Administration','Parul Institute of Business Administration',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT126',NULL,'Dr. D. ANJANEYULU','Principal','Dept. of Commerce','Sri Krishnadevaraya University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT127',NULL,'Dr. D Asok','Assistant Professor',NULL,'Sri Ramachandra Institute of Higher Education and Research',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT128',NULL,'Dr. D. DHANASEKAR','Assistant Professor','Department of Management','Shrimati Indira Gandhi College',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT129',NULL,'Dr. DANISH KHAN','Assistant Professor','St. Joseph’s College of Commerce (Autonomous)','St. Joseph’s College of Commerce (Autonomous)',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT130',NULL,'Dr. DASARI RAJESH BABU','Associate Professor',NULL,'Mohan Babu University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT131',NULL,'Dr. DEBASIS MOHAPATRO','Assistant Professor',NULL,'School of Management Studies',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT132',NULL,'Dr. DEBASRI DEY','Associate Professor','Department of Management','Brainware University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT133',NULL,'Mr. DEBAYAN KANTY BOSE','Assistant Professor',NULL,'Presidency University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT134',NULL,'Mr. DEEP','Assistant Professor',NULL,'Emeritus',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT135',NULL,'Dr. DEEPIKA CHAUDHARY','Assistant Professor','School of Management and Commerce','K R Mangalam University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT136',NULL,'Dr. Deepika Gautam','Assistant Professor',NULL,'Himachal Pradesh National Law University Shimla',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT137',NULL,'Dr. DEVANJALI DUTTA','Assistant Professor','K.M Agrawal College of Arts Commerce and Science','K.M Agrawal College of Arts Commerce and Science',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT138',NULL,'Mr. DEVANSHU MONGA','Research Scholar','HPKV Business School','HPKV Business School',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT139',NULL,'Dr. DEVRSHI UPADHAYAY','Associate Professor',NULL,'GLS University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT140',NULL,'Mr. DHARAVATH POOLSINGH','Assistant Professor','School of Agribusiness management','Professional Jayashankar Telangana Agricultural University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT141',NULL,'Dr. DILEEP KUMAR M','Professor',NULL,'Hensard University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT142',NULL,'Dr. Abhishek Kumar Singh','Research Scholar',NULL,NULL,NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT143',NULL,'Dr. Sailaja Vasakarla','Assistant Professor',NULL,'Sri Krishnadevaraya University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT144',NULL,'Dr. SUGANYA SUBRAMANIYAM','Assistant Professor','School of Management Studies','School of Management Studies',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT145',NULL,'Mr. DUSHAN KESHAWA DEEMANTHA PERERA','Head of the Department','Former Head of the Department (for International Programmes)','Saegis Campus',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT146',NULL,'Dr. ELIZABETH DIAS','Assistant Professor',NULL,'Vile Parle',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT147',NULL,'Mr. FATAI KAYODE WAHAB','Research Scholar',NULL,'Federal University of Medicine and Medical Sciences Abeokuta',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT148',NULL,'Dr. G PRASANNA KUMAR','Assistant Professor','Department of Management Studies','Pragati Engineering college',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT149',NULL,'Dr. G RAMAKRISHNA REDDY','Professor',NULL,'Sri Ramakrishna Degree &PG College (Autonomous)',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT150',NULL,'Dr. GAIKAR VILAS B.','Professor','Dept of Economics and Business Economics','Smt. CHM College (Autonomous)Ulhasnagar',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT151',NULL,'Dr. Dr GANAPATHI JAGARAPU','Assistant Professor',NULL,'Department of MBA Loyola academy Hyderabad',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT152',NULL,'Mr. GAURAV','Assistant Professor',NULL,'Bharati Vidyapeeth University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT153',NULL,'Mr. GAURAV MITRA','Research Scholar','Finance and Accouting area at FORE School of Management- Adhitam Kendra','Finance and Accouting area at FORE School of Management- Adhitam Kendra',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT154',NULL,'Mr. Gokul K','Assistant Professor','Center for Management Studies','Jain (deemed to be) University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT155',NULL,'Dr. Dr Gonjipalli Suneetha','Principal',NULL,'MRM institute of management chintapalli guda village Ibrahimpatnam mandal range reddy district Telangana Hyderabad',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT156',NULL,'Dr. GOVINDAPPA. D','Professor','School of Commerce and Management','School of Commerce and Management',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT157',NULL,'Dr. Gowtham Aashirwad Kumar','Assistant Professor','Department of Management Studies','School of Commerce and Management',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT158',NULL,'Ms. GOWTHAMI M','Assistant Professor',NULL,NULL,NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT159',NULL,'Mrs. GUDURI SWATHI','Assistant Professor',NULL,'BIMS',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT160',NULL,'Dr. GURU BASAVA ARADHYA S`','Dean',NULL,'Atria Institute of technology',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT161',NULL,'Dr. Gyan Prakash Mishra','Professor',NULL,'Madan Mohan Malviya University of Technology',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT162',NULL,'Ms. HUZAIFA NAXIR','Research Scholar',NULL,'Department Of Management Studies University Of Kashmir South Campus Highground Fatehgarh Anantnag',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT163',NULL,'Dr. J Rajesh','Dean',NULL,'Srinath University Jamshedpur Jharkhand',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT164',NULL,'Dr. J.SNEHA JAYALAKSHMI','Assistant Professor',NULL,'Sanjivani University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT165',NULL,'Dr. JAMSHI J','Assistant Professor',NULL,'Sacred Heart College',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT166',NULL,'Ms. Jayasree S R','Assistant Professor','Meenakshi Sundararajan School of Management','Meenakshi Sundararajan School of Management',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT167',NULL,'Dr. JIGNESH N. VIDANI','Associate Professor','Swarrnim Institute of Management Studies','Swarrnim Institute of Management Studies',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT168',NULL,'Dr. JOMON JOSE M','Associate Professor','Sahrdaya Institute of Management Studies (SIMS)','Sahrdaya Institute of Management Studies (SIMS)',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT169',NULL,'Dr. JOY CHAKRABORTY','Assistant Professor','INDIAN INSTITUTE OF SOCIAL WELFARE & BUSINESS MANAGEMENT','INDIAN INSTITUTE OF SOCIAL WELFARE & BUSINESS MANAGEMENT',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT170',NULL,'Dr. JYOTI KUKREJA','Assistant Professor',NULL,'New Delhi Institute of Management',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT171',NULL,'Dr. Jyotsna','Associate Professor',NULL,'Jagan institute of management studies sector-5 Rohini',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT172',NULL,'Mrs. , K.LALITHA PARAMESHWARI','Assistant Professor',NULL,'hindusthan college of Arts & Science',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT173',NULL,'Dr. K.Sharath Babu','Professor','Department of Management Studies','Geethanjali College of Engineering and Technology',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT174',NULL,'Dr. KAILASH CHANDRA DASH','Assistant Professor',NULL,'Parul University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT175',NULL,'Dr Kamal Agal','Associate Professor',NULL,'Associate Professor School of Management Studies Gujarat Technological University Ahmedabad Gujarat',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT176',NULL,'Dr. Kamlesh Kumar Maurya','Assistant Professor',NULL,'UPES Dehradun Uttarakhand',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT177',NULL,'Dr. KAUSIK MUKHERJEE','Dean',NULL,'DEAN. AKS UNIVERSITY SATNA MP INDIA',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT178',NULL,'Dr. KAVITA DIVE','Head of the Department','Kopargoan SCM Commerce Department','Sanjivani University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT179',NULL,'Dr. Keerthi jain','Assistant Professor',NULL,'VIT-AP University',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT180',NULL,'Dr. Dr Kiran Kumar Thoti','Professor',NULL,'Vidya Vikas Institute of Engineering and Technology',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT181',NULL,'Dr. Kiran Maney','Associate Professor',NULL,'Acharya Institute of Graduate Studies',NULL,0,'Inactive','2026-09-19 06:41:24','2026-09-28 12:06:32'),('ICMT182',NULL,'Dr. KIRTI SINGH','Assistant Professor','Department of Commerce','Faculty of Commerce & Business Delhi School of Economics',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT183',NULL,'Dr. KOLACHINA SRINIVAS','Director',NULL,'Skyline University Nigeria',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT184',NULL,'Dr. KRISHN AWATAR GOYAL','Professor','Department of Business Finance & Economics','Jai Narain Vyas University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT185',NULL,'Mr. KRISHNA PRAKASH M','Research Scholar',NULL,'SRM Institute of Science and Technology',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT186',NULL,'Dr. Krishnan Sampath','Professor',NULL,'Freelancer',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT187',NULL,'Dr. KULVINDER KAUR','Professor',NULL,'KC College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT188',NULL,'Dr. Kumardatt Ganjre','Professor','Sankalp Business School','Sankalp Business School',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT189',NULL,'Dr. KURUVA MADDILETI','Assistant Professor','Department of Commerce','Sri Krishnadevaraya University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT190',NULL,'Dr. KUSHAGRA SHARAN','Assistant Professor',NULL,'IILM Lucknow',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT191',NULL,'Dr. LAKSHMAN SINGH','Head of the Department',NULL,'Hindustan Aeronautics Limited',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT192',NULL,'Dr. LAKSHMINARAYANA K','Assistant Professor','Department of Master of Business Administration','Visvesvaraya Technological University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT193',NULL,'Dr. LALY ANTONEY','Principal',NULL,'VISAT Arts and Science. College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT194',NULL,'Dr. LATEEF OKIKIOLA OLANIPEKUN','Associate Professor',NULL,'Accra Institute of Technology',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT195',NULL,'Dr. LEENA','Assistant Professor','Jaipuria School of business','Jaipuria School of business',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT196',NULL,'Dr. LINET CHRISTILDA GNANALILLY R','Dean',NULL,'Women\'s Christian College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT197',NULL,'Dr. MAHENDER PAL','Assistant Professor','Department of Commerce','Govt. Post Graduate College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT198',NULL,'Dr. Mahesh Bendigeri','Dean','Global Business School Hubli','Global Business School Hubli',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT199',NULL,'Dr. MALATHI GOTTUMUKKALA','Assistant Professor',NULL,'Central University of Andhra Pradesh',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT200',NULL,'Dr. MALAY PATEL','Associate Professor',NULL,'Karnavati University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT201',NULL,'Dr. MALIKA SUBHASHISH JAIN','Assistant Professor',NULL,'MIT WPU',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT202',NULL,'Dr. MALLIKARJUN MARADI','Dean',NULL,'Bagalkot University Jamkhandi and Department of Commerce',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT203',NULL,'Ms. MANISHA KALRA','Assistant Professor','Department Of Commerce & Management','Guru Kashi University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT204',NULL,'Mr. MANU G C','Research Scholar',NULL,'IIM',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT205',NULL,'Dr. MAYANK RAJ','Assistant Professor','Faculty of Commerce and Management','United University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT206',NULL,'Mr. Michael Vijay Kiran C','Research Scholar','School of Business','VIT-AP University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT207',NULL,'Ms. Minerva Das','Assistant Professor',NULL,'PES University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT208',NULL,'Dr. MOHAMED RIAZ','Head of the Department','Department of Management Studies','Jamal Mohamed College of Engineering',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT209',NULL,'Dr. MOHAMMAD ZUBAIR AHMAD','Professor',NULL,'Utkarsh College of Management Education',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT210',NULL,'Dr. MRITYUNJAY KUMAR','Assistant Professor',NULL,'Indira University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT211',NULL,'Dr. MUHAMMED ALI KT','Dean','Sirajul Huda Institute of Management Studies','Sirajul Huda Institute of Management Studies',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT212',NULL,'Ms. Muskaan arora','Assistant Professor','Faridabad Department of management','Jb knowledge park college',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT213',NULL,'Ms. MUTHAMIL ARIVARASI THANGARAJ','Research Scholar','Faculty of Management','SRM Institute of Science and Technology',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT214',NULL,'Dr. N ANITHA','Associate Professor','Department of Commerce','Annai Women\'s College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT215',NULL,'Dr. N KAVIPRIYA','Assistant Professor',NULL,'Sri Ramachandra Institute of Higher Education and Research',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT216',NULL,'Dr. N. KUMAR','Assistant Professor','Department of Economics','C. Kandaswami Naidu College for Men (Govt Aided & Affiliated to University of Madras)',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT217',NULL,'Dr. Narayana Engineering College','Dean','MBA Department','Narayana Engineering College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT218',NULL,'Dr. NAVJOT KAUR','Assistant Professor',NULL,'University College Chunni Kalan',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT219',NULL,'Dr. NAZISH RAHAT','Assistant Professor',NULL,'Jamia Hamdard',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT220',NULL,'Dr. NDUKA TRUST OBINNA','Associate Professor','Department of Accounting','Philomath University of Nigeria',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT221',NULL,'Dr. NEENA SINHA','Professor',NULL,'USMS GGS IP University Dwarka Sector 16 C Delhi',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT222',NULL,'Dr. NEHA TYAGI','Associate Professor',NULL,'Shobhit University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT223',NULL,'Mr. Nehal shaikh','Assistant Professor',NULL,'Delhi technological university delhi school of Management',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT224',NULL,'Dr. NIDHI KHARE','Associate Professor','Institute of Management Research & Technology Management Park','Institute of Management Research & Technology Management Park',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT225',NULL,'Dr. NIDHI KHURANA','Assistant Professor','Department of Commerce','St. Aloysius\' College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT226',NULL,'Dr. NISHANT KUMAR SINGH','Associate Professor',NULL,'GNIOT INSTITUTE OF MANAGEMENT STUDIES GREATER NOIDA plot no7 knowlege park 2 greater Noida',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT227',NULL,'Dr. NITIN KISHORE SAXENA','Assistant Professor',NULL,'Nirma University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT228',NULL,'Dr. NITIN UMAKANT DWIVEDi','Head of the Department',NULL,'Shambhunath Institute of Engineering & Technology',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT229',NULL,'Dr. NIYATI PATEL','Principal',NULL,'Gyanmanjari Innovative University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT230',NULL,'Dr. NURADDEEN USMAN MIKO','Professor',NULL,'Department of Procurement and Supply Chain Management',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT231',NULL,'Dr. NVR Jyoti Kumar','Professor',NULL,'Sri Krishnadevaraya University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT232',NULL,'Dr. P. CH. PRAVEEN KUMAR','Associate Professor',NULL,'Sree Rama Engineering CollegeRami Reddy Nagar',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT233',NULL,'Dr. P R Jeyalakshmi','Assistant Professor','School of Management studies','School of Management studies',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT234',NULL,'Dr. PARVEZ MALEK','Assistant Professor',NULL,'UKA TARSADIA UNIVERSITY',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT235',NULL,'Dr. PAWAN KUMAR','Assistant Professor','Faculty of Management and Commerce','SRM University Delhi NCR Sonepat Haryana',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT236',NULL,'Dr. PINKI RANI','Associate Professor',NULL,'IGU Meerpur Rewari Haryana India',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT237',NULL,'Dr. PITESHVER RANE','Head of the Department',NULL,'Mittal Institute of Technology Bhopal',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT238',NULL,'Dr. Piyush Ranjan Sahay','Dean',NULL,'Xavier University Patna',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT239',NULL,'Ms. POOJA ARVINDBHAI PANDYA','Assistant Professor','Department of Forensic Accounting and Fraud Investigation','NSIT-IFSCS (Affiliated to NFSU)',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT240',NULL,'Ms. POOJA GOYAL','Assistant Professor','Commerce Department','DAV Centenary College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT241',NULL,'Ms. POOJA RANI','Assistant Professor',NULL,'Lonza',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT242',NULL,'Dr. Poorva Ranjan','Dean',NULL,'DMD College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT243',NULL,'Mr. PRABHAKARA S','Research Scholar',NULL,'Symbiosis School for Online and Digital Learning Symbiosis International Deemed University Pune',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT244',NULL,'Dr. Prabhakaran Jagadeesan','Associate Professor','ACHARYA BANGALORE B SCHOOL','ACHARYA BANGALORE B SCHOOL',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT245',NULL,'Dr. PRABIR CHANDRA PADHY','Dean','Faculty of Management','SRM University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT246',NULL,'Dr. PRACHI PATHAK','Associate Professor',NULL,'Doon University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT247',NULL,'Dr. PRASHANT KALSHETTI','Head of the Department','Dr D Y Patil Vidyapeeth Global Business School and Research Centre','Dr D Y Patil Vidyapeeth Global Business School and Research Centre',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT248',NULL,'Dr. PRASHANT PAREEK','Associate Professor','Shanti Business School','Shanti Business School',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT249',NULL,'Dr. Preethi Inampudi','Associate Professor','Department of Management','Surana College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT250',NULL,'Ms. PREETI SONKER','Assistant Professor','School of Business Studies','Jigyasa University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT251',NULL,'Dr. PREMENDRA SAHU','Associate Professor',NULL,'MATS University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT252',NULL,'Dr. PRIF DR PRIYA SACHDEVA','Professor',NULL,'Amity University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT253',NULL,'Mr. PRINCE','Research Scholar','Department of Financial Administration','Central University of Punjab',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT254',NULL,'Dr. PRIYADHARSHINI','Associate Professor','SAVEETHA SCHOOL OF MANAGEMENT','SAVEETHA SCHOOL OF MANAGEMENT',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT255',NULL,'Dr. R.Raghavendra Rao','Assistant Professor','Indian Institute of management and Commerce','Indian Institute of management and Commerce',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT256',NULL,'Dr. R S CH MURTHY CHODISETTY','Professor',NULL,'Vardhaman College of Engineering',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT257',NULL,'Dr. RACHNA SINGH','Associate Professor',NULL,'Professor part-time faculty Magalaytan university aligarh Uttar Pradesh',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT258',NULL,'Dr. Rahul Kumar','Assistant Professor','Indian Institute of Management Sambalpur','Indian Institute of Management Sambalpur',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT259',NULL,'Dr. Dr Raja Sekhar Koduru','Assistant Professor',NULL,'Government Polytechnic for Women Kakinada',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT260',NULL,'Mr. Rajaprabakaran K','Research Scholar','Research Scholar in Management Studies','Bharath Institute higher Education and Education',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT261',NULL,'Dr. Rajeshwari Jain','Associate Professor','Som-Lalit Institute of Management Studies','Som-Lalit Institute of Management Studies',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT262',NULL,'Dr. RAJIB DUTTA','Professor',NULL,'Bhawanipur Global Campus',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT263',NULL,'Dr. RAJJAT BHATTACHAARJEE','Assistant Professor','Nalbari Commerce College','Nalbari Commerce College',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT264',NULL,'Dr. RAJWINDER KAUR','Assistant Professor','School of Legal Studies','School of Legal Studies',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT265',NULL,'Dr. RAKESH KUMAR YADAV','Professor',NULL,'IFTM University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT266',NULL,'Mr. Ravi Kishor Ranjan','Assistant Professor','ASIAN BUSINESS SCHOOL','ASIAN BUSINESS SCHOOL',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT267',NULL,'Dr. RAVI KUMAR','Assistant Professor',NULL,'SVGC GHUMARWIN',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT268',NULL,'Dr. Ravi Rachapudy','Associate Professor','MBA','Dr.K.V.Subba Reddy School of Business Management',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT269',NULL,'Dr. Reetika Dadheech','Assistant Professor',NULL,'United World Institute of Management',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT270',NULL,'Dr. REKHA DARBAR','Assistant Professor',NULL,'Janardan Rai Nagar Rajasthan Vidyapeeth (Deemed-to-be University)',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT271',NULL,'Dr. REKHA NARANG','Professor','School of Commerce and Business Management','Geeta University',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT272',NULL,'Dr. DR RENU AGARWAL','Assistant Professor','Dpt of Business Administration','SDNB Vaishnav college for Women',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT273',NULL,'Ms. RICHA GULATI','Assistant Professor','School of Commerce and Management','Career Point University Kota',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT274',NULL,'Dr. RICHA MEHTA','Assistant Professor',NULL,'St Francis College for women',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT275',NULL,'Dr. Dr Richa Ramdev Purohit','Assistant Professor',NULL,'Jai Narayan Vyas University jodhpur',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT276',NULL,'Dr. RICHA TIWARI','Professor',NULL,'CDOE DSU',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT277',NULL,'Dr. RUCHIKA JESWAL','Associate Professor','Amity School of Business','Amity School of Business',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT278',NULL,'Mr. RUPAM KUMAR SAHA','Assistant Professor',NULL,'NSHM Knowledge Campus Durgapur',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT279',NULL,'Mrs. S.Aishwarya','Research Scholar','Management Department','SRM Institute of Science and Technology',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT280',NULL,'Mr. S Ismail Basha','Associate Professor',NULL,'Siddhartha Educational Academy Group of Institutions',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT281',NULL,'Dr. S. M. ANAS IQBAL','Director','Vishisht School of Management','Vishisht School of Management',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT282',NULL,'Dr. S PADMA','Professor','KL Business School','KL Business School',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT283',NULL,'Dr. Prof. S. S. Prasada Rao Ph.D','Professor',NULL,'SP Mandali\'s Prin. L.N. Welingkar Institute of Management Development and Research',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT284',NULL,'Dr. S. VENKATA SIVA KUMAR','Associate Professor',NULL,'Vardhaman College of Engineering',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT285',NULL,'Mr. SACHIN','Assistant Professor',NULL,'GJUST',NULL,0,'Inactive','2026-09-19 06:41:25','2026-09-28 12:06:32'),('ICMT286',NULL,'Dr. SACHIN GUPTA','Assistant Professor','Department of Business Administration','Mohanlal Sukhadia University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT287',NULL,'Dr. SAGAR ONKARRAO MANJARE','Professor',NULL,'Mahatma Gandhi University Meghalaya',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT288',NULL,'Dr. SAGAR S TANNA','Assistant Professor','Tolani Motwane Institute of Management Studies','Tolani Motwane Institute of Management Studies',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT289',NULL,'Ms. SAHAR B KAPDI','Head of the Department','Terna Global Business School','Terna Global Business School',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT290',NULL,'Dr. SAJAD AHMAD MIR','Assistant Professor',NULL,'Guru Kashi University Talwandi Sabo Bathinda',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT291',NULL,'Ms. SAKSHI MITTAL','Assistant Professor',NULL,'Inmantec Institutions',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT292',NULL,'Dr. SATULURI PADMA','Professor','Department of MBA','KL Business School',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT293',NULL,'Dr. Satya Narayan Singh','Associate Professor',NULL,'Institute of Advanced Research Gandhinagar',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT294',NULL,'Mr. SAURABH SHARMA','Research Scholar',NULL,'Guru Ghasidas Vishwavidyalaya Bilaspur Chhattisgarh',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT295',NULL,'Dr. SEEMA VARSHNEY','Assistant Professor',NULL,'Gulf College',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT296',NULL,'Dr. SHAILESH TRIPATHI','Professor',NULL,'Sri Balaji University Pune',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT297',NULL,'Dr. Shalini Singh','Associate Professor','Department of MBA','Cambridge Institute of Technology',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT298',NULL,'Dr. SHANTANU SAURABH','Assistant Professor',NULL,'DAV PG College',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT299',NULL,'Dr. SHAUNAK ROY','Assistant Professor',NULL,'St. Xavier\'s College (Autonomous)',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT300',NULL,'Dr. SHIKHA MITTAL','Associate Professor',NULL,'Raj kumar goel Institute of technology Ghaziabad',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT301',NULL,'Dr. SHILPA TANDON','Associate Professor',NULL,'AIMT',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT302',NULL,'Dr. SHINKI K PANDEY','Assistant Professor','Department of Management','Kalinga University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT303',NULL,'Dr. SHIVANI SHARMA','Assistant Professor','Prestige Institute of Management and Research Gwalior','Prestige Institute of Management and Research Gwalior',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT304',NULL,'Mr. SHREEKANTHA JAYARAMA ACHARI','Assistant Professor',NULL,'AITM',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT305',NULL,'Dr. SHRIKRISHNA DHALE','Dean',NULL,'Kalinga University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT306',NULL,'Dr. SHRIPAD KARJATKAR','Assistant Professor',NULL,'Management Bharati University pune',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT307',NULL,'Ms. SHRIYA.K','Research Scholar',NULL,'Faculty of Management Srm Institute of Science and Technology',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT308',NULL,'Mr. Shubham Singh Chandel','Assistant Professor',NULL,'Kalinga University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT309',NULL,'Ms. SIMRAN SINGH','Research Scholar',NULL,'IBM',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT310',NULL,'Mr. Sindhu P','Assistant Professor',NULL,'SRM Trichy Arts and Science College',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT311',NULL,'Dr. SIRAJ K K','Assistant Professor','Modern College of Business and Science','Modern College of Business and Science',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT312',NULL,'Mr. SIVARAMAN V S','Head of the Department','Jairam Public School','Jairam Public School',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT313',NULL,'Dr. SMITA IYER','Assistant Professor',NULL,'St.Kabir Institute of Professional Studies',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT314',NULL,'Dr. SMRITI PATHAK','Associate Professor','BCA BBA Department','PCCOER',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT315',NULL,'Dr. SONAL AGARWAL','Assistant Professor','DEPT OF MANAGEMENT STUDIES','INDIAN INSTITUTE OF INFORMATION TECHNOLOGY ALLAHABAD',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT316',NULL,'Ms. Sripriya','Assistant Professor','Ashoka school of Business','Ashoka school of Business',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT317',NULL,'Dr. SUBASH CHANDRA NATH','Professor',NULL,'FMS',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT318',NULL,'Dr. Sudha Bishnoi','Assistant Professor',NULL,'Gurmeet Singh Ghanshyam Dass Girls College',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT319',NULL,'Dr. SURENDAR GADE','Assistant Professor','SVKM\'s Narsee Monjee Institute of Management Studies (NMIMS) Deemed to be University','SVKM\'s Narsee Monjee Institute of Management Studies (NMIMS) Deemed to be University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT320',NULL,'Dr. SURENDRA BHADU','Research Scholar','Department of Business Finance and Economics Jai Narain Vyas University','Department of Business Finance and Economics Jai Narain Vyas University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT321',NULL,'Dr. Swati Khanna','Associate Professor',NULL,'IILM Institute for Higher Education',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT322',NULL,'Ms. , SWATI SHARMA','Research Scholar',NULL,NULL,NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT323',NULL,'Dr. SYED JAFFER','Assistant Professor','Accounting and finance department','GITAM University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT324',NULL,'Dr. T BHASKARA REDDY','Head of the Department','Department of Computer Science & Technology','Sri Krishnadevaraya University Anantapuram',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT325',NULL,'Dr. TANVEER AHMED','Assistant Professor',NULL,'Government Degree College Kilhotran University of jammu',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT326',NULL,'Mr. TRINKUL KALITA','Assistant Professor',NULL,'Assam down town University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT327',NULL,'Mr. Tushar Dhiman','Assistant Professor','Faculty of Management Studies','Gurukula Knagri (Deemed to be University) Haridwar',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT328',NULL,'Dr. VAIBHAV PARMANAND GALLANI','Assistant Professor',NULL,'Shri K.K. Shastri Government Commerce College/Department of Accountancy/Maninagar.',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT329',NULL,'Ms. VANSHIKA THAKUR','Research Scholar','Department of Commerce','Guru Ghasidas Vishwavidyalaya',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT330',NULL,'Mrs. Varsha Jha','Assistant Professor','Management Department','Oriental College of Technology',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT331',NULL,'Dr. Varshini S K','Assistant Professor','PG Department of Business Administration','Seshadripuram College',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT332',NULL,'Dr. VIBHA BHANDARI','Assistant Professor',NULL,'University of Technology and Applied Sciences',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT333',NULL,'Dr. Vidhi Jalan','Assistant Professor',NULL,'ALARD University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT334',NULL,'Mr. VIKHYAT PANDEY','Assistant Professor',NULL,'Prestige Institute Of Management and Research Gwalior Madhya Pradesh India',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT335',NULL,'Mr. VIKHYAT PANDEY','Assistant Professor','Prestige Institute Of Management and Research','Prestige Institute Of Management and Research',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT336',NULL,'Dr. VISHWAS GUPTA','Assistant Professor','Symbiosis Centre for Management Studies','Noida-',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT337',NULL,'Mr. Vivek Kumar Singh Jha','Assistant Professor',NULL,'Sandip University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT338',NULL,'Ms. Vriti Bhatia','Assistant Professor',NULL,'DAV institute of management.',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT339',NULL,'Dr. VYOMKESH BHATT','Assistant Professor','Uttaranchal Institute of Management','Uttaranchal Institute of Management',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT340',NULL,'Dr. Yachna Ramesh Gharde','Associate Professor','Arihant Institute of business management','Arihant Institute of business management',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT341',NULL,'Dr. Yaduvamsi Sai Krishna C','Assistant Professor','ICFAILAWSCHOOL','IFHE (Deemed to be University under sec. of the UGC Act 1956)',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT342',NULL,'Dr. YOGESH MEHTA','Professor',NULL,'SGT University',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT343',NULL,'Dr. Zertaj Fatima','Assistant Professor',NULL,'Management Department',NULL,0,'Inactive','2026-09-19 06:41:26','2026-09-28 12:06:32'),('ICMT344',NULL,'ABHAY SINGH CHAUHAN','Assistant Professor','','Narsee Monjee Centre for Distance and Online Education, Mumbai',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT345',NULL,'Dr. A. VIGNESH','Professor','Department of Business Administration SRM TRP Engineering College Tiruchirapalli','Department of Business Administration  SRM TRP Engineering College  Tiruchirapalli 621105',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT346',NULL,'AMARESH','Assistant Professor','','Sobhasaria Group of Institutions, Sikar, Raj. 332001',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT347',NULL,'Samrat ray','Professor','','Vice President',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT348',NULL,'AMANDEEP KAUR','Assistant Professor','','Khalsa university,  Amritsar',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT349',NULL,'AMARNATH PADHI','Associate Professor','School of Management Studies','School of Management Studies, NIST University, Berhampur, Odisha-761008, Ganjam',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT350',NULL,'ADARSH KUMAR','Assistant Professor','Department of Management','Institute of Technology & Management, Department of Management, Gwalior (474001)',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT351',NULL,'Aijaz Ahmad Bhat','Assistant Professor','','CT University, Management Studies, Ludhiana Punjab',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT352',NULL,'Anjaneyulu Chandupatla','Dean','Department of Business Management','Department of Business Management, Telangana University, Dichpally, Nizamabad, pin : 503001',NULL,0,'Inactive','2026-09-22 14:56:55','2026-09-28 12:06:32'),('ICMT353',NULL,'ADITYA PRATAP SINGH','Research Scholar','Department of Management Studies','Department of Management Studies, Harcourt Butler Technical University, Kanpur.',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT354',NULL,'AMIT GUPTA','Assistant Professor','','Universal AI university karjat',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT355',NULL,'AAKASH KAMBLE','Assistant Professor','Department of Marketing','FLAME University, Department of Marketing, Lavale, Pune -412115',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT356',NULL,'AKANKSHA CHOUBEY','Assistant Professor','','Alliance University, Management, Anekal, Bangalore',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT357',NULL,'AJIT KUMAR','Associate Professor','SOIL School of Business Design','SOIL School of Business Design',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT358',NULL,'ANJITA KHANDELWAL','Assistant Professor','','Jagannath university, Faculty of management studies, sitapura industrial area, Jaipur',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT359',NULL,'AMIT SINGH','Associate Professor','Commerce and Management Department','Madhav University,Commerce and Management Department,Sirohi, Rajasthan -307026',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT360',NULL,'AJAY JAIN','Assistant Professor','School of Management Studies','School of Management Studies, Rajiv Gandhi National Aviation University (RGNAU), Amethi, Uttar Pradesh, India, Pin Code -229302',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT361',NULL,'Dr. Ajit Kar','Dean','','RCM, Bhubaneswar, Odisha',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT362',NULL,'A Nagaraj Subbarao','Dean','','Dayananda Sagar University, Bengaluru',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT363',NULL,'AAYUSHI JAIN','Assistant Professor','','SRM University , 39, Rajiv Gandhi Education City, Delhi-NCR, Sonepat-131029, Haryana (India)',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT364',NULL,'KIRAN S','Assistant Professor','','BGS College of Engineering and Technology, 2nd Phase, Stage 2, Mahalakshmipuram, Bengaluru, Karnataka 560086',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT365',NULL,'Lovejit kaur','Assistant Professor','','Moddy university',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT366',NULL,'D.Sudarsana Murthy','Professor','Department of Management Studies','AMC Engineering College (Autonomous), Department of Management Studies, 18th K.M. Bannerghatta Main Road, Kalkere, Bengaluru, Karnataka - 560083',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT367',NULL,'Dr Amit Kumar','Assistant Professor','','University of Lucknow, Lucknow, 226007',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT368',NULL,'BURLAKANTI KUBERUDU','Professor','Department of Commerce &Management','Professor of Commerce &Management Studies (Rtd.), Department of Commerce &Management, Andhra University, Visakhapatnam.,',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT369',NULL,'PALLAVI SINGH','Assistant Professor','Ashoka Institute of Technology and Management (Dept of Business and Administration) Paharia','Ashoka Institute of Technology and Management (Dept of Business and Administration) Paharia ,Varanasi,221007',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT370',NULL,'ASHISH SHARMA','Professor','','ERNST & YOUNG, INVESTMENT BANKING',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT371',NULL,'Dr Asjad Usmani','Associate Professor','DBIT New Delhi - HOD Department Sukhdev Vihar New Delhi','DBIT New Delhi - HOD Department Sukhdev Vihar New Delhi 110025',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT372',NULL,'Dr Samuel Mores Geddam','Assistant Professor','Alliance School of Management and Technology','Alliance School of Management and Technology, Alliance University, Bengaluru, India',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT373',NULL,'Leena George','Associate Professor','','Freelancer - Business Communications Trainer',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT374',NULL,'NITIN S N','Assistant Professor','Department of Commerce','K.L.E Society\'s J G College of Commerce, Department of Commerce, Vidyanagar, Hubli, 580021',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT375',NULL,'POPOOLA MUFUTAU AKANMU','Professor','department of Business t','Global Humanistic University Curacao, department of Business t',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT376',NULL,'RUPESH THAKUR','Assistant Professor','Department of Commerce','Department of Commerce, Government Degree College, Nihri, District Mandi, Himachal Pradesh 175038',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT377',NULL,'VARUN KUMAR SINGH','Assistant Professor','School of Business and Commerce','School of Business and Commerce, Tulas University, Dhoolkot, Chkrata Raod, Dehradun, 248007',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT378',NULL,'ANUJ HARIKANT TIWARI','Assistant Professor','','Sanpada college of commerce and technology',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT379',NULL,'BHARTENDU SINGH','Professor','Department of Commerce','Department of Commerce, Mizoram University, Aizawl - 796 004',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT380',NULL,'VINEET SURI','Professor','School of Business Studies','School of Business Studies, Sharda University, Plot no 32-34, Knowledge Park III, Greater Noida, Uttar Pradesh-201310',NULL,0,'Inactive','2026-09-22 14:56:56','2026-09-28 12:06:32'),('ICMT381','Dr.','PAYMENT TEST MEMBER','Assistant Professor','Department of Commerce','Payment Test University','Annual Membership Faculty',0,'Inactive','2026-09-22 16:54:04','2026-09-28 12:06:32'),('ICMT382','Prof. Dr.','FINAL TESTING','Senior Professor & Dean','Advanced Quantitative Finance','Anna University Central Campus','Life Member (Faculty)',1,'Active','2026-09-27 12:01:42','2026-09-28 12:20:51'),('ICMT383','Mr.','audi shankar','finance','finance','abc','Research Scholar Member',1,'Active','2026-09-29 05:14:34','2026-09-29 05:14:34');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_applications`
--

DROP TABLE IF EXISTS `membership_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_applications` (
  `application_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `member_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `membership_category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `approval_status` enum('Pending','Approved','Rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `admin_notes` text COLLATE utf8mb4_unicode_ci,
  `reviewed_by` bigint unsigned DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`),
  KEY `idx_membership_applications_member_id` (`member_id`),
  KEY `idx_membership_applications_reviewed_by` (`reviewed_by`),
  CONSTRAINT `fk_application_reviewer` FOREIGN KEY (`reviewed_by`) REFERENCES `admin_users` (`admin_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_applications`
--

LOCK TABLES `membership_applications` WRITE;
/*!40000 ALTER TABLE `membership_applications` DISABLE KEYS */;
INSERT INTO `membership_applications` VALUES (36,'ICMT382','Life Member (Faculty)','FINAL TESTING','Approved','[Submission: sub_1790588691977_d1snq53a]',8,'2026-09-28 15:50:31','2026-09-28 09:44:52','2026-09-28 10:20:31'),(37,'ICMT382','Life Member (Faculty)','FINAL TESTING','Approved','[Payment Proof: /uploads/payment_proofs/proof_7f7590a807ce4bbc82585d4cb15f3923.jpg]',8,'2026-09-28 16:45:36','2026-09-28 11:15:36','2026-09-28 11:15:36'),(39,'ICMT382','Life Member (Faculty)','FINAL TESTING','Approved','[Payment Proof: /uploads/payment_proofs/proof_7f7590a807ce4bbc82585d4cb15f3923.jpg]',8,'2026-09-28 16:46:28','2026-09-28 11:16:27','2026-09-28 11:16:28'),(40,'ICMT383','Annual Member (Faculty)','Dr. Maya R. Krishnan','Approved',NULL,8,'2026-09-28 16:46:42','2026-09-28 11:16:40','2026-09-28 11:16:42'),(41,'ICMT382','Life Member (Faculty)','FINAL TESTING','Approved','[Payment Proof: /uploads/payment_proofs/proof_7f7590a807ce4bbc82585d4cb15f3923.jpg]',8,'2026-09-28 17:16:33','2026-09-28 11:46:32','2026-09-28 11:46:33'),(42,'ICMT384','Annual Member (Faculty)','Dr. Maya R. Krishnan','Approved',NULL,8,'2026-09-28 17:16:45','2026-09-28 11:46:43','2026-09-28 11:46:45'),(43,'ICMT383','Research Scholar Member','audi shankar','Approved','[Submission: sub_1790658212229_pt6h0egm]',8,'2026-09-29 10:44:34','2026-09-29 05:03:32','2026-09-29 05:14:34');
/*!40000 ALTER TABLE `membership_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_payments`
--

DROP TABLE IF EXISTS `membership_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_payments` (
  `payment_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `member_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `membership_category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INR',
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` enum('Pending','Paid','Failed','Refunded') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `uq_payment_transaction_id` (`transaction_id`),
  KEY `idx_payment_application_id` (`application_id`),
  KEY `idx_payment_member_id` (`member_id`),
  CONSTRAINT `fk_payment_application` FOREIGN KEY (`application_id`) REFERENCES `membership_applications` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_payments`
--

LOCK TABLES `membership_payments` WRITE;
/*!40000 ALTER TABLE `membership_payments` DISABLE KEYS */;
INSERT INTO `membership_payments` VALUES (24,36,'ICMT382','Life Member (Faculty)',5000.00,'INR','PhonePe UPI','PhonePe QR','FINALTEST123','Paid','2026-09-28 10:20:17','2026-09-28 04:15:21','2026-09-28 04:50:17'),(25,37,'ICMT382','Life Member (Faculty)',5000.00,'INR','PhonePe QR','PhonePe','UTR-ICMT382-TEST-ACTIVATE','Paid','2026-09-28 11:15:37','2026-09-28 11:15:36','2026-09-28 05:45:37'),(27,39,'ICMT382','Life Member (Faculty)',5000.00,'INR','PhonePe QR','PhonePe','UTR-ICMT382-1790594187461','Paid','2026-09-28 11:16:28','2026-09-28 11:16:27','2026-09-28 05:46:28'),(28,40,NULL,'Annual Member (Faculty)',1000.00,'INR','PhonePe QR','PhonePe','UTR-NEW-MAYA-1790594200176','Paid',NULL,'2026-09-28 11:16:40','2026-09-28 11:16:40'),(29,41,'ICMT382','Life Member (Faculty)',5000.00,'INR','PhonePe QR','PhonePe','UTR-ICMT382-1790595992524','Paid','2026-09-28 11:46:33','2026-09-28 11:46:32','2026-09-28 06:16:33'),(30,42,NULL,'Annual Member (Faculty)',1000.00,'INR','PhonePe QR','PhonePe','UTR-NEW-MAYA-1790596003833','Paid',NULL,'2026-09-28 11:46:43','2026-09-28 11:46:43'),(31,43,NULL,'Research Scholar Member',600.00,'INR','PhonePe UPI','PhonePe QR','upi@123','Paid','2026-09-29 10:44:22','2026-09-29 05:03:48','2026-09-29 05:14:22');
/*!40000 ALTER TABLE `membership_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'icmta_stage'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_member_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_add_member_image`(
    IN p_member_id VARCHAR(20),
    IN p_image_url TEXT,
    IN p_image_type VARCHAR(50),
    IN p_is_primary BOOLEAN
)
BEGIN

    DECLARE v_member_exists INT DEFAULT 0;
    DECLARE v_image_id BIGINT UNSIGNED;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    /* ==========================================
       1. Validate member ID
       ========================================== */

    IF p_member_id IS NULL OR TRIM(p_member_id) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Member ID is required';
    END IF;


    /* ==========================================
       2. Validate image URL
       ========================================== */

    IF p_image_url IS NULL OR TRIM(p_image_url) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Image URL is required';
    END IF;


    /* ==========================================
       3. Verify member exists
       ========================================== */

    SELECT COUNT(*)
    INTO v_member_exists
    FROM members
    WHERE member_id = TRIM(p_member_id);

    IF v_member_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Member does not exist';
    END IF;


    START TRANSACTION;


    /* ==========================================
       4. Remove previous primary image
       ========================================== */

    IF COALESCE(p_is_primary, FALSE) = TRUE THEN

        UPDATE member_images
        SET is_primary = FALSE
        WHERE member_id = TRIM(p_member_id)
          AND is_primary = TRUE;

    END IF;


    /* ==========================================
       5. Insert image
       ========================================== */

    INSERT INTO member_images (
        member_id,
        image_url,
        image_type,
        is_primary
    )
    VALUES (
        TRIM(p_member_id),
        TRIM(p_image_url),
        NULLIF(TRIM(p_image_type), ''),
        COALESCE(p_is_primary, FALSE)
    );


    SET v_image_id = LAST_INSERT_ID();


    COMMIT;


    /* ==========================================
       6. Return result
       ========================================== */

    SELECT
        v_image_id AS image_id,
        TRIM(p_member_id) AS member_id,
        'Image added successfully' AS message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_approve_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_approve_event`(
    IN p_event_id BIGINT UNSIGNED,
    IN p_admin_id BIGINT UNSIGNED
)
BEGIN

    DECLARE v_event_exists INT DEFAULT 0;
    DECLARE v_admin_exists INT DEFAULT 0;
    DECLARE v_current_status VARCHAR(20);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    /* ==========================================
       1. Validate event
       ========================================== */

    IF p_event_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event ID is required';
    END IF;


    SELECT COUNT(*)
    INTO v_event_exists
    FROM events
    WHERE event_id = p_event_id;

    IF v_event_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event does not exist';
    END IF;


    /* ==========================================
       2. Get current status
       ========================================== */

    SELECT status
    INTO v_current_status
    FROM events
    WHERE event_id = p_event_id
    FOR UPDATE;


    /* ==========================================
       3. Validate current status
       ========================================== */

    IF v_current_status NOT IN ('Pending', 'Rejected') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Only pending or rejected events can be approved';
    END IF;


    /* ==========================================
       4. Validate admin
       ========================================== */

    SELECT COUNT(*)
    INTO v_admin_exists
    FROM admin_users
    WHERE admin_id = p_admin_id
      AND is_active = TRUE;

    IF v_admin_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Admin user does not exist or is inactive';
    END IF;


    /* ==========================================
       5. Start transaction
       ========================================== */

    START TRANSACTION;


    /* ==========================================
       6. Approve / publish event
       ========================================== */

    UPDATE events
    SET
        status = 'Published',
        reviewed_by = p_admin_id,
        reviewed_at = CURRENT_TIMESTAMP
    WHERE event_id = p_event_id;


    /* ==========================================
       7. Commit
       ========================================== */

    COMMIT;


    /* ==========================================
       8. Return result
       ========================================== */

    SELECT
        p_event_id AS event_id,
        'Published' AS status,
        p_admin_id AS reviewed_by,
        'Event approved and published successfully' AS message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_approve_membership_application` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_approve_membership_application`(
    IN p_application_id BIGINT UNSIGNED,
    IN p_admin_id BIGINT UNSIGNED
)
BEGIN

    DECLARE v_member_id VARCHAR(20);
    DECLARE v_new_member_id VARCHAR(20);

    DECLARE v_membership_category VARCHAR(100);
    DECLARE v_full_name VARCHAR(200);
    DECLARE v_approval_status VARCHAR(20);

    DECLARE v_admin_exists INT DEFAULT 0;
    DECLARE v_paid_payment_exists INT DEFAULT 0;
    DECLARE v_application_exists INT DEFAULT 0;

    DECLARE v_max_member_number INT DEFAULT 0;
    DECLARE v_rows INT DEFAULT 0;

    /* ------------------------------------------
       Roll back everything if any SQL error occurs
       ------------------------------------------ */
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    /* ==========================================
       1. Verify application
       ========================================== */

    SELECT COUNT(*)
    INTO v_application_exists
    FROM membership_applications
    WHERE application_id = p_application_id;

    IF v_application_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Membership application does not exist';
    END IF;


    /* ==========================================
       2. Get application details
       ========================================== */

    SELECT
        member_id,
        membership_category,
        full_name,
        approval_status
    INTO
        v_member_id,
        v_membership_category,
        v_full_name,
        v_approval_status
    FROM membership_applications
    WHERE application_id = p_application_id
    FOR UPDATE;


    /* ==========================================
       3. Application must be Pending
       ========================================== */

    IF v_approval_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Only pending applications can be approved';
    END IF;


    /* ==========================================
       4. Verify admin
       ========================================== */

    SELECT COUNT(*)
    INTO v_admin_exists
    FROM admin_users
    WHERE admin_id = p_admin_id
      AND is_active = TRUE;

    IF v_admin_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Admin user does not exist or is inactive';
    END IF;


    /* ==========================================
       5. Verify paid payment
       ========================================== */

    SELECT COUNT(*)
    INTO v_paid_payment_exists
    FROM membership_payments
    WHERE application_id = p_application_id
      AND payment_status = 'Paid';

    IF v_paid_payment_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Application cannot be approved because payment is not marked as Paid';
    END IF;


    /* ==========================================
       6. Start transaction
       ========================================== */

    START TRANSACTION;


    /* ==========================================
       7. Generate new member ID if required
       ========================================== */

    IF v_member_id IS NULL OR TRIM(v_member_id) = '' THEN

        /*
          Find the highest numeric portion of existing
          ICMT member IDs.

          Example:
          ICMT001 → 1
          ICMT381 → 381
        */

        SELECT COALESCE(
            MAX(
                CAST(
                    SUBSTRING(member_id, 5)
                    AS UNSIGNED
                )
            ),
            0
        )
        INTO v_max_member_number
        FROM members
        WHERE member_id REGEXP '^ICMT[0-9]+$';


        SET v_max_member_number = v_max_member_number + 1;


        SET v_new_member_id =
            CONCAT(
                'ICMT',
                LPAD(v_max_member_number, 3, '0')
            );


        /* Safety check */
        IF EXISTS (
            SELECT 1
            FROM members
            WHERE member_id = v_new_member_id
        ) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT =
                'Generated member ID already exists';
        END IF;


        SET v_member_id = v_new_member_id;

    ELSE

        /* Existing member ID must exist */

        IF NOT EXISTS (
            SELECT 1
            FROM members
            WHERE member_id = TRIM(v_member_id)
        ) THEN

            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT =
                'Existing member ID was provided but member does not exist';

        END IF;

        SET v_member_id = TRIM(v_member_id);

    END IF;


    /* ==========================================
       8. Get applicant information
       ========================================== */

    /*
      We use the application tables as the source
      for creating/updating the member.
    */


    /* ==========================================
       9. Create or update main member
       ========================================== */

    IF NOT EXISTS (
        SELECT 1
        FROM members
        WHERE member_id = v_member_id
    ) THEN

        INSERT INTO members (
            member_id,
            academic_title,
            name,
            designation,
            department,
            institution,
            membership_category,
            is_active,
            my_status
        )
        SELECT
            v_member_id,
            ai.academic_title,
            v_full_name,
            ai.designation,
            ai.department,
            ai.institution,
            v_membership_category,
            TRUE,
            'Active'
        FROM application_applicant_info ai
        WHERE ai.application_id = p_application_id;

    ELSE

        UPDATE members m
        JOIN application_applicant_info ai
            ON ai.application_id = p_application_id
        SET
            m.academic_title = COALESCE(NULLIF(TRIM(ai.academic_title), ''), m.academic_title),
            m.name = COALESCE(NULLIF(TRIM(v_full_name), ''), m.name),
            m.designation = COALESCE(NULLIF(TRIM(ai.designation), ''), m.designation),
            m.department = COALESCE(NULLIF(TRIM(ai.department), ''), m.department),
            m.institution = COALESCE(NULLIF(TRIM(ai.institution), ''), m.institution),
            m.membership_category = COALESCE(NULLIF(TRIM(v_membership_category), ''), m.membership_category),
            m.is_active = TRUE,
            m.my_status = 'Active'
        WHERE m.member_id = v_member_id;

    END IF;


    SET v_rows = ROW_COUNT();


    /* ==========================================
       10. Create/update contact information
       ========================================== */

    INSERT INTO member_contact_info (
        member_id,
        mobile,
        whatsapp,
        whatsapp_secondary,
        professional_email,
        personal_email,
        address,
        city,
        state_province,
        pin_code,
        country
    )
    SELECT
        v_member_id,
        ac.mobile,
        ac.whatsapp,
        ac.whatsapp_secondary,
        ac.professional_email,
        ac.personal_email,
        ai.college_address,
        NULL,
        ai.state_province,
        ai.pin_code,
        ai.country
    FROM application_contact_info ac
    JOIN application_applicant_info ai
        ON ai.application_id = ac.application_id
    WHERE ac.application_id = p_application_id
    ON DUPLICATE KEY UPDATE
        mobile = COALESCE(NULLIF(TRIM(VALUES(mobile)), ''), member_contact_info.mobile),
        whatsapp = COALESCE(NULLIF(TRIM(VALUES(whatsapp)), ''), member_contact_info.whatsapp),
        whatsapp_secondary = COALESCE(NULLIF(TRIM(VALUES(whatsapp_secondary)), ''), member_contact_info.whatsapp_secondary),
        professional_email = COALESCE(NULLIF(TRIM(VALUES(professional_email)), ''), member_contact_info.professional_email),
        personal_email = COALESCE(NULLIF(TRIM(VALUES(personal_email)), ''), member_contact_info.personal_email),
        address = COALESCE(NULLIF(TRIM(VALUES(address)), ''), member_contact_info.address),
        state_province = COALESCE(NULLIF(TRIM(VALUES(state_province)), ''), member_contact_info.state_province),
        pin_code = COALESCE(NULLIF(TRIM(VALUES(pin_code)), ''), member_contact_info.pin_code),
        country = COALESCE(NULLIF(TRIM(VALUES(country)), ''), member_contact_info.country);


    /* ==========================================
       11. Create/update academic profile
       ========================================== */

    INSERT INTO member_academic_profile (
        member_id,
        date_of_birth,
        qualification,
        research_guideship,
        expertise,
        linkedin,
        orcid,
        google_scholar,
        photo_url,
        source_record
    )
    SELECT
        v_member_id,
        ai.date_of_birth,
        ai.highest_qualification,
        ac.research_guideship,
        ac.expertise,
        ac.linkedin,
        ac.orcid,
        ac.google_scholar,
        ac.photo_url,
        NULL
    FROM application_applicant_info ai
    JOIN application_contact_info ac
        ON ac.application_id = ai.application_id
    WHERE ai.application_id = p_application_id
    ON DUPLICATE KEY UPDATE
        date_of_birth = COALESCE(VALUES(date_of_birth), member_academic_profile.date_of_birth),
        qualification = COALESCE(NULLIF(TRIM(VALUES(qualification)), ''), member_academic_profile.qualification),
        research_guideship = COALESCE(NULLIF(TRIM(VALUES(research_guideship)), ''), member_academic_profile.research_guideship),
        expertise = COALESCE(NULLIF(TRIM(VALUES(expertise)), ''), member_academic_profile.expertise),
        linkedin = COALESCE(NULLIF(TRIM(VALUES(linkedin)), ''), member_academic_profile.linkedin),
        orcid = COALESCE(NULLIF(TRIM(VALUES(orcid)), ''), member_academic_profile.orcid),
        google_scholar = COALESCE(NULLIF(TRIM(VALUES(google_scholar)), ''), member_academic_profile.google_scholar),
        photo_url = COALESCE(NULLIF(TRIM(VALUES(photo_url)), ''), member_academic_profile.photo_url);


    /* ==========================================
       12. Update application
       ========================================== */

    UPDATE membership_applications
    SET
        member_id = v_member_id,
        approval_status = 'Approved',
        reviewed_by = p_admin_id,
        reviewed_at = CURRENT_TIMESTAMP
    WHERE application_id = p_application_id;


    /* ==========================================
       13. Commit everything
       ========================================== */

    COMMIT;


    /* ==========================================
       14. Return result
       ========================================== */

    SELECT
        p_application_id AS application_id,
        v_member_id AS member_id,
        'Approved' AS approval_status,
        'Membership application approved successfully' AS message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_admin_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_create_admin_user`(
    IN p_user_id VARCHAR(100),
    IN p_password_hash VARCHAR(255),
    IN p_is_active BOOLEAN
)
BEGIN

    -- Validate user ID
    IF p_user_id IS NULL OR TRIM(p_user_id) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'User ID is required';
    END IF;

    -- Validate password hash
    IF p_password_hash IS NULL OR TRIM(p_password_hash) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Password hash is required';
    END IF;

    -- Check duplicate user ID
    IF EXISTS (
        SELECT 1
        FROM admin_users
        WHERE user_id = TRIM(p_user_id)
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Admin user ID already exists';
    END IF;

    -- Insert admin
    INSERT INTO admin_users (
        user_id,
        password_hash,
        is_active
    )
    VALUES (
        TRIM(p_user_id),
        p_password_hash,
        COALESCE(p_is_active, TRUE)
    );

    -- Return created admin ID
    SELECT
        LAST_INSERT_ID() AS admin_id,
        TRIM(p_user_id) AS user_id,
        COALESCE(p_is_active, TRUE) AS is_active;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_create_event`(

    -- Main event
    IN p_event_title VARCHAR(255),
    IN p_event_category VARCHAR(100),
    IN p_event_date DATE,
    IN p_registration_deadline DATE,
    IN p_start_time TIME,
    IN p_end_time TIME,
    IN p_event_mode VARCHAR(50),

    -- Event details
    IN p_short_description TEXT,
    IN p_full_description LONGTEXT,
    IN p_poster_url TEXT,
    IN p_organized_by VARCHAR(255),
    IN p_in_association_with VARCHAR(255),
    IN p_registration_fee DECIMAL(10,2),
    IN p_registration_link TEXT,

    -- Event contact
    IN p_speaker_name VARCHAR(200),
    IN p_speaker_designation VARCHAR(150),
    IN p_speaker_institution VARCHAR(255),
    IN p_coordinator_name VARCHAR(200),
    IN p_contact_number VARCHAR(40),
    IN p_contact_email VARCHAR(255),

    -- Admin
    IN p_admin_id BIGINT UNSIGNED

)
BEGIN

    DECLARE v_event_id BIGINT UNSIGNED;
    DECLARE v_admin_exists INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    /* ==========================================
       1. Validate title
       ========================================== */

    IF p_event_title IS NULL OR TRIM(p_event_title) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event title is required';
    END IF;


    /* ==========================================
       2. Validate event date
       ========================================== */

    IF p_event_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event date is required';
    END IF;


    /* ==========================================
       3. Validate time range
       ========================================== */

    IF p_start_time IS NOT NULL
       AND p_end_time IS NOT NULL
       AND p_end_time <= p_start_time THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Event end time must be later than start time';

    END IF;


    /* ==========================================
       4. Validate registration deadline
       ========================================== */

    IF p_registration_deadline IS NOT NULL
       AND p_registration_deadline > p_event_date THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Registration deadline cannot be after event date';

    END IF;


    /* ==========================================
       5. Validate registration fee
       ========================================== */

    IF p_registration_fee IS NOT NULL
       AND p_registration_fee < 0 THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Registration fee cannot be negative';

    END IF;


    /* ==========================================
       6. Validate admin
       ========================================== */

    SELECT COUNT(*)
    INTO v_admin_exists
    FROM admin_users
    WHERE admin_id = p_admin_id
      AND is_active = TRUE;

    IF v_admin_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Admin user does not exist or is inactive';
    END IF;


    START TRANSACTION;


    /* ==========================================
       7. Create main event
       ========================================== */

    INSERT INTO events (
        event_title,
        event_category,
        event_date,
        registration_deadline,
        start_time,
        end_time,
        event_mode,
        status,
        reviewed_by,
        reviewed_at
    )
    VALUES (
        TRIM(p_event_title),
        NULLIF(TRIM(p_event_category), ''),
        p_event_date,
        p_registration_deadline,
        p_start_time,
        p_end_time,
        NULLIF(TRIM(p_event_mode), ''),
        'Pending',
        NULL,
        NULL
    );


    SET v_event_id = LAST_INSERT_ID();


    /* ==========================================
       8. Create event details
       ========================================== */

    INSERT INTO event_details (
        event_id,
        short_description,
        full_description,
        poster_url,
        organized_by,
        in_association_with,
        registration_fee,
        registration_link,
        rejection_reason
    )
    VALUES (
        v_event_id,
        p_short_description,
        p_full_description,
        p_poster_url,
        NULLIF(TRIM(p_organized_by), ''),
        NULLIF(TRIM(p_in_association_with), ''),
        p_registration_fee,
        p_registration_link,
        NULL
    );


    /* ==========================================
       9. Create event contact
       ========================================== */

    INSERT INTO event_contacts (
        event_id,
        speaker_name,
        speaker_designation,
        speaker_institution,
        coordinator_name,
        contact_number,
        contact_email
    )
    VALUES (
        v_event_id,
        p_speaker_name,
        p_speaker_designation,
        p_speaker_institution,
        p_coordinator_name,
        p_contact_number,
        p_contact_email
    );


    COMMIT;


    /* ==========================================
       10. Return created event
       ========================================== */

    SELECT
        v_event_id AS event_id,
        'Pending' AS status,
        'Event created successfully and is awaiting approval' AS message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_membership_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_create_membership_payment`(
    IN p_application_id BIGINT UNSIGNED,
    IN p_member_id VARCHAR(20),
    IN p_membership_category VARCHAR(100),
    IN p_amount DECIMAL(10,2),
    IN p_currency CHAR(3),
    IN p_payment_method VARCHAR(50),
    IN p_payment_gateway VARCHAR(100),
    IN p_transaction_id VARCHAR(255)
)
BEGIN

    DECLARE v_payment_id BIGINT UNSIGNED;

    DECLARE v_application_exists INT DEFAULT 0;
    DECLARE v_application_status VARCHAR(20);
    DECLARE v_application_category VARCHAR(100);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    /* ==========================================
       1. Validate application
       ========================================== */

    SELECT COUNT(*)
    INTO v_application_exists
    FROM membership_applications
    WHERE application_id = p_application_id;


    IF v_application_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Membership application does not exist';
    END IF;


    /* ==========================================
       2. Get application details
       ========================================== */

    SELECT
        approval_status,
        membership_category
    INTO
        v_application_status,
        v_application_category
    FROM membership_applications
    WHERE application_id = p_application_id;


    /* ==========================================
       3. Payment must be for a pending application
       ========================================== */

    IF v_application_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Payment can only be created for a pending application';
    END IF;


    /* ==========================================
       4. Validate membership category
       ========================================== */

    IF p_membership_category IS NULL
       OR TRIM(p_membership_category) = '' THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Membership category is required';

    END IF;


    IF TRIM(p_membership_category) <> TRIM(v_application_category) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Payment membership category does not match application category';
    END IF;


    /* ==========================================
       5. Validate amount
       ========================================== */

    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Payment amount must be greater than zero';
    END IF;


    /* ==========================================
       6. Validate currency
       ========================================== */

    IF p_currency IS NULL
       OR UPPER(TRIM(p_currency)) <> 'INR' THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Only INR currency is supported';
    END IF;


    /* ==========================================
       7. Validate member ID if supplied
       ========================================== */

    IF p_member_id IS NOT NULL
       AND TRIM(p_member_id) <> '' THEN

        IF NOT EXISTS (
            SELECT 1
            FROM members
            WHERE member_id = TRIM(p_member_id)
        ) THEN

            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT =
                'Provided member ID does not exist';

        END IF;

    END IF;


    /* ==========================================
       8. Prevent duplicate transaction ID
       ========================================== */

    IF p_transaction_id IS NOT NULL
       AND TRIM(p_transaction_id) <> '' THEN

        IF EXISTS (
            SELECT 1
            FROM membership_payments
            WHERE transaction_id = TRIM(p_transaction_id)
        ) THEN

            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT =
                'Transaction ID already exists';

        END IF;

    END IF;


    /* ==========================================
       9. Start transaction
       ========================================== */

    START TRANSACTION;


    /* ==========================================
       10. Create payment
       ========================================== */

    INSERT INTO membership_payments (
        application_id,
        member_id,
        membership_category,
        amount,
        currency,
        payment_method,
        payment_gateway,
        transaction_id,
        payment_status
    )
    VALUES (
        p_application_id,
        NULLIF(TRIM(p_member_id), ''),
        TRIM(p_membership_category),
        p_amount,
        UPPER(TRIM(p_currency)),
        NULLIF(TRIM(p_payment_method), ''),
        NULLIF(TRIM(p_payment_gateway), ''),
        NULLIF(TRIM(p_transaction_id), ''),
        'Pending'
    );


    SET v_payment_id = LAST_INSERT_ID();


    /* ==========================================
       11. Commit
       ========================================== */

    COMMIT;


    /* ==========================================
       12. Return result
       ========================================== */

    SELECT
        v_payment_id AS payment_id,
        p_application_id AS application_id,
        'Pending' AS payment_status,
        'Payment record created successfully' AS message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mark_membership_payment_paid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_mark_membership_payment_paid`(
    IN p_payment_id BIGINT UNSIGNED
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM membership_payments
        WHERE payment_id = p_payment_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment does not exist';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM membership_payments
        WHERE payment_id = p_payment_id
          AND payment_status = 'Paid'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment is already marked as Paid';
    END IF;

    UPDATE membership_payments
    SET
        payment_status = 'Paid',
        paid_at = CURRENT_TIMESTAMP,
        updated_at = CURRENT_TIMESTAMP
    WHERE payment_id = p_payment_id;

    SELECT
        payment_id,
        application_id,
        payment_status,
        paid_at
    FROM membership_payments
    WHERE payment_id = p_payment_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_submit_membership_application` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_submit_membership_application`(

    -- Main application
    IN p_member_id VARCHAR(20),
    IN p_membership_category VARCHAR(100),
    IN p_full_name VARCHAR(200),

    -- Applicant information
    IN p_academic_title VARCHAR(30),
    IN p_date_of_birth DATE,
    IN p_highest_qualification TEXT,
    IN p_designation VARCHAR(150),
    IN p_department VARCHAR(200),
    IN p_institution TEXT,
    IN p_college_address TEXT,
    IN p_pin_code VARCHAR(20),
    IN p_state_province VARCHAR(100),
    IN p_country VARCHAR(100),

    -- Contact / professional information
    IN p_personal_email VARCHAR(255),
    IN p_professional_email VARCHAR(255),
    IN p_mobile VARCHAR(40),
    IN p_whatsapp VARCHAR(40),
    IN p_whatsapp_secondary VARCHAR(40),
    IN p_photo_url TEXT,
    IN p_google_scholar TEXT,
    IN p_linkedin TEXT,
    IN p_orcid VARCHAR(120),
    IN p_expertise TEXT,
    IN p_research_guideship TEXT

)
BEGIN

    DECLARE v_application_id BIGINT UNSIGNED;

    -- If anything fails, rollback the complete application
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    /* ==========================================
       1. Validate required fields
       ========================================== */

    IF p_membership_category IS NULL
       OR TRIM(p_membership_category) = '' THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Membership category is required';

    END IF;


    IF p_full_name IS NULL
       OR TRIM(p_full_name) = '' THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Full name is required';

    END IF;


    /* ==========================================
       2. Validate member_id if supplied
       ========================================== */

    IF p_member_id IS NOT NULL
       AND TRIM(p_member_id) <> '' THEN

        IF NOT EXISTS (
            SELECT 1
            FROM members
            WHERE member_id = TRIM(p_member_id)
        ) THEN

            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Provided member ID does not exist';

        END IF;

    END IF;


    /* ==========================================
       3. Start transaction
       ========================================== */

    START TRANSACTION;


    /* ==========================================
       4. Create main application record
       ========================================== */

    INSERT INTO membership_applications (
        member_id,
        membership_category,
        full_name,
        approval_status
    )
    VALUES (
        NULLIF(TRIM(p_member_id), ''),
        TRIM(p_membership_category),
        TRIM(p_full_name),
        'Pending'
    );


    SET v_application_id = LAST_INSERT_ID();


    /* ==========================================
       5. Insert applicant information
       ========================================== */

    INSERT INTO application_applicant_info (
        application_id,
        academic_title,
        date_of_birth,
        highest_qualification,
        designation,
        department,
        institution,
        college_address,
        pin_code,
        state_province,
        country
    )
    VALUES (
        v_application_id,
        NULLIF(TRIM(p_academic_title), ''),
        p_date_of_birth,
        p_highest_qualification,
        p_designation,
        p_department,
        p_institution,
        p_college_address,
        p_pin_code,
        p_state_province,
        p_country
    );


    /* ==========================================
       6. Insert contact information
       ========================================== */

    INSERT INTO application_contact_info (
        application_id,
        personal_email,
        professional_email,
        mobile,
        whatsapp,
        whatsapp_secondary,
        photo_url,
        google_scholar,
        linkedin,
        orcid,
        expertise,
        research_guideship
    )
    VALUES (
        v_application_id,
        p_personal_email,
        p_professional_email,
        p_mobile,
        p_whatsapp,
        p_whatsapp_secondary,
        p_photo_url,
        p_google_scholar,
        p_linkedin,
        p_orcid,
        p_expertise,
        p_research_guideship
    );


    /* ==========================================
       7. Commit complete application
       ========================================== */

    COMMIT;


    /* ==========================================
       8. Return result
       ========================================== */

    SELECT
        v_application_id AS application_id,
        'Pending' AS approval_status,
        'Application submitted successfully' AS message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_update_event`(

    IN p_event_id BIGINT UNSIGNED,

    -- Main event
    IN p_event_title VARCHAR(255),
    IN p_event_category VARCHAR(100),
    IN p_event_date DATE,
    IN p_registration_deadline DATE,
    IN p_start_time TIME,
    IN p_end_time TIME,
    IN p_event_mode VARCHAR(50),
    IN p_status VARCHAR(20),

    -- Event details
    IN p_short_description TEXT,
    IN p_full_description LONGTEXT,
    IN p_poster_url TEXT,
    IN p_organized_by VARCHAR(255),
    IN p_in_association_with VARCHAR(255),
    IN p_registration_fee DECIMAL(10,2),
    IN p_registration_link TEXT,

    -- Event contact
    IN p_speaker_name VARCHAR(200),
    IN p_speaker_designation VARCHAR(150),
    IN p_speaker_institution VARCHAR(255),
    IN p_coordinator_name VARCHAR(200),
    IN p_contact_number VARCHAR(40),
    IN p_contact_email VARCHAR(255)

)
BEGIN

    DECLARE v_event_exists INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    /* ==========================================
       1. Validate event ID
       ========================================== */

    IF p_event_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event ID is required';
    END IF;


    /* ==========================================
       2. Verify event exists
       ========================================== */

    SELECT COUNT(*)
    INTO v_event_exists
    FROM events
    WHERE event_id = p_event_id;

    IF v_event_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event does not exist';
    END IF;


    /* ==========================================
       3. Validate title
       ========================================== */

    IF p_event_title IS NULL
       OR TRIM(p_event_title) = '' THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event title is required';

    END IF;


    /* ==========================================
       4. Validate event date
       ========================================== */

    IF p_event_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Event date is required';
    END IF;


    /* ==========================================
       5. Validate time range
       ========================================== */

    IF p_start_time IS NOT NULL
       AND p_end_time IS NOT NULL
       AND p_end_time <= p_start_time THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Event end time must be later than start time';

    END IF;


    /* ==========================================
       6. Validate registration deadline
       ========================================== */

    IF p_registration_deadline IS NOT NULL
       AND p_registration_deadline > p_event_date THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Registration deadline cannot be after event date';

    END IF;


    /* ==========================================
       7. Validate registration fee
       ========================================== */

    IF p_registration_fee IS NOT NULL
       AND p_registration_fee < 0 THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Registration fee cannot be negative';

    END IF;


    /* ==========================================
       8. Validate status
       ========================================== */

    IF p_status IS NOT NULL
       AND p_status NOT IN (
           'Pending',
           'Approved',
           'Rejected',
           'Published',
           'Completed',
           'Cancelled'
       ) THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Invalid event status';

    END IF;


    START TRANSACTION;


    /* ==========================================
       9. Update main event
       ========================================== */

    UPDATE events
    SET
        event_title = TRIM(p_event_title),
        event_category = NULLIF(TRIM(p_event_category), ''),
        event_date = p_event_date,
        registration_deadline = p_registration_deadline,
        start_time = p_start_time,
        end_time = p_end_time,
        event_mode = NULLIF(TRIM(p_event_mode), ''),
        status = COALESCE(p_status, status)
    WHERE event_id = p_event_id;


    /* ==========================================
       10. Update event details
       ========================================== */

    INSERT INTO event_details (
        event_id,
        short_description,
        full_description,
        poster_url,
        organized_by,
        in_association_with,
        registration_fee,
        registration_link,
        rejection_reason
    )
    VALUES (
        p_event_id,
        p_short_description,
        p_full_description,
        p_poster_url,
        NULLIF(TRIM(p_organized_by), ''),
        NULLIF(TRIM(p_in_association_with), ''),
        p_registration_fee,
        p_registration_link,
        NULL
    )
    ON DUPLICATE KEY UPDATE
        short_description = VALUES(short_description),
        full_description = VALUES(full_description),
        poster_url = VALUES(poster_url),
        organized_by = VALUES(organized_by),
        in_association_with = VALUES(in_association_with),
        registration_fee = VALUES(registration_fee),
        registration_link = VALUES(registration_link);


    /* ==========================================
       11. Update event contacts
       ========================================== */

    INSERT INTO event_contacts (
        event_id,
        speaker_name,
        speaker_designation,
        speaker_institution,
        coordinator_name,
        contact_number,
        contact_email
    )
    VALUES (
        p_event_id,
        p_speaker_name,
        p_speaker_designation,
        p_speaker_institution,
        p_coordinator_name,
        p_contact_number,
        p_contact_email
    )
    ON DUPLICATE KEY UPDATE
        speaker_name = VALUES(speaker_name),
        speaker_designation = VALUES(speaker_designation),
        speaker_institution = VALUES(speaker_institution),
        coordinator_name = VALUES(coordinator_name),
        contact_number = VALUES(contact_number),
        contact_email = VALUES(contact_email);


    COMMIT;


    /* ==========================================
       12. Return result
       ========================================== */

    SELECT
        p_event_id AS event_id,
        'Event updated successfully' AS message;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_member` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_update_member`(
    IN p_member_id VARCHAR(20),

    -- Main member information
    IN p_academic_title VARCHAR(30),
    IN p_name VARCHAR(200),
    IN p_designation VARCHAR(150),
    IN p_department VARCHAR(200),
    IN p_institution TEXT,
    IN p_membership_category VARCHAR(100),
    IN p_is_active BOOLEAN,
    IN p_my_status VARCHAR(20),

    -- Contact information
    IN p_mobile VARCHAR(40),
    IN p_whatsapp VARCHAR(40),
    IN p_whatsapp_secondary VARCHAR(40),
    IN p_professional_email VARCHAR(255),
    IN p_personal_email VARCHAR(255),
    IN p_address TEXT,
    IN p_city VARCHAR(100),
    IN p_state_province VARCHAR(100),
    IN p_pin_code VARCHAR(20),
    IN p_country VARCHAR(100),

    -- Academic information
    IN p_date_of_birth DATE,
    IN p_qualification TEXT,
    IN p_research_guideship TEXT,
    IN p_expertise TEXT,
    IN p_linkedin TEXT,
    IN p_orcid VARCHAR(120),
    IN p_google_scholar TEXT,
    IN p_photo_url TEXT,
    IN p_source_record TEXT
)
BEGIN

    DECLARE v_member_exists INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;


    /* ==========================================
       1. Validate member ID
       ========================================== */

    IF p_member_id IS NULL OR TRIM(p_member_id) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Member ID is required';
    END IF;


    /* ==========================================
       2. Check member exists
       ========================================== */

    SELECT COUNT(*)
    INTO v_member_exists
    FROM members
    WHERE member_id = TRIM(p_member_id);

    IF v_member_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Member does not exist';
    END IF;


    /* ==========================================
       3. Validate required name
       ========================================== */

    IF p_name IS NULL OR TRIM(p_name) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Member name is required';
    END IF;


    /* ==========================================
       4. Validate status
       ========================================== */

    IF p_my_status IS NOT NULL
       AND p_my_status NOT IN ('Active','Inactive','Pending') THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid member status';

    END IF;


    START TRANSACTION;


    /* ==========================================
       5. Update main member
       ========================================== */

    UPDATE members
    SET
        academic_title = p_academic_title,
        name = TRIM(p_name),
        designation = p_designation,
        department = p_department,
        institution = p_institution,
        membership_category = p_membership_category,
        is_active = COALESCE(p_is_active, is_active),
        my_status = COALESCE(p_my_status, my_status)
    WHERE member_id = TRIM(p_member_id);


    /* ==========================================
       6. Update contact information
       ========================================== */

    INSERT INTO member_contact_info (
        member_id,
        mobile,
        whatsapp,
        whatsapp_secondary,
        professional_email,
        personal_email,
        address,
        city,
        state_province,
        pin_code,
        country
    )
    VALUES (
        TRIM(p_member_id),
        p_mobile,
        p_whatsapp,
        p_whatsapp_secondary,
        p_professional_email,
        p_personal_email,
        p_address,
        p_city,
        p_state_province,
        p_pin_code,
        p_country
    )
    ON DUPLICATE KEY UPDATE
        mobile = VALUES(mobile),
        whatsapp = VALUES(whatsapp),
        whatsapp_secondary = VALUES(whatsapp_secondary),
        professional_email = VALUES(professional_email),
        personal_email = VALUES(personal_email),
        address = VALUES(address),
        city = VALUES(city),
        state_province = VALUES(state_province),
        pin_code = VALUES(pin_code),
        country = VALUES(country);


    /* ==========================================
       7. Update academic profile
       ========================================== */

    INSERT INTO member_academic_profile (
        member_id,
        date_of_birth,
        qualification,
        research_guideship,
        expertise,
        linkedin,
        orcid,
        google_scholar,
        photo_url,
        source_record
    )
    VALUES (
        TRIM(p_member_id),
        p_date_of_birth,
        p_qualification,
        p_research_guideship,
        p_expertise,
        p_linkedin,
        p_orcid,
        p_google_scholar,
        p_photo_url,
        p_source_record
    )
    ON DUPLICATE KEY UPDATE
        date_of_birth = VALUES(date_of_birth),
        qualification = VALUES(qualification),
        research_guideship = VALUES(research_guideship),
        expertise = VALUES(expertise),
        linkedin = VALUES(linkedin),
        orcid = VALUES(orcid),
        google_scholar = VALUES(google_scholar),
        photo_url = VALUES(photo_url),
        source_record = VALUES(source_record);


    COMMIT;


    /* ==========================================
       8. Return updated member
       ========================================== */

    SELECT
        TRIM(p_member_id) AS member_id,
        'Member updated successfully' AS message;

END ;;
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

-- Dump completed on 2026-09-29 11:42:13
