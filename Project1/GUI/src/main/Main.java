package main;

import DBConnection.MySQLAccess;
import DBConnection.Queries;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import stages.preview.previewController;

import java.io.IOException;
import java.util.List;

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
        //showPreview();
        //showMainMenu();
        //showUserPane();
        showShopPane();

    }


    public void showMainPane() throws IOException {
        mainLayout = FXMLLoader.load(getClass().getResource("/main/MainPane.fxml"));
        Scene scene = new Scene(mainLayout);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void showShopPane() throws IOException {
        Pane shopPane = FXMLLoader.load(Main.class.getResource("/stages/shop/shop.fxml"));
        mainLayout.setCenter(shopPane);
    }
    public static void showCarRegistrationForm() throws IOException {
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/inventory/CarRegistrationForm.fxml"));
        mainLayout.setCenter(pane);
    }
    public static void showUserPane() throws IOException {
        Pane shopPane = FXMLLoader.load(Main.class.getResource("/stages/userRegistration/client/RegistrationForm.fxml"));
        mainLayout.setCenter(shopPane);
    }
    public static void showMainMenu() throws IOException {
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/menu/MainMenu.fxml"));
        mainLayout.setCenter(pane);
    }
    public static void showPreview() throws IOException {
        AnchorPane previewPane = FXMLLoader.load(Main.class.getResource("/stages/preview/preview.fxml"));
        mainLayout.setCenter(previewPane);
    }

    public static void showPreviewStage(List<String> attributes, List<String> values) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/preview/preview.fxml"));
        AnchorPane anchorPane = fxmlLoader.load();
        Stage addInventoryStage = new Stage();
        addInventoryStage.setTitle("Car Preview");
        addInventoryStage.initModality(Modality.WINDOW_MODAL);
        addInventoryStage.initOwner(primaryStage);
        Scene scene = new Scene(anchorPane);
        addInventoryStage.setScene(scene);
        previewController previewController = fxmlLoader.getController();
        previewController.addAttributes(attributes,values);
        addInventoryStage.showAndWait();
    }

    public static void show_pane(String pane) throws IOException{
        if(pane == "shop"){
            showShopPane();
        }
        else if(pane == "user"){
            showUserPane();
        }
        else if(pane == "main"){
            showMainMenu();
        }
        else if(pane == "car_registration"){
            showCarRegistrationForm();
        }
    }

    public static void main(String[] args) throws Exception{
        launch(args);
    }

}
