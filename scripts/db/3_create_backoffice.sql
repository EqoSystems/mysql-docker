USE `luxx` ;

--
-- Table structure for table `LocationType`
--

DROP TABLE IF EXISTS `LocationType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `LocationType` (
                              `code` char(4) NOT NULL,
                              `label` varchar(64) NOT NULL,
                              `description` varchar(256) DEFAULT NULL,
                              `active` tinyint(4) NOT NULL DEFAULT '1',
                              `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                              `lastModifiedUser` int(11) NOT NULL DEFAULT '0',
                              PRIMARY KEY (`code`),
                              CONSTRAINT `LocationType_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LocationType`
--

LOCK TABLES `LocationType` WRITE;
/*!40000 ALTER TABLE `LocationType` DISABLE KEYS */;
INSERT INTO `LocationType` VALUES
('ondm','On Demand Location','On Demand Location',1,'2018-05-01 21:06:29.346',0),
('pvnd','Vendor Location','Preferred Vendor Location',1,'2018-05-01 17:16:04.972',0),
('rout','Routed Location','Routed Location',1,'2018-05-01 17:16:05.013',0),
('stop','Routed Location Stop','Routed Location Stop such as bathroom breaks, alcohol, snacks, etc',1,'2018-05-01 17:16:05.013',0),
('srvc','Service Location','Vehicle Maintenance, Tags, Inspections, Detailing, Accessories',1,'2018-05-01 17:16:05.094',0);
/*!40000 ALTER TABLE `LocationType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
                          `id` int(11) NOT NULL AUTO_INCREMENT,
                          `locationType` char(4) NOT NULL DEFAULT 'ondm',
                          `name` varchar(128) DEFAULT NULL,
                          `address` varchar(256) DEFAULT NULL,
                          `city` varchar(64) DEFAULT NULL,
                          `state` varchar(2) DEFAULT NULL,
                          `zip` varchar(9) DEFAULT NULL,
                          `lat` decimal(10,8) DEFAULT NULL,
                          `lng` decimal(11,8)  DEFAULT NULL,
                          `plusCode` varchar(11) DEFAULT NULL,
                          `placeId` varchar(11) DEFAULT NULL,
                          `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                          `lastModifiedUser` int(11) NOT NULL DEFAULT '0',
                          PRIMARY KEY (`id`),
                          KEY `Location_ibfk1_idx` (`locationType`),
                          KEY `Location_ibfk2_idx` (`city`),
                          KEY `Location_ibfk3_idx` (`state`),
                          KEY `Location_ibfk4_idx` (`zip`),
                          CONSTRAINT `Location_ibfk1` FOREIGN KEY (`locationType`) REFERENCES `LocationType` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                          CONSTRAINT `Location_ibfk2` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES
(1,'ondm','Clyde Home','400 Echelon Drive','Louisville','KY','40223',38.24802400,-85.51623000,NULL,NULL,'2018-05-02 02:24:15.684',0),
(2,'ondm','Sullivans','3929 Shelbyville Rd.','Louisville','KY','40207',38.25827400,-85.65349200,NULL,NULL,'2018-05-02 02:24:15.923',0);
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vendor`
--

DROP TABLE IF EXISTS `Vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vendor` (
                        `id` int(11) NOT NULL AUTO_INCREMENT,
                        `name` varchar(64) NOT NULL,
                        `description` varchar(256) DEFAULT NULL,
                        `idAddress` int(11) DEFAULT NULL,
                        `phone` varchar(14) NOT NULL,
                        `fax` varchar(14) DEFAULT NULL,
                        `website` varchar(2048) DEFAULT NULL,
                        `businessStartDate` date NOT NULL,
                        `active` tinyint(4) NOT NULL DEFAULT '1',
                        `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                        `lastModifiedUser` int(11) NOT NULL DEFAULT '0',
                        PRIMARY KEY (`id`),
                        KEY `Vendor_ibfk1_idx` (`idAddress`),
                        CONSTRAINT `Vendor_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendor`
--

LOCK TABLES `Vendor` WRITE;
/*!40000 ALTER TABLE `Vendor` DISABLE KEYS */;
-- INSERT INTO `Vendor` VALUES (1,'Luxx Corp','Main Vendor of the Application',19,'5029306508',1,'2018-05-03 02:01:11.525',0);
/*!40000 ALTER TABLE `Vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VendorHasCategory`
--

DROP TABLE IF EXISTS `VendorHasCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VendorHasCategory` (
                                   `idVendor` int(11) NOT NULL,
                                   `category` char(4) NOT NULL,
                                   `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                   `lastModifiedUser` int(11) NOT NULL DEFAULT '0',
                                   PRIMARY KEY (`idVendor`,`category`),
                                   CONSTRAINT `VendorHasCategory_ibfk1` FOREIGN KEY (`idVendor`) REFERENCES `Vendor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                   CONSTRAINT `VendorHasCategory_ibfk2` FOREIGN KEY (`category`) REFERENCES `Category` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                   CONSTRAINT `VendorHasCategory_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VendorHasCategory`
--

LOCK TABLES `VendorHasCategory` WRITE;
/*!40000 ALTER TABLE `VendorHasCategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `VendorHasCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VendorUserRole`
--

DROP TABLE IF EXISTS `VendorUserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VendorUserRole` (
                               `idVendor` int(11) NOT NULL,
                               `idUserRole` int(11) NOT NULL,
                               `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                               `lastModifiedUser` int(11) NOT NULL DEFAULT '0',
                               PRIMARY KEY (`idVendor`,`idUserRole`),
                               KEY `VendorUserRole_ibfk1_idx` (`idUserRole`),
                               CONSTRAINT `VendorUserRole_ibfk1` FOREIGN KEY (`idVendor`) REFERENCES `Vendor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                               CONSTRAINT `VendorUserRole_ibfk2` FOREIGN KEY (`idUserRole`) REFERENCES `UserRole` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                               CONSTRAINT `VendorUserRole_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VendorHasUser`
--

LOCK TABLES `VendorUserRole` WRITE;
/*!40000 ALTER TABLE `VendorUserRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `VendorUserRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vehicle`
--

DROP TABLE IF EXISTS `Vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vehicle` (
                         `id` int(11) NOT NULL AUTO_INCREMENT,
                         `vin` varchar(64) NOT NULL,
                         `color` varchar(32) DEFAULT NULL,
                         `make` varchar(64) DEFAULT NULL,
                         `model` varchar(64) DEFAULT NULL,
                         `mileage` decimal(6,1) DEFAULT NULL,
                         `licensePlate` varchar(16) DEFAULT NULL,
                         `dotNumber` varchar(45) DEFAULT NULL,
                         `tagExpirationMonthYear` datetime DEFAULT NULL,
                         `maxPassengers` tinyint(4) DEFAULT NULL,
                         `vehicleStatus` varchar(4) NOT NULL DEFAULT 'act',
                         `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                         `lastModifiedUser` int(11) NOT NULL DEFAULT '0',
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `vin_UNIQUE` (`vin`),
                         UNIQUE KEY `dotNumber_UNIQUE` (`dotNumber`),
                         UNIQUE KEY `licensePlate_UNIQUE` (`licensePlate`),
                         CONSTRAINT `Vehicle_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vehicle`
--

LOCK TABLES `Vehicle` WRITE;
/*!40000 ALTER TABLE `Vehicle` DISABLE KEYS */;
INSERT INTO `Vehicle` VALUES (1,'98FFAG224G6322','black','mercedes','sprinter',30000.0,'1125-GO',NULL,NULL,NULL,'act','2018-05-01 17:16:05.998',0);
/*!40000 ALTER TABLE `Vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VehicleHasCategory`
--

DROP TABLE IF EXISTS `VehicleHasCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VehicleHasCategory` (
                                  `idVehicle` int(11) NOT NULL,
                                  `category` char(4) NOT NULL,
                                  `lastModifiedtimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                  `lastModifiedUser` int(11) DEFAULT '0',
                                  PRIMARY KEY (`idVehicle`,`category`),
                                  CONSTRAINT `VehicleHasCategory_ibfk1` FOREIGN KEY (`idVehicle`) REFERENCES `Vehicle` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                  CONSTRAINT `VehicleHasCategory_ibfk2` FOREIGN KEY (`category`) REFERENCES `Category` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                  CONSTRAINT `VehicleHasCategory_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VehicleHasCategory`
--

LOCK TABLES `VehicleHasCategory` WRITE;
/*!40000 ALTER TABLE `VehicleHasCategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `VehicleHasCategory` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `VendorHasVehicle`
--

DROP TABLE IF EXISTS `VendorHasVehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VendorHasVehicle` (
                                 `idVehicle` int(11) NOT NULL,
                                 `idVendor` int(11) NOT NULL,
                                 `lastModifiedtimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                 `lastModifiedUser` int(11) DEFAULT '0',
                                 PRIMARY KEY (`idVehicle`,`idVendor`),
                                 KEY `VendorHasVehicle_ibfk1_idx` (`idVehicle`),
                                 CONSTRAINT `VendorHasVehicle_ibfk1` FOREIGN KEY (`idVehicle`) REFERENCES `Vehicle` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                 CONSTRAINT `VendorHasVehicle_ibfk2` FOREIGN KEY (`idVendor`) REFERENCES `Vendor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                 CONSTRAINT `VendorHasVehicle_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VendorHasVehicle`
--

LOCK TABLES `VendorHasVehicle` WRITE;
/*!40000 ALTER TABLE `VendorHasVehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `VendorHasVehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VendorServiceArea`
--

DROP TABLE IF EXISTS `VendorServiceArea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VendorServiceArea` (
                                   `idVendor` int(11) NOT NULL,
                                   `idLocation` int(11) NOT NULL,
                                   `radius` tinyint(4) NOT NULL,
                                   `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                   `lastModifiedUser` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`idVendor`,`idLocation`,`radius`),
                                   CONSTRAINT `VendorServiceArea_ibfk1` FOREIGN KEY (`idVendor`) REFERENCES `Vendor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                   CONSTRAINT `VendorServiceArea_ibfk2` FOREIGN KEY (`idLocation`) REFERENCES `Location` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                                   CONSTRAINT `VendorServiceArea_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VendorServiceArea`
--

LOCK TABLES `VendorServiceArea` WRITE;
/*!40000 ALTER TABLE `VendorServiceArea` DISABLE KEYS */;
/*!40000 ALTER TABLE `VendorServiceArea` ENABLE KEYS */;
UNLOCK TABLES;
