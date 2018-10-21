
INSERT INTO SpeciesType("Type")
VALUES ('Animal')
INSERT INTO SpeciesType("Type")
VALUES ('Vegetal')
INSERT INTO SpeciesType("Type")
VALUES ('Mineral')

INSERT INTO Species(ScientificName, NonScientificName, fk_idSpeciesType)
VALUES('dog', 'perrus',1)
INSERT INTO Species(ScientificName, NonScientificName, fk_idSpeciesType)
VALUES('cat', 'gatus',1)
INSERT INTO Species(ScientificName, NonScientificName, fk_idSpeciesType)
VALUES('uno', 'v',1)
INSERT INTO Species(ScientificName, NonScientificName, fk_idSpeciesType)
VALUES('uno', 'b',2)
INSERT INTO Species(ScientificName, NonScientificName, fk_idSpeciesType)
VALUES('uno', 'c',2)
SELECT * FROM SpeciesType
SELECT * FROM Species
SELECT * FROM FoodChainLink

DELETE FROM FoodChainLink
DELETE FROM Species
DBCC CHECKIDENT ('[Species]', RESEED, 0)

INSERT INTO FoodChainLink(fk_idConsumer, fk_idFood)
VALUES(1,2)
INSERT INTO FoodChainLink(fk_idConsumer, fk_idFood)
VALUES(1,3)
INSERT INTO FoodChainLink(fk_idConsumer, fk_idFood)
VALUES(1,4)
INSERT INTO FoodChainLink(fk_idConsumer, fk_idFood)
VALUES(1,5)
INSERT INTO FoodChainLink(fk_idConsumer, fk_idFood)
VALUES(2,3)

CREATE PROCEDURE GetBeings AS
--Missing some things...
WITH IDTable 
AS (SELECT fk_idConsumer AS id FROM FoodChainLink
UNION
SELECT fk_idFood AS id FROM FoodChainLink)
SELECT IDSpecies, fk_idSpeciesType AS IDType, ScientificName, NonScientificName FROM Species
INNER JOIN IDTable ON IDTable.id = Species.idSpecies
GO

CREATE PROCEDURE GetChain AS
SELECT fk_idConsumer AS IDConsumer, fk_idFood AS IDFood
FROM FoodChainLink
GO
EXEC GetChain
EXEC GetBeings
