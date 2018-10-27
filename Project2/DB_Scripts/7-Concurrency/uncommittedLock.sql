-- Set our starting point of the transaction, useful for commits and rollbacks
PRINT 'Transaction starting'
BEGIN TRANSACTION uncommitedDemonstration;

	-- Lets modify data by running this block
	-- doesnt block
	PRINT 'Updating park'
	UPDATE Park
	SET Park.Name = 'Jurassic park'
	WHERE Park.idPark = 1 
	WAITFOR DELAY '00:00:10'
	PRINT 'Park updated'
	GO 

COMMIT TRANSACTION uncommitedDemonstration;
PRINT 'Transaction commited'

-- Rollback is only to remove changes for the next tests
/*
ROLLBACK TRANSACTION uncommitedDemonstration;
GO
*/