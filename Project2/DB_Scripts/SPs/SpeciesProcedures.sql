-- DBCC CHECKIDENT ('[Species]', RESEED, 0)
DROP PROCEDURE GetBeings
CREATE PROCEDURE GetBeings AS
	WITH IDTable 
	AS (SELECT fk_idConsumer AS id FROM FoodChainLink
	UNION
	SELECT fk_idFood AS id FROM FoodChainLink)
	SELECT IDSpecies, fk_idSpeciesType AS IDType, ScientificName, NonScientificName FROM Species
	INNER JOIN IDTable ON IDTable.id = Species.idSpecies
	WHERE fk_idSpeciesType = 1 OR fk_idSpeciesType = 2
GO

DROP PROCEDURE GetChain
CREATE PROCEDURE GetChain AS
	SELECT fk_idConsumer AS IDConsumer, fk_idFood AS IDFood
	FROM FoodChainLink
GO

EXEC GetChain
EXEC GetBeings
