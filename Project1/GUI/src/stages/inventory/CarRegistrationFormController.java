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

import static java.sql.Types.NULL;
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

    private final int[] indexes = new int[4]; //index0 : brand, index1 : modelo
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
        listenToModel();
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

    private void listenToModel(){
        modelo_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = modelo_cb.getSelectionModel().getSelectedIndex();
            if(indexes[1] != -1){
                indexes[1] = Integer.decode(model_indexes.get(indexes[1]));
            }
        });
    }

    private void listenToSend(){
        send_bb.setOnMouseClicked(event -> {
            for( Node node: vBox.getChildren()) {
                if( node instanceof TextField) {
                    if(((TextField) node).getText().replace(" ","").equals("")){
                        Alert alert = new Alert(Alert.AlertType.ERROR);
                        alert.setTitle("Ooops!");
                        alert.setContentText("El campo "+node.getId().split("_")[0] + " no puede ser vacio.");
                        alert.showAndWait();
                        break;
                    }
                }
            }

            int ubicacion = NULL;
            /*try {
                if(indexes[0] == -1){
                    ubicacion = addFromCountry(country, province, city, zipCode, locationDescription);
                    //Add from country
                }
                else if(indexes[1] == -1){
                    //Add from province
                    ubicacion = addFromProvince(indexes[0], province, city, zipCode, locationDescription);
                }


                //Generates new person
                HashMap<String, List<String>> person_id = dao.selectData(queries.AGREGAR_PERSONA,
                        id, name, last_name, age, phone, extension, ubicacion);
                int new_person_id = Integer.parseInt(person_id.get("LAST_INSERT_ID()").get(0));
            } catch (Exception e1) {
                e1.printStackTrace();
            }*/
        });
    }

}
