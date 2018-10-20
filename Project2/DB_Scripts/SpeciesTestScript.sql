
INSERT INTO Species(ScientificName, NonScientificName)
VALUES('uno', 'uno')
INSERT INTO Species(ScientificName, NonScientificName)
VALUES('uno', 'd')
INSERT INTO Species(ScientificName, NonScientificName)
VALUES('uno', 'v')
INSERT INTO Species(ScientificName, NonScientificName)
VALUES('uno', 'b')
INSERT INTO Species(ScientificName, NonScientificName)
VALUES('uno', 'c')

SELECT * FROM testv
SELECT * FROM FoodChainLink
INSERT INTO FoodChainLink(fk_idConsumer, fk_idFood)
VALUES(4,6)

CREATE VIEW testv AS
SELECT fk_idConsumer AS id FROM FoodChainLink
UNION
SELECT fk_idFood AS id FROM FoodChainLink;



--Missing some things...
SELECT ScientificName, NonScientificName, SpeciesType."Type" FROM Species
INNER JOIN testv ON testv.id = Species.idSpecies
LEFT JOIN SpeciesType ON SpeciesType.idSpeciesType = Species.fk_idSpeciesType
DROP VIEW testv;