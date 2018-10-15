/*
 * Licensed to Neo4j under one or more contributor
 * license agreements. See the NOTICE file distributed with
 * this work for additional information regarding copyright
 * ownership. Neo4j licenses this file to you under
 * the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;
import org.neo4j.io.fs.FileUtils;

public class EmbeddedNeo4j {
    private static String nodePath = (System.getProperty("user.dir") + "/src/Person.csv").replaceAll("\\\\", "/");
    private static String relationPath = (System.getProperty("user.dir") + "/src/Relationship.csv").replaceAll("\\\\", "/");
    private static String cypherPath = (System.getProperty("user.dir") + "/src/import_csv.cypher").replaceAll("\\\\", "/");
    private static String[] cmds;
    private static final File databaseDirectory = new File("target/neo4j-hello-db");

    // START SNIPPET: vars
    private GraphDatabaseService graphDb;
    // END SNIPPET: vars


    public static void main(final String[] args) throws IOException {
        EmbeddedNeo4j app = new EmbeddedNeo4j();
        app.loadCypher();
        app.generate();
        app.add();
        app.shutDown();
    }

    private void loadCypher() throws IOException {
        String data = new String(Files.readAllBytes(Paths.get(cypherPath)));
        data = String.format(data, nodePath, relationPath, relationPath);
        cmds = data.split(";");
    }

    private void generate() throws IOException {
        // START SNIPPET: startDb
        graphDb = new GraphDatabaseFactory().newEmbeddedDatabase(databaseDirectory);
        registerShutdownHook(graphDb);
        // END SNIPPET: startDb
    }

    private void add() {
        System.out.println("About to run");
        for (int i = 0; i < cmds.length-1; i++) {
            try {
                int finalI = i;
                System.out.println(cmds[finalI]);
                graphDb.execute(cmds[finalI]);
                System.out.println("Running command: " + i);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        System.out.println("Finished the run");
    }

    void shutDown() {
        System.out.println();
        System.out.println("Shutting down database ...");
        // START SNIPPET: shutdownServer
        graphDb.shutdown();
        // END SNIPPET: shutdownServer
    }

    // START SNIPPET: shutdownHook
    private static void registerShutdownHook(final GraphDatabaseService graphDb) {
        // Registers a shutdown hook for the Neo4j instance so that it
        // shuts down nicely when the VM exits (even if you "Ctrl-C" the
        // running application).
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                graphDb.shutdown();
            }
        });
    }
    // END SNIPPET: shutdownHook
}