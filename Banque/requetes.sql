SELECT creer_compte(1,1,86786,76567);
SELECT creer_compte(2,2,40000,12345);
SELECT creer_compte(2,4,67890,12345);
SELECT creer_compte_joint(4,1,2,50000,76567,true,false);
SELECT creer_compte_joint(3,2,4,40000,12345,false,true);

UPDATE compte SET solde=3400 WHERE id_compte=1;
UPDATE compte SET solde=4700 WHERE id_compte=2;
UPDATE compte SET solde=5000 WHERE id_compte=3;
UPDATE compte SET solde=900 WHERE id_compte=4;
UPDATE compte SET solde=2100 WHERE id_compte=5;

SELECT get_solde('20147770001',86786);
SELECT get_solde('20147770002',40000);
SELECT get_solde('20147770004',50000);



---------------------credits-------------------

--crediter cheque

select creer_transaction ('I',2, 100, 2014-01-06 ,1, '12345678901234567890123', '2014011','0987654321098765') ;


--crediter -- virement uni

select creer_transaction ('I',4, 100, 2014-01-06 ,1, '12345678901234567890123', null,'0987654321098765') ;


--crediter -- virement periodique

select creer_transaction ('I',5, 100, 2014-01-06 ,5, '12345678901234567890123', null,'0987654321098765') ;

--crediter par dep™t d'especes "avec carte"

select creer_transaction ('O',6, 100, 2014-01-06 ,1, null, null,'0987654321098765') ;


---------------------debits-------------------
--debiter par prelevement  5eme parametre '5' pour une periodicite mensuel

select creer_transaction ('O',1, 100, 2014-01-06 ,5, '12345678901234567890123', '2014011','0987654321098765') ;


--debiter par retrait d'especes "par carte"

select creer_transaction ('O',3, 100, 2014-01-06 ,1, null, '2014011','0987654321098765') ;


--debiter -- virement uni

select creer_transaction ('O',4, 100, 2014-01-06 ,1, '12345678901234567890123', null,'0987654321098765') ;



--debiter -- virement periodique 5eme parametre '5' pour une periodicite mensuel

select creer_transaction ('O',5, 100, 2014-01-06 ,5, '12345678901234567890123', null,'0987654321098765') ;
