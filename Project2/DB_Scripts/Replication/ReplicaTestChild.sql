USE BASESTECREPLICA
GO

--delete from country
--where "Name" = 'Nuevopais' OR "Name" = 'Nuevopaisrepl'

select * from  country

--insert into country("Name") values('Nuevopaisrepl')