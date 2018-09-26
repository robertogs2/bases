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
import stages.inventory.CarRegistrationFormController;
import stages.preview.previewController;
import stages.userRegistration.client.RegistrationFormController;

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

        ///Shows the main menu
        //showMainMenu();
        showMechanicPane();
        //showMainMenu();
        //showUserPane();
        //showShopPane();
        showTables();

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
    public static void showMechanicPane() throws IOException {
        Main.primaryStage.setTitle("Agregar mecánico");
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/userRegistration/mechanic/MechanicForm.fxml"));
        mainLayout.setCenter(pane);
    }

    public static void showPreview() throws IOException {
        AnchorPane previewPane = FXMLLoader.load(Main.class.getResource("/stages/preview/preview.fxml"));
        mainLayout.setCenter(previewPane);
    }
    public static void showTables() throws IOException {
        AnchorPane previewPane = FXMLLoader.load(Main.class.getResource("/stages/tables/TableVisualization.fxml"));
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

    public static int showAddPersonStage(String cedula) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/userRegistration/client/RegistrationForm.fxml"));
        BorderPane borderPane = fxmlLoader.load();
        Stage addInventoryStage = new Stage();
        addInventoryStage.setTitle("Agregar Persona");
        addInventoryStage.initModality(Modality.WINDOW_MODAL);
        addInventoryStage.initOwner(primaryStage);
        Scene scene = new Scene(borderPane);
        addInventoryStage.setScene(scene);
        RegistrationFormController previewController = fxmlLoader.getController();
        previewController.setCedula(cedula);
        addInventoryStage.showAndWait();
        return previewController.getPersonId();
    }

    public static void showAddCar(String matricula) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/inventory/CarRegistrationForm.fxml"));
        BorderPane borderPane = fxmlLoader.load();
        Stage addInventoryStage = new Stage();
        addInventoryStage.setTitle("Agregar Carro");
        addInventoryStage.initModality(Modality.WINDOW_MODAL);
        addInventoryStage.initOwner(primaryStage);
        Scene scene = new Scene(borderPane);
        addInventoryStage.setScene(scene);
        CarRegistrationFormController previewController = fxmlLoader.getController();
        previewController.setMatricula(matricula);
        addInventoryStage.showAndWait();
    }

    public static void showString(String toShow) throws IOException {
        if(toShow.compareTo("menu") == 0){
            showMainMenu();
        }
        else if(toShow.compareTo("user") == 0){
            showUserPane();
        }
        else if(toShow.compareTo("shop") == 0){
            showShopPane();
        }
        else if(toShow.compareTo("mechanic") == 0){
            showMechanicPane();
        }
    }

    public static void main(String[] args) throws Exception{
        launch(args);
    }

}
