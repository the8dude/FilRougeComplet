use master
go

--drop login AdminSysteme
--go

--drop login Client
--go

--drop login AdminProduit
--go

--drop login AdminCommande
--go

--drop login AdminClient
--go


create login AdminSysteme with password = 'frsysteme', DEFAULT_DATABASE=[master],
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
go

create login Client with password = 'frclient', DEFAULT_DATABASE=[filrouge],
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
go

create login AdminProduit with password = 'frproduit', DEFAULT_DATABASE=[filrouge],
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
go

create login AdminCommande with password = 'frcommande', DEFAULT_DATABASE=[filrouge],
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
go

create login AdminClient with password = 'fradclient', DEFAULT_DATABASE=[filrouge],
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
go

use filrouge
go

--drop user Client
--drop user AdminSysteme
--drop user AdminProduit
--drop user AdminCommande
--drop user AdminClient

create user AdminSysteme for login AdminSysteme
create user Client for login Client
create user AdminProduit for login AdminProduit
create user AdminCommande for login AdminCommande
create user AdminClient for login AdminClient

------------ROLE----CLIENT------------------

create role clientrole

grant all on fr.commande to clientrole
grant all on fr.livre to clientrole
grant all on fr.livraison to clientrole
grant all on fr.secomposede to clientrole

revoke delete on fr.commande to clientrole
revoke delete on fr.livre to clientrole
revoke delete on fr.livraison to clientrole
 
execute sp_addrolemember 'clientrole', 'Client'

------------ROLE----ADMINSYSTEME------------------

create role adminsystemerole

grant select on schema::fr to adminsystemerole
grant insert on schema::fr to adminsystemerole
grant update on schema::fr to adminsystemerole
grant delete on schema::fr to adminsystemerole
 
execute sp_addrolemember 'adminsystemerole', 'AdminSysteme'

------------ROLE----ADMINPRODUIT------------------

create role adminproduitrole

grant all on fr.rubrique to adminproduitrole
grant all on fr.sousrubrique to adminproduitrole
grant all on fr.article to adminproduitrole

execute sp_addrolemember 'adminproduitrole', 'AdminProduit'

------------ROLE----ADMINCOMMANDE------------------

create role admincommanderole

grant all on fr.livraison to admincommanderole
grant all on fr.livre to admincommanderole
grant all on fr.commande to admincommanderole

execute sp_addrolemember 'admincommanderole', 'AdminCommande'

------------ROLE----ADMINCLIENT------------------

create role adminclientrole

grant all on fr.client to adminclientrole

execute sp_addrolemember 'adminclientrole', 'AdminClient'