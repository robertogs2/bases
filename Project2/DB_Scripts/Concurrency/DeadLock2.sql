BEGIN TRANSACTION;-- Second this for the same reason as the other     
 
	-- Fourth this block to create the deadlock in Person
	UPDATE Person
	SET Person.Name = 'Anrres'
	WHERE Person.idPerson = 1 

	-- Sixth this line, it will cause an error since we have park blocked
	-- so this transaction is killed and the deadlock in Person is removed
	-- the other transaction can continue
	UPDATE Park
	SET Park.Name = 'Jurassic kingdom'
	WHERE Park.idPark = 1 

COMMIT TRANSACTION
ROLLBACK TRANSACTION