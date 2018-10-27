import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;
import org.neo4j.io.fs.FileUtils;

public class SpeciesUpdater {
    private static final String nodePath = (System.getProperty("user.dir") + "/data/beings.csv").replaceAll("\\\\", "/");
    private static final String relationPath = (System.getProperty("user.dir") + "/data/chain.csv").replaceAll("\\\\", "/");
    private static final String cypherPath = (System.getProperty("user.dir") + "/data/importCSV.cypher").replaceAll("\\\\", "/");
    private static String[] cmds;
    private static final File databaseDirectory = new File("databases/species");
    public GraphDatabaseService graphDb;

    public static void main(final String[] args) throws IOException {
        SpeciesUpdater app = new SpeciesUpdater();
        app.loadCypher();
        app.create();
        app.update();
        app.shutDown();
    }

    private void loadCypher() throws IOException {
        String data = new String(Files.readAllBytes(Paths.get(cypherPath)));
        data = String.format(data, nodePath, relationPath);
        cmds = data.split(";");
    }

    private void create() throws IOException {
	   FileUtils.deleteRecursively( databaseDirectory );
        graphDb = new GraphDatabaseFactory().newEmbeddedDatabase(databaseDirectory);
        registerShutdownHook(graphDb);
    }

    private void update() {
        System.out.println("About to run");
        for (int i = 0; i < cmds.length; i++) {
            try {
                System.out.println(cmds[i]);
                graphDb.execute(cmds[i]);
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
        graphDb.shutdown();
    }

    private static void registerShutdownHook( final GraphDatabaseService graphDb ){
        Runtime.getRuntime().addShutdownHook( new Thread(){
            @Override
            public void run(){
                graphDb.shutdown();
            }
        } );
    }
}