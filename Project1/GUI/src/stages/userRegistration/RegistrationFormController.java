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


    //@FXML FlowPane flowPane;
    @FXML BorderPane borderPane;
    @FXML ComboBox country_cb;
    @FXML ComboBox province_cb;

    final int[] indexes = new int[2]; //index0 : country, index1 : province

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, String> country_list = new HashMap<>();
        try {
            country_list = dao.selectData(queries.OBTENER_PAISES).get(0);
        } catch (Exception e) {
            e.printStackTrace();
        }

        country_cb.getItems().setAll(country_list.values());
        listenToCountry();

    }

    private void listenToCountry(){
        country_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[0] = country_cb.getSelectionModel().getSelectedIndex();
            //updateProvince(indexes[0]);
        });
    }

    private void updateProvince(int countryIndex){
        try {
            HashMap<String, String> province_list = dao.selectData(queries.OBTENER_PROVINCIAS_POR_PAIS, countryIndex).get(0);
            province_cb.getItems().setAll(province_list.values());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void refresh(){

    }
}
