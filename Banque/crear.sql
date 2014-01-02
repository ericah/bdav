\connect postgres


DROP DATABASE "BDAV";

CREATE DATABASE "BDAV"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default;


\connect BDAV





CREATE TABLE Banque (
  Id_banque   SERIAL NOT NULL, 
  Nom_banque varchar(30) NOT NULL UNIQUE, 
  BIC        varchar(15) NOT NULL UNIQUE, 
  CONSTRAINT PK_banque 
    PRIMARY KEY (Id_banque));


CREATE TABLE Agence (
  Id_Agence        SERIAL NOT NULL, 
  Nom_agence      varchar(30) NOT NULL, 
  BanqueId_banque int4 NOT NULL, 
  PRIMARY KEY (Id_Agence));


ALTER TABLE Agence ADD CONSTRAINT FKAgence FOREIGN KEY (BanqueId_banque) REFERENCES Banque (Id_banque);
 
CREATE TABLE Type_carte (
  Id_Type        SERIAL NOT NULL, 
  Nom_Type          varchar(10) NOT NULL, 
  International int4, 
  Mensualite    int4, 
  PRIMARY KEY (Id_Type));






CREATE TABLE Personne (
  Id_Perso        SERIAL NOT NULL,
  Num_Doc       varchar(10) NOT NULL, 
  Nom            varchar(30) NOT NULL, 
  Prenom         varchar(30) NOT NULL, 
  Date_Naissance date NOT NULL, 
  Etat_civil     char(10) NOT NULL, 
  PRIMARY KEY (Id_Perso));

CREATE TABLE Type_compte (
  Code            SERIAL NOT NULL, 
  nb_personnes   int4 NOT NULL,    
  Et_ou_OU       int4,
  nom_type      varchar(10) NOT NULL,
  PRIMARY KEY (Code));


CREATE TABLE Compte (
  NbCompte        varchar(11) NOT NULL, 
  Solde           int4, 
  Decouvert_Aut   int4, 
  ID_titulaire    int4, 
  Type_compte     int4, 
  IBAN            varchar(255), 
  Id_Agence int4 NOT NULL, 
  PRIMARY KEY (NbCompte));


ALTER TABLE Compte ADD CONSTRAINT FKCompte FOREIGN KEY (Id_Agence) REFERENCES Agence (Id_Agence);
ALTER TABLE Compte ADD CONSTRAINT FKCompte_perso FOREIGN KEY (ID_titulaire) REFERENCES Personne (Id_Perso);
ALTER TABLE Compte ADD CONSTRAINT FKType_compte FOREIGN KEY (Type_compte) REFERENCES  Type_compte (Code);


CREATE TABLE Carte_Bancaire (
  Numero_Carte      varchar(16) NOT NULL, 
  Cle_Sec           int4, 
  Date_validite     date NOT NULL, 
  id_Titulaire      int4 NOT NULL, 
  RPC               char(1) NOT NULL, 
  Plafond           int4 NOT NULL, 
  Type_carte	     int4 NOT NULL, 
  NbCompte    varchar(11) NOT NULL, 
  PRIMARY KEY (Numero_Carte));




ALTER TABLE Carte_Bancaire ADD CONSTRAINT FKCarte_Bank FOREIGN KEY (Type_carte) REFERENCES Type_carte (Id_Type);
ALTER TABLE Carte_Bancaire ADD CONSTRAINT FKCarte_Bank_compte FOREIGN KEY (NbCompte) REFERENCES Compte (NbCompte);



CREATE TABLE Cheque (
  ID_cheque       SERIAL NOT NULL, 
  NbCompte varchar(11) NOT NULL, 
  PRIMARY KEY (ID_cheque));



ALTER TABLE Cheque ADD CONSTRAINT FKCheque FOREIGN KEY (NbCompte) REFERENCES Compte (NbCompte);





CREATE UNIQUE INDEX Compte_NbCompte 
  ON Compte (NbCompte);
CREATE INDEX Agence_Id_Agence 
  ON Agence (Id_Agence);
CREATE INDEX Banque_Id_banque 
  ON Banque (Id_banque);
CREATE INDEX Personne_Id 
  ON Personne (Id_Perso);
CREATE UNIQUE INDEX Carte_Bancaire_Numero_Carte 
  ON Carte_Bancaire (Numero_Carte);
CREATE UNIQUE INDEX Cheque_ID_cheque 
  ON Cheque (ID_cheque);