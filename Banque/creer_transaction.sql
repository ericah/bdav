
DROP FUNCTION creer_transaction(character, integer, integer, timestamp without time zone, integer, character varying, integer, 
character varying);


CREATE OR REPLACE FUNCTION creer_transaction (flux transactions.flux%TYPE,nat transactions.nature_trans%TYPE, mont transactions.montant%TYPE, date_eff transactions.date_effect%TYPE ,period transactions.periodicite%TYPE, rib Tiers.rib_tiers%TYPE, ID_chequ transactions.ID_cheque%TYPE,num_cart transactions.Num_Carte%TYPE) RETURNS integer AS $$
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
		     		 INSERT INTO transactions(id_trans, montant, date_trans, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,now,flux,period, null, nat);    
		     	
				INSERT INTO debits(id_debit, commentaires, Nbcompte, Nature) 
				       VALUES (default, 'retrait espece', mon_nbcompte, nat);

				UPDATE compte
				SET solde=solde-mont
 				WHERE nbcompte=mon_nbcompte;	

			ELSEIF nat=4 THEN -- virement uni
			        INSERT INTO transactions(id_trans, montant, date_trans, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, id_tiers, nat);   

				INSERT INTO debits(id_debit, commentaires, Nbcompte, Nature) 
				       VALUES (default, 'virement unitaire', mon_nbcompte, nat);


				UPDATE compte
				SET solde=solde-mont
 				WHERE nbcompte=mon_nbcompte;	
		     
		     

			ELSEIF nat=5 THEN --virement periodique


			       INSERT INTO transactions(id_trans, montant, date_trans, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, id_tiers, nat); 

				INSERT INTO debits(id_debit, commentaires, Nbcompte, Nature) 
				       VALUES (default, 'virement unitaire', mon_nbcompte, nat);   

				UPDATE compte
				SET solde=solde-mont
 				WHERE nbcompte=mon_nbcompte;
	     		
		ELSE RETURN -1;
		END IF; -- end prelev


	ELSE --IF flux='I' THEN
	     	

		IF nat=2 THEN --cheque
	   	   	  INSERT INTO transactions(id_trans, montant, date_trans, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans,ID_cheque) 
					VALUES (default,mont, now,date_eff,flux,period, null, nat,  ID_chequ);    

				UPDATE compte
				SET solde=solde+mont
 				WHERE nbcompte=mon_nbcompte;	
	
			ELSEIF nat=4 THEN -- virement uni
			        INSERT INTO transactions(id_trans, montant, date_trans, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, id_tiers, nat);    

				UPDATE compte
				SET solde=solde+mont
 				WHERE nbcompte=mon_nbcompte;	
		     
		     

			ELSEIF nat=5 THEN --virement periodique


			       INSERT INTO transactions(id_trans, montant, date_trans, date_effect, flux, periodicite, 
				 	     		TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,date_eff,flux,period, id_tiers, nat);    

				UPDATE compte
				SET solde=solde+mont
 				WHERE nbcompte=mon_nbcompte;
		     
		     	ELSEIF nat=6 THEN --especes
		       		 INSERT INTO transactions(id_trans, montant, date_trans, date_effect, flux,
				 	     		periodicite,TiersId_tiers, nature_trans) 
					VALUES (default,mont, now,now,flux,period, mon_nbcompte, nat);    
		     	
					UPDATE compte
					SET solde=solde+mont
 					WHERE nbcompte=mon_nbcompte;	
		     		     
		     
		 ELSE RETURN -1; 			            
	     END IF;---fin nat
	END IF; --fin flux
				



	RETURN 1;	
END;
$$ LANGUAGE plpgsql;