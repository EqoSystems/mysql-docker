USE `luxx` ;

--
-- Table structure for table `Token`
--

DROP TABLE IF EXISTS `Token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Token` (
                       `id` int(11) NOT NULL AUTO_INCREMENT,
                       `tokenType` char(4) NOT NULL,
                       `token` varchar(512) NOT NULL,
                       `timestampLastAccessed` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                       PRIMARY KEY (`id`),
                       CONSTRAINT `Token_ibfk1` FOREIGN KEY (`tokenType`) REFERENCES `SysTokenType` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Token`
--

LOCK TABLES `Token` WRITE;
/*!40000 ALTER TABLE `Token` DISABLE KEYS */;
/*!40000 ALTER TABLE `Token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserHasToken`
--

DROP TABLE IF EXISTS `UserHasToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserHasToken` (
                              `idUser` int(11) NOT NULL,
                              `idToken` int(11) NOT NULL,
                              PRIMARY KEY (`idUser`,`idToken`),
                              UNIQUE KEY `idToken_UNIQUE` (`idToken`),
                              KEY `UserHasToken_ibfk1_idx` (`idToken`),
                              KEY `UserHasToken_ibfk2_idx` (`idUser`),
                              CONSTRAINT `UserHasToken_ibfk1` FOREIGN KEY (`idToken`) REFERENCES `Token` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `UserHasToken_ibfk2` FOREIGN KEY (`idUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserHasToken`
--

LOCK TABLES `UserHasToken` WRITE;
/*!40000 ALTER TABLE `UserHasToken` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserHasToken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRole`
--

DROP TABLE IF EXISTS `UserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserRole` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `idUser` int(11) NOT NULL,
                      `idRole` char(4) NOT NULL,
                      `active` tinyint(4) NOT NULL DEFAULT '1',
                      `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                      `lastModifiedUser` int(11) DEFAULT '0',
                      PRIMARY KEY (`id`),
                      UNIQUE KEY `UserRole_UNIQUE`(`idUser`, `idRole`),
                      KEY `UserRole_ibfk1_idx` (`idUser`),
                      CONSTRAINT `UserRole_ibfk1` FOREIGN KEY (`idUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                      CONSTRAINT `UserRole_ibfk2` FOREIGN KEY (`idRole`) REFERENCES `SysRole` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                      CONSTRAINT `UserRole_ibfk3` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRole`
--

LOCK TABLES `UserRole` WRITE;
/*!40000 ALTER TABLE `UserRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Address` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `address` varchar(128) DEFAULT NULL,
                      `address2` varchar(128) DEFAULT NULL,
                      `city` varchar(64) DEFAULT NULL,
                      `state` varchar(2) DEFAULT NULL,
                      `zip` varchar(5) DEFAULT NULL,
                      `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                      `lastModifiedUser` int(11) DEFAULT 0,
                      PRIMARY KEY (`id`),
                      CONSTRAINT `Address_ibfk1` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserHasAddress`
--

DROP TABLE IF EXISTS `UserHasAddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserHasAddress` (
                            `idUser` int(11) NOT NULL,
                            `idAddress` int(11) NOT NULL,
                            `addressType` char(4) NOT NULL DEFAULT 'bill',
                            `label` varchar(256) DEFAULT NULL,
                            `active` tinyint(4) NOT NULL DEFAULT '1',
                            `lastModifiedTimestamp` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                            `lastModifiedUser` int(11) DEFAULT 0,
                            PRIMARY KEY (`idUser`, `idAddress`),
                            KEY `UserHasAddress_ibfk1_idx` (`idUser`),
                            CONSTRAINT `UserHasAddress_ibfk1` FOREIGN KEY (`idUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                            CONSTRAINT `UserHasAddress_ibfk2` FOREIGN KEY (`idAddress`) REFERENCES `Address` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
                            CONSTRAINT `UserHasAddress_ibfk3` FOREIGN KEY (`addressType`) REFERENCES `SysAddressType` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
                            CONSTRAINT `UserHasAddress_ibfk4` FOREIGN KEY (`lastModifiedUser`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserHasAddress`
--

LOCK TABLES `UserHasAddress` WRITE;
/*!40000 ALTER TABLE `UserHasAddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserHasAddress` ENABLE KEYS */;
UNLOCK TABLES;
