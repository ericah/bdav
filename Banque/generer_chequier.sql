CREATE OR REPLACE FUNCTION generer_chequier(nbcheques,nbcompte) RETURNS integer AS $$

DECLARE
i integer;
num_cheque int4;
formule int4;
BEGIN	
	
	select valeur
	into formule
	from parametres 
	where nom_par='Formule_cheque';
	
	IF nbcompte.valide=true THEN
	   	FOR i IN 1..nbcheques LOOP 
			nbcheque:=formule+i;		         
			 INSERT INTO cheque 
			 VALUES (num_cheque,nbcompte); 		
		
		END IF;

	END LOOP;

	RETURN 1;
END;

$$ LANGUAGE 'plpgsql';