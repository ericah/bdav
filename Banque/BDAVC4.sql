CREATE SEQUENCE seq_periodicite;
CREATE SEQUENCE seq_Virements;
CREATE SEQUENCE seq_Beneficiaires_;
CREATE SEQUENCE seq_parametres;
CREATE TABLE periodicite (
  id_periode            int4 NOT NULL, 
  nom_per               varchar(25) NOT NULL, 
  temps                 timestamp, 
  periodiciteid_periode int4 NOT NULL, 
  PRIMARY KEY (id_periode));
CREATE TABLE Virements (
  id_vire        int4 NOT NULL, 
  unitaire       bool NOT NULL, 
  montant        int4 NOT NULL, 
  "date"         timestamp NOT NULL, 
  date_effect    timestamp NOT NULL, 
  periodicite    int4 NOT NULL, 
  CompteNbCompte varchar(10) NOT NULL, 
  PRIMARY KEY (id_vire));
CREATE TABLE "Beneficiaires " (
  Id_bene        int4 NOT NULL, 
  rib_bene       varchar(15) NOT NULL, 
  CompteNbCompte varchar(10) NOT NULL, 
  PRIMARY KEY (Id_bene));
CREATE TABLE parametres (
  id_para  int4 NOT NULL, 
  nom_para varchar(25) NOT NULL, 
  valeur   int4 NOT NULL, 
  PRIMARY KEY (id_para));
CREATE TABLE comptes_joints (
  id_compte          varchar(10) NOT NULL, 
  id_personne        varchar(10), 
  procuration        bool, 
  responsable_unique bool, 
  Et_ou_OU           bool, 
  PRIMARY KEY (id_compte));
CREATE TABLE nature_debit (
  id_nature   SERIAL NOT NULL, 
  Nom_nature varchar(25) NOT NULL, 
  PRIMARY KEY (id_nature));
CREATE TABLE debits (
  id_debit      SERIAL NOT NULL, 
  Nbcompte     varchar(10) NOT NULL, 
  Nature       int4 NOT NULL, 
  commentaires varchar(255), 
  PRIMARY KEY (id_debit));
CREATE TABLE Type_compte (
  Code          SERIAL NOT NULL, 
  nom_type     varchar(25), 
  unipersonnel bool, 
  PRIMARY KEY (Code));
CREATE TABLE Cheque (
  ID_cheque       SERIAL NOT NULL, 
  CompteNbCompte varchar(10) NOT NULL, 
  PRIMARY KEY (ID_cheque));
CREATE TABLE Carte_Bancaire (
  Numero_Carte      varchar(16) NOT NULL, 
  Clé_Sec           int4, 
  Date_validité     date NOT NULL, 
  id_Titulaire      int4 NOT NULL, 
  RPC               char(1) NOT NULL, 
  Plafond           int4 NOT NULL, 
  Type_carteId_Type int4 NOT NULL, 
  CompteNbCompte    varchar(10) NOT NULL, 
  PRIMARY KEY (Numero_Carte));
CREATE TABLE Personne (
  Nb_Doc_Id           SERIAL NOT NULL, 
  Nom                varchar(30) NOT NULL, 
  Prenom             varchar(30) NOT NULL, 
  Date_Naissance     date NOT NULL, 
  Etat_civil         char(30) NOT NULL, 
  CompteNbCompte     varchar(10) NOT NULL, 
  revenues_annuelles int4, 
  Interdit_bancaire  bool, 
  PRIMARY KEY (Nb_Doc_Id));
CREATE TABLE Type_carte (
  Id_Type        SERIAL NOT NULL, 
  Type          varchar(10) NOT NULL, 
  International int4, 
  Mensualité    int4, 
  PRIMARY KEY (Id_Type));
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
CREATE TABLE Compte (
  NbCompte            varchar(10) NOT NULL, 
  Solde               int4, 
  Decouvert_Aut       int4, 
  ID_titulaire        int4 NOT NULL, 
  Type_compte         int4 NOT NULL, 
  IBAN                varchar(255), 
  AgenceId_Agence     int4 NOT NULL, 
  tolere_depassements bool NOT NULL, 
  CompteNbCompte      varchar(10) NOT NULL, 
  PRIMARY KEY (NbCompte));
CREATE TABLE Interdiction_bancaire (
  id_interd      SERIAL NOT NULL, 
  id_client     int4 NOT NULL, 
  date_interdit timestamp NOT NULL, 
  PRIMARY KEY (id_interd));


ALTER TABLE Tiers ADD CONSTRAINT FKTiers777107 FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Virements ADD CONSTRAINT FKVirements399577 FOREIGN KEY (periodicite) REFERENCES periodicite (id_periode);
ALTER TABLE Virements ADD CONSTRAINT FKVirements905386 FOREIGN KEY (TiersId_tiers) REFERENCES Tiers (Id_tiers);
ALTER TABLE debits ADD CONSTRAINT FKdebits16045 FOREIGN KEY (Nbcompte) REFERENCES Compte (NbCompte);
ALTER TABLE debits ADD CONSTRAINT FKdebits673429 FOREIGN KEY (Nature) REFERENCES nature_debit (id_nature);
ALTER TABLE comptes_joints ADD CONSTRAINT FKcomptes_jo782460 FOREIGN KEY (id_compte) REFERENCES Compte (NbCompte);
ALTER TABLE Compte ADD CONSTRAINT FKCompte198434 FOREIGN KEY (Type_compte) REFERENCES Type_compte (Code);
ALTER TABLE Carte_Bancaire ADD CONSTRAINT a FOREIGN KEY (Type_carte) REFERENCES Type_carte (Id_Type);
ALTER TABLE Carte_Bancaire ADD CONSTRAINT FKCarte_Banc714693 FOREIGN KEY (NbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Cheque ADD CONSTRAINT FKCheque676562 FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Agence ADD CONSTRAINT FKAgence868298 FOREIGN KEY (BanqueId_banque) REFERENCES Banque (Id_banque);
ALTER TABLE Compte ADD CONSTRAINT FKCompte761980 FOREIGN KEY (AgenceId_Agence) REFERENCES Agence (Id_Agence);
ALTER TABLE Interdiction_bancaire ADD CONSTRAINT FKInterdicti447170 FOREIGN KEY (id_client) REFERENCES Personne (Id_Perso);


CREATE UNIQUE INDEX Cheque_ID_cheque 
  ON Cheque (ID_cheque);
CREATE UNIQUE INDEX Carte_Bancaire_Numero_Carte 
  ON Carte_Bancaire (Numero_Carte);
CREATE INDEX Personne_Date_Naissance 
  ON Personne (Date_Naissance);
CREATE INDEX Banque_Id_banque 
  ON Banque (Id_banque);
CREATE INDEX Agence_Id_Agence 
  ON Agence (Id_Agence);
CREATE UNIQUE INDEX Compte_NbCompte 
  ON Compte (NbCompte);




	SELECT   max(id_Compte))
	FROM compte;
	

SELECT CONCAT(, CAST(id_agence AS varchar(5))) FROM agence WHERE nom_agence= 'FirstAgenceFstBK';


SELECT creer_num_compte();


select * from parametres;