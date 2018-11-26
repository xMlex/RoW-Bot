-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.5.34 - MySQL Community Server (GPL)
-- ОС Сервера:                   Win64
-- HeidiSQL Версия:              8.0.0.4464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры для таблица vk_row.row_skills
CREATE TABLE IF NOT EXISTS `row_skills` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Дамп структуры для таблица vk_row.row_skills_depend
CREATE TABLE IF NOT EXISTS `row_skills_depend` (
  `id` int(10) unsigned NOT NULL,
  `parent` int(10) unsigned NOT NULL,
  `parent_lvl` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Дамп структуры для таблица vk_row.row_skill_map
CREATE TABLE IF NOT EXISTS `row_skill_map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skill` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `skill` (`skill`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- Дамп структуры для таблица vk_row.row_static
CREATE TABLE IF NOT EXISTS `row_static` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(225) DEFAULT '''''',
  `descr` text,
  `type` enum('NONE','BUILD','WARIOR','DRAWING','TECHNOLOGY','ARTIFACT') DEFAULT 'NONE',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Дамп структуры для таблица vk_row.row_users
CREATE TABLE IF NOT EXISTS `row_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;