package stages.userRegistration.mechanic;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import main.Main;
import stages.menu.MainMenuController;

import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.dao;
import static main.Main.queries;

public class MechanicFormController implements Initializable {


    @FXML FlowPane flowPane;
    @FXML BorderPane borderPane;
    @FXML ComboBox country_cb, province_cb, city_cb, direction_cb;
    @FXML TextField name_tf, last_name_tf, id_tf, age_tf, phone_tf, extension_tf;
    @FXML Button send_bb, cancel_bb;
    @FXML TextArea location_ta;
    private static List<String> country_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {


        int concesionary = MainMenuController.indexes[0];
        int car_shop = MainMenuController.indexes[1];

    }


    private void showErrorMessage(String msg){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Ooooooops!");
        alert.setContentText(msg);
        alert.showAndWait();
    }

}
