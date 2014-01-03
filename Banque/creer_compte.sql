CREATE OR REPLACE FUNCTION creer_num_compte() RETURNS varchar(11) AS $$
DECLARE
	entete varchar(10);
	serie integer;
	resultat varchar(11);
BEGIN
	SELECT  CAST(valeur AS varchar(10))
	INTO entete
	FROM parametres 
	WHERE nom_para = 'entetecompte';

	SELECT MAX(id_Compte)
	INTO serie
	FROM compte;

	IF serie is NULL OR serie=0 THEN
	   serie:=0;
	END IF;
	
	serie := serie +1;
	
	resultat := entete || serie;

	
	RETURN resultat;
	
END;


$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_cle_rib() RETURNS varchar(2) AS $$
BEGIN
	RETURN TRUNC(RANDOM() * 99 + 1);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION creer_iban(c varchar(11), b banque.id_banque%TYPE, a agence.id_agence%TYPE) RETURNS varchar(27) AS $$
DECLARE
	iban varchar(27);
	nbcompte varchar(11);
	cle varchar(2);
BEGIN
	SELECT creer_num_compte() INTO nbcompte;
	SELECT creer_cle_rib() INTO cle; 
	iban := 'FR76' || b || a || nbcompte || cle;
	RETURN iban;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_compte(typec type_compte.code%TYPE, d compte.Decouvert_Aut%TYPE, p personne.id_perso%TYPE, a agence.id_agence%TYPE, b banque.id_banque%TYPE) RETURNS BOOLEAN AS $$
DECLARE
	iban varchar(27);
	nbcompte varchar(11);
BEGIN

	SELECT creer_num_compte() INTO nbcompte;
	SELECT creer_iban(nbcompte, b,a) INTO iban;

	INSERT INTO compte VALUES (default, nbcompte,0,d, p, typec, iban, a, false, 0);
	RETURN true;
END;
$$ LANGUAGE plpgsql;