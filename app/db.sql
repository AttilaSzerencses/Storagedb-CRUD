DROP DATABASE IF EXISTS raktar;
CREATE DATABASE raktar CHARACTER SET utf8 COLLATE utf8_hungarian_ci;


CREATE TABLE aru(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nev VARCHAR(100) NOT NULL,
	egysegar INT NOT NULL,
	mennyiseg INT NOT NULL
);

CREATE TABLE atvevo(
	id INT PRIMARY KEY AUTO_INCREMENT,
	vezeteknev VARCHAR(100) NOT NULL,
	keresztnev VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	telefonszam VARCHAR(100) NOT NULL
);

CREATE TABLE beszallito(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nev VARCHAR(100),
	telefonszam VARCHAR(100) NOT NULL

);

CREATE TABLE kiadas(
	id INT PRIMARY KEY AUTO_INCREMENT,
	termeknev VARCHAR(100) NOT NULL,
	mennyiseg INT NOT NULL,
	datum VARCHAR(100) 	NOT NULL,
	atvevo_id INT,
	CONSTRAINT fkatvevoid 
		FOREIGN KEY (atvevo_id) 
		REFERENCES atvevo(id) 
		ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE behozatal(
	id INT PRIMARY KEY AUTO_INCREMENT,
	termeknev VARCHAR(100) NOT NULL,
	mennyiseg INT NOT NULL,
	egysegar INT NOT NULL,
	beszallito_id INT,
	CONSTRAINT fkbeszallito_id 
		FOREIGN KEY (beszallito_id) 
			REFERENCES beszallito(id)
				ON UPDATE CASCADE ON DELETE CASCADE 

);

CREATE TABLE stored_kiadas(
	id INT PRIMARY KEY AUTO_INCREMENT,
	termeknev VARCHAR(100) NOT NULL,
	mennyiseg INT NOT NULL,
	datum VARCHAR(100) 	NOT NULL,
	satvevo_id INT
	

);

CREATE TABLE stored_behozatal(
	id INT PRIMARY KEY AUTO_INCREMENT,
	termeknev VARCHAR(100) NOT NULL,
	mennyiseg INT NOT NULL,
	egysegar INT NOT NULL,
	sbeszallito_id INT

);

CREATE TABLE helyszin(
	id INT PRIMARY KEY AUTO_INCREMENT,
	hatvevo_id INT NOT NULL,
	iranyitoszam INT NOT NULL,
	telepules VARCHAR(100) NOT NULL,
	utca VARCHAR(100) NOT NULL,
	hazszam INT NOT NULL,
	egyeb VARCHAR(100),
	CONSTRAINT fkhatvevo_id
		FOREIGN KEY(hatvevo_id) 
			REFERENCES atvevo(id)
				ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('1','Alma','200','50');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('2','Csiga tészta','300','30');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('3','Kenyér','350','70');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('4','Coca Cola','250','80');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('5','Tojás','30','200');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('6','Liszt','190','100');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('7','Cukor','265','150');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('8','Kávé','800','65');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('9','Milka csoki','310','400');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('10','Wc papír','900','50');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('11','Zsebkendő','190','120');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('12','Répa','300','130');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('13','Babkonzerv','250','200');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('14','Vajkrém','400','75');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('15','Túró','375','45');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('16','Felvágott','255','250');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('17','Kutyakonzerv','340','120');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('18','Fogkrém','380','200');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('19','Kukászsák','330','270');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('20','Mosópor','1700','150');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('21','Almalé','285','80');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('22','Sajt','2100','50');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('23','Tej','200','300');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('24','Chips','300','125');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('25','Eper lekvár','850','45');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('26','Kókuszreszelék','195','120');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('27','Rizs','250','380');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('28','Kakaó','1250','60');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('29','Energia ital','170','420');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('30','Szájvíz','1400','60');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('31','Bögre','500','30');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('32','Fakanál','450','45');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('33','Füzet','230','300');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('34','Ceruza elem','600','50');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('35','Fanta','300','180');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('36','Tea','380','120');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('37','Kolbász','2100','70');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('38','Csirkemell','1500','80');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('39','Füstölő','280','60');
INSERT INTO aru (id, nev, egysegar, mennyiseg) VALUES ('40','Táska','150','500');

INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('1','Szerencsés', 'Attila', 'szerencses.attila.06@gmail.com','06201221221');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('2','Orsós','Attila','orsosattila@gmail.com','06302456754');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('3','Király','Károly','kiralykaroly@gmail.com','06703452154');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('4','Halász','Dominik','halaszdominik@gmail.com','06304526347');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('5','Papp','Dávid','pappdavid@gmail.com','06205647263');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('6','Balogh','Bálint','baloghbalint@gmail.com','06304556721');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('7','Szücs','Dániel','szucsdaniel@gmail.com','06204568723');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('8','Szőke','Krisztián','szokekrisztian@gmail.com','06309824631');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('9','Fábián','Béla','fabianbela@gmail.com','06709134672');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('10','Gulyás','Zsolt','gulyaszsolt@gmail.com','06706423841');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('11','Fehér','Kornél','feherkornel@gmail.com','06304614753');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('12','Illés','Adrián','illesadrian@gmail.com','06209723412');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('13','Kende','Erik','kendeerik@gmail.com','06301951378');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('14','Csatár','Csongor','csatarcsongor@gmail.com','06706154726');
INSERT INTO atvevo (id, vezeteknev, keresztnev, email, telefonszam) VALUES ('15','Szőke','Éva','szokeeva@gmail.com','06204981345');

INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('1', '1', '5948', 'Kaszaper', 'Kiss Péter utca', '43', '');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('2','2','3511','Miskolc','Dózsa György utca','25','2. em 9. ajtó');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('3','3','3261','Abasár','Erzsébet tér','35','');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('4','4','6111','Gátér','Király utca','83','');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('5','5','1077','Budapest','Csabai kapu','10','6. em 17. ajtó');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('6','6','8973','Alsószenterzsébet','Nyár utca','98','');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('7','7','4405','Nyíregyháza','Budaörsi út','43','1.em 2. ajtó');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('8','8','8831','Nagykanizsa','Kálmán Imre utca','15','');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('9','9','1112','Budapest','Teréz krt.','43','7.em 56. ajtó');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('10','10','2822','Szomor','Munkácsy Mihály út','35','');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('11','11','9021','Győr','Bécsi utca','23','5.em 24-es ajtó');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('12','12','4731','Tunyogmatolcs','Kálmán Imre utca','91','');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('13','13','4565','Pusztadobos','Bem rakpart','77','');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('14','14','4029','Debrecen','Hegyalja út','97','3.em 11-es ajtó');
INSERT INTO helyszin(id, hatvevo_id, iranyitoszam, telepules, utca, hazszam, egyeb) VALUES ('15','15','4731','Tunyogmatolcs','Bem utca','33','');

INSERT INTO beszallito(id, nev, telefonszam) VALUES ('1', 'Kisker Beszállító kft.', '06201679423');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('2', 'Központi Ellátó kft.', '06304578239');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('3', 'Ludasi ellátmány kft.','06704267531');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('4', 'Szemerey kft.','06204972346');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('5', 'Kiss és Kiss KFT.','06705972154');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('6', 'Bartó és társa kft.','06304872643');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('7', 'Lentői ellátó kft.','06209134672');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('8', 'Nagy és társa kft.','06704975314');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('9', 'Lenti szállítmányozó kft.','06307523146');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('10', 'Arunagyker kft.','06209512647');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('11','Besenyő áru kft.','06705416432');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('12','Mártoni ellátmányozó kft.','06309413476');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('13','Debreceni ellátó kft.','06209134624');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('14','Fővárosi beszállító kft.','06708916732');
INSERT INTO beszallito(id, nev, telefonszam) VALUES ('15','Viharsarki áru kft.','06309512439');


INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('1','Alma','200','50','1');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('2','Fogkrém','380','200','2');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('3','Szájvíz','60','1400','3');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('4','Rizs','250','380','4');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('5','Répa','300','130','5');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('6','Táska','500','150','6');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('7','Füstölő','280','60','7'); 
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('8','Túró','375','45','8');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('9','Mosópor','1700','150','9');
INSERT INTO stored_behozatal(id, termeknev, mennyiseg, egysegar, sbeszallito_id) VALUES ('10','Tej','200','300','10');

INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('1','Fokhagyma','2','2021-11-11','1');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('2','Tej','10','2021-11-15','2');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('3','Vajkrém','1','2021-11-16','3');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('4','Chips','5','2021-11-17','4');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('5','Tojás','30','2021-11-18','5');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('6','Alma','10','2021-11-19','6');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('7','Fakanál','1','2021-11-20','7');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('8','Energia ital','5','2021-11-20','8');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('9','Füzet','10','2021-11-22','9');
INSERT INTO stored_kiadas(id, termeknev, mennyiseg, datum, satvevo_id) VALUES ('10','Sajt','2','2021-11-22','10');