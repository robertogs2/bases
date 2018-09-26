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

        ///Conects to the database and generates the wrapper
        queries = Queries.getInstance();
        dao = new MySQLAccess();
        dao.connectToDB();

        showMainPane();
<<<<<<< HEAD

        ///Shows the main menu
        showMainMenu();
        //showMainMenu();
        //showUserPane();
        showShopPane();
>>>>>>> 2db3ff9bbd68c207ab8d5cb7fd380c45b946a713

    }

    public void showMainPane() throws IOException {
        mainLayout = FXMLLoader.load(getClass().getResource("/main/MainPane.fxml"));
        Scene scene = new Scene(mainLayout);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void showShopPane() throws IOException {
        Main.primaryStage.setTitle("Tienda");
        Pane shopPane = FXMLLoader.load(Main.class.getResource("/stages/shop/shop.fxml"));
        mainLayout.setCenter(shopPane);
    }
    public static void showCarRegistrationForm() throws IOException {
        Main.primaryStage.setTitle("Registrar carro");
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/inventory/CarRegistrationForm.fxml"));
        mainLayout.setCenter(pane);
    }
    public static void showUserPane() throws IOException {
        Main.primaryStage.setTitle("Registrar cliente");
        Pane shopPane = FXMLLoader.load(Main.class.getResource("/stages/userRegistration/client/RegistrationForm.fxml"));
        mainLayout.setCenter(shopPane);
    }
    public static void showMainMenu() throws IOException {
        Main.primaryStage.setTitle("Menu principal");
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/menu/MainMenu.fxml"));
        mainLayout.setCenter(pane);
    }
    public static void showPreview() throws IOException {
        AnchorPane previewPane = FXMLLoader.load(Main.class.getResource("/stages/preview/preview.fxml"));
        mainLayout.setCenter(previewPane);
    }

<<<<<<< HEAD
=======
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
>>>>>>> 2db3ff9bbd68c207ab8d5cb7fd380c45b946a713

    public static void main(String[] args) throws Exception{
        launch(args);
    }

}
