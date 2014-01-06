DROP FUNCTION get_banque(character varying);
DROP FUNCTION get_agence(character varying);
DROP FUNCTION get_Nbcompte(character varying);
DROP FUNCTION get_Clerib(character varying);
DROP FUNCTION get_id_compte(integer, integer, character varying);
DROP FUNCTION get_mon_nbcompte(integer, integer, character varying);
DROP FUNCTION get_id_tiers(character varying);

CREATE OR REPLACE FUNCTION get_banque (rib Tiers.rib_tiers%TYPE) RETURNS int4 AS $$
DECLARE
	id_banque1 int4;
	var_banque varchar(5);
BEGIN

	var_banque:=substring(rib from 1 for 5);
	
	SELECT id_banque
	INTO id_banque1
	FROM banque 
	WHERE id_banque = var_banque::int4 ;
		
	Return id_banque1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_agence (rib Tiers.rib_tiers%TYPE) RETURNS int4 AS $$
DECLARE
	id_agence1 int4;
	var_agence varchar(5);
BEGIN

	var_agence:=substring(rib from 6 for 5);
	
	SELECT id_agence
	INTO id_agence1
	FROM agence 
	WHERE id_agence = var_agence::int4;
		
	Return id_agence1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_Nbcompte (rib Tiers.rib_tiers%TYPE) RETURNS varchar(11) AS $$
DECLARE
	nbc int4;
	var_nbc varchar(11);
BEGIN

	var_nbc:=substring(rib from 11 for 11);
	
	Return var_nbc;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_Clerib (rib Tiers.rib_tiers%TYPE) RETURNS varchar(2) AS $$
DECLARE	
	var_cle varchar(2);
BEGIN

	var_cle:=substring(rib from 22 for 2);
	
	Return var_cle;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_id_compte (banque int4, agence int4,var_nbc varchar(11)) RETURNS integer AS $$
DECLARE	
	idc integer;
BEGIN

	SELECT id_compte
	INTO idc
	FROM compte 
	WHERE id_agence = agence and NbCompte=var_nbc;

	
	
	Return idc;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_mon_nbcompte (banque int4, agence int4 ,num_cart  Carte_Bancaire.Numero_Carte%TYPE) RETURNS varchar(11) AS $$

DECLARE	
	nbC varchar(11);
BEGIN

	SELECT carte_bancaire.nbcompte
	INTO nbC
	FROM carte_bancaire
	WHERE Numero_Carte=num_cart;

Return nbC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_id_tiers  (rib Tiers.rib_tiers%TYPE)  RETURNS integer AS $$

DECLARE	
	idt integer;
BEGIN

	SELECT Id_tiers
	INTO idt
	FROM Tiers
	WHERE rib_tiers=rib;

Return idt;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_solde(nb compte.NbCompte%TYPE, a agence.Id_Agence%TYPE) RETURNS int4 AS $$
DECLARE
	montant int4;
BEGIN
	SELECT solde INTO montant FROM compte
	WHERE NbCompte=nb AND Id_Agence=a;
	RETURN montant;
END;
$$ LANGUAGE plpgsql;
