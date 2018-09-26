package stages.workshop;

import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.stage.FileChooser;
import main.Main;
import tools.ImageUploader;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.*;
import java.util.List;

import static main.Main.dao;
import static main.Main.queries;

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
                    HashMap<String, List<String>> cedula = dao.selectData(queries.OBTENER_ID_CLIENTE_POR_CEDULA,newValue);
                    if(cedula.get("matricula").size() > 0){
                        indexes[0] = Integer.valueOf(newValue);
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

    private void listenToSend(){
        send_bb.setOnMouseClicked(event -> {

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
