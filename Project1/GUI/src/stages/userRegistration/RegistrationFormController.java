package stages.userRegistration;

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
    @FXML ComboBox pais_cb;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, List<String>> pais_list = new HashMap<>();


        try {
            pais_list = dao.selectData(queries.OBTENER_PAISES);
        } catch (Exception e) {
            System.out.println("entre tus piernas pongo la berga");
            e.printStackTrace();
        }
        pais_cb.getItems().setAll(pais_list.get("nombre"));



    }

        private void refresh(){

    }
}
