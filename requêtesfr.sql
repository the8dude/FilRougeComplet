--01
select SUM(Quantite*PVHTArticle) AS 'Chiffre d''affaire pour l''ensemble'
	FROM
		fr.article
	JOIN
		fr.secomposede
	ON
		fr.article.RefArticle = fr.secomposede.RefArticle
	

--02
select FournisseurArticle, SUM(Quantite*PVHTArticle) 'Chiffre d''affaire par fournisseur'
	FROM
		fr.article
	JOIN
		fr.secomposede
	ON
		fr.article.RefArticle = fr.secomposede.RefArticle
	GROUP BY
		FournisseurArticle

--03
select RefArticle, Quantite
	FROM
		fr.secomposede
	

--04
select DISTINCT DateCommande, fr.client.RefClient,NomClient, TotalHT, (TotalHT*CoeffClient) AS 'Total TTC'
	FROM
		fr.client
	JOIN
		fr.commande
	ON
		fr.client.RefClient = fr.commande.RefClient
	JOIN
		fr.secomposede
	ON
		fr.commande.NumCommande = fr.secomposede.NumCommande

--05
select TypeClient, SUM(TotalHT) AS 'Total HT', SUM(TotalHT*CoeffClient) AS 'Total TTC'
	FROM
		fr.client
	JOIN
		fr.commande
	ON
		fr.client.RefClient = fr.commande.RefClient
	JOIN
		fr.secomposede
	ON
		fr.commande.NumCommande = fr.secomposede.NumCommande
	GROUP BY
		TypeClient

--06
select fr.commande.NumCommande, NomClient, EtatColis AS 'Etat de la commande'
	FROM
		fr.livre
	JOIN
		fr.client
	ON
		fr.client.RefClient = fr.livre.RefClient
	JOIN
		fr.commande
	ON
		fr.livre.NumCommande = fr.commande.NumCommande
	WHERE
		EtatColis = 0