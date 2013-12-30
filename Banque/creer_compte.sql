CREATE OR REPLACE FUNCTION creer_iban(num_compte Compte.nbcompte) RETURNS varchar(27) AS $$
DECLARE
	iban varchar(27);
BEGIN
	SELECT code_pays + id_banque + id_agence + num_compte + cle_rib 
	FROM banque NATURAL JOIN (banque NATURAL JOIN (agence NATURAL JOIN compte)) 
	WHERE compte.nbcompte = num_compte;
	RETURN iban;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_compte(agence Agence.id_agence, personne Personne.nb_doc_id, type_compte Type_compte.code) RETURNS BOOLEAN AS $$
DECLARE

BEGIN

END;
$$ LANGUAGE plpgsql;