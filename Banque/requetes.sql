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