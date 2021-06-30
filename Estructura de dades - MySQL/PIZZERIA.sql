DROP DATABASE IF EXISTS `pizzeria`;
CREATE DATABASE `pizzeria`;
USE `pizzeria`;


CREATE TABLE `provincia` (
	`provincia_id` INT NOT NULL AUTO_INCREMENT,
    `nom` varchar(50) NOT NULL,
    PRIMARY KEY (`provincia_id`)
);

CREATE TABLE `localitat` (
	`localitat_id` INT NOT NULL AUTO_INCREMENT,
    `nom` varchar(50) NOT NULL,
    `provincia_id` INT NOT NULL,
    PRIMARY KEY (`provincia_id`),
    FOREIGN KEY (`provincia_id`) REFERENCES provincia(provincia_id)
);

CREATE TABLE `clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  `cognom` varchar(20) NOT NULL,
  `adreça` varchar(60) NOT NULL,
  `CP` INT NOT NULL,
  `telefon` INT NOT NULL,
  `localitat_id` INT NOT NULL,
  PRIMARY KEY (`client_id`),
  FOREIGN KEY (`localitat_id`) REFERENCES localitat(localitat_id)
);