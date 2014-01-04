DELETE FROM Type_carte;
DELETE FROM Compte;
DELETE FROM Type_compte;
DELETE FROM Personne;
DELETE FROM Agence;
DELETE FROM Banque;

INSERT INTO Banque VALUES (default, 'FirstBank', 'FST BK BIC', 100000);
INSERT INTO Banque VALUES (default, 'SecondBank', 'SND BK BIC',200000);
INSERT INTO Banque VALUES (default, 'ThirdBank', 'THRD BK BIC',300000);
INSERT INTO Agence VALUES (77770, 'FirstAgenceFstBK', 001);
INSERT INTO Agence VALUES (default, 'SndAgenceFstBK', 001);
INSERT INTO Agence VALUES (default, 'ThirdAgenceFstBK', 001);
INSERT INTO Agence VALUES (default, 'FirstAgenceSndBK', 002);
INSERT INTO Agence VALUES (default, 'SecondAgenceSndBK', 002);
INSERT INTO Personne VALUES (default,'2014888001','Castellanos','Alejandro','12/17/1985','M');
INSERT INTO Personne VALUES (default,'2014888002','Huam','Erica','08/23/1990','M');
INSERT INTO Personne VALUES (default,'2014888003','Jamal','Meryam','05/15/1990','M');
INSERT INTO Personne VALUES (default,'2014888004','Tonnelier','Jerome','07/23/1988','M');
INSERT INTO Personne VALUES (default,'2014888005' ,'Maimaiti', 'Amina','06/28/1984','C');
INSERT INTO Type_compte VALUES (default,'Epargne',true,0);
INSERT INTO Type_compte VALUES (default,'Courant',true,1);
INSERT INTO Type_compte VALUES (default,'Epargne',false,2);
INSERT INTO Type_compte VALUES (default,'Courant',false,3);
--INSERT INTO Compte VALUES ('moncompte1',0,400,1,1,'ibanalejo',0002);
--INSERT INTO Compte VALUES ('moncompte2',2000,0,3,2,'ibanmeryam',0011);
--INSERT INTO Compte VALUES ('moncompte3',0,400,2,1,'ibanerica',0012);
INSERT INTO Type_carte VALUES (default, 'retrait', 0, 0);
INSERT INTO Type_carte VALUES (default, 'paiement', 0, 8);
INSERT INTO Type_carte VALUES (default, 'credit', 0, 12);
INSERT INTO Type_carte VALUES (default, 'retrait', 1, 8);
INSERT INTO Type_carte VALUES (default, 'paiement', 1, 12);
INSERT INTO Type_carte VALUES (default, 'credit', 1, 20);

INSERT INTO nature_trans VALUES (default, 'prelevement');
INSERT INTO nature_trans VALUES (default, 'cheque');
INSERT INTO nature_trans VALUES (default, 'retrait');


INSERT INTO periodicite VALUES (default, 'Hebdomadaire',7);
INSERT INTO periodicite VALUES (default, 'Mensuel',30);
INSERT INTO periodicite VALUES (default, 'Annuel',360);

INSERT INTO parametres VALUES (default,'entetecompte',2014777000);
INSERT INTO parametres VALUES (default,'Formule_cheque',201401);
