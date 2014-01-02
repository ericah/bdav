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
	FROM banque NATURAL JOIN (agence JOIN compte)) 
	WHERE compte.nbcompte = num_compte;
	RETURN iban;
END;
$$ LANGUAGE plpgsql;
/*
CREATE OR REPLACE FUNCTION creer_compte(agence agence.id_agence, personne personne.nb_doc_id, type_compte type_compte.code) RETURNS BOOLEAN AS $$
DECLARE

BEGIN

END;
$$ LANGUAGE plpgsql;
*/