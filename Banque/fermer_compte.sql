DROP FUNCTION ferme_compte(integer,character varying,character varying);
DROP FUNCTION ferme_compte_joint(integer,character varying,character varying);

CREATE OR REPLACE FUNCTION ferme_compte(a agence.Id_agence%TYPE, nb Compte.NbCompte%TYPE, rib_tiers Tiers.rib_tiers%TYPE) RETURNS int4 AS $$
DECLARE
	montant Compte.Solde%TYPE;
	id Compte.id_compte%TYPE;
BEGIN
	SELECT id_compte,solde INTO id,montant FROM compte
	WHERE NbCompte=nb AND Id_Agence=a;
 
	SELECT creer_transaction('O',4,montant,current_timestamp,1,rib_tiers,null,null);
	DELETE FROM compte WHERE id_compte=id;
	RETURN montant;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ferme_compte_joint(a agence.Id_agence%TYPE, nb Compte.NbCompte%TYPE, rib_tiers Tiers.rib_tiers%TYPE) RETURNS int4 AS $$
DECLARE
	montant Compte.Solde%TYPE;
	id Compte.id_compte%TYPE;
	id_joint comptes_joints.id_compte_joint%TYPE;
BEGIN
	SELECT id_compte,solde INTO id,montant FROM compte
	WHERE NbCompte=nb AND Id_Agence=a;
 
	SELECT creer_transaction('O',4,montant,now(),1,rib_tiers,null,null);
	DELETE FROM compte WHERE id_compte=id;
	DELETE FROM comptes_joints WHERE id_compte_joint = id_joint;
	RETURN montant;
END;
$$ LANGUAGE plpgsql;