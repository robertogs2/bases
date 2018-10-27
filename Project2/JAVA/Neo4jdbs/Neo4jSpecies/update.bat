pushd %~dp0
javac -cp ".;../Neo4jLib/*" SpeciesUpdater.java
java -cp ".;../Neo4jLib/*" SpeciesUpdater