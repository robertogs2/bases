MATCH (n)
DETACH DELETE n;

// Create Species
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///%s" AS row
FOREACH(ignoreMe IN CASE WHEN toInt(row.IDType) = 1 THEN [1] ELSE [] END | 
    CREATE (:Species:Animal {NonScientificName: row.NonScientificName, ScientificName: row.ScientificName, IDSpecies : row.IDSpecies})
)
FOREACH(ignoreMe IN CASE WHEN NOT toInt(row.IDType) = 1 THEN [1] ELSE [] END | 
    CREATE (:Species:Vegetal {NonScientificName: row.NonScientificName, ScientificName: row.ScientificName, IDSpecies : row.IDSpecies})
);

//Create index to ensure quick lookup when creating relations
CREATE INDEX ON :Animal(IDSpecies);
CREATE INDEX ON :Vegetal(IDSpecies);

// Creating chain relations
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///%s" AS row
MATCH (speciesA:Species {IDSpecies: row.IDEater})
MATCH (speciesB:Species {IDSpecies: row.IDFood})
MERGE (speciesA)-[:Eats]->(speciesB);

MATCH (n)
RETURN n;