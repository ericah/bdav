CREATE OR REPLACE FUNCTION creer_iban(num_compte public.compte.nbcompte) RETURNS varchar(27) AS $$
DECLARE
	iban varchar(27);
BEGIN
	SELECT CONCAT( CONCAT( CONCAT( CONCAT(
					public.banque.code_pays,
	       	       	       	     	CAST(public.banque.id_banque AS varchar(5))),
				CAST(public.agence.id_agence AS varchar(5))),
			public.compte.nb_compte),
		public.compte.cle_rib)
	INTO iban
	FROM public.banque NATURAL JOIN (public.agence NATURAL JOIN public.compte)) 
	WHERE public.compte.nbcompte = num_compte;
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