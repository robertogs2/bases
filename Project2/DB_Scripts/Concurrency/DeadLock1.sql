BEGIN TRANSACTION;-- First run this to explicitly mark the starting point of a transaction   

	-- Third this block to create the deadlock in Park
	UPDATE Park
	SET Park.Name = 'Jurassic park'
	WHERE Park.idPark = 1 

	-- Fifth this block, it will freeze until the next transaction 
	-- lifts the deadlock
	UPDATE Person
	SET Person.Name = 'Teto'
	WHERE Person.idPerson = 1 

COMMIT TRANSACTION
ROLLBACK TRANSACTION
