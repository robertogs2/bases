-- Set to REPEATABLE READ prevent us from reading changes that have not been commited
-- and from modifying data that is being read. This helps us to avoid changing data that some
-- other transaction is reading. Allows insertion and read at the same time
SET TRANSACTION ISOLATION LEVEL	SERIALIZABLE


BEGIN TRANSACTION serializableDemonstration

-- This will block everything but changes outside the search scope
SELECT Park.Name 
FROM Park
WHERE Park.idPark = 1

WAITFOR DELAY '00:00:10'


COMMIT TRANSACTION serializableDemonstration;
GO


-- Rollback is only to remove changes for the next tests
/*
ROLLBACK TRANSACTION repeateableReadDemonstration;
GO
*/