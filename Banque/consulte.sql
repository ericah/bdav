CREATE OR REPLACE FUNCTION get_solde(nb compte.NbCompte%TYPE, a agence.Id_Agence%TYPE) RETURNS int4 AS $$
DECLARE
	montant int4;
BEGIN
	SELECT solde INTO montant FROM compte
	WHERE NbCompte=nb AND Id_Agence=a;
	RETURN montant;
END;
$$ LANGUAGE plpgsql;