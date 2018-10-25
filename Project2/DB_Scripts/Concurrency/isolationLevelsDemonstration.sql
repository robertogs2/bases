-- Set to READ UNCOMMITTED allows us to read changes that have not been commited
-- it also help us to avoid locks that would be produced by other transactions modifyinG the data
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- Set to READ COMMITTED prevent us from reading changes that have not been commited
-- prevents dirty reads, the query is frozen until the transaction is commited
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Set to REPEATABLE READ prevent us from reading changes that have not been commited
-- and from modifying data that is being read. This helps us to avoid changing data that some
-- other transaction is reading. Allows insertion and read at the same time
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ


BEGIN TRANSACTION
	SELECT Park.Name 
	FROM Park
	WHERE Park.idPark = 1
	WAITFOR DELAY '00:00:10'
	GO
ROLLBACK
