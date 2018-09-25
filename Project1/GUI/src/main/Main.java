package main;

import DBConnection.MySQLAccess;
import DBConnection.Queries;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

import java.io.IOException;

public class Main extends Application {

    public static Stage primaryStage;
    private static BorderPane mainLayout;

    public static MySQLAccess dao;
    public static Queries queries;



    @Override
    public void start(Stage primaryStage) throws Exception{
        Main.primaryStage = primaryStage;
        Main.primaryStage.setTitle("Developer Workbench");

        queries = Queries.getInstance();
        dao = new MySQLAccess();
        dao.connectToDB();

        showMainPane();
        //showShopPane();
        showUserPane();
    }


    public void showMainPane() throws IOException {
        mainLayout = FXMLLoader.load(getClass().getResource("/main/MainPane.fxml"));
        Scene scene = new Scene(mainLayout);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public void showShopPane() throws IOException {
        Pane shopPane = FXMLLoader.load(getClass().getResource("/stages/shop/shop.fxml"));
        mainLayout.setCenter(shopPane);
    }

    public void showUserPane() throws IOException {
        Pane shopPane = FXMLLoader.load(getClass().getResource("/stages/userRegistration/RegistrationForm.fxml"));
        mainLayout.setCenter(shopPane);
    }

    public static void main(String[] args) {
        launch(args);
    }

}
