package stages.menu;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;
import stages.userRegistration.client.RegistrationFormController;

import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.*;
import static main.Main.queries;
import static stages.userRegistration.client.RegistrationFormController.past;

public class MainMenuController implements Initializable {

    @FXML BorderPane borderPane;
    @FXML VBox vBox;
    @FXML ComboBox concessionary_cb, car_shop_cb, shop_cb, car_shop2_cb;;

    public static final int[] indexes = new int[2]; //index0 : concesionary, index1: carshop
    private static List<String> concessionary_indexes;
    private static List<String> carshop_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, List<String>> concesionary_list = new HashMap<>();

        clear_cb(concessionary_cb);
        try {
            concesionary_list = dao.selectData(queries.OBTENER_CONCESIONARIOS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Arrays.fill(indexes, -1);
        concessionary_indexes = concesionary_list.get("idConcesionario");
        List<String> concesionaries = concesionary_list.get("nombre");

        //Sets all concesionaries for the list and sets the first one as the visible
        concessionary_cb.getItems().setAll(concesionaries);
        concessionary_cb.setValue(concesionaries.get(0));
        indexes[0] = 0;

        //Sets the list for the carshop options
        car_shop2_cb.getItems().add("Reparaciones");
        car_shop2_cb.getItems().add("Mecánicos");

        //Sets the list for the shop options
        shop_cb.getItems().add("Ver tienda");
        shop_cb.getItems().add("Vender auto");


        //listenToClient();
        //listenToCar();
        listenToShop();
        listenToConcesionary();
        listenToCarshop1();
        listenToCarshop2();
    }

    private void listenToConcesionary(){//Done
        concessionary_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[0] = concessionary_cb.getSelectionModel().getSelectedIndex();
            if(indexes[0] != -1){ //If we have selected some concesionary
                indexes[0] = Integer.decode(concessionary_indexes.get(indexes[0]));
                updateCarshop(indexes[0]);
            }
            else{
                clear_cb(concessionary_cb);
            }
        });
    }//Done
    private void listenToCarshop1(){//Done
        car_shop_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = car_shop_cb.getSelectionModel().getSelectedIndex();
            if(indexes[1] != -1){ //If we have selected some car shop
                indexes[1] = Integer.decode(carshop_indexes.get(indexes[1]));
            }
            else{
                clear_cb(car_shop_cb);
            }
        });
    }//Done
    private void listenToShop(){//Done
        shop_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            try {
                int selected = shop_cb.getSelectionModel().getSelectedIndex();
                if(selected == 0){ //If we selected to go to the shop
                    System.out.println("Entrar a tienda");
                    showShopPane();
                }
                else if(selected == 1){
                    showAddCar("");
                    System.out.println("Entrar a poner en venta");
                }
                else{
                    System.out.println("No hacer nada tienda");
                    clear_cb(shop_cb);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }//Done
    private void listenToCarshop2(){//Done
        car_shop2_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            int selected = car_shop2_cb.getSelectionModel().getSelectedIndex();
            if(selected == 0){ //If we selected to go to reparaciones
                //Show Reparaiones
                System.out.println("Entrar a reparaciones");
            }
            else if(selected == 1){
                System.out.println("Entrar a ver los mecánicos");
            }
            else{
                System.out.println("No hacer nada");
                clear_cb(car_shop2_cb);
            }
        });
    }//Done

    private void updateCarshop(int concesionary_index){
        try {
            car_shop_cb.getItems().clear();
            HashMap<String, List<String>> carshop_list = dao.selectData(queries.OBTENER_TALLER_POR_CONCESIONARIO, concesionary_index);
            carshop_indexes = carshop_list.get("idTaller"); //Stores in the list the ids from the carshops
            if(carshop_list.size() > 0) {
                car_shop_cb.getItems().setAll(carshop_list.get("nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void clear_cb(ComboBox cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field
    }

}

