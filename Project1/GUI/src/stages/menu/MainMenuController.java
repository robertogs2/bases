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

import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.*;
import static main.Main.queries;

public class MainMenuController implements Initializable {

    @FXML BorderPane borderPane;
    @FXML VBox vBox;
    @FXML Button shop_bb;
    @FXML Button client_bb;
    @FXML Button car_bb;
    @FXML ComboBox concesionary_cb, carshop_cb;

    public final int[] indexes = new int[2]; //index0 : concesionary, index1: carshop
    private static List<String> concesionary_indexes;
    private static List<String> carshop_indexes;
    @Override
    public void initialize(URL location, ResourceBundle resources) {

        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, List<String>> concesionary_list = new HashMap<>();

        clear_cb(concesionary_cb);
        try {
            concesionary_list = dao.selectData(queries.OBTENER_CONCESIONARIOS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Arrays.fill(indexes, -1);
        concesionary_indexes = concesionary_list.get("idConcesionario");
        List<String> concesionaries = concesionary_list.get("nombre");

        //Sets all concesionaries for the list and sets the first one as the visible
        concesionary_cb.getItems().setAll(concesionaries);
        concesionary_cb.setValue(concesionaries.get(0));
        indexes[0] = 0;

        listenToShop();
        listenToClient();
        listenToCar();
        listenToConcesionary();
        listenToCarshop();
    }

    private void listenToShop(){
        shop_bb.setOnAction(event -> {
            try {
                showShopPane();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
    private void listenToClient(){
        client_bb.setOnAction(event -> {
            try {
                showUserPane();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
    private void listenToCar(){
        car_bb.setOnAction(event -> {
            try {
                showCarRegistrationForm();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
    private void listenToConcesionary(){
        concesionary_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[0] = concesionary_cb.getSelectionModel().getSelectedIndex();
            if(indexes[0] != -1){ //If we have selected some concesionary
                indexes[0] = Integer.decode(concesionary_indexes.get(indexes[0]));
                updateCarshop(indexes[0]);
            }
            else{
                clear_cb(concesionary_cb);
            }
        });
    }
    private void listenToCarshop(){
        carshop_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = carshop_cb.getSelectionModel().getSelectedIndex();
            if(indexes[1] != -1){ //If we have selected some concesionary
                indexes[1] = Integer.decode(carshop_indexes.get(indexes[1]));
            }
            else{
                clear_cb(carshop_cb);
            }
        });
    }

    private void updateCarshop(int concesionary_index){
        try {
            carshop_cb.getItems().clear();
            HashMap<String, List<String>> carshop_list = dao.selectData(queries.OBTENER_TALLER_POR_CONCESIONARIO, concesionary_index);
            carshop_indexes = carshop_list.get("idTaller"); //Stores in the list the ids from the carshops
            if(carshop_list.size() > 0) {
                carshop_cb.getItems().setAll(carshop_list.get("nombre"));
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

