use filrouge
go

exec sp_addumpdevice 'disk', 'savFR', 'C:\Backup\FilRouge.bak'
go

backup database filrouge to savFR
go

alter database filrouge set restricted_user with rollback immediate
go

restore database filrouge from savFR with replace
go

alter database filrouge set multi_user
go

--REMPLACE LA COMMANDE restore database POUR RESTORER A PARTIR D'UNE SAUVEGARDE ANTERIEURE
--restore headeronly from savFR
--restore database filrouge from savFR with file=?, replace
