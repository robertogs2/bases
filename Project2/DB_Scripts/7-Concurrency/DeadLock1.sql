PRINT 'Transaction 1 started'
BEGIN TRANSACTION;-- First run this to explicitly mark the starting point of a transaction   

	-- Third this block to create the deadlock in Park
	PRINT 'Park table is blocked'
	UPDATE Park
	SET Park.Name = 'Jurassic park'
	WHERE Park.idPark = 1 

	-- Fifth this block, it will freeze until the next transaction 
	-- lifts the deadlock
	PRINT 'Attempting to update Person'
	UPDATE Person
	SET Person.Name = 'Teto'
	WHERE Person.idPerson = 1 

ROLLBACK TRANSACTION
