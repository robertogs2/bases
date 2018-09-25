package stages.inventory;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;

import java.net.URL;
import java.util.*;

import static main.Main.primaryStage;
import static main.Main.queries;
import static main.Main.dao;

public class CarRegistrationFormController implements Initializable {

    @FXML ComboBox marca_cb;
    @FXML ComboBox modelo_cb;
¿    @FXML TextField matricula_tf;
    @FXML TextField color_tf;
    @FXML TextField estado_tf;
    @FXML TextField kilometraje_tf;
    @FXML TextField precio_tf;
    @FXML Button send_bb;
¿
    private final int[] indexes = new int[4]; //index0 : country, index1 : province, index2: city, index3: direction
    private static List<String> country_indexes;
    private static List<String> province_indexes;
    private static List<String> city_indexes;
    private static List<String> direction_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, List<String>> marca_list = new HashMap<>();

        clear_cb(marca_cb);
        clear_cb(modelo_cb);

        try {
            marca_list = dao.selectData(queries.OBTENER_PAISES);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Arrays.fill(indexes, -1);
        country_indexes = country_list.get("idPais");
        country_cb.getItems().setAll(country_list.get("nombre"));

    }

    private void clear_cb(ComboBox cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field

    }

}
