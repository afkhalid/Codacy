-- MySQL dump 10.13  Distrib 5.7.25, for Win64 (x86_64)
--
-- Host: dev-writer-db.internal.qbdvision.com    Database: client_devryan_RocketsRUS
-- ------------------------------------------------------
-- Server version	5.7.12
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
-- Table structure for table `AttachmentAudits`
--
DROP TABLE IF EXISTS `AttachmentAudits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AttachmentAudits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `S3TmpKey` varchar(255) DEFAULT NULL,
  `S3TmpVersion` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `linkVersion` varchar(255) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `AttachmentAudits`
--
LOCK TABLES `AttachmentAudits` WRITE;
/*!40000 ALTER TABLE `AttachmentAudits` DISABLE KEYS */;
/*!40000 ALTER TABLE `AttachmentAudits` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `ControlMethodApprovalReqToUsers`
--
DROP TABLE IF EXISTS `ControlMethodApprovalReqToUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlMethodApprovalReqToUsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controlMethodApprovalRequestId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `controlMethodApprovalRequestId` (`controlMethodApprovalRequestId`),
  CONSTRAINT `ControlMethodApprovalReqToUsers_ibfk_1` FOREIGN KEY (`controlMethodApprovalRequestId`) REFERENCES `ControlMethodApprovalRequests` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `ControlMethodApprovalReqToUsers`
--
LOCK TABLES `ControlMethodApprovalReqToUsers` WRITE;
/*!40000 ALTER TABLE `ControlMethodApprovalReqToUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlMethodApprovalReqToUsers` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `ControlMethodApprovalRequests`
--
DROP TABLE IF EXISTS `ControlMethodApprovalRequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlMethodApprovalRequests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controlMethodVersionTransitionId` int(11) DEFAULT NULL,
  `controlMethodVersionId` int(11) DEFAULT NULL,
  `controlMethodId` int(11) DEFAULT NULL,
  `ipAddress` varchar(255) DEFAULT NULL,
  `action` enum('archive','restore','') DEFAULT NULL,
  `url` text,
  `comment` text,
  `withdrawn` tinyint(1) DEFAULT NULL,
  `withdrawalComment` text,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `approveByDate` text,
  PRIMARY KEY (`id`),
  KEY `controlMethodId` (`controlMethodId`),
  KEY `controlMethodVersionId` (`controlMethodVersionId`),
  KEY `ControlMethodAppReq_controlMethodVerTranId_idx` (`controlMethodVersionTransitionId`),
  CONSTRAINT `ControlMethodAppReq_controlMethodVerTranId_idfk` FOREIGN KEY (`controlMethodVersionTransitionId`) REFERENCES `ControlMethodVersionTransitions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodApprovalRequests_ibfk_1` FOREIGN KEY (`controlMethodId`) REFERENCES `ControlMethods` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodApprovalRequests_ibfk_2` FOREIGN KEY (`controlMethodVersionId`) REFERENCES `ControlMethodVersions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `ControlMethodApprovalRequests`
--
LOCK TABLES `ControlMethodApprovalRequests` WRITE;
/*!40000 ALTER TABLE `ControlMethodApprovalRequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlMethodApprovalRequests` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `ControlMethodApprovalResponseHistories`
--
DROP TABLE IF EXISTS `ControlMethodApprovalResponseHistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlMethodApprovalResponseHistories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controlMethodVersionTransitionId` int(11) DEFAULT NULL,
  `controlMethodApprovalResponseId` int(11) DEFAULT NULL,
  `ipAddress` varchar(255) DEFAULT NULL,
  `comment` text,
  `url` varchar(255) DEFAULT NULL,
  `approve` tinyint(1) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ControlMethodAppResHistories_controlMethodAppResId_idx` (`controlMethodApprovalResponseId`),
  KEY `ControlMethodAppResHistories_controlMethodVerTranId_idx` (`controlMethodVersionTransitionId`),
  CONSTRAINT `ControlMethodAppResHistories_controlMethodAppResId_idfk` FOREIGN KEY (`controlMethodApprovalResponseId`) REFERENCES `ControlMethodApprovalResponses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodAppResHistories_controlMethodVerTranId_idfk` FOREIGN KEY (`controlMethodVersionTransitionId`) REFERENCES `ControlMethodVersionTransitions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `ControlMethodApprovalResponseHistories`
--
LOCK TABLES `ControlMethodApprovalResponseHistories` WRITE;
/*!40000 ALTER TABLE `ControlMethodApprovalResponseHistories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlMethodApprovalResponseHistories` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `ControlMethodApprovalResponses`
--
DROP TABLE IF EXISTS `ControlMethodApprovalResponses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlMethodApprovalResponses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controlMethodVersionTransitionId` int(11) DEFAULT NULL,
  `controlMethodVersionId` int(11) DEFAULT NULL,
  `controlMethodId` int(11) DEFAULT NULL,
  `ipAddress` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `comment` text,
  `approve` tinyint(1) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `controlMethodId` (`controlMethodId`),
  KEY `controlMethodVersionId` (`controlMethodVersionId`),
  KEY `ControlMethodAppRes_controlMethodVerTranId_idx` (`controlMethodVersionTransitionId`),
  CONSTRAINT `ControlMethodAppRes_controlMethodVerTranId_idfk` FOREIGN KEY (`controlMethodVersionTransitionId`) REFERENCES `ControlMethodVersionTransitions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodApprovalResponses_ibfk_1` FOREIGN KEY (`controlMethodId`) REFERENCES `ControlMethods` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodApprovalResponses_ibfk_2` FOREIGN KEY (`controlMethodVersionId`) REFERENCES `ControlMethodVersions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `ControlMethodApprovalResponses`
--
LOCK TABLES `ControlMethodApprovalResponses` WRITE;
/*!40000 ALTER TABLE `ControlMethodApprovalResponses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlMethodApprovalResponses` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `ControlMethodVersionTransitions`
--
DROP TABLE IF EXISTS `ControlMethodVersionTransitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlMethodVersionTransitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controlMethodVersionId` int(11) DEFAULT NULL,
  `transition` varchar(255) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ControlMethodVerTran_controlMethodVId_idx` (`controlMethodVersionId`),
  CONSTRAINT `ControlMethodVerTran_controlMethodVId_idfk` FOREIGN KEY (`controlMethodVersionId`) REFERENCES `ControlMethodVersions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `ControlMethodVersionTransitions`
--
LOCK TABLES `ControlMethodVersionTransitions` WRITE;
/*!40000 ALTER TABLE `ControlMethodVersionTransitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlMethodVersionTransitions` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `ControlMethodVersions`
--
DROP TABLE IF EXISTS `ControlMethodVersions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlMethodVersions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lastVersionTransitionId` int(11) DEFAULT NULL,
  `controlMethodId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `majorVersion` int(11) DEFAULT NULL,
  `minorVersion` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('Chemical','Biological','Microbiological','Physico-Chemical','') DEFAULT NULL,
  `standard` enum('USP','NF','BP','EP','JP','CP','Non-Standard','') DEFAULT NULL,
  `description` text,
  `equipment` text,
  `status` enum('Pending','Developed','Qualified/Verified','Validated','Transferred','') DEFAULT NULL,
  `developmentLinks` text,
  `referencesLinks` text,
  `currentState` varchar(255) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `stabilityIndicating` enum('Yes','No','') DEFAULT NULL,
  `clonedFromModel` varchar(255) DEFAULT NULL,
  `clonedFromVersionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `supplierId` (`supplierId`),
  KEY `projectId` (`projectId`),
  KEY `controlMethodId` (`controlMethodId`),
  KEY `ControlMethodVersions_lastVerTranId_idx` (`lastVersionTransitionId`),
  KEY `name_idx` (`name`),
  CONSTRAINT `ControlMethodVersions_ibfk_1` FOREIGN KEY (`supplierId`) REFERENCES `Suppliers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodVersions_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodVersions_ibfk_3` FOREIGN KEY (`controlMethodId`) REFERENCES `ControlMethods` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethodVersions_lastVerTranId_idfk` FOREIGN KEY (`lastVersionTransitionId`) REFERENCES `ControlMethodVersionTransitions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `ControlMethodVersions`
--
LOCK TABLES `ControlMethodVersions` WRITE;
/*!40000 ALTER TABLE `ControlMethodVersions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlMethodVersions` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `ControlMethods`
--
DROP TABLE IF EXISTS `ControlMethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlMethods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lastVersionTransitionId` int(11) DEFAULT NULL,
  `lastApprovedVersionId` int(11) DEFAULT NULL,
  `lastVersionId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('Chemical','Biological','Microbiological','Physico-Chemical','') DEFAULT NULL,
  `standard` enum('USP','NF','BP','EP','JP','CP','Non-Standard','') DEFAULT NULL,
  `description` text,
  `equipment` text,
  `status` enum('Pending','Developed','Qualified/Verified','Validated','Transferred','') DEFAULT NULL,
  `developmentLinks` text,
  `referencesLinks` text,
  `currentState` varchar(255) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `stabilityIndicating` enum('Yes','No','') DEFAULT NULL,
  `clonedFromModel` varchar(255) DEFAULT NULL,
  `clonedFromVersionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `supplierId` (`supplierId`),
  KEY `projectId` (`projectId`),
  KEY `lastVersionId` (`lastVersionId`),
  KEY `lastApprovedVersionId` (`lastApprovedVersionId`),
  KEY `ControlMethods_lastVerTranId_idx` (`lastVersionTransitionId`),
  KEY `name_idx` (`name`),
  CONSTRAINT `ControlMethods_ibfk_1` FOREIGN KEY (`supplierId`) REFERENCES `Suppliers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethods_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethods_ibfk_3` FOREIGN KEY (`lastVersionId`) REFERENCES `ControlMethodVersions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethods_ibfk_4` FOREIGN KEY (`lastApprovedVersionId`) REFERENCES `ControlMethodVersions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ControlMethods_lastVerTranId_idfk` FOREIGN KEY (`lastVersionTransitionId`) REFERENCES `ControlMethodVersionTransitions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `ControlMethods`
--
LOCK TABLES `ControlMethods` WRITE;
/*!40000 ALTER TABLE `ControlMethods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlMethods` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `Curricula`
--
DROP TABLE IF EXISTS `Curricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Curricula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lastVersionTransitionId` int(11) DEFAULT NULL,
  `lastApprovedVersionId` int(11) DEFAULT NULL,
  `lastVersionId` int(11) DEFAULT NULL,
  `name` text,
  `description` text,
  `departments` text,
  `referencesLinks` text,
  `currentState` varchar(255) DEFAULT NULL,
  `clonedFromVersionId` int(11) DEFAULT NULL,
  `clonedFromModel` varchar(255) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Curricula_lastVId_idx` (`lastVersionId`),
  KEY `Curricula_lastApprovedVId_idx` (`lastApprovedVersionId`),
  KEY `Curricula_lastVerTranId_idx` (`lastVersionTransitionId`),
  CONSTRAINT `Curricula_lastApprovedVId_idfk` FOREIGN KEY (`lastApprovedVersionId`) REFERENCES `CurriculumVersions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Curricula_lastVId_idfk` FOREIGN KEY (`lastVersionId`) REFERENCES `CurriculumVersions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `Curricula_lastVerTranId_idfk` FOREIGN KEY (`lastVersionTransitionId`) REFERENCES `CurriculumVersionTransitions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `Curricula`
--
LOCK TABLES `Curricula` WRITE;
/*!40000 ALTER TABLE `Curricula` DISABLE KEYS */;
/*!40000 ALTER TABLE `Curricula` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `CurriculaToDocuments`
--
DROP TABLE IF EXISTS `CurriculaToDocuments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CurriculaToDocuments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CurriculumId` int(11) DEFAULT NULL,
  `DocumentId` int(11) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `curriculatodocuments1` (`CurriculumId`,`DocumentId`),
  KEY `curriculatodocuments2` (`DocumentId`,`CurriculumId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `CurriculaToDocuments`
--
LOCK TABLES `CurriculaToDocuments` WRITE;
/*!40000 ALTER TABLE `CurriculaToDocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `CurriculaToDocuments` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `CurriculumApprovalReqToUsers`
--
DROP TABLE IF EXISTS `CurriculumApprovalReqToUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CurriculumApprovalReqToUsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculumApprovalRequestId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CurriculumAppReqToUsers_curriculumAppReqId_idx` (`curriculumApprovalRequestId`),
  CONSTRAINT `CurriculumAppReqToUsers_curriculumAppReqId_idfk` FOREIGN KEY (`curriculumApprovalRequestId`) REFERENCES `CurriculumApprovalRequests` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `CurriculumApprovalReqToUsers`
--
LOCK TABLES `CurriculumApprovalReqToUsers` WRITE;
/*!40000 ALTER TABLE `CurriculumApprovalReqToUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `CurriculumApprovalReqToUsers` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `CurriculumApprovalRequests`
--
DROP TABLE IF EXISTS `CurriculumApprovalRequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CurriculumApprovalRequests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculumVersionTransitionId` int(11) DEFAULT NULL,
  `curriculumVersionId` int(11) DEFAULT NULL,
  `curriculumId` int(11) DEFAULT NULL,
  `ipAddress` varchar(255) DEFAULT NULL,
  `action` enum('archive','restore','') DEFAULT NULL,
  `url` text,
  `comment` text,
  `approveByDate` text,
  `withdrawn` tinyint(1) DEFAULT NULL,
  `withdrawalComment` text,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CurriculumAppReq_curriculumId_idx` (`curriculumId`),
  KEY `CurriculumAppReq_curriculumVId_idx` (`curriculumVersionId`),
  KEY `CurriculumAppReq_curriculumVerTranId_idx` (`curriculumVersionTransitionId`),
  CONSTRAINT `CurriculumAppReq_curriculumId_idfk` FOREIGN KEY (`curriculumId`) REFERENCES `Curricula` (`id`) ON DELETE SET NULL,
  CONSTRAINT `CurriculumAppReq_curriculumVId_idfk` FOREIGN KEY (`curriculumVersionId`) REFERENCES `CurriculumVersions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `CurriculumAppReq_curriculumVerTranId_idfk` FOREIGN KEY (`curriculumVersionTransitionId`) REFERENCES `CurriculumVersionTransitions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `CurriculumApprovalRequests`
--
LOCK TABLES `CurriculumApprovalRequests` WRITE;
/*!40000 ALTER TABLE `CurriculumApprovalRequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `CurriculumApprovalRequests` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `CurriculumApprovalResponseHistories`
--
DROP TABLE IF EXISTS `CurriculumApprovalResponseHistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CurriculumApprovalResponseHistories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculumVersionTransitionId` int(11) DEFAULT NULL,
  `curriculumApprovalResponseId` int(11) DEFAULT NULL,
  `ipAddress` varchar(255) DEFAULT NULL,
  `comment` text,
  `url` varchar(255) DEFAULT NULL,
  `approve` tinyint(1) DEFAULT NULL,
  `createdByUserId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CurriculumAppResHistories_curriculumAppResId_idx` (`curriculumApprovalResponseId`),
  KEY `CurriculumAppResHistories_curriculumVerTranId_idx` (`curriculumVersionTransitionId`),
  CONSTRAINT `CurriculumAppResHistories_curriculumAppResId_idfk` FOREIGN KEY (`curriculumApprovalResponseId`) REFERENCES `CurriculumApprovalResponses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `CurriculumAppResHistories_curriculumVerTranId_idfk` FOREIGN KEY (`curriculumVersionTransitionId`) REFERENCES `CurriculumVersionTransitions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
