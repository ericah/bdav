
CREATE TABLE Type_carte (
  Id_Type        SERIAL NOT NULL, 
  Type          varchar(10) NOT NULL, 
  International int4, 
  Mensualite    int4, 
  PRIMARY KEY (Id_Type));


CREATE TABLE Carte_Bancaire (
  Numero_Carte      varchar(16) NOT NULL, 
  Cle_Sec           int4, 
  Date_validite     date NOT NULL, 
  id_Titulaire      int4 NOT NULL, 
  RPC               char(1) NOT NULL, 
  Plafond           int4 NOT NULL, 
  Type_carteId_Type int4 NOT NULL, 
  CompteNbCompte    varchar(10) NOT NULL, 
  PRIMARY KEY (Numero_Carte));

CREATE TABLE Compte (
  NbCompte        varchar(10) NOT NULL, 
  Solde           int4, 
  Decouvert_Aut   int4, 
  ID_titulaire    int4, 
  Type_compte     int4, 
  IBAN            varchar(255), 
  AgenceId_Agence int4 NOT NULL, 
  PRIMARY KEY (NbCompte));
CREATE TABLE Agence (
  Id_Agence        SERIAL NOT NULL, 
  Nom_agence      varchar(30) NOT NULL, 
  BanqueId_banque int4 NOT NULL, 
  PRIMARY KEY (Id_Agence));
CREATE TABLE Banque (
  Id_banque   SERIAL NOT NULL, 
  Nom_banque varchar(30) NOT NULL UNIQUE, 
  BIC        varchar(15) NOT NULL UNIQUE, 
  CONSTRAINT PK_banque 
    PRIMARY KEY (Id_banque));

CREATE TABLE Personne (
  Nb_Doc_Id       SERIAL NOT NULL, 
  Nom            varchar(30) NOT NULL, 
  Prenom         varchar(30) NOT NULL, 
  Date_Naissance date NOT NULL, 
  Etat_civil     char(30) NOT NULL, 
  CompteNbCompte varchar(10) NOT NULL, 
  PRIMARY KEY (Nb_Doc_Id));
CREATE TABLE Carte_Bancaire (
  Numero_Carte      varchar(16) NOT NULL, 
  Cle_Sec           int4, 
  Date_validite     date NOT NULL, 
  id_Titulaire      int4 NOT NULL, 
  RPC               char(1) NOT NULL, 
  Plafond           int4 NOT NULL, 
  Type_carteId_Type int4 NOT NULL, 
  CompteNbCompte    varchar(10) NOT NULL, 
  PRIMARY KEY (Numero_Carte));
CREATE TABLE Cheque (
  ID_cheque       SERIAL NOT NULL, 
  CompteNbCompte varchar(10) NOT NULL, 
  PRIMARY KEY (ID_cheque));
CREATE TABLE Type_compte (
  Code            SERIAL NOT NULL, 
  nb_personnes   int4 NOT NULL, 
  Et_ou_OU       int4,
  nom_type      varchar(10) NOT NULL,
  PRIMARY KEY (Code));
ALTER TABLE Carte_Bancaire ADD CONSTRAINT a FOREIGN KEY (Type_carteId_Type) REFERENCES Type_carte (Id_Type);
ALTER TABLE Carte_Bancaire ADD CONSTRAINT FKCarte_Banc378269 FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Cheque ADD CONSTRAINT FKCheque676562 FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Agence ADD CONSTRAINT FKAgence868298 FOREIGN KEY (BanqueId_banque) REFERENCES Banque (Id_banque);
ALTER TABLE Compte ADD CONSTRAINT FKCompte761980 FOREIGN KEY (AgenceId_Agence) REFERENCES Agence (Id_Agence);
ALTER TABLE Type_compte ADD CONSTRAINT FKType_compt979275 FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Personne ADD CONSTRAINT FKPersonne781753 FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);
CREATE UNIQUE INDEX Compte_NbCompte 
  ON Compte (NbCompte);
CREATE INDEX Agence_Id_Agence 
  ON Agence (Id_Agence);
CREATE INDEX Banque_Id_banque 
  ON Banque (Id_banque);
CREATE INDEX Personne_Date_Naissance 
  ON Personne (Date_Naissance);
CREATE UNIQUE INDEX Carte_Bancaire_Numero_Carte 
  ON Carte_Bancaire (Numero_Carte);
CREATE UNIQUE INDEX Cheque_ID_cheque 
  ON Cheque (ID_cheque);

--modifier relation type compte