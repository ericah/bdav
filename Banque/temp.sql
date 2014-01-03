CREATE OR REPLACE FUNCTION retrait( montant integer, id_cpt varchar(11) ) RETURNS integer AS $$
DECLARE
	somme integer;
	decouvert integer;
BEGIN
	SELECT solde INTO somme FROM compte WHERE nbcompte = id_cpt;

	SELECT decouvert_aut INTO decouvert FROM compte WHERE nbcompte = id_cpt;

	IF (somme-montant > decouvert) THEN RETURN decouvert-somme+montant;
	ELSE RAISE NOTICE 'Montant demandé trop élevé';
	END IF;
END;
$$ LANGUAGE plpgsql;