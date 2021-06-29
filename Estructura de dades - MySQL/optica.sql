DROP DATABASE IF EXISTS `optica`;
CREATE DATABASE `optica`;
USE `optica`;


CREATE TABLE `clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `nom` varchar(50) NOT NULL,
  `cognom` varchar(50) NOT NULL,
  `CP` INT NOT NULL,
  `telefon` INT NOT NULL UNIQUE,
  `email` varchar(50) NOT NULL UNIQUE,
  `data_registre`  DATE NOT NULL,
  `recomanat_per` INT DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  FOREIGN KEY (`client_id`) REFERENCES clients(client_id)
);

CREATE TABLE `proveidor` (
  `proveidor_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `nom` varchar(50) NOT NULL,
  `NIF` varchar(15) NOT NULL UNIQUE,
  `telefon` INT NOT NULL UNIQUE,
  `fax` varchar(15) NOT NULL UNIQUE,
  PRIMARY KEY (`proveidor_id`)
);

CREATE TABLE `proveidor_adreça` (
  `proveidor_id` INT NOT NULL,
  `carrer` varchar(50) NOT NULL,
  `num` INT NOT NULL,
  `pis` varchar(15),
  `porta` varchar(15),
  `ciutat` varchar(20) NOT NULL,
  `CP` INT NOT NULL,
  `pais` varchar(20) NOT NULL,
  FOREIGN KEY (`proveidor_id`) REFERENCES proveidor(proveidor_id)
);

CREATE TABLE `ulleres` (
  `ulleres_id` INT NOT NULL AUTO_INCREMENT,
  `proveidor_id` INT NOT NULL,
  `marca` varchar(20)  NOT NULL,
  `graduació_dreta` varchar(20)  NOT NULL,
  `graruació_esq` varchar(20) NOT NULL,
  `tipus_montura` varchar(20) NOT NULL,
  `color_montura` varchar(20) NOT NULL,
  `color_vidre_dreta` varchar(20)  NOT NULL,
  `color_vidre_esq` varchar(20)  NOT NULL,
  `preu` decimal(6,2) NOT NULL,
  PRIMARY KEY (`ulleres_id`),
  FOREIGN KEY (`proveidor_id`) REFERENCES proveidor(proveidor_id)
);

CREATE TABLE `empleat`(
	`empleat_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `nom` varchar(20),
    PRIMARY KEY (`empleat_id`)
);

CREATE TABLE `venta_ulleres`(
	`venta_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `client_id` iNT NOT NULL,
    `ulleres_id` INT NOT NULL,
    `empleat_id` INT NOT NULL,
    `quantitat` INT NOT NULL,

    PRIMARY KEY (`venta_id`),
    FOREIGN KEY (`client_id`) REFERENCES clients(client_id),
    FOREIGN KEY (`ulleres_id`) REFERENCES ulleres(ulleres_id),
    FOREIGN KEY (`empleat_id`) REFERENCES empleat(empleat_id)
);

INSERT INTO clients(nom, cognom, CP,telefon,email, data_registre)
VALUES ('Bader', 'Tabeche', 08923, 611428921, 'btabeche23@gmail.com', CURRENT_DATE());
INSERT INTO clients(nom, cognom, CP,telefon,email, data_registre, recomanat_per)
VALUES ('Dwight', 'Shrute', 08321, 727881382, 'dwigth@beetfarm.com', CURRENT_DATE(), 1);
INSERT INTO clients(nom, cognom, CP, telefon,email, data_registre, recomanat_per)
VALUES ('Sheldon', 'Cooper', 93213, 628231382, 'sheldon@engineersaredumb.com', CURRENT_DATE(), 1);
INSERT INTO clients(nom, cognom, CP, telefon,email, data_registre, recomanat_per)
VALUES ('Michael', 'Scoot', 08321, 736312393, 'michelScott@thebestbossever.com', CURRENT_DATE(), 2);
INSERT INTO clients(nom, cognom, CP, telefon,email, data_registre, recomanat_per)
VALUES ('Howard', 'Cooper', 93213, 611392322, 'howard@engineersareNOTdumb.com', CURRENT_DATE(), 3);


INSERT INTO proveidor (nom, NIF, telefon, fax)
VALUES ('multioptica', '05220162J', 782066380, 782066381);
INSERT INTO proveidor_adreça(proveidor_id, carrer, num, ciutat, CP, pais)
VALUES( 1, 'PLACETA IGLESIA', 68, 'Cuenca', 16874, 'Espanya');

INSERT INTO proveidor (nom, NIF, telefon, fax)
VALUES ('medop', '15561524T', 656393047, 656393048);
INSERT INTO proveidor_adreça
VALUES(2, 'RAMBLA MAYOR', 58, 2, 1, 'Guadalajara', 19422, 'Espanya');


INSERT INTO ulleres (proveidor_id, marca, graduació_dreta, graruació_esq, tipus_montura, color_montura, color_vidre_dreta, color_vidre_esq, preu)
VALUES(2, 'ojeras', 2, 1, 'acetato', 'verde', 'transparente', 'transparente', 50.99);
INSERT INTO ulleres (proveidor_id, marca, graduació_dreta, graruació_esq, tipus_montura, color_montura, color_vidre_dreta, color_vidre_esq, preu)
VALUES(2, 'ojeras', 3, 4, 'acetato', 'negras', 'transparente', 'transparente', 90.99);
INSERT INTO ulleres (proveidor_id, marca, graduació_dreta, graruació_esq, tipus_montura, color_montura, color_vidre_dreta, color_vidre_esq, preu)
VALUES(1, 'ojo loco', 3, 4, 'metal', 'negras', 'transparente', 'transparente', 120.99);
INSERT INTO ulleres (proveidor_id, marca, graduació_dreta, graruació_esq, tipus_montura, color_montura, color_vidre_dreta, color_vidre_esq, preu)
VALUES(1, 'ojo loco', 2, 2, 'metal', 'azul', 'transparente', 'transparente', 125.99);


INSERT INTO empleat (nom) VALUES('Fran');
INSERT INTO empleat (nom) VALUES('Maya');

INSERT INTO venta_ulleres(client_id, ulleres_id, empleat_id, quantitat)
VALUES(2, 1, 1, 1);
INSERT INTO venta_ulleres(client_id, ulleres_id, empleat_id, quantitat)
VALUES(3, 2, 2, 2);
INSERT INTO venta_ulleres(client_id, ulleres_id, empleat_id, quantitat)
VALUES(5, 4, 1, 1);
INSERT INTO venta_ulleres(client_id, ulleres_id, empleat_id, quantitat)
VALUES(2, 4, 1, 1);
INSERT INTO venta_ulleres(client_id, ulleres_id, empleat_id, quantitat)
VALUES(2, 4, 1, 2);

-- Llista el total de factures d'un client en un període determinat
SELECT nom, cognom, marca, preu * quantitat AS 'preu total' 
FROM clients 
JOIN venta_ulleres 
ON clients.client_id = venta_ulleres.client_id 
JOIN ulleres 
ON venta_ulleres.ulleres_id = ulleres.ulleres_id 
WHERE clients.client_id = 2;
-- Llista els diferents models d'ulleres que ha venut un empleat durant un any
SELECT nom, marca FROM empleat
JOIN venta_ulleres 
ON empleat.empleat_id = venta_ulleres.empleat_id
JOIN ulleres 
ON venta_ulleres.ulleres_id = ulleres.ulleres_id 
WHERE empleat.empleat_id = 1;
-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica
SELECT DISTINCT nom FROM proveidor
JOIN ulleres
ON proveidor.proveidor_id = ulleres.proveidor_id
JOIN venta_ulleres
ON venta_ulleres.ulleres_id = ulleres.ulleres_id;



