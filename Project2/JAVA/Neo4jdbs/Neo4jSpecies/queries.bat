pushd %~dp0
javac -cp ".;../Neo4jLib/*" SpeciesQueries.java
java -cp ".;../Neo4jLib/*" SpeciesQueries