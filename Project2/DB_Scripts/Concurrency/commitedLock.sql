-- Set our starting point of the transaction, useful for commits and rollbacks
BEGIN TRANSACTION commitedDemonstration;
GO

	-- Lets modify data by running this block and 
	-- then try to select it from another query
	-- blocks select
	UPDATE Park
	SET Park.Name = 'Jurassic park'
	WHERE Park.idPark = 1
	WAITFOR DELAY '00:00:10'
	GO 

COMMIT TRANSACTION commitedDemonstration;
-- Rollback is only to remove changes for the next tests
/*
ROLLBACK TRANSACTION commitedDemonstration;
GO
*/