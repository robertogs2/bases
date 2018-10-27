EXEC sp_configure 'remote query timeout', 5 ;  
GO  
RECONFIGURE ;  
GO

BEGIN TRANSACTION timeoutRollbackDemonstration;
GO

	BEGIN TRY  
		SELECT  Park.Name
		FROM Park
		WHERE Park.idPark = 1
		--WAITFOR DELAY '00:00:10'
		COMMIT TRANSACTION commitedDemonstration; 
  
	END TRY  

	BEGIN CATCH  
		 ROLLBACK TRANSACTION commitedDemonstration;
	END CATCH    