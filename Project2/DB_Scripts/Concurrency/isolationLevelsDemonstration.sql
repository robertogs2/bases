-- Set to READ UNCOMMITTED allows us to read changes that have not been commited
-- it also help us to avoid locks that would be produced by other transactions modifyinG the data
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- Set to READ COMMITTED prevent us from reading changes that have not been commited
-- prevents dirty reads, the query is frozen until the transaction is commited
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Set to REPEATABLE READ prevent us from reading changes that have not been commited
-- and from modifying data that is being read. This helps us to avoid changing data that some
-- other transaction is reading. Allows insertion and read at the same time
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- This shoud be blocked whe updating in all levels but 
-- the read uncommited
/*
SELECT Park.Name 
FROM Park
*/

--Inserts are allowed
/*
INSERT INTO Park
	(Name,foundationDate)
VALUES
	('Hoenh','February 26, 19')
*/

--Updates lock till the reading ends

UPDATE Park
SET Park.Name = 'Jurassic park'
WHERE Park.idPark = 3 





-- Set to SERIALIZABLE prevent us from reading changes that have not been commited,
-- from modifying data that is being readand from inserting data in a table that is being read. 
-- This locks us away from modifying data that is being used
--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

