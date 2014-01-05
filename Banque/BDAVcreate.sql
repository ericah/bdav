CREATE SEQUENCE seq_periodicite;
CREATE SEQUENCE seq_Virements;
CREATE SEQUENCE seq_Tiers;
CREATE SEQUENCE seq_parametres;
CREATE TABLE periodicite (
  id_periode int4 NOT NULL, 
  nom_per    varchar(25) NOT NULL, 
  NbJours    int4, 
  PRIMARY KEY (id_periode));
CREATE TABLE Virements (
  id_vire       int4 NOT NULL, 
  unitaire      bool NOT NULL, 
  montant       int4 NOT NULL, 
  date_virement date NOT NULL, 
  date_effect   date NOT NULL, 
  flux          char(1) NOT NULL, 
  periodicite   int4 NOT NULL, 
  TiersId_tiers int4 NOT NULL, 
  nature_trans  int4 NOT NULL, 
  ID_cheque     int4, 
  PRIMARY KEY (id_vire));
CREATE TABLE Tiers (
  Id_tiers       int4 NOT NULL, 
  RIB_tiers      varchar(23) NOT NULL, 
  CompteNbCompte varchar(11) NOT NULL, 
  PRIMARY KEY (Id_tiers));
CREATE TABLE parametres (
  id_para  int4 NOT NULL, 
  nom_para varchar(25) NOT NULL, 
  valeur   int4 NOT NULL, 
  PRIMARY KEY (id_para));
CREATE TABLE comptes_joints (
  id_compte           varchar(11) NOT NULL, 
  id_2eme_personne    int4 NOT NULL, 
  procuration         bool, 
  responsable_unique  bool, 
  Et_ou_OU            bool, 
  CompteDecouvert_Aut int4 NOT NULL, 
  PRIMARY KEY (id_compte));
CREATE TABLE nature_trans (
  id_nature   SERIAL NOT NULL, 
  Nom_nature varchar(25) NOT NULL, 
  PRIMARY KEY (id_nature));
CREATE TABLE debits (
  id_debit      SERIAL NOT NULL, 
  commentaires varchar(255), 
  Nbcompte     varchar(11) NOT NULL, 
  Nature       int4 NOT NULL, 
  PRIMARY KEY (id_debit));
CREATE TABLE Type_compte (
  Code           SERIAL NOT NULL, 
  nom_type      varchar(25) NOT NULL, 
  unipersonnel  bool NOT NULL, 
  tarif_mensuel int4 NOT NULL, 
  PRIMARY KEY (Code));
CREATE TABLE Cheque (
  ID_cheque  SERIAL NOT NULL, 
  NbCompte  varchar(11) NOT NULL, 
  PRIMARY KEY (ID_cheque));
CREATE TABLE Carte_Bancaire (
  Numero_Carte  varchar(16) NOT NULL, 
  Clé_Sec       char(3) NOT NULL, 
  Date_validité date NOT NULL, 
  id_Titulaire  int4 NOT NULL, 
  RPC           char(1) NOT NULL, 
  Plafond       int4 NOT NULL, 
  Type_carte    int4 NOT NULL, 
  NbCompte      varchar(11) NOT NULL, 
  PRIMARY KEY (Numero_Carte));
CREATE TABLE Personne (
  Id_Perso            SERIAL NOT NULL, 
  Num_Doc            varchar(12) NOT NULL, 
  Nom                varchar(30) NOT NULL, 
  Prenom             varchar(30) NOT NULL, 
  Date_Naissance     date NOT NULL, 
  Etat_civil         char(1) NOT NULL, 
  revenues_annuelles int4, 
  Interdit_bancaire  bool, 
  PRIMARY KEY (Id_Perso));
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
  Actifs     int4 NOT NULL, 
  CONSTRAINT PK_banque 
    PRIMARY KEY (Id_banque));
CREATE TABLE Agence (
  Id_Agence        SERIAL NOT NULL, 
  Nom_agence      varchar(30) NOT NULL, 
  BanqueId_banque int4 NOT NULL, 
  PRIMARY KEY (Id_Agence));
CREATE TABLE Compte (
  NbCompte            varchar(11) NOT NULL, 
  id_compte           int4 NOT NULL, 
  Solde               int4 NOT NULL, 
  Decouvert_Aut       int4 NOT NULL, 
  IBAN                varchar(27) NOT NULL, 
  tolere_depassements bool NOT NULL, 
  taux_annuel         int4 NOT NULL, 
  ID_titulaire        int4 NOT NULL, 
  Type_compte         int4 NOT NULL, 
  AgenceId_Agence     int4 NOT NULL, 
  PRIMARY KEY (NbCompte));
CREATE TABLE Interdiction_bancaire (
  id_interd            SERIAL NOT NULL, 
  id_client           int4 NOT NULL, 
  date_interdit       date NOT NULL, 
  date_regularisation date, 
  PRIMARY KEY (id_interd));
ALTER TABLE Virements ADD CONSTRAINT FKVirements399577 FOREIGN KEY (periodicite) REFERENCES periodicite (id_periode);
ALTER TABLE Virements ADD CONSTRAINT FKVirements905386 FOREIGN KEY (TiersId_tiers) REFERENCES Tiers (Id_tiers);
ALTER TABLE debits ADD CONSTRAINT FKdebits16045 FOREIGN KEY (Nbcompte) REFERENCES Compte (NbCompte);
ALTER TABLE debits ADD CONSTRAINT FKdebits510602 FOREIGN KEY (Nature) REFERENCES nature_trans (id_nature);
ALTER TABLE Tiers ADD CONSTRAINT FKTiers777107 FOREIGN KEY (CompteNbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE comptes_joints ADD CONSTRAINT FKcomptes_jo782460 FOREIGN KEY (id_compte) REFERENCES Compte (NbCompte);
ALTER TABLE Compte ADD CONSTRAINT FKCompte198434 FOREIGN KEY (Type_compte) REFERENCES Type_compte (Code);
ALTER TABLE Carte_Bancaire ADD CONSTRAINT a FOREIGN KEY (Type_carte) REFERENCES Type_carte (Id_Type);
ALTER TABLE Carte_Bancaire ADD CONSTRAINT FKCarte_Banc714693 FOREIGN KEY (NbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Agence ADD CONSTRAINT FKAgence868298 FOREIGN KEY (BanqueId_banque) REFERENCES Banque (Id_banque);
ALTER TABLE Compte ADD CONSTRAINT FKCompte761980 FOREIGN KEY (AgenceId_Agence) REFERENCES Agence (Id_Agence);
ALTER TABLE Interdiction_bancaire ADD CONSTRAINT FKInterdicti447170 FOREIGN KEY (id_client) REFERENCES Personne (Id_Perso);
ALTER TABLE Compte ADD CONSTRAINT FKCompte107261 FOREIGN KEY (ID_titulaire) REFERENCES Personne (Id_Perso);
ALTER TABLE comptes_joints ADD CONSTRAINT FKcomptes_jo842916 FOREIGN KEY (id_2eme_personne) REFERENCES Personne (Id_Perso);
ALTER TABLE Cheque ADD CONSTRAINT FKCheque12987 FOREIGN KEY (NbCompte) REFERENCES Compte (NbCompte);
ALTER TABLE Virements ADD CONSTRAINT FKVirements679186 FOREIGN KEY (nature_trans) REFERENCES nature_trans (id_nature);
CREATE UNIQUE INDEX Cheque_ID_cheque 
  ON Cheque (ID_cheque);
CREATE UNIQUE INDEX Carte_Bancaire_Numero_Carte 
  ON Carte_Bancaire (Numero_Carte);
CREATE INDEX Personne_Date_Naissance 
  ON Personne (Date_Naissance);
CREATE UNIQUE INDEX Banque_Id_banque 
  ON Banque (Id_banque);
CREATE INDEX Agence_Id_Agence 
  ON Agence (Id_Agence);
CREATE UNIQUE INDEX Compte_NbCompte 
  ON Compte (NbCompte);



select get_banque ('12345678');


SELECT 
  compte.id_compte
FROM 
  public.compte, 
  public.agence, 
  public.banque
WHERE 
  compte.id_agence = agence.id_agence AND
  agence.banqueid_banque = banque.id_banque;


DECLARE
       v_sysdate DATE := SYSDATE;
       v_systimestamp TIMESTAMP := SYSTIMESTAMP;
       v_date DATE;
       v_number NUMBER(10);
    BEGIN
  
       -- Print the current date and timestamp
       DBMS_OUTPUT.PUT_LINE(v_systimestamp);
 
   END;

 DBMS_OUTPUT.PUT_LINE(SYSTIMESTAMP);


--retrait
creer_transaction ('O',3, 100, '2014-01-06' ,1, null,null);


INSERT INTO Virements(id_vire, montant, date_virement, date_effect, flux, periodicite, TiersId_tiers, nature_trans,ID_cheque) 
		VALUES (default,mont, now,date_eff,flux,period, null, nat, Null);

INSERT INTO debits(id_debit, commentaires, Nbcompte, Nature) ;
VALUES (default, 'retrait espece', mon_nbcompte, nat);


UPDATE compte
   SET solde=solde-mont
 WHERE nbcompte=mon_nbcompte;


--cheque
creer_transaction ('O',2, 100, '2014-01-06' ,1, '12345678901234567890123',8888801);



INSERT INTO Virements(id_vire, montant, date_virement, date_effect, flux, periodicite, TiersId_tiers, nature_trans,ID_cheque) 
		VALUES (default,mont, now,date_eff,flux,period, null, nat, Null);




