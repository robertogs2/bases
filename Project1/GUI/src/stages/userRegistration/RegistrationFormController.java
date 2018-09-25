package stages.userRegistration;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ComboBox;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;

import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.primaryStage;
import static main.Main.queries;
import static main.Main.dao;

public class RegistrationFormController implements Initializable {


    @FXML FlowPane flowPane;
    @FXML BorderPane borderPane;
    @FXML ComboBox country_cb;
    @FXML ComboBox province_cb;
    @FXML ComboBox city_cb;

    private final int[] indexes = new int[2]; //index0 : country, index1 : province
    private static List<String> country_indexes;
    private static List<String> province_indexes;
    private static List<String> city_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, List<String>> country_list = new HashMap<>();

        try {
            country_list = dao.selectData(queries.OBTENER_PAISES);
        } catch (Exception e) {
            e.printStackTrace();
        }
        country_indexes = country_list.get("idPais");
        country_cb.getItems().setAll(country_list.get("nombre"));
        listenToCountry();
        listenToProvince();
    }

    private void listenToCountry(){



        country_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[0] = country_cb.getSelectionModel().getSelectedIndex();
            if(indexes[0] != -1){
                updateProvince(Integer.decode(country_indexes.get(indexes[0])));
                //country_cb.setEditable(false);
            }
        });
    }
    private void listenToProvince(){
        province_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = province_cb.getSelectionModel().getSelectedIndex();
            province_cb.setEditable(true);
            if(indexes[1] != -1){
                updateCity(Integer.decode(province_indexes.get(indexes[1])));
                //province_cb.setEditable(false);
            }

        });
    }

    private void updateProvince(int countryIndex){
        try {
            province_cb.getItems().clear();
            HashMap<String, List<String>> province_list = dao.selectData(queries.OBTENER_PROVINCIAS_POR_PAIS, countryIndex);
            province_indexes = province_list.get("idProvincia");
            if(province_list.size() > 0) {
                province_cb.getItems().setAll(province_list.get("nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void updateCity(int provinceIndex){
        try {
            city_cb.getItems().clear();
            HashMap<String, List<String>> city_list = dao.selectData(queries.OBTENER_CIUDADES_POR_PROVINCIA, provinceIndex);
            city_indexes = city_list.get("idCiudad");
            if(city_list.size() > 0) {
                city_cb.getItems().setAll(city_list.get("nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void refresh(){

    }
}
