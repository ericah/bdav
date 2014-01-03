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
--	RETURN entete;

	

	SELECT   max(id_Compte)
	INTO serie
	FROM compte;
	--RETURN serie;


	IF serie is NULL OR serie=0 THEN
	   serie:=0;
	END IF;
	
	serie := serie +1;
	
	resultat := entete || serie;

	
	RETURN resultat;
	
END;


$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION creer_iban(num_compte varchar(11)) RETURNS varchar(27) AS $$
DECLARE
	iban varchar(27);
BEGIN
	SELECT CONCAT( CONCAT( CONCAT( CONCAT(
					banque.code_pays,
	       	       	       	     	CAST(banque.id_banque AS varchar(5))),
				CAST(agence.id_agence AS varchar(5))),
			compte.nbcompte),
		compte.cle_rib)
	INTO iban
	FROM banque NATURAL JOIN agence NATURAL JOIN compte 
	WHERE compte.nbcompte = num_compte;
	RETURN iban;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_compte(type_cpt integer, solde integer, deccouvert integer, titulaire integer, agence integer) RETURNS BOOLEAN AS $$
DECLARE

BEGIN

END;
$$ LANGUAGE plpgsql;
