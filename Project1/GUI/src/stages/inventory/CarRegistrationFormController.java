package stages.inventory;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.scene.layout.VBox;

import java.net.URL;
import java.util.*;

import static main.Main.queries;
import static main.Main.dao;

public class CarRegistrationFormController implements Initializable {

    @FXML ComboBox<String> marca_cb;
    @FXML ComboBox<String> modelo_cb;
    @FXML TextField matricula_tf;
    @FXML TextField color_tf;
    @FXML TextField estado_tf;
    @FXML TextField kilometraje_tf;
    @FXML TextField precio_tf;
    @FXML Button send_bb;
    @FXML VBox vBox;

    private final int[] indexes = new int[4]; //index0 : country, index1 : province, index2: city, index3: direction
    private static List<String> brand_indexes;
    private static List<String> model_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, List<String>> brand_list = new HashMap<>();

        clear_cb(marca_cb);
        clear_cb(modelo_cb);

        try {
            brand_list = dao.selectData(queries.OBTENER_MARCAS_REGISTRADAS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Arrays.fill(indexes, -1);
        brand_indexes = brand_list.get("idMarca");
        marca_cb.getItems().setAll(brand_list.get("nombre"));

        listenToBrand();
        listenToSend();
    }

    private void clear_cb(ComboBox<String> cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field

    }

    private void listenToBrand(){
        marca_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[0] = marca_cb.getSelectionModel().getSelectedIndex();
            if(indexes[0] != -1){
                indexes[0] = Integer.decode(brand_indexes.get(indexes[0]));
                updateModel(indexes[0]);
                //country_cb.setEditable(false);
            }
            else{
                clear_cb(modelo_cb);
            }
        });
    }

    private void updateModel(int brandIndex){
        try {
            modelo_cb.getItems().clear();
            HashMap<String, List<String>> province_list = dao.selectData(queries.ObTENER_MODELOS_POR_MARCA, brandIndex);
            model_indexes = province_list.get("idModelo");
            if(province_list.size() > 0) {
                modelo_cb.getItems().setAll(province_list.get("nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void listenToSend(){
        send_bb.setOnMouseClicked(event -> {
            for( Node node: vBox.getChildren()) {
                if( node instanceof TextField) {
                    if(((TextField) node).getText().replace(" ","") == ""){
                        Alert alert = new Alert(Alert.AlertType.ERROR);
                        alert.setTitle("Ooops!");
                        alert.setContentText("El campo "+node.getId().split("_")[0] + "no puede ser vacio.");

                        alert.showAndWait();
                    }
                }
            }
        });
    }

}
