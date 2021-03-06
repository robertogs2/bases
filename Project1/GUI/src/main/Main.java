package main;

import DBConnection.MySQLAccess;
import DBConnection.Queries;
import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import stages.inventory.CarRegistrationFormController;
import stages.menu.MainMenuController;
import stages.preview.previewController;
import stages.shop.shopController;
import stages.tables.mechanic.reparations.SingleReparationController;
import stages.userRegistration.client.RegistrationFormController;
import stages.userRegistration.mechanic.MechanicFormController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Main extends Application {

    public static Stage primaryStage;
    private static BorderPane mainLayout;

    public static MySQLAccess dao;
    public static Queries queries;
    //public static Stage popUpStage;

    public static List<Stage> popUpStages;
    @Override
    public void start(Stage primaryStage) throws Exception{
        Main.primaryStage = primaryStage;
        Main.primaryStage.setTitle("Developer Workbench");
        popUpStages = new ArrayList<>();
        ///Conects to the database and generates the wrapper
        queries = Queries.getInstance();
        dao = new MySQLAccess();
        dao.connectToDB();

        showMainPane();
        //showAllMechanicsPane();
        ///Shows the main menu
        showMainMenu();
        //showMechanicPane();
        //showMainMenu();
        //showUserPane();
        //showShopPane();
        //showTables();
        //showReparationsForm();
    }

    public void showMainPane() throws IOException {
        mainLayout = FXMLLoader.load(getClass().getResource("/main/MainPane.fxml"));
        Scene scene = new Scene(mainLayout);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void showShopPane(int consecionario) throws IOException {
        Main.primaryStage.setTitle("Tienda");
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/shop/shop.fxml"));
        Pane shopPane = fxmlLoader.load();
        shopController shopController = fxmlLoader.getController();
        shopController.fillCars(consecionario);
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

    public static void showAllMechanicsPane() throws IOException {
        Main.primaryStage.setTitle("Mecánicos");
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/tables/mechanic/MechanicVisualization.fxml"));
        mainLayout.setCenter(pane);
    }
    public static void showMechanicPane() throws IOException {
        Main.primaryStage.setTitle("Agregar mecánico");
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/userRegistration/mechanic/MechanicForm.fxml"));
        mainLayout.setCenter(pane);
    }

    public static void showReparationsForm() throws IOException {
        Main.primaryStage.setTitle("Reparaciones");
        Pane pane = FXMLLoader.load(Main.class.getResource("/stages/workshop/ReparationForm.fxml"));
        mainLayout.setCenter(pane);
    }

    public static void showPreview() throws IOException {
        AnchorPane previewPane = FXMLLoader.load(Main.class.getResource("/stages/preview/preview.fxml"));
        mainLayout.setCenter(previewPane);
    }
    public static void showTables() throws IOException {
        AnchorPane previewPane = FXMLLoader.load(Main.class.getResource("/stages/tables/persona/TableVisualization.fxml"));
        mainLayout.setCenter(previewPane);
    }

    public static void showCompras() throws IOException {
        AnchorPane previewPane = FXMLLoader.load(Main.class.getResource("/stages/tables/compra/CompraVisualization.fxml"));
        mainLayout.setCenter(previewPane);
    }

    public static void showPreviewStage(int pk, List<String> attributes, List<String> values, ObservableList<String> urls) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/preview/preview.fxml"));
        AnchorPane anchorPane = fxmlLoader.load();
        Stage addInventoryStage = new Stage();
        addInventoryStage.setTitle("Car Preview");
        addInventoryStage.initModality(Modality.WINDOW_MODAL);
        addInventoryStage.initOwner(primaryStage);
        Scene scene = new Scene(anchorPane);
        addInventoryStage.setScene(scene);
        previewController previewController = fxmlLoader.getController();
        previewController.addAttributes(pk,attributes,values,urls);
        popUpStages.add(addInventoryStage);
        addInventoryStage.showAndWait();
    }

    public static int showAddPersonStage(String cedula) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/userRegistration/client/RegistrationForm.fxml"));
        BorderPane borderPane = fxmlLoader.load();
        Stage popUpStage = new Stage();
        popUpStage.setTitle("Agregar Persona");
        popUpStage.initModality(Modality.WINDOW_MODAL);
        popUpStage.initOwner(primaryStage);
        Scene scene = new Scene(borderPane);
        popUpStage.setScene(scene);
        RegistrationFormController previewController = fxmlLoader.getController();
        previewController.setCedula(cedula);
        popUpStages.add(popUpStage);
        popUpStage.showAndWait();
        return previewController.getPersonId();
    }

    public static void showAddMechanicStage() throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/userRegistration/mechanic/MechanicForm.fxml"));
        BorderPane borderPane = fxmlLoader.load();
        Stage popUpStage = new Stage();
        popUpStage.setTitle("Agregar Mecánico");
        popUpStage.initModality(Modality.WINDOW_MODAL);
        popUpStage.initOwner(primaryStage);
        Scene scene = new Scene(borderPane);
        popUpStage.setScene(scene);
        MechanicFormController previewController = fxmlLoader.getController();
        popUpStages.add(popUpStage);
        popUpStage.showAndWait();
    }

    public static void showReparationsByMechanicStage(String mechanicId) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/tables/mechanic/reparations/SingleReparation.fxml"));
        AnchorPane anchorPane = fxmlLoader.load();
        Stage popUpStage = new Stage();
        popUpStage.setTitle("Reparaciones del mecánico");
        popUpStage.initModality(Modality.WINDOW_MODAL);
        popUpStage.initOwner(primaryStage);
        Scene scene = new Scene(anchorPane);
        popUpStage.setScene(scene);
        SingleReparationController previewController = fxmlLoader.getController();
        previewController.setId(mechanicId);
        popUpStages.add(popUpStage);
        popUpStage.showAndWait();
    }

    public static void showAddCar(String matricula, String cedula, boolean toRep) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("/stages/inventory/CarRegistrationForm.fxml"));
        BorderPane borderPane = fxmlLoader.load();
        Stage popUpStage = new Stage();
        popUpStage.setTitle("Agregar Carro");
        popUpStage.initModality(Modality.WINDOW_MODAL);
        popUpStage.initOwner(primaryStage);
        Scene scene = new Scene(borderPane);
        popUpStage.setScene(scene);
        CarRegistrationFormController previewController = fxmlLoader.getController();
        previewController.setMatricula(matricula);
        previewController.setCedula(cedula);
        previewController.setToRep(toRep);
        popUpStages.add(popUpStage);
        popUpStage.showAndWait();
    }


    public static void showAddCar(String matricula) throws IOException {
        showAddCar(matricula,"",false);
    }

    public static void showString(String toShow) throws IOException {
        if(toShow.compareTo("menu") == 0){
            showMainMenu();
        }
        else if(toShow.compareTo("user") == 0){
            showUserPane();
        }
        else if(toShow.compareTo("shop") == 0){
            showShopPane(MainMenuController.concesionario);
        }
        else if(toShow.compareTo("mechanic") == 0){
            showMechanicPane();
        }
    }

    public static void main(String[] args) throws Exception{
        launch(args);
    }

}
