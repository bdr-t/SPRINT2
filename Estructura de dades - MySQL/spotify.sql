DROP DATABASE IF EXISTS `spotify`;
CREATE DATABASE `spotify`;
USE `spotify`;

CREATE TABLE `usuari` (
  `usuari_id` INT NOT NULL AUTO_INCREMENT,
  `nom_usuari` varchar(45) NOT NULL UNIQUE,
  `email` varchar(255) NOT NULL UNIQUE,
  `constrasenya` varchar(45) NOT NULL,
  `data_naixement` DATETIME NOT NULL,
  `sexe` varchar(3) NOT NULL,
  `pais` varchar(3) NOT NULL,
  `CP` varchar(5) NOT NULL,
  PRIMARY KEY (`usuari_id`)
);


CREATE TABLE `subscripcio` (
  `subscripcio_id` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `inici_subscripcio` DATETIME NOT NULL,
  `renovacio_subscripcio` DATETIME NOT NULL,
  `forma_pagament` ENUM('targeta', 'paypal') NOT NULL,
  PRIMARY KEY (`subscripcio_id`),
  FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id)
);

CREATE TABLE `targeta` (
    `targeta_id` INT NOT NULL AUTO_INCREMENT,
    `subscripcio_id` INT NOT NULL,
    `numero` INT NOT NULL,
    `mes_caducitat` INT NOT NULL,
    `any_caducitat` INT NOT NULL,
    PRIMARY KEY (`targeta_id`),
    FOREIGN KEY (`subscripcio_id`) REFERENCES subscripcio(subscripcio_id)
);

CREATE TABLE `paypal` (
    `paypal_id` INT NOT NULL AUTO_INCREMENT,
    `subscripcio_id` INT NOT NULL,
    `nom_usuari` varchar(50) NOT NULL,
    PRIMARY KEY (`paypal_id`),
    FOREIGN KEY (`subscripcio_id`) REFERENCES subscripcio(subscripcio_id)
);

CREATE TABLE `registre_subscripcions` (
    `usuari_id` INT NOT NULL,
    `numero_ordre` INT NOT NULL UNIQUE,
    `total` DECIMAL(6,2) NOT NULL,
    FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id)
);

CREATE TABLE `playlist` (
    `playlist_id` INT NOT NULL AUTO_INCREMENT,
    `usuari_id` INT NOT NULL,
    `nom` varchar(50) NOT NULL,
    `num_cançons` INT DEFAULT 0,
    `data_creacio` DATETIME NOT NULL,
    `estat` ENUM('activa', 'esborrada') DEFAULT 'activa',
    `data_eliminacio` DATETIME DEFAULT NULL, 
    PRIMARY KEY (`playlist_id`),
    FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id)
);

CREATE TABLE `artista` (
    `artista_id` INT NOT NULL AUTO_INCREMENT,
    `nom` varchar(50) NOT NULL,
    `imatge` varchar(100),
    PRIMARY KEY (`artista_id`)
);

CREATE TABLE `album` (
    `album_id` INT NOT NULL AUTO_INCREMENT,
    `artista_id` INT NOT NULL,
    `titol` VARCHAR(50) NOT NULL,
    `any_publicacio`INT NOT NULL,
    `imatge_portada` VARCHAR(250) NOT NULL,
    PRIMARY KEY (`album_id`),
    FOREIGN KEY (`artista_id`) REFERENCES artista(artista_id)
);

CREATE TABLE `canço` (
    `canço_id` INT NOT NULL AUTO_INCREMENT,
    `artista_id` INT NOT NULL,
    `album_id` INT NOT NULL,
    `titol` varchar(150) NOT NULL,
    `durada_min` DECIMAL(2,2) NOT NULL,
    `durada_seg` INT NOT NULL,
    `numero_reproduccions` INT DEFAULT 0,
    PRIMARY KEY (`canço_id`),
    FOREIGN KEY (`artista_id`) REFERENCES artista(artista_id),
    FOREIGN KEY (`album_id`) REFERENCES album(album_id)
);

CREATE TABLE `playlist_canço` (
    `usuari_id` INT NOT NULL,
    `playlist_id` INT NOT NULL,
    `canço_id` INT NOT NULL,
    `data_afegida` INT NOT NULL,
    FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
    FOREIGN KEY (`playlist_id`) REFERENCES playlist(playlist_id),
    FOREIGN KEY (`canço_id`) REFERENCES canço(canço_id)
);

CREATE TABLE `usuari_segeix_artista` (
    `usuari_id` INT NOT NULL,
    `artista_id` INT NOT NULL,
    FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
    FOREIGN KEY (`artista_id`) REFERENCES artista(artista_id)
);

CREATE TABLE `artistes_semblants` (
    `artista_id1` INT NOT NULL,
    `artista_id2` INT NOT NULL,
    FOREIGN KEY (`artista_id1`) REFERENCES artista(artista_id),
    FOREIGN KEY (`artista_id2`) REFERENCES artista(artista_id)
);

CREATE TABLE `album_liked` (
    `usuari_id` INT NOT NULL,
    `album_id` INT NOT NULL,
    FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
    FOREIGN KEY (`album_id`) REFERENCES album(album_id)
);

CREATE TABLE `canço_liked` (
    `usuari_id` INT NOT NULL,
    `canço_id` INT NOT NULL,
    FOREIGN KEY (`usuari_id`) REFERENCES usuari(usuari_id),
    FOREIGN KEY (`canço_id`) REFERENCES canço(canço_id)
);