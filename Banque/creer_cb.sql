DROP FUNCTION creer_cb(int4, int4);

CREATE OR REPLACE FUNCTION creer_cle_sec() RETURNS varchar(3) AS $$
BEGIN
	RETURN TRUNC(RANDOM() * 199 + 1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION random_8char() RETURNS varchar(8) AS $$
BEGIN
	RETURN TRUNC(RANDOM() * 199999999 + 1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION max_date() RETURNS date AS $$
DECLARE
	today date;
BEGIN
	SELECT date(current_date) INTO today;
	RETURN (today+ 365*2);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_cb(id_cpt int4, id_type_cb int4) RETURNS varchar(16) AS $$
DECLARE
	bk int4;
	num varchar(16);
	nb varchar(11);
	val1 varchar(8);
	val2 varchar(8);
	titulaire int4;
	maxi int4;
	choix_rpc char(1);
	valide date;
	cle varchar(3);
BEGIN
	SELECT id_banque,NbCompte,ID_titulaire INTO bk,nb,titulaire
	FROM banque NATURAL JOIN agence NATURAL JOIN compte
	WHERE id_compte=id_cpt;
	
	SELECT valeur::varchar(8) INTO val1
	FROM parametres WHERE nom_para=('formule_cb_bk'||bk);
	SELECT random_8char() INTO val2;
	num := val1 || val2;

	SELECT creer_cle_sec() INTO cle;
	SELECT max_date() INTO valide;

	IF id_type_cb=1 OR id_type_cb=4 THEN choix_rpc = 'R';
	ELSIF id_type_cb=2 OR id_type_cb=5 THEN choix_rpc = 'P';
	ELSIF id_type_cb=3 OR id_type_cb=6 THEN choix_rpc = 'C';
	ELSE RAISE NOTICE 'Type CB unknown';
	END IF;

	SELECT valeur INTO maxi
	FROM parametres WHERE nom_para=('cb'||id_type_cb||'bk'||bk||'plafond');

	INSERT INTO carte_bancaire VALUES (num,cle,valide,titulaire,choix_rpc,maxi,id_type_cb,nb);
	
	RETURN num;
END;
$$ LANGUAGE plpgsql;