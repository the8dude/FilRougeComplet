--use test
--go

--drop database filrouge
--go

create database filrouge
go

use filrouge
go

create schema fr
go

-------------------------COMMERCIAL--------------------------

create table fr.commercial(
	IdCom			int IDENTITY NOT NULL,
	NomCom			varchar(50) NOT NULL,
	PrenomCom		varchar(50) NOT NULL,
	Tel				varchar(30)	NOT NULL CHECK (Tel LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	TypeCommercial	bit
PRIMARY KEY (IdCom) 
)
go

-------------------------CLIENT-----------------------------
create table fr.client(
	RefClient					int IDENTITY NOT NULL,
	NomClient					varchar(50) NOT NULL,
	PrenomClient				varchar(50) NOT NULL,
	AdresseFacturationClient	varchar(200) NOT NULL,
	CoeffClient					decimal(4,2) NOT NULL,
	TypeClient					bit,
	IdCom						int REFERENCES fr.commercial(IdCom) NOT NULL
PRIMARY KEY (RefClient) 
)
go

--------------------------COMMANDE----------------------------

create table fr.commande(
	NumCommande					int IDENTITY NOT NULL,
	DateCommande				date NOT NULL,
	TotalTTCCommande			money NOT NULL,
	DateReglement				date NOT NULL,
	EtatCommande				int NOT NULL,
	BonDeCommande				varchar(50) NOT NULL,
	TotalHT						money NOT NULL,
	Reduction					numeric NOT NULL,
	Facture						varchar(50) NOT NULL,
	DateFacture					date NOT NULL,
	RefClient					int REFERENCES fr.client(RefClient) NOT NULL
PRIMARY KEY (NumCommande) 
)
go
---------------------------RUBRIQUE-------------------------------

create table fr.rubrique(
	IdRubrique					int IDENTITY NOT NULL,
	NomRubrique					varchar(50) NOT NULL
PRIMARY KEY (IdRubrique) 
)
go
---------------------------SOUS RUBRIQUE---------------------------

create table fr.sousrubrique(
	IdSousRubrique				int IDENTITY NOT NULL,
	NomSousRubrique				varchar(50) NOT NULL,
	IdRubrique					int REFERENCES fr.rubrique(IdRubrique) NOT NULL
PRIMARY KEY (IdSousRubrique) 
)
go

-------------------------FOURNISSEURS-----------------------------
create table fr.fournisseurs(
	IDFournisseur				int IDENTITY NOT NULL,
	NomFournisseur				varchar(50) NOT NULL,
	AdresseFournisseur			varchar(200) NOT NULL,
PRIMARY KEY (IdFournisseur) 
)
go

----------------------------ARTICLE-------------------------------

create table fr.article(
	RefArticle					int IDENTITY NOT NULL,
	AppelationArticle			varchar(50) NOT NULL,
	CaracteristiqueArticle		varchar(250) NULL,
	PUHTArticle					money NOT NULL,
	PhotoArticle				varchar(100) NULL,
	QteStockArticle				int NULL,
	IdSousRubrique				int REFERENCES fr.sousrubrique(IdSousRubrique) NOT NULL,
	IDFournisseur				int REFERENCES fr.fournisseurs(IdFournisseur) NOT NULL
PRIMARY KEY (RefArticle) 
)
go

----------------------------SECOMPOSEDE---------------------------

create table fr.secomposede(
	Quantite					int NULL,
	PVHTArticle					money NOT NULL,
	NumCommande					int REFERENCES fr.commande(NumCommande) NOT NULL,
	RefArticle					int REFERENCES fr.article(RefArticle) NOT NULL
PRIMARY KEY (NumCommande, RefArticle) 
)
go

---------------------------LIVRAISON----------------------------------

create table fr.livraison(
	NumLivraison				int IDENTITY NOT NULL,
	DateLivraison				date NOT NULL,
	NombreColisLivraison		Int	NULL
PRIMARY KEY (NumLivraison) 
)
go

---------------------------LIVRE----------------------------------

create table fr.livre(
	BonLivraisonClient			varchar(80) NOT NULL,
	DateExpeditionCommande		date NOT NULL,
	AdresseLivraisonClient		varchar(250) NOT NULL,
	EtatColis					bit NULL,
	RefClient					int REFERENCES fr.client(RefClient) NOT NULL,
	NumCommande					int REFERENCES fr.commande(NumCommande) NOT NULL,
	NumLivraison				int REFERENCES fr.livraison(NumLivraison)NOT NULL,
	
PRIMARY KEY (RefClient, NumCommande, NumLivraison) 
)
go
