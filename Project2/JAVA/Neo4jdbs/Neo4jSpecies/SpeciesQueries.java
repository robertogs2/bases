import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import org.neo4j.graphdb.*;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;

public class SpeciesQueries {

    private static final File databaseDirectory = new File("databases/species");
    private GraphDatabaseService graphDb;
    private Scanner scan;

    public static void main(final String[] args) throws IOException, InterruptedException {
        SpeciesQueries app = new SpeciesQueries();
        app.loadDatabase();
        app.listen();
        app.shutDown();
    }

    private void loadDatabase() throws IOException {
        scan = new Scanner(System.in);
        graphDb = new GraphDatabaseFactory().newEmbeddedDatabase(databaseDirectory);
        registerShutdownHook(graphDb);
    }

    private void listen() throws IOException, InterruptedException {
        String input;
        while (true) {
            System.out.println("Please enter a query");
            input = scan.nextLine();
            //System.out.println(input);
            if (input.toLowerCase().equals("exit")) {
                break;
            }
            else if(input.toLowerCase().equals("clear")){
                new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
            }
            else {
		String[] split = input.split(" ");
		if(split.length > 3){
			result(input);
		}
		else if(split[0].equals("Food")){
			result("match (n:Animal)-[:Eats]->(:Species {ScientificName : '" + input.substring(5, input.length()) + "'}) return n" );
		}
		else if(split[0].equals("Consumer")){
			result("match (n:Animal {ScientificName : '" + input.substring(9, input.length()) + "'})-[:Eats]->(m:Species) return m");
		}
		else{
                	result(input);
		}	
            }
        }

        System.out.println("Finished the run");
    }

    private void result(String input) {
        System.out.println("Executing: " + input);
        try (Transaction ignored = graphDb.beginTx(); Result result = graphDb.execute(input)) {
            while (result.hasNext()) {
                Map<String, Object> res = result.next();
                for (Map.Entry<String, Object> entry: res.entrySet()) {
                    Entity entity = (Entity)entry.getValue();
                    try{
                        Node node = (Node)entity;
                        node.getRelationships();
                        System.out.print("Found a node as " + entry.getKey() + ", with \n\tLabels: ");
                        System.out.println();
                        for(Label label : node.getLabels()){
                            System.out.println("\t\t" + label.name());
                        }
                    }
                    catch (Exception e){
                        e.printStackTrace();
                        Relationship relationship = (Relationship)entity;
                        System.out.print("Found a relationship with type: " + relationship.getType());
                    }
                    System.out.println("\n\tProperties: ");
                    for(String k : entity.getPropertyKeys()){
                        System.out.print("\t\t" + k + " : " + entity.getProperty(k) + " ");
                        System.out.println();
                    }
                    System.out.println();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    void shutDown() {
        System.out.println();
        System.out.println("Shutting down database ...");
        graphDb.shutdown();
    }

    private static void registerShutdownHook(final GraphDatabaseService graphDb) {
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                graphDb.shutdown();
            }
        });
    }
}