DROP DATABASE IF EXISTS `pizzeria`;
CREATE DATABASE `pizzeria`;
USE `pizzeria`;


CREATE TABLE `provincia` (
	`provincia_id` INT NOT NULL AUTO_INCREMENT,
    `nom` varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (`provincia_id`)
);

INSERT INTO `provincia`(nom) VALUES('Barcelona');
INSERT INTO `provincia`(nom) VALUES('Girona');
INSERT INTO `provincia`(nom) VALUES('Lleida');
INSERT INTO `provincia`(nom) VALUES('Tarragona');

CREATE TABLE `localitat` (
	`localitat_id` INT NOT NULL AUTO_INCREMENT,
    `nom` varchar(50) NOT NULL UNIQUE,
    `provincia_id` INT NOT NULL,
    PRIMARY KEY (`localitat_id`),
    FOREIGN KEY (`provincia_id`) REFERENCES provincia(provincia_id)
);

INSERT INTO `localitat`(nom, provincia_id) VALUES('Santa Coloma de Gramenet', 1);
INSERT INTO `localitat`(nom, provincia_id) VALUES('Badalona', 1);
INSERT INTO `localitat`(nom, provincia_id) VALUES('Sant Adrià de Besòs', 1);

CREATE TABLE `clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  `cognom` varchar(20) NOT NULL,
  `adreça` varchar(60) NOT NULL,
  `CP` INT NOT NULL,
  `telefon` INT NOT NULL UNIQUE,
  `localitat_id` INT NOT NULL,
  PRIMARY KEY (`client_id`),
  FOREIGN KEY (`localitat_id`) REFERENCES localitat(localitat_id)
);

INSERT INTO `clients`(nom, cognom, adreça, CP, telefon, localitat_id) VALUES('Bader', 'Tabeche', 'Carrer Torras i bages', 08923, 611428921, 1);
INSERT INTO `clients`(nom, cognom, adreça, CP, telefon, localitat_id) VALUES('Joan', 'Castillo', 'Carrer Irlanda', 08923, 67233213, 1);
INSERT INTO `clients`(nom, cognom, adreça, CP, telefon, localitat_id) VALUES('Mar', 'Vall', 'Carrer Urá', 08532, 67234213, 2);
INSERT INTO `clients`(nom, cognom, adreça, CP, telefon, localitat_id) VALUES('David', 'García', 'Pl. la vila', 08930, 643389613, 3);

CREATE TABLE `botiga` (
  `botiga_id` INT NOT NULL AUTO_INCREMENT,
  `adreça` varchar(50) NOT NULL,
  `localitat_id` INT NOT NULL,
  `CP` INT NOT NULL,
  PRIMARY KEY (`botiga_id`),
  FOREIGN KEY (`localitat_id`) REFERENCES localitat(localitat_id)
);

INSERT INTO botiga(adreça, localitat_id, CP) VALUES ('Carrer Jacint Verdaguer', 1, 08922);
INSERT INTO botiga(adreça, localitat_id, CP) VALUES ('Carrer Ausias March', 2, 08942);
INSERT INTO botiga(adreça, localitat_id, CP) VALUES ('Av. Alfons XII', 3, 08942);

CREATE TABLE `comanda` (
  `comanda_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` varchar(50) NOT NULL,
  `data` DATETIME NOT NULL,
  `hora` TIME NOT NULL,
  `tipus_comanda` ENUM('domicili', 'recollir') NOT NULL,
  `preu` FLOAT(6,2) NOT NULL,
  `botiga_id` INT NOT NULL,
  PRIMARY KEY (`comanda_id`),
  FOREIGN KEY (`botiga_id`) REFERENCES botiga(botiga_id)
);

INSERT INTO comanda(client_id, data, hora, tipus_comanda, preu, botiga_id) VALUES ('1', '2020-06-10', "19:30:10",'domicili', 45.35, 1 );
INSERT INTO comanda(client_id, data, hora, tipus_comanda, preu, botiga_id) VALUES ('2', '2020-06-15', "20:45:12",'domicili', 9.55, 1 );
INSERT INTO comanda(client_id, data, hora, tipus_comanda, preu, botiga_id) VALUES ('2', '2020-06-23', "21:02:43",'domicili', 9.55, 1 );

CREATE TABLE `pizza_categoria` (
  `categoria_id` INT NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (`categoria_id`)
);

INSERT INTO pizza_categoria(nom) VALUES('Napolitana');
INSERT INTO pizza_categoria(nom) VALUES('Margarita');
INSERT INTO pizza_categoria(nom) VALUES('Barbacoa');

CREATE TABLE `producte` (
  `producte_id` INT NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL UNIQUE,
  `categoria_id` INT NULL,
  `descripció` varchar(350) NOT NULL,
  `imatge` varchar(350) NOT NULL,
  `preu` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`producte_id`),
  FOREIGN KEY (`categoria_id`) REFERENCES pizza_categoria(categoria_id)
);

INSERT INTO producte(nom, categoria_id, descripció, imatge, preu) VALUES('Pizza napolitana','1', 'Pizza napolitana', 'imagur.com/pizza-napolitana32', 7.55);
INSERT INTO producte(nom, categoria_id, descripció, imatge, preu) VALUES('Pizza barbacoa','3', 'Pizza barbacoa', 'imagur.com/pizza-barbacoa32', 7.55);
INSERT INTO producte(nom, descripció, imatge, preu) VALUES('Bebida', 'Begudes: Aigua, coca-cola...', 'imagur.com/agua', 2);
INSERT INTO producte(nom, descripció, imatge, preu) VALUES('Hamburgesa', 'Hamburgesa clasica', 'imagur.com/hamuburger', 6.75);


CREATE TABLE `comanda_detalls` (
  `comanda_id` INT NOT NULL,
  `producte_id` INT NOT NULL,
  `quantiat` INT NOT NULL,
  FOREIGN KEY (`comanda_id`) REFERENCES comanda(comanda_id),
  FOREIGN KEY (`producte_id`) REFERENCES producte(producte_id)
);

INSERT INTO `comanda_detalls` VALUES(1, 1, 1);
INSERT INTO `comanda_detalls` VALUES(1, 2, 1);
INSERT INTO `comanda_detalls` VALUES(1, 3, 2);
INSERT INTO `comanda_detalls` VALUES(1, 4, 3);
INSERT INTO `comanda_detalls` VALUES(2, 1, 1);
INSERT INTO `comanda_detalls` VALUES(2, 3, 1);
INSERT INTO `comanda_detalls` VALUES(3, 2, 1);
INSERT INTO `comanda_detalls` VALUES(3, 3, 1);

CREATE TABLE `empleat` (
  `empleat_id` INT NOT NULL AUTO_INCREMENT,
  `botiga_id` INT NOT NULL,
  `nom` varchar(50) NOT NULL,
  `cognom` varchar(50) NOT NULL,
  `NIF` varchar(50) NOT NULL UNIQUE,
  `telefon` INT NOT NULL UNIQUE,
  `tipus` ENUM('repartidor', 'cuiner') NOT NULL,
  PRIMARY KEY (`empleat_id`),
  FOREIGN KEY (`botiga_id`) REFERENCES botiga(botiga_id)
);

INSERT INTO empleat(botiga_id, nom, cognom, NIF, telefon, tipus) VALUES (1, 'Fran', 'Cesc', '54314491A', 611428921, 'repartidor');
INSERT INTO empleat(botiga_id, nom, cognom, NIF, telefon, tipus) VALUES (1, 'Mari', 'Carmen', '54314491B', 611428922, 'cuiner');


CREATE TABLE `repartiment_domicili` (
  `comanda_id` INT NOT NULL,
  `empleat_id` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `hora` TIME NOT NULL,
  FOREIGN KEY (`comanda_id`) REFERENCES comanda(comanda_id),
  FOREIGN KEY (`empleat_id`) REFERENCES empleat(empleat_id)
);

INSERT INTO repartiment_domicili VALUES(1, 1, '2020-06-10', '19:40:02'); 
INSERT INTO repartiment_domicili VALUES(2, 1, '2020-06-15', '20:55:10'); 
INSERT INTO repartiment_domicili VALUES(3, 1, '2020-06-23', '21:15:53'); 


-- Descomenta les consultes

-- SELECT SUM(quantiat) AS 'Begudes venudes: Santa Coloma' FROM comanda
-- JOIN comanda_detalls
-- ON comanda.comanda_id = comanda_detalls.comanda_id
-- WHERE producte_id = 3 AND botiga_id = 1;

-- SELECT COUNT(*) from comanda
-- JOIN repartiment_domicili
-- ON comanda.comanda_id = repartiment_domicili.comanda_id
-- WHERE tipus_comanda = 'domicili' AND empleat_id = 1;
