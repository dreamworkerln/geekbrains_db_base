CREATE DATABASE  IF NOT EXISTS `geekbrainz`;
USE `geekbrainz`;
-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Database: geekbrainz
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1-log


DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `index_region_country_id` (`country_id`),
  CONSTRAINT `fk_region_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Область';



DROP TABLE IF EXISTS `district`;
CREATE TABLE `district` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `index_district_region_id` (`region_id`),
  CONSTRAINT `fk_district_region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Район';




DROP TABLE IF EXISTS `locality`;
CREATE TABLE `locality` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region_id` bigint(20) NOT NULL,
  `district_id` bigint(20) DEFAULT NULL,
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0 - деревня, 1 - поселок, 2 - город - надо больше - тип в отдельную таблицу и FK на нее.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `index_locality_region_id` (`region_id`),
  KEY `index_locality_district_id` (`district_id`),
  CONSTRAINT `fk_locality_district_id` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_locality_region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Населеный пункт';



-- test


SELECT con.`display_name` AS 'страна', reg.`display_name` AS 'область', dis.`display_name` AS 'район', loc.`display_name` AS 'населенный пункт'
FROM `locality` loc
LEFT JOIN  `district` dis ON loc.`district_id` = dis.`id`
LEFT JOIN  `region` reg ON loc.`region_id` = reg.`id`
LEFT JOIN  `country` con ON reg.`country_id` = con.`id`;


