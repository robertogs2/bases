SET LOCK_TIMEOUT 2000;
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

PRINT 'BEFORE TRY timeout'
BEGIN TRY
	BEGIN TRANSACTION 
		PRINT 'First Statement in the TRY block'
			PRINT 'Attempting to update Park'
			SELECT Park.Name 
			FROM Park
		PRINT 'Last Statement in the TRY block'

	COMMIT TRANSACTION  -- Commit changes to the database, used in case rollback is needed
END TRY
BEGIN CATCH
	PRINT 'In CATCH Block'
		-- @@TRANCOUNT is used to realiably detect errors in nested transactions
	IF(@@TRANCOUNT > 0)
	BEGIN
		PRINT 'Rollingback'
		ROLLBACK TRANSACTION;
	END;
		
	THROW; -- raise error to the client
END CATCH
PRINT 'After END CATCH'