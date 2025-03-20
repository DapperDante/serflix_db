-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: serflix_dev
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.24.04.1

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goals`
--

LOCK TABLES `goals` WRITE;
/*!40000 ALTER TABLE `goals` DISABLE KEYS */;
INSERT INTO `goals` VALUES (1,'Fan','Add 5 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x5.png'),(2,'Crazy fan','Add 10 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x10.png'),(3,'Addict','Add 20 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x20.png'),(4,'Noob','Add 1 favorite movie','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x1.png'),(5,'Maniac','Add 1 favorite serie','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x1_serie.png'),(6,'Cinefilo','Add 5 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x5_serie.png'),(7,'Full','Add 10 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x10_serie.png'),(8,'Respect','Add 15 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x15_serie.png'),(9,'Master','Add 50 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x50.png'),(10,'Fan','Add 5 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x5.png'),(11,'Crazy fan','Add 10 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x10.png'),(12,'Addict','Add 20 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x20.png'),(13,'Noob','Add 1 favorite movie','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x1.png'),(14,'Maniac','Add 1 favorite serie','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x1_serie.png'),(15,'Cinefilo','Add 5 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x5_serie.png'),(16,'Full','Add 10 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x10_serie.png'),(17,'Respect','Add 15 favorite series','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x15_serie.png'),(18,'Master','Add 50 favorite movies','https://serflix-bucket.s3.us-east-2.amazonaws.com/goals/goal_favorite_x50.png');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_views`
--

LOCK TABLES `log_views` WRITE;
/*!40000 ALTER TABLE `log_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `detail` varchar(100) NOT NULL,
  `price_mxn` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (3,'Free','Free plan\n5 profiles',0.00),(4,'Premium','Premium plan\n10 profiles',100.00);
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
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
  KEY `goal_id` (`goal_id`),
  KEY `idx_unique_item` (`profile_id`,`goal_id`),
  CONSTRAINT `profile_goals_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`),
  CONSTRAINT `profile_goals_ibfk_2` FOREIGN KEY (`goal_id`) REFERENCES `goals` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_goals`
--

LOCK TABLES `profile_goals` WRITE;
/*!40000 ALTER TABLE `profile_goals` DISABLE KEYS */;
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
  KEY `idx_unique_item` (`profile_id`,`movie_id`),
  CONSTRAINT `profile_movies_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_movies`
--

LOCK TABLES `profile_movies` WRITE;
/*!40000 ALTER TABLE `profile_movies` DISABLE KEYS */;
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
  KEY `idx_unique_item` (`profile_id`,`serie_id`),
  CONSTRAINT `profile_series_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_series`
--

LOCK TABLES `profile_series` WRITE;
/*!40000 ALTER TABLE `profile_series` DISABLE KEYS */;
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
  KEY `user_id` (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,6,'Dante','https://rickandmortyapi.com/api/character/avatar/1.jpeg');
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
  KEY `idx_unique_item` (`profile_id`,`movie_id`),
  CONSTRAINT `score_movies_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score_movies`
--

LOCK TABLES `score_movies` WRITE;
/*!40000 ALTER TABLE `score_movies` DISABLE KEYS */;
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
  KEY `idx_unique_item` (`profile_id`,`serie_id`),
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
-- Table structure for table `suscription`
--

DROP TABLE IF EXISTS `suscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suscription` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `suscription_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  CONSTRAINT `suscription_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscription`
--

LOCK TABLES `suscription` WRITE;
/*!40000 ALTER TABLE `suscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `suscription` ENABLE KEYS */;
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
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'danteadonai.dp@gmail.com','DapperDante','U2FsdGVkX1/JQ/b9dGcyMk1XtQsgQLJMPpfMpSRqCXg=');
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

-- Dump completed on 2025-02-28 13:23:28
