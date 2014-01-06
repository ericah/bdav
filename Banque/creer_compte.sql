DROP FUNCTION creer_compte_joint(int4,int4,int4,int4,int4,boolean,boolean);
DROP FUNCTION creer_compte(integer,integer,integer,integer);
DROP FUNCTION calcul_taux_annuel(character varying,integer);
DROP FUNCTION calcul_decouvert(character varying,integer);
DROP FUNCTION creer_iban(varchar(11),integer,integer);

CREATE OR REPLACE FUNCTION creer_num_compte() RETURNS varchar(11) AS $$
DECLARE
	entete varchar(10);
	serie integer;
	resultat varchar(11);
BEGIN
	SELECT CAST(valeur AS varchar(10))
	INTO entete
	FROM parametres 
	WHERE nom_para = 'entetecompte';

	SELECT MAX(id_Compte)
	INTO serie
	FROM compte;

	IF serie is NULL OR serie=0 THEN
	   serie:=0;
	END IF;
	
	serie := serie +1;
	resultat := entete || serie;

	RETURN resultat;	
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION creer_cle_rib() RETURNS varchar(2) AS $$
BEGIN
	RETURN TRUNC(RANDOM() * 89 + 10);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION creer_iban(compte_code varchar(11), banque_code int4, agence_code int4) RETURNS varchar(27) AS $$
DECLARE
	iban varchar(27);
	cle varchar(2);
BEGIN
	SELECT creer_cle_rib() INTO cle; 
	iban := 'FR76' || banque_code || agence_code || compte_code || cle;
	RETURN iban;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcul_decouvert(nb_cpt compte.NbCompte%TYPE, a compte.id_agence%TYPE) RETURNS boolean AS $$
DECLARE
	perso int4;
	decouvert_max int4;
	decouvert_actuel int4;
	revenus int4;
	res boolean;
BEGIN
	SELECT id_titulaire,decouvert_aut INTO perso, decouvert_actuel
	FROM compte WHERE NbCompte=nb_cpt AND Id_Agence=a;

	SELECT revenues_annuelles INTO revenus
	FROM personne WHERE id_perso = perso;

	decouvert_max := TRUNC(revenus * 20/100);
	res := FALSE;

	IF (decouvert_actuel < decouvert_max) THEN
	   UPDATE compte SET decouvert_aut=decouvert_max
	   WHERE NbCompte=nb_cpt AND Id_Agence=a;
	   res := TRUE;
	END IF;

	RETURN res;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcul_taux_annuel(nb_cpt compte.NbCompte%TYPE, a compte.Id_Agence%TYPE) RETURNS float AS $$
DECLARE
	bk int4;
	cpt int4;
	info varchar(15);
	val int4;
BEGIN
	SELECT id_banque,type_compte INTO bk,cpt
	FROM banque NATURAL JOIN compte
	WHERE compte.NbCompte=nb_cpt AND compte.Id_Agence=a;
	
	info := 'bk' || bk || 'codecpt' || cpt;

	SELECT valeur INTO val
	FROM parametres WHERE nom_para=info;

	RETURN (val/100 :: float);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_compte(typec int4, p int4, a int4, b int4) RETURNS int4 AS $$
DECLARE
	iban varchar(27);
	cpt varchar(11);
	id int4;
	decouvert boolean;
	taux float;
BEGIN
	SELECT creer_num_compte() INTO cpt;
	SELECT creer_iban(cpt, b,a) INTO iban;

	INSERT INTO compte VALUES (default, cpt,0,0,p,typec,iban,a, false, 0.0);
	
	SELECT id_compte INTO id FROM compte WHERE NbCompte=cpt AND Id_Agence=a;
	SELECT calcul_decouvert(cpt,a) INTO decouvert;
	SELECT calcul_taux_annuel(cpt,a) INTO taux;
	UPDATE compte SET taux_annuel=taux WHERE id_compte=id;

	RETURN id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_compte_joint(typec int4, p1 int4, p2 int4, a int4, b int4, resp boolean, commun boolean) RETURNS int4 AS $$
DECLARE
	id int4;
	num varchar(11);
BEGIN
	SELECT creer_compte(typec,p1,a,b) INTO id;
	SELECT NbCompte INTO num FROM compte WHERE id_compte = id;
	INSERT INTO comptes_joints VALUES (default, num, p2, false, resp, commun);
	RETURN id;
END;
$$ LANGUAGE plpgsql;