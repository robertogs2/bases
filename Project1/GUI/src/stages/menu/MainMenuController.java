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
    @FXML VBox tienda_vBox,taller_vBox;
    @FXML ComboBox concessionary_cb, car_shop_cb;
    @FXML Button tienda_btn, vender_btn, rep_btn, mec_btn;

    public static final int[] indexes = new int[2]; //index0 : concesionary, index1: carshop
    private static List<String> concessionary_indexes;
    private static List<String> carshop_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        clear_cb(concessionary_cb);

        initCB();
        initOptions();
        //listenToClient();
        //listenToCar();
        listenToConcesionary();
        listenToCarshop1();
    }

    private void initCB(){
        HashMap<String, List<String>> concesionary_list = new HashMap<>();
        HashMap<String, List<String>> car_shop_list = new HashMap<>();
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
        indexes[0] = 1;

        try {
            car_shop_list = dao.selectData(queries.OBTENER_TALLER_POR_CONCESIONARIO, indexes[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }
        carshop_indexes = car_shop_list.get("idTaller");
        List<String> carshops = car_shop_list.get("nombre");
        //Sets all concesionaries for the list and sets the first one as the visible
        car_shop_cb.getItems().setAll(carshops);
        car_shop_cb.setValue(carshops.get(0));
        indexes[1] = 1;
    }

    private void initOptions(){
        String cssLayout = "-fx-border-color: black;\n" +
                "-fx-border-insets: 5;\n" +
                "-fx-border-width: 3;\n" +
                "-fx-border-style: line;\n";
        tienda_vBox.setStyle(cssLayout);
        taller_vBox.setStyle(cssLayout);

        tienda_btn.setOnMouseClicked(event -> {
            try {
                showShopPane();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });

        vender_btn.setOnMouseClicked(event -> {
            try {
                showAddCar("");
            } catch (IOException e) {
                e.printStackTrace();
            }
        });

        rep_btn.setOnMouseClicked(event -> {
            try {
                showReparationsForm();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });

        mec_btn.setOnMouseClicked(event -> {
            try {
                showMechanicPane();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
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
    private void updateCarshop(int concesionary_index){
        try {
            car_shop_cb.getItems().clear();
            HashMap<String, List<String>> carshop_list = dao.selectData(queries.OBTENER_TALLER_POR_CONCESIONARIO, concesionary_index);
            carshop_indexes = carshop_list.get("idTaller"); //Stores in the list the ids from the carshops

            if(carshop_list.size() > 0) {
                List<String> carshops = carshop_list.get("nombre");
                car_shop_cb.getItems().setAll(carshops);
                car_shop_cb.setValue(carshops.get(0));
                indexes[1] = 1;
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

