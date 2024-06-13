
DROP DATABASE IF EXISTS mrsdemo ;
CREATE DATABASE mrsdemo;


USE mrsdemo;

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 82.180.44.110    Database: stratos_dev
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.8-MariaDB-log

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


DROP TABLE IF EXISTS `aziende`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aziende` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `codice` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_codice_aziende` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aziende`
--

LOCK TABLES `aziende` WRITE;
/*!40000 ALTER TABLE `aziende` DISABLE KEYS */;
INSERT INTO `aziende` VALUES (1,'PADIAD','PADigitale','PA Digitale Adriatica S.r.l.','2024-03-12 09:07:02','2024-03-26 12:38:19'),(2,'PACENT','PACentro','Pa Centro S.r.l.','2024-03-12 09:07:02','2024-03-12 09:07:02');
/*!40000 ALTER TABLE `aziende` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `linee_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linee_ordine` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ordine_id` int(10) unsigned NOT NULL,
  `azienda_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `codice` varchar(100) DEFAULT NULL,
  `gruppo_operatore_id` tinyint(3) unsigned DEFAULT NULL,
  `modalita_fatturazione_id` tinyint(3) unsigned NOT NULL,
  `prodotto_id` int(10) unsigned NOT NULL,
  `stato_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `note_prodotto` varchar(250) DEFAULT NULL,
  `prezzo` decimal(11,2) DEFAULT NULL,
  `qta` int(10) unsigned NOT NULL,
  `qta_residua` int(10) unsigned DEFAULT NULL,
  `totale` decimal(11,2) NOT NULL,
  `totale_residuo` decimal(11,2) DEFAULT 0.00,
  `note` varchar(250) DEFAULT NULL,
  `decorrenza` timestamp NULL DEFAULT current_timestamp(),
  `scadenza` timestamp NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linee_ordine`
--

LOCK TABLES `linee_ordine` WRITE;
/*!40000 ALTER TABLE `linee_ordine` DISABLE KEYS */;
INSERT INTO `linee_ordine` VALUES (1,1,1,'A10384',NULL,4,5,2,'Service finanziaria  Celenza 2024',NULL,200,62,10000.00,4870.00,NULL,'2024-03-27 10:11:46','2024-05-31 09:11:46','2024-03-27 10:11:46','2024-03-28 15:43:55'),(2,1,1,'483984A',NULL,1,10,2,'Stampanti HP per comune',NULL,5,2,1000.00,700.00,NULL,'2024-03-27 10:13:04','2024-05-31 09:13:04','2024-03-27 10:13:04','2024-03-28 15:43:55'),(3,1,1,'43244',NULL,1,9,2,'Pc asus Rog',NULL,2,1,1952.50,1077.50,NULL,'2024-03-27 10:53:02','2024-03-27 10:53:02','2024-03-27 10:53:02','2024-03-28 15:43:55'),(4,16,1,'874387438',NULL,4,1,1,'Servizio Documentale Campobasso',NULL,200,0,5000.00,0.00,NULL,'2024-03-27 11:16:45','2024-06-29 10:16:45','2024-03-27 11:16:45','2024-03-28 10:47:12'),(5,2,2,'8473847',NULL,1,2,1,'Service Tributi ANNO 2024-2025',NULL,250,0,20000.00,0.00,NULL,'2024-04-30 13:49:40','2024-12-31 14:49:40','2024-03-28 09:31:29','2024-03-28 15:44:50'),(7,2,1,'stor1',NULL,1,12,1,'storno per decreto numero 333',NULL,1,0,250.00,0.00,NULL,'2024-03-28 15:22:31','2024-03-28 15:22:31','2024-03-28 15:22:31','2024-03-28 15:44:50'),(8,2,2,'portmir21',NULL,1,9,1,'laptop lenovo thinkpad t420',NULL,2,0,1800.00,0.00,NULL,'2024-03-28 15:33:56','2024-03-28 15:33:56','2024-03-28 15:33:56','2024-03-28 15:44:50');
/*!40000 ALTER TABLE `linee_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modalita_fatturazione`
--

DROP TABLE IF EXISTS `modalita_fatturazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modalita_fatturazione` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `codice` varchar(50) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `cadenza_in_giorni` int(11) NOT NULL DEFAULT 0,
  `latenza_in_giorni` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_modalita_fatturazione_codice` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modalita_fatturazione`
--

LOCK TABLES `modalita_fatturazione` WRITE;
/*!40000 ALTER TABLE `modalita_fatturazione` DISABLE KEYS */;
INSERT INTO `modalita_fatturazione` VALUES (1,'IMMEDIATA','fattura emessa alla attivazione del contratto',0,-1),(2,'ANNUALE_PRE','cadenza annuale - emissione anticipata',365,-1),(3,'ANNUALE','cadenza annuale - emissione immediata',365,0),(4,'TRIMESTRALE','cadenza trimestale - emissione immediata',90,0),(5,'UNA_TANTUM','una tantum - emissione immediata',0,0),(6,'UNA_TANTUM_PRE','una tantum - emissione anticipata',0,-1);
/*!40000 ALTER TABLE `modalita_fatturazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini`
--

DROP TABLE IF EXISTS `ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordini` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` int(10) unsigned NOT NULL,
  `numero` int(11) NOT NULL,
  `rif_numero` varchar(50) DEFAULT NULL,
  `rif_contratto` varchar(50) DEFAULT NULL,
  `descrizione` mediumtext DEFAULT NULL,
  `cig` varchar(50) DEFAULT NULL,
  `cup` varchar(50) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `anno_esercizio` year(4) DEFAULT NULL,
  `data_ordine` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_ordini_numero_anno` (`numero`,`anno_esercizio`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` VALUES (1,1,1,'54905940','59495489','Ordine Bla bla bla ciao per il cliente','78547854378534','767896478',1,2024,'2024-03-12','2024-03-12 09:07:02','2024-03-27 12:36:17'),(2,2,2,NULL,NULL,NULL,NULL,NULL,1,2024,'2024-03-12','2024-03-12 09:07:02','2024-03-19 16:01:02'),(3,3,3,NULL,NULL,NULL,NULL,NULL,1,2024,'2024-03-12','2024-03-12 09:07:02','2024-03-19 16:46:26'),(4,3,4,NULL,NULL,NULL,NULL,NULL,0,2024,'2024-03-12','2024-03-12 09:07:02','2024-03-26 09:15:40'),(5,3,5,'rifnum-00012','CON0012','aggiunto da riccardo',NULL,NULL,0,2024,'2024-03-14','2024-03-14 15:55:24','2024-03-19 16:16:49'),(6,1,6,'hlhasdlhdaslkh','sajidsaijsad','dsahiolsdhaiohdsaiohsdai',NULL,NULL,0,2024,'2024-03-16','2024-03-15 07:36:38','2024-03-15 07:36:38'),(7,2,7,'rif-demo-determina-001','rif-demo-contratto-001','prova inserimeto dopo il refactor delle colonne Salv','abc3&','123a$',1,2024,'2024-03-17','2024-03-18 08:57:07','2024-03-26 09:18:35'),(14,1,8,'rif-1234','con-12345','feed ins',NULL,NULL,0,2024,'2024-03-20','2024-03-20 09:31:50','2024-03-26 09:19:02'),(15,4,9,'65465','54687987','desc',NULL,NULL,1,2024,'2024-03-22','2024-03-22 11:34:18','2024-03-22 11:34:18'),(16,4,10,'rif 123','contr 6','una nota così, tanto per....','8473874387','8743874387',1,2024,'2024-03-19','2024-03-26 10:26:59','2024-03-28 09:27:50');
/*!40000 ALTER TABLE `ordini` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `prodotti`
--

DROP TABLE IF EXISTS `prodotti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotti` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codice` varchar(50) NOT NULL,
  `unita_misura_id` tinyint(3) unsigned NOT NULL,
  `tipo_id` tinyint(3) unsigned NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descrizione` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `codice_prodotti_unique` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotti`
--

LOCK TABLES `prodotti` WRITE;
/*!40000 ALTER TABLE `prodotti` DISABLE KEYS */;
INSERT INTO `prodotti` VALUES (1,'PROTO_1',2,2,'Service Documentale','servizio di protocollazione sul posto/remoto','2024-03-12 09:07:02','2024-03-13 11:09:01'),(2,'CED_1',2,2,'Service Tributi','servizio di cedolini sul posto/remoto','2024-03-12 09:07:02','2024-03-13 11:09:07'),(3,'URBI_DEMO_LIC_1',1,1,'urbi demografico','licenza di urbi demografico','2024-03-12 09:07:02','2024-03-12 09:07:02'),(4,'NOLE_1',1,4,'noleggio postazioni per giorno',NULL,'2024-03-12 09:07:02','2024-03-12 09:07:02'),(5,'FORM_1',2,2,'Service Finanziaria','formazione sul posto/remoto','2024-03-12 09:07:02','2024-03-13 11:08:15'),(6,'CANONE_MANUT_1',1,3,'manutenzione annuale',NULL,'2024-03-12 09:07:02','2024-03-12 09:07:02'),(7,'DEV_1',2,2,'intervista analisti','il programmatore si reca sul posto per discutere le specifiche','2024-03-12 09:07:02','2024-03-12 09:07:02'),(9,'PC',1,5,'Portatile ','portatile','2024-03-13 11:10:10','2024-03-13 11:10:38'),(10,'STAMPANTE',1,5,'Stampante','stampante','2024-03-13 11:10:29','2024-03-13 11:10:45'),(12,'STORNO',1,6,'Storno','storno','2024-03-28 15:18:27','2024-03-28 15:18:27');
/*!40000 ALTER TABLE `prodotti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stati_linee_ordine`
--

DROP TABLE IF EXISTS `stati_linee_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stati_linee_ordine` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `codice` varchar(25) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `css` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_stati_linea` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stati_linee_ordine`
--

LOCK TABLES `stati_linee_ordine` WRITE;
/*!40000 ALTER TABLE `stati_linee_ordine` DISABLE KEYS */;
INSERT INTO `stati_linee_ordine` VALUES (1,'IN ATTESA','in attesa della decorrenza','badge-primary'),(2,'IN LAVORAZIONE','in lavorazione','badge-warning'),(3,'SOSPESO','sospeso','badge-danger'),(4,'EVASO','chiuso','badge-success'),(5,'CANCELLATO','cancellato','badge-dark');
/*!40000 ALTER TABLE `stati_linee_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipi_prodotti`
--

DROP TABLE IF EXISTS `tipi_prodotti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipi_prodotti` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `codice` varchar(50) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `css` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_tipi_prodotti_codice` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipi_prodotti`
--

LOCK TABLES `tipi_prodotti` WRITE;
/*!40000 ALTER TABLE `tipi_prodotti` DISABLE KEYS */;
INSERT INTO `tipi_prodotti` VALUES (1,'LICENZA','pacchetto software','badge-primary'),(2,'SERVIZIO','qualsiasi servizio ad ore in loco o remoto','badge-info'),(3,'PREPAGATO','per servizi prepagati','badge-success'),(4,'NOLEGGIO','noleggio attrezzature','badge-secondary'),(5,'HARDWARE','vendita attrezzatura','badge-dark'),(6,'STORNO','storno','badge-dark');
/*!40000 ALTER TABLE `tipi_prodotti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unita_misura`
--

DROP TABLE IF EXISTS `unita_misura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unita_misura` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `codice` varchar(50) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_unita_misura_codice` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unita_misura`
--

LOCK TABLES `unita_misura` WRITE;
/*!40000 ALTER TABLE `unita_misura` DISABLE KEYS */;
INSERT INTO `unita_misura` VALUES (1,'UNITA','una unita'),(2,'ORA','sessanta minuti');
/*!40000 ALTER TABLE `unita_misura` ENABLE KEYS */;
UNLOCK TABLES;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
