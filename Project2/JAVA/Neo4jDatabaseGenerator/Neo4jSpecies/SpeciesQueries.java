import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Result;
import org.neo4j.graphdb.Transaction;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;
import org.neo4j.io.fs.FileUtils;
import java.util.Scanner; 
import java.util.Map;
public class SpeciesQueries {

    private static final File databaseDirectory = new File("databases/species");
    private GraphDatabaseService graphDb;
    private Scanner scan;

    public static void main(final String[] args) throws IOException {
        SpeciesQueries app = new SpeciesQueries();
        app.loadDatabase();
        app.listen();
        app.shutDown();
    }

    private void loadDatabase() throws IOException {
    	FileUtils.deleteRecursively( databaseDirectory );
        scan = new Scanner(System.in);
        graphDb = new GraphDatabaseFactory().newEmbeddedDatabase(databaseDirectory);
        registerShutdownHook(graphDb);
    }

    private void listen() {
        String input;
        while(true){
            System.out.println("Please enter a query");
            input = scan.next();
            if(input.toLowerCase().equals("exit") || input.toLowerCase().equals("e")){
                break;
            }
            else{
                result(input);
            }
        }
        
        System.out.println("Finished the run");
    }

    private void result(String input){
        try (Transaction ignored = graphDb.beginTx(); Result result = graphDb.execute(input)){
            while ( result.hasNext() ){
                    Map<String,Object> row = result.next();
                    String line;
                    for ( Entry<String,Object> column : row.entrySet() ){
                        line = column.getKey() + ": " + column.getValue() + "; ";
                        System.out.println(line);
                    }
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
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