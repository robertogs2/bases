package sample;

import DBConnection.MySQLAccess;
import DBConnection.Queries;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.util.HashMap;
import java.util.List;


public class Main2 extends Application {
    static Queries queries;
    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        primaryStage.setTitle("Hello World");
        primaryStage.setScene(new Scene(root, 300, 275));
        primaryStage.show();
    }


    public static void main(String[] args) throws Exception{
        queries = Queries.getInstance();
        MySQLAccess dao = new MySQLAccess();
        dao.connectToDB();
        HashMap<String, List<String>> data = dao.selectData(queries.ObTENER_INFO_CARRO_POR_CONCESIONARIO, 1);
        for(String key : data.keySet()){
            System.out.println(key + " : " + data.get(key));
        }
        System.out.println("DONE READING DATA");
        //launch(args);
    }
}
