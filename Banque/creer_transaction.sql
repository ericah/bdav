DROP FUNCTION get_banque(character varying);
DROP FUNCTION get_agence(character varying);
DROP FUNCTION get_Nbcompte(character varying);
DROP FUNCTION get_Clerib(character varying);
--DROP FUNCTION creer_transaction(character varying);

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


CREATE OR REPLACE FUNCTION creer_transaction (flux transactions.flux%TYPE,nat transactions.nature_trans%TYPE, mont transactions.montant%TYPE, date_eff transactions.date_effect%TYPE ,period transactions.periodicite%TYPE, rib Tiers.rib_tiers%TYPE, ID_chequ transactions.ID_cheque%TYPE,num_cart transactions.Numero_Carte%TYPE) RETURNS integer AS $$
DECLARE
	now TIMESTAMP;
	banque int4;
	agence int4;
	cle varchar(2);
	var_nbc varchar(11);
	idc integer;
	mon_nbcompte varchar(11);
	id_tiers integer;
BEGIN

	now:=now();

	banque:=get_banque(rib); --tiers

	agence:=get_agence(rib); --tiers
	
 	cle:= get_Clerib (rib); --tiers
	
	var_nbc :=get_Nbcompte (rib); --tiers

	id_tiers:=get_id_tiers (rib);
	
	idc:=get_id_compte (banque , agence ,var_nbc);  --tiers

	mon_nbcompte:=get_mon_nbcompte (banque , agence ,num_cart);
									
	IF flux='O' THEN
	   
		IF nat=1 THEN ---prelev


			ELSEIF nat=3 THEN--retrait
		     		 INSERT INTO transactions(id_vire, montant, date_virement, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, null, nat);    
		     	
				INSERT INTO debits(id_debit, commentaires, Nbcompte, Nature) ;
				       VALUES (default, 'retrait espece', mon_nbcompte, nat);

				UPDATE compte
				SET solde=solde-mont
 				WHERE nbcompte=mon_nbcompte;	

			ELSEIF nat=4 THEN -- virement uni
		     

			ELSEIF nat=5 THEN --virement periodique	
	     		
		ELSE RETURN -1;
		END IF; -- end prelev


	ELSE --IF flux='I' THEN
	     	

		IF nat=2 THEN --cheque
	   	   	  INSERT INTO transactions(id_vire, montant, date_virement, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans,ID_cheque) 
					VALUES (default,mont, now,date_eff,flux,period, null, nat,  ID_chequ);    

				UPDATE compte
				SET solde=solde+mont
 				WHERE nbcompte=mon_nbcompte;	
	
			ELSEIF nat=4 THEN -- virement uni
			        INSERT INTO transactions(id_vire, montant, date_virement, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, id_tiers, nat);    

				UPDATE compte
				SET solde=solde+mont
 				WHERE nbcompte=mon_nbcompte;	
		     
		     

			ELSEIF nat=5 THEN --virement periodique


			       INSERT INTO transactions(id_vire, montant, date_virement, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, id_tiers, nat);    

				UPDATE compte
				SET solde=solde+mont
 				WHERE nbcompte=mon_nbcompte;
		     
		     	ELSEIF nat=6 THEN --especes
		       		 INSERT INTO transactions(id_vire, montant, date_virement, date_effect, flux,
				 	     		periodicite,TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, mon_nbcompte, nat);    
		     	
					UPDATE compte
					SET solde=solde+mont
 					WHERE nbcompte=mon_nbcompte;	
		     		     
		     
		 ELSE RETURN -1; 			            
	     END IF;---fin nat
	END IF; --fin flux
				



	RETURN 1;	
END;
$$ LANGUAGE plpgsql;