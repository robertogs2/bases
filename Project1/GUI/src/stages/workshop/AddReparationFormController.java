package stages.workshop;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

import static main.Main.*;

public class AddReparationFormController implements Initializable {

    @FXML TextField cedula_tf;
    @FXML ComboBox<String> matricula_cb;
    @FXML TextArea descripcion_ta;
    @FXML Button send_bb,cancel_bb;

    private final int[] indexes = new int[2]; //index0 : cedula, index1 : matricula

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        listenToCancel();
        listenToName();
    }

    private void listenToName(){
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

    private void listenToMatricula(){
        matricula_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = matricula_cb.getSelectionModel().getSelectedIndex();
        });
    }

    private void listenToSend(){
        send_bb.setOnMouseClicked(event -> {
            boolean flag = true;
            if(cedula_tf.getText().equals("")){
                showErrorMessage("Ingrese la cedula.");
                flag = false;
            }
            if(matricula_cb.valueProperty().getValue().equals("")){
                showErrorMessage("ingrese un numero de matricula.");
                flag = false;
            }
            if(flag){
                if (indexes[0] == -1) {
                    try {
                        int personId;
                        HashMap<String, List<String>> personIds = dao.selectData(queries.OBTENER_ID_PERSONA_POR_CEDULA, cedula_tf.getText());
                        if(personIds.get("idPersona").size() > 0){
                            personId = Integer.valueOf(personIds.get("idPersona").get(0));
                        }else{
                            personId = showAddPersonStage(cedula_tf.getText());
                        }
                        HashMap<String, List<String>> id = dao.selectData(queries.OBTENER_ID_CLIENTE_POR_CEDULA, cedula_tf.getText());
                        if(id.get("idCliente").size() == 0){
                            dao.selectData(queries.AGREGAR_CLIENTE_POR_CEDULA, cedula_tf.getText());
                        }
                    }catch (Exception e){}
                }
                if (indexes[1] == -1) {
                    try {
                        showAddCar(matricula_cb.valueProperty().getValue());
                    }catch (Exception e){
                        showErrorMessage("No se pudo agregar el carro.");
                    }
                }

                DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                Date dateobj = new Date();
                try {
                    dao.pushData(queries.AGREGAR_REPARACION, df.format(dateobj), "NULL", matricula_cb.valueProperty().getValue(), descripcion_ta.getText());
                }catch (Exception e){}
            }
        });
    }

    private void clear_cb(ComboBox<String> cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field
    }

    private void listenToCancel(){
        cancel_bb.setOnMouseClicked(e -> {
            try {
                Main.showMainMenu();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        });
    }

    private void showErrorMessage(String msg){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Ooops!");
        alert.setContentText(msg);
        alert.showAndWait();
    }

}
