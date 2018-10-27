USE BASESTEC;
GO
-- We set the transaction level to accomplish the
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRANSACTION cursorLockDemonstration

	--Works like a ptr, local scope means is available only in this SQL statement
	DECLARE tourPrice CURSOR LOCAL	
		FOR 
		SELECT Tour.idTour
		FROM Tour 
	-- Gets the data from the cursor, is like a dereference of a ptr, *x
	OPEN tourPrice;
	-- gets the next value and inserts it into the variable
	FETCH FROM tourPrice;
	WHILE @@fetch_status = 0
	BEGIN
		UPDATE Tour  
		SET Tour.Price = 20  
		WHERE CURRENT OF tourPrice
		WAITFOR DELAY '00:00:10'  
		FETCH NEXT FROM tourPrice 
	END
	-- Removes the cursor
	CLOSE tourPrice
	DEALLOCATE tourPrice

COMMIT TRANSACTION cursorLockDemonstration;