DELETE FROM Nature_trans;
DELETE FROM Periodicite;
DELETE FROM Parametres;
DELETE FROM Type_carte;
DELETE FROM Comptes_joints;
DELETE FROM Compte;
DELETE FROM Type_compte;
DELETE FROM Personne;
DELETE FROM Agence;
DELETE FROM Banque;

INSERT INTO Banque VALUES (76567, 'FirstBank', 'FST BK BIC', 100000);
INSERT INTO Banque VALUES (12345, 'SecondBank', 'SND BK BIC',200000);
INSERT INTO Banque VALUES (75765, 'ThirdBank', 'THRD BK BIC',300000);

INSERT INTO Agence VALUES (86786, 'FirstAgenceFstBK', 76567);
INSERT INTO Agence VALUES (78678, 'SndAgenceFstBK', 76567);
INSERT INTO Agence VALUES (50000, 'ThirdAgenceFstBK', 76567);
INSERT INTO Agence VALUES (67890, 'FirstAgenceSndBK', 12345);
INSERT INTO Agence VALUES (40000, 'SecondAgenceSndBK', 12345);

INSERT INTO Personne VALUES (default,'201488877001','Castellanos','Alejandro','12/17/1985','M',10400);
INSERT INTO Personne VALUES (default,'201488877002','Huam','Erica','08/23/1990','M',5200);
INSERT INTO Personne VALUES (default,'201488877003','Jamal','Meryam','05/15/1990','M');
INSERT INTO Personne VALUES (default,'201488877004','Tonnelier','Jerome','07/23/1988','M');
INSERT INTO Personne VALUES (default,'201488877005' ,'Maimaiti', 'Amina','06/28/1984','C');

INSERT INTO Type_compte VALUES (default,'Epargne',true,0);
INSERT INTO Type_compte VALUES (default,'Courant',true,1);
INSERT INTO Type_compte VALUES (default,'Epargne',false,2);
INSERT INTO Type_compte VALUES (default,'Courant',false,3);

INSERT INTO Type_carte VALUES (default, 'retrait', 0, 0);
INSERT INTO Type_carte VALUES (default, 'paiement', 0, 8);
INSERT INTO Type_carte VALUES (default, 'credit', 0, 12);
INSERT INTO Type_carte VALUES (default, 'retrait', 1, 8);
INSERT INTO Type_carte VALUES (default, 'paiement', 1, 12);
INSERT INTO Type_carte VALUES (default, 'credit', 1, 20);

INSERT INTO nature_trans VALUES (default, 'prelevement');
INSERT INTO nature_trans VALUES (default, 'cheque');
INSERT INTO nature_trans VALUES (default, 'retrait');
INSERT INTO nature_trans VALUES (default, 'virement unitaire');
INSERT INTO nature_trans VALUES (default, 'virement periodique');
INSERT INTO nature_trans VALUES (default, 'dépôt d´ espèces');

INSERT INTO periodicite VALUES (default, 'Unitaire',1);
INSERT INTO periodicite VALUES (default, 'Journalier',1);
INSERT INTO periodicite VALUES (default, 'Hebdomadaire',7);
INSERT INTO periodicite VALUES (default, 'Bimensuel',15);
INSERT INTO periodicite VALUES (default, 'Mensuel',30);
INSERT INTO periodicite VALUES (default, 'Trimestriel',90);
INSERT INTO periodicite VALUES (default, 'Semestriel',180);
INSERT INTO periodicite VALUES (default, 'Annuel',360);

INSERT INTO parametres VALUES (default,'entetecompte',2014777000);
INSERT INTO parametres VALUES (default,'Formule_cheque',201401);

INSERT INTO parametres VALUES (default,'formule_cb_bk1',20143849);
INSERT INTO parametres VALUES (default,'formule_cb_bk2',20144512);
INSERT INTO parametres VALUES (default,'formule_cb_bk3',20142718);

INSERT INTO parametres VALUES (default,'bk1codecpt1', 35);
INSERT INTO parametres VALUES (default,'bk1codecpt2', 15);
INSERT INTO parametres VALUES (default,'bk1codecpt3', 70);
INSERT INTO parametres VALUES (default,'bk1codecpt4', 57);

INSERT INTO parametres VALUES (default,'bk2codecpt1', 25);
INSERT INTO parametres VALUES (default,'bk2codecpt2', 20);
INSERT INTO parametres VALUES (default,'bk2codecpt3', 75);
INSERT INTO parametres VALUES (default,'bk2codecpt4', 57);

INSERT INTO parametres VALUES (default,'bk3codecpt1', 30);
INSERT INTO parametres VALUES (default,'bk3codecpt2', 20);
INSERT INTO parametres VALUES (default,'bk3codecpt3', 65);
INSERT INTO parametres VALUES (default,'bk3codecpt4', 55);

INSERT INTO parametres VALUES (default, 'cb1bk1plafond', 2000);
INSERT INTO parametres VALUES (default, 'cb2bk1plafond', 6000);
INSERT INTO parametres VALUES (default, 'cb3bk1plafond', 8000);
INSERT INTO parametres VALUES (default, 'cb4bk1plafond', 6000);
INSERT INTO parametres VALUES (default, 'cb5bk1plafond', 8000);
INSERT INTO parametres VALUES (default, 'cb6bk1plafond', 10000);

INSERT INTO parametres VALUES (default, 'cb1bk2plafond', 1000);
INSERT INTO parametres VALUES (default, 'cb2bk2plafond', 3000);
INSERT INTO parametres VALUES (default, 'cb3bk2plafond', 5000);
INSERT INTO parametres VALUES (default, 'cb4bk2plafond', 3000);
INSERT INTO parametres VALUES (default, 'cb5bk2plafond', 5000);
INSERT INTO parametres VALUES (default, 'cb6bk2plafond', 7000);

INSERT INTO parametres VALUES (default, 'cb1bk3plafond', 1500);
INSERT INTO parametres VALUES (default, 'cb2bk3plafond', 4000);
INSERT INTO parametres VALUES (default, 'cb3bk3plafond', 7000);
INSERT INTO parametres VALUES (default, 'cb4bk3plafond', 4000);
INSERT INTO parametres VALUES (default, 'cb5bk3plafond', 7000);
INSERT INTO parametres VALUES (default, 'cb6bk3plafond', 9000);
