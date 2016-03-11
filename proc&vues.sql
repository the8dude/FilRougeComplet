-------------------PROCEDURES-----------------------
--01

create proc Lst_commande_non_sold�es
as
select NumCommande, EtatCommande
	FROM 
		fr.commande
	WHERE
		EtatCommande = 6

exec Lst_commande_non_sold�es

--02

create proc D�lai_moyen
as
select AVG(DATEDIFF(DAY, DateCommande, DateFacture)) AS 'D�lai Moyen'
	FROM
		fr.commande

Exec D�lai_moyen



-------------------VUES-----------------------------

drop view Produits_Fournisseurs

create view Produits_Fournisseurs
as
select fr.article.*, fr.fournisseurs.NomFournisseur
	FROM
		fr.article
	JOIN
		fr.fournisseurs
	ON
		fr.article.IdFournisseur = fr.fournisseurs.IdFournisseur

select * from Produits_Fournisseurs
