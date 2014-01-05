DROP FUNCTION creer_cb(int4, int4);

CREATE OR REPLACE FUNCTION creer_cle_sec() RETURNS varchar(3) AS $$
BEGIN
	RETURN TRUNC(RANDOM() * 899 + 100);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION random_4char() RETURNS varchar(8) AS $$
BEGIN
	RETURN TRUNC(RANDOM() * 8999 + 1000);
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
	val2 varchar(4);
	val3 varchar(4);
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
	SELECT random_4char() INTO val2;
	SELECT random_4char() INTO val3;
	num := val1 || val2 || val3;
	num := substring(num from 1 for 16);

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

CREATE OR REPLACE FUNCTION creer_cb_joint(id_cpt int4, id_type_cb int4, titulaire int4) RETURNS varchar(16) AS $$
DECLARE
	num_carte varchar(16);
	nb varchar(11);
	nb_carte integer;
BEGIN
	SELECT NbCompte INTO nb FROM compte WHERE id_compte=id_cpt;

	SELECT COUNT(DISTINCT numero_carte) INTO nb_carte
	FROM carte_bancaire WHERE NbCompte=nb AND id_titulaire=titulaire;

	IF nb_carte != 0 THEN num_carte=NULL;
	ELSE SELECT creer_cb(id_cpt,id_type_cb) INTO num_carte;
	END IF;

	RETURN nb_carte;
END;
$$ LANGUAGE plpgsql;