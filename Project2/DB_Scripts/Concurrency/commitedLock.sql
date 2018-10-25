-- Set our starting point of the transaction, useful for commits and rollbacks
BEGIN TRANSACTION commitedDemonstration;
GO

	-- Lets modify data by running this block and 
	-- then try to select it from another query
	UPDATE Park
	SET Park.Name = 'Jurassic kingdom'
	WHERE Park.idPark = 1
	WAITFOR DELAY '00:00:10'
	GO 


-- Rollback is only to remove changes for the next tests
/*
ROLLBACK TRANSACTION commitedDemonstration;
GO
*/