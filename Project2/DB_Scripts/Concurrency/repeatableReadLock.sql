-- Set to REPEATABLE READ prevent us from reading changes that have not been commited
-- and from modifying data that is being read. This helps us to avoid changing data that some
-- other transaction is reading. Allows insertion and read at the same time
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ


BEGIN TRANSACTION repeateableReadDemonstration

-- Lets modify data by running this block, it ll create a deadlock
-- if someone tries to read it
UPDATE Park
SET Park.Name = 'Jurassic park'
WHERE Park.idPark = 1 


-- Lets test an select while doing an insert (wont block)
-- and a update(will block)
/*
SELECT Park.Name 
FROM Park
*/

WAITFOR DELAY '00:00:10'


COMMIT TRANSACTION repeateableReadDemonstration;
GO


-- Rollback is only to remove changes for the next tests
/*
ROLLBACK TRANSACTION repeateableReadDemonstration;
GO
*/