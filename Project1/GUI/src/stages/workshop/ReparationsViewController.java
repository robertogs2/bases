package stages.workshop;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.util.*;

import static java.sql.Types.NULL;
import static main.Main.*;

public class ReparationsViewController implements Initializable {


    @FXML TextField cedula_tf;
    @FXML ComboBox<String> matricula_cb;
    @FXML TextArea descripcion_ta;
    @FXML Button send_bb,cancel_bb;

    public static String past;

    private final int[] indexes = new int[2]; //index0 : cedula, index1 : matricula

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        listenToCancel();
        listenToId();
    }

    private void listenToId(){
        cedula_tf.textProperty().addListener((observable, oldValue, newValue) -> {
            if(newValue.length() > 0 && newValue.matches("\\d+")){
                try {
                    HashMap<String, List<String>> clientId = dao.selectData(queries.OBTENER_ID_CLIENTE_POR_CEDULA,newValue);
                    if(clientId.get("idCliente").size() > 0){
                        indexes[0] = Integer.valueOf(clientId.get("idCliente").get(0));
                        updateMatricula();
                    }
                }catch (Exception e){

                }
            }
        });
    }

    private void updateMatricula(){
        try {
            clear_cb(matricula_cb);
            HashMap<String, List<String>> matriculas = dao.selectData(queries.OBTENER_MATRICULAS_POR_CLIENTE, indexes[0]);
            if(matriculas.size() > 0) {
                matricula_cb.getItems().setAll(matriculas.get("matricula"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void clear_cb(ComboBox cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field
    }

    private void listenToCancel(){
        cancel_bb.setOnMouseClicked(e -> {
            try {
                Main.showString(past);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        });
    }


    public static void showErrorMessage(String msg){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Ooooooops!");
        alert.setContentText(msg);
        alert.showAndWait();
    }

    public static void showInformation(String msg, String label) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(label);
        alert.setContentText(msg);
        alert.showAndWait();
    }
}
