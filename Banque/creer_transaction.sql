DROP FUNCTION get_banque(character varying);
DROP FUNCTION get_agence(character varying);
DROP FUNCTION get_Nbcompte(character varying);
DROP FUNCTION get_Clerib(character varying);
DROP FUNCTION creer_transaction(character varying);

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



CREATE OR REPLACE FUNCTION creer_transaction (flux Virements.flux%TYPE,nat Virements.nature_trans%TYPE, mont Virements.montant%TYPE, date_eff Virements.date_effect%TYPE ,period Virements.periodicite%TYPE, rib Tiers.rib_tiers%TYPE) RETURNS integer AS $$
DECLARE
	now date;
	banque int4;
	agence int4;
	cle varchar(2);
	var_nbc varchar(11);
	idc integer;
BEGIN

	now:=CURRENT_TIMESTAMP;

	banque:=get_banque(rib);

	agence:=get_agence(rib);
	
 	cle:= get_Clerib (rib);
	
	var_nbc :=get_Nbcompte (rib);
	
	idc:=get_id_compte (banque , agence ,var_nbc);
									
	IF flux='O' THEN

	






	END IF
				

--	INSERT INTO Virements
  --	       	    (id_vire, montant, date_virement, date_effect, flux, periodicite, TiersId_tiers, nature_trans,
--	            ID_cheque) 
--		VALUES (default,mont, ?,date_eff,flux,period, ?, ?, ?, ?);



	RETURN 1;	
END;
$$ LANGUAGE plpgsql;

