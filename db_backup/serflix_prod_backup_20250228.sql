-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: autorack.proxy.rlwy.net    Database: serflix_prod
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `goals`
--

DROP TABLE IF EXISTS `goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `detail` varchar(40) NOT NULL,
  `url` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goals`
--

LOCK TABLES `goals` WRITE;
/*!40000 ALTER TABLE `goals` DISABLE KEYS */;
INSERT INTO `goals` VALUES (1,'Fan','Add 5 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x5.png'),(2,'Crazy fan','Add 10 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x10.png'),(3,'Addict','Add 20 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x20.png'),(4,'Noob','Add 1 favorite movie','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x1.png'),(5,'Maniac','Add 1 favorite serie','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x1_serie.png'),(6,'Cinefilo','Add 5 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x5_serie.png'),(7,'Full','Add 10 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x10_serie.png'),(8,'Respect','Add 15 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x15_serie.png'),(9,'Master','Add 50 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x50.png');
/*!40000 ALTER TABLE `goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_passwords`
--

DROP TABLE IF EXISTS `log_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_passwords` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `old_password` varchar(100) DEFAULT NULL,
  `new_password` varchar(100) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `log_passwords_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_passwords`
--

LOCK TABLES `log_passwords` WRITE;
/*!40000 ALTER TABLE `log_passwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_views`
--

DROP TABLE IF EXISTS `log_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_views` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `item_id` int NOT NULL,
  `type` char(1) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_unique_item` (`profile_id`,`item_id`,`type`),
  CONSTRAINT `log_views_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`),
  CONSTRAINT `log_views_chk_1` CHECK ((`type` in (_utf8mb4'M',_utf8mb4'S')))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_views`
--

LOCK TABLES `log_views` WRITE;
/*!40000 ALTER TABLE `log_views` DISABLE KEYS */;
INSERT INTO `log_views` VALUES (1,5,912649,'M','2025-02-10 23:55:19'),(2,5,251691,'S','2025-02-10 23:55:35'),(3,5,2288,'S','2025-02-10 23:55:59'),(4,5,1241982,'M','2025-02-10 23:56:09'),(5,5,993710,'M','2025-02-10 23:56:14'),(6,5,1160956,'M','2025-02-10 23:56:18'),(7,5,1249289,'M','2025-02-10 23:56:22'),(8,5,533535,'M','2025-02-11 01:39:13'),(9,7,1035048,'M','2025-02-11 02:34:09'),(10,7,939243,'M','2025-02-11 02:34:57'),(11,5,1241982,'M','2025-02-12 23:54:13'),(12,5,822119,'M','2025-02-19 22:29:31'),(13,6,822119,'M','2025-02-26 22:27:14'),(14,6,1124620,'M','2025-02-26 22:28:21'),(15,6,822119,'M','2025-02-26 22:28:36'),(16,6,2288,'S','2025-02-26 22:28:44');
/*!40000 ALTER TABLE `log_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_goals`
--

DROP TABLE IF EXISTS `profile_goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_goals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `goal_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `profile_id` (`profile_id`,`goal_id`),
  KEY `goal_id` (`goal_id`),
  CONSTRAINT `profile_goals_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`),
  CONSTRAINT `profile_goals_ibfk_2` FOREIGN KEY (`goal_id`) REFERENCES `goals` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_goals`
--

LOCK TABLES `profile_goals` WRITE;
/*!40000 ALTER TABLE `profile_goals` DISABLE KEYS */;
INSERT INTO `profile_goals` VALUES (3,1,1),(1,1,4),(2,1,5),(4,1,6),(5,2,5),(6,3,4),(9,5,1),(7,5,4),(8,5,5),(11,6,4),(12,6,5),(10,7,4);
/*!40000 ALTER TABLE `profile_goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_movies`
--

DROP TABLE IF EXISTS `profile_movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `delete_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id` (`profile_id`),
  CONSTRAINT `profile_movies_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_movies`
--

LOCK TABLES `profile_movies` WRITE;
/*!40000 ALTER TABLE `profile_movies` DISABLE KEYS */;
INSERT INTO `profile_movies` VALUES (1,1,539972,NULL),(2,1,939243,NULL),(3,1,912649,NULL),(4,1,1241982,NULL),(5,1,1005331,NULL),(6,3,939243,NULL),(7,5,939243,'2025-02-10 23:14:02'),(8,5,912649,NULL),(9,5,1241982,NULL),(10,5,993710,NULL),(11,5,1160956,NULL),(12,5,1249289,NULL),(13,5,533535,NULL),(14,7,939243,NULL),(15,6,822119,NULL);
/*!40000 ALTER TABLE `profile_movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_series`
--

DROP TABLE IF EXISTS `profile_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `serie_id` int NOT NULL,
  `delete_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id` (`profile_id`),
  CONSTRAINT `profile_series_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_series`
--

LOCK TABLES `profile_series` WRITE;
/*!40000 ALTER TABLE `profile_series` DISABLE KEYS */;
INSERT INTO `profile_series` VALUES (1,1,1396,NULL),(2,1,209867,NULL),(3,1,257064,NULL),(4,1,36361,NULL),(5,1,251691,NULL),(6,2,93405,NULL),(7,5,254821,'2025-02-10 23:14:02'),(8,5,251691,NULL),(9,5,2288,NULL),(10,6,2288,NULL);
/*!40000 ALTER TABLE `profile_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(65) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,'Dante','https://rickandmortyapi.com/api/character/avatar/8.jpeg'),(2,1,'Jorge emilio','https://rickandmortyapi.com/api/character/avatar/1.jpeg'),(3,2,'Dantes','https://rickandmortyapi.com/api/character/avatar/4.jpeg'),(4,2,'oikujtyhrg','https://rickandmortyapi.com/api/character/avatar/6.jpeg'),(5,3,'Adonais','https://rickandmortyapi.com/api/character/avatar/19.jpeg'),(6,3,'Don javier','https://rickandmortyapi.com/api/character/avatar/2.jpeg'),(7,3,'Beto','https://rickandmortyapi.com/api/character/avatar/8.jpeg'),(8,6,'Dante','https://rickandmortyapi.com/api/character/avatar/1.jpeg');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score_movies`
--

DROP TABLE IF EXISTS `score_movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `score_movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `score` tinyint NOT NULL,
  `review` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `profile_id` (`profile_id`,`movie_id`),
  CONSTRAINT `score_movies_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score_movies`
--

LOCK TABLES `score_movies` WRITE;
/*!40000 ALTER TABLE `score_movies` DISABLE KEYS */;
INSERT INTO `score_movies` VALUES (1,5,533535,5,'The best movie of the world'),(2,7,1035048,4,'The best movie of the world');
/*!40000 ALTER TABLE `score_movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score_series`
--

DROP TABLE IF EXISTS `score_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `score_series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `serie_id` int NOT NULL,
  `score` tinyint NOT NULL,
  `review` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `profile_id` (`profile_id`,`serie_id`),
  CONSTRAINT `score_series_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score_series`
--

LOCK TABLES `score_series` WRITE;
/*!40000 ALTER TABLE `score_series` DISABLE KEYS */;
/*!40000 ALTER TABLE `score_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(70) NOT NULL,
  `username` varchar(65) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'danteadonai@gmail.com','DapperDante','U2FsdGVkX1+5oxGGP5MFOeoQmYKpXj/t/dyRu6s998UxSI3UKCR8c9oJgFfqEN95'),(2,'kyujthrgef@mail.com','DantesAdonai2000','U2FsdGVkX18STy9+RnYzfL6CUAfDzm8wZs3kMQ01CDtdz/wOWmqO2Kmd/dCwzqXl'),(3,'dantesadonai@gmail.com','DantesAdonai','U2FsdGVkX19EyTrR2m5bRlJWLuzIf0uuooDOuWKSAwI='),(6,'Danteadonai.dp@gmail.com','DapperDante2005','U2FsdGVkX19IYpQbS1TCFmF1DZPH0xUSqVn2KqnBuJQ=');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-28 13:16:17
