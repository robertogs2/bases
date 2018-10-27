-- Set our starting point of the transaction, useful for commits and rollbacks
BEGIN TRANSACTION uncommitedDemonstration;

	-- Lets modify data by running this block
	-- doesnt block
	UPDATE Park
	SET Park.Name = 'Jurassic park'
	WHERE Park.idPark = 1 
	WAITFOR DELAY '00:00:10'
	GO 

COMMIT TRANSACTION uncommitedDemonstration;

-- Rollback is only to remove changes for the next tests
/*
ROLLBACK TRANSACTION uncommitedDemonstration;
GO
*/