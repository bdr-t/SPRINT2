DROP DATABASE IF EXISTS `optica`;
CREATE DATABASE `optica`;
USE `optica`;


CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `CP` int(5) NOT NULL,
  `telefon` int(14) NOT NULL,
  `email` varchar(50) NOT NULL,
  `data_registre` DATE NOT NULL,
  PRIMARY KEY (`client_id`)
);

CREATE TABLE `proveidor` (
  `proveidor_id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `NIF` varchar(15) NOT NULL,
  `telefon` int(14) NOT NULL,
  `fax` varchar(15) NOT NULL,
  PRIMARY KEY (`proveidor_id`)
);

CREATE TABLE `proveidor_adreça` (
  `proveidor_id` int(11) NOT NULL AUTO_INCREMENT,
  `carrer` varchar(50) NOT NULL,
  `num` int(10) NOT NULL,
  `pis` varchar(15) NOT NULL,
  `porta` varchar(15) NOT NULL,
  `ciutat` varchar(20) NOT NULL,
  `CP` int(5) NOT NULL,
  `pais` varchar(20) NOT NULL,
  FOREIGN KEY (`proveidor_id`) REFERENCES proveidor(proveidor_id)
);

CREATE TABLE `ulleres` (
  `ulleres_id` int(11) NOT NULL AUTO_INCREMENT,
  `proveidor_id` int(11) NOT NULL,
  `marca` varchar(20)  NOT NULL,
  `graduació_dreta` varchar(20)  NOT NULL,
  `graruació_esq` varchar(20) NOT NULL,
  `tipus_montura` varchar(20) NOT NULL,
  `color_montura` varchar(20) NOT NULL,
  `color_vidre_dreta` varchar(20)  NOT NULL,
  `color_vidre_esq` varchar(20)  NOT NULL,
  `preu` decimal(4,2) NOT NULL,
  PRIMARY KEY (`ulleres_id`),
  FOREIGN KEY (`proveidor_id`) REFERENCES proveidor(proveidor_id)
);

CREATE TABLE `empleat`(
	`empleat_id` int(11) NOT NULL AUTO_INCREMENT,
    `nom` varchar(20),
    PRIMARY KEY (`empleat_id`)
);

CREATE TABLE `ulleres_venudes`(
	`ullera_venuda_id` int(11) NOT NULL AUTO_INCREMENT,
    `client_id` int(11) NOT NULL,
    `ulleres_id` int(11) NOT NULL,
    `empleat_id` int(11) NOT NULL,
    `recomendador_id` int(11) NOT NULL,
    `quantitat` int(5) NOT NULL,
    PRIMARY KEY (`ullera_venuda_id`),
    FOREIGN KEY (`client_id`) REFERENCES clients(client_id),
    FOREIGN KEY (`ulleres_id`) REFERENCES ulleres(ulleres_id),
    FOREIGN KEY (`empleat_id`) REFERENCES empleat(empleat_id),
    FOREIGN KEY (`recomendador_id`) REFERENCES clients(client_id)
)