DROP DATABASE IF EXISTS `youtube`;
CREATE DATABASE `youtube`;
USE `youtube`;

CREATE TABLE `usuari` (
  `usuari_id` INT NOT NULL AUTO_INCREMENT,
  `nom_usuari` varchar(20) NOT NULL UNIQUE,
  `email` varchar(150) NOT NULL UNIQUE,
  `data_naixement` DATE NOT NULL,
  `sexe` varchar(15) NOT NULL,
  `pais` varchar(35) NOT NULL,
  `CP` INT NOT NULL,
  PRIMARY KEY (`usuari_id`)
);

CREATE TABLE `video` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `titol` varchar(100) NOT NULL,
  `descripcio` varchar(1000) NOT NULL,
  `grandaria` DECIMAL(20,2) NOT NULL,
  `nom_arxiu_video` varchar(100) NOT NULL,
  `durada_minuts` INT NOT NULL,
  `thumbnail` varchar(45) NOT NULL,
  `reproduccions` INT DEFAULT 0,
  `likes` INT DEFAULT 0,
  `dislikes` INT DEFAULT 0,
  `estat` enum('public','privat','ocult') DEFAULT 'public',
  PRIMARY KEY (`video_id`)
);

CREATE TABLE `videos_publicats` (
  `usuari_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `data_publicacio` DATETIME NOT NULL,
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
  FOREIGN KEY (`video_id`) REFERENCES video(video_id)
);

CREATE TABLE `etiqueta` (
  `etiqueta_id` INT NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`etiqueta_id`),
  FOREIGN KEY (`video_id`) REFERENCES video(video_id)
);

CREATE TABLE `canal` (
  `canal_id` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `nom` varchar(50) NOT NULL UNIQUE,
  `descripcio` varchar(1000) DEFAULT NULL,
  `data_creacio` DATETIME NOT NULL,
  PRIMARY KEY (`canal_id`),
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id)
);

CREATE TABLE `subscripcio` (
  `usuari_id` INT NOT NULL,
  `canal_id` INT NOT NULL,
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
  FOREIGN KEY (`canal_id`) REFERENCES canal(canal_id)
);

CREATE TABLE `video_likes_dislikes` (
  `usuari_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `accio` ENUM('like', 'dislike') NOT NULL,
  `data-accio` DATETIME NOT NULL,
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
  FOREIGN KEY (`video_id`) REFERENCES video(video_id)
);

CREATE TABLE `playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `nom` varchar(50) NOT NULL,
  `data_creacio` DATETIME NOT NULL,
  `estat` ENUM('public', 'privat'),
  PRIMARY KEY (`playlist_id`),
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id)
);

CREATE TABLE `playlist_video` (
  `playlist_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  FOREIGN KEY (`playlist_id`) REFERENCES playlist(playlist_id),
  FOREIGN KEY (`video_id`) REFERENCES video(video_id)
);

CREATE TABLE `comentari` (
  `comentari_id` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `text` varchar(1000) NOT NULL,
  `data` DATETIME DEFAULT NULL,
  PRIMARY KEY (`comentari_id`),
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
  FOREIGN KEY (`video_id`) REFERENCES video(video_id)
);

CREATE TABLE `comentari_like_dislike` (
  `usuari_id` INT NOT NULL,
  `comentari_id` INT NOT NULL,
  `accio` ENUM('like', 'dislike') NOT NULL,
  `data-accio` DATETIME NOT NULL,
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
  FOREIGN KEY (`comentari_id`) REFERENCES comentari(comentari_id)
);