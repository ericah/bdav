\connect postgres

DROP DATABASE "BDAV";

CREATE DATABASE "BDAV"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default;

\connect BDAV

CREATE TABLE Banque (
  Id_banque   SERIAL NOT NULL, 
  Nom_banque  varchar(30) NOT NULL UNIQUE, 
  BIC         varchar(15) NOT NULL UNIQUE, 
  Actifs      int4 NOT NULL, 
  CONSTRAINT PK_banque 
    PRIMARY KEY (Id_banque));

CREATE TABLE Agence (
  Id_Agence        SERIAL NOT NULL, 
  Nom_agence       varchar(30) NOT NULL, 
  BanqueId_banque  int4 NOT NULL, 
  PRIMARY KEY (Id_Agence));

ALTER TABLE Agence ADD CONSTRAINT FKAgence FOREIGN KEY (BanqueId_banque) REFERENCES Banque (Id_banque);
 
CREATE TABLE Type_carte (
  Id_Type    		SERIAL NOT NULL, 
  Nom_Type   		varchar(10) NOT NULL, 
  International		int4, 
  Mensualite    	int4, 
  PRIMARY KEY (Id_Type));

CREATE TABLE Personne (
  Id_Perso            SERIAL NOT NULL,
  Num_Doc             varchar(12) NOT NULL, 
  Nom                 varchar(30) NOT NULL, 
  Prenom              varchar(30) NOT NULL, 
  Date_Naissance      date NOT NULL, 
  Etat_civil          char(1) NOT NULL, 
  revenues_annuelles  int4, 
  interdit_bancaire   bool,
  PRIMARY KEY (Id_Perso));

CREATE TABLE Type_compte (
  Code            SERIAL NOT NULL, 
  nom_type     	  varchar(25) NOT NULL, 
  unipersonnel 	  bool NOT NULL, 
  tarif_mensuel   int4 NOT NULL,
  PRIMARY KEY (Code));

CREATE TABLE Compte (
  id_compte		SERIAL NOT NULL,  
  NbCompte        	varchar(11) NOT NULL, 
  Solde         	int4 NOT NULL, 
  Decouvert_Aut     	int4 NOT NULL, 
  ID_titulaire       	int4 NOT NULL, 
  Type_compte          	int4 NOT NULL, 
  IBAN                 	varchar(27) NOT NULL, 
  Id_Agence	 	int4 NOT NULL, 
  tolere_depassements	bool NOT NULL,
  taux_annuel 	      	float NOT NULL, 
  PRIMARY KEY (NbCompte));

ALTER TABLE Compte ADD CONSTRAINT FKCompte FOREIGN KEY (Id_Agence) REFERENCES Agence (Id_Agence);
ALTER TABLE Compte ADD CONSTRAINT FKCompte_perso FOREIGN KEY (ID_titulaire) REFERENCES Personne (Id_Perso);
ALTER TABLE Compte ADD CONSTRAINT FKType_compte FOREIGN KEY (Type_compte) REFERENCES  Type_compte (Code);

CREATE TABLE Carte_Bancaire (
  Numero_Carte      varchar(16) NOT NULL, 
  Cle_Sec           char(3) NOT NULL, 
  Date_validite     varchar(6) NOT NULL, 
  id_Titulaire      int4 NOT NULL, 
  RPC               char(1) NOT NULL, 
  Plafond           int4 NOT NULL, 
  Type_carte	    int4 NOT NULL, 
  NbCompte    	    varchar(11) NOT NULL, 
  PRIMARY KEY (Numero_Carte));

ALTER TABLE Carte_Bancaire ADD CONSTRAINT FKCarte_Bank FOREIGN KEY (Type_carte) REFERENCES Type_carte (Id_Type);
ALTER TABLE Carte_Bancaire ADD CONSTRAINT FKCarte_Bank_compte FOREIGN KEY (NbCompte) REFERENCES Compte (NbCompte);

CREATE TABLE nature_trans (
  id_nature   SERIAL NOT NULL, 
  Nom_nature  varchar(25) NOT NULL, 
  PRIMARY KEY (id_nature));

CREATE TABLE debits (
  id_debit     SERIAL NOT NULL, 
  Nbcompte     varchar(11) NOT NULL, 
  Nature       int4 NOT NULL, 
  commentaires varchar(255), 
  PRIMARY KEY (id_debit));

ALTER TABLE debits ADD CONSTRAINT FKdebits_compte FOREIGN KEY (Nbcompte) REFERENCES Compte (NbCompte);
ALTER TABLE debits ADD CONSTRAINT FKdebitsNat FOREIGN KEY (Nature) REFERENCES nature_trans (id_nature);

CREATE TABLE comptes_joints (
  id_compte_joint    SERIAL NOT NULL,     
  NbCompte	     varchar(11) NOT NULL, 
  id_2eme_personne   int4, 
  procuration        bool, 
  responsable_unique bool, 
  Et_ou_OU           bool,  
  PRIMARY KEY (id_compte_joint));

ALTER TABLE comptes_joints ADD CONSTRAINT FKcomptes_jo FOREIGN KEY (NbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE comptes_joints ADD CONSTRAINT FKcomptes_joints FOREIGN KEY (id_2eme_personne) REFERENCES Personne (Id_Perso);

CREATE TABLE Tiers(
  Id_tiers        int4 NOT NULL, 
  rib_tiers       varchar(23) NOT NULL, 
  CompteNbCompte  varchar(11) NOT NULL, 
  PRIMARY KEY (Id_tiers));

ALTER TABLE Tiers ADD CONSTRAINT FKTiers FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);

CREATE TABLE Interdiction_bancaire (
  id_interd		SERIAL NOT NULL, 
  id_client            	int4 NOT NULL, 
  date_interdit        	date NOT NULL,
  date_regularisation  	date, 
  PRIMARY KEY (id_interd));

ALTER TABLE Interdiction_bancaire ADD CONSTRAINT FKInterdicti FOREIGN KEY (id_client) REFERENCES Personne (Id_Perso);

CREATE TABLE periodicite (
  id_periode 		SERIAL NOT NULL, 
  nom_per               varchar(25) NOT NULL, 
  NbJours               int4,
  PRIMARY KEY (id_periode));

CREATE TABLE transactions (
  id_vire        int4 NOT NULL, 
  unitaire       bool NOT NULL, 
  montant        int4 NOT NULL, 
  date_virement  TIMESTAMP NOT NULL, 
  date_effect    date NOT NULL, 
  flux           char(1) NOT NULL, 
  periodicite    int4 NOT NULL, 
  Id_tiers  	 int4, 
  nature_trans   int4 NOT NULL, 
  ID_cheque      int4, 
  transactions	 varchar(16),
  PRIMARY KEY (id_vire));
 
ALTER TABLE Virements ADD CONSTRAINT FKVirementsPeriodicite FOREIGN KEY (periodicite) REFERENCES periodicite (id_periode);
ALTER TABLE Virements ADD CONSTRAINT FKVirementTiers FOREIGN KEY (Id_tiers) REFERENCES Tiers (Id_tiers);
ALTER TABLE Virements ADD CONSTRAINT FKVirementsNat FOREIGN KEY (nature_trans) REFERENCES nature_trans (id_nature);

CREATE TABLE Cheque (
  ID_cheque       SERIAL NOT NULL, 
  NbCompte 	  varchar(11) NOT NULL, 
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

CREATE TABLE parametres (
  id_para  SERIAL NOT NULL, 
  nom_para varchar(25) NOT NULL unique, 
  valeur   int4 NOT NULL, 
  PRIMARY KEY (id_para));
