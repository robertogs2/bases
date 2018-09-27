package stages.workshop;

import javafx.application.Platform;
import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Insets;
import javafx.scene.Node;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.util.Pair;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

import static main.Main.*;

public class ReparationFormController implements Initializable {

    @FXML TextField cedula_tf;
    @FXML ComboBox<String> matricula_cb, fecha_cb;
    @FXML TextArea descripcion_ta;
    @FXML Button send_bb,cancel_bb, addMechanic_bb;
    @FXML TableView mecanicos_tbl;
    @FXML TableColumn<Object, Object> mecanico_clm, horas_clm;
    @FXML VBox vBox;

    private final int[] indexes = new int[3]; //index0 : cedula, index1 : matricula, index2 : idReparacion

    private String mode;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        Arrays.fill(indexes,-1);
        this.mode = "VIEW";

        mecanico_clm.setCellValueFactory(new PropertyValueFactory<>("name"));
        horas_clm.setCellValueFactory(new PropertyValueFactory<>("horas"));

        listenToMode();
        listenToCancel();
        listenToAddMechanic();
        listenToName();
        listenToMatricula();
        listenToDate();
        listenToSend();
    }

    private void listenToDate(){
        fecha_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
                int i = -1;
                i = matricula_cb.getSelectionModel().getSelectedIndex();
                if(i != -1){
                    try {
                        HashMap<String,List<String>> reparations = dao.selectData(queries.OBTENER_REPARACIONES_POR_FECHA,
                                matricula_cb.valueProperty().getValue(),fecha_cb.valueProperty().getValue());
                        System.out.println(fecha_cb.valueProperty().getValue());
                        if(reparations.get("fechaHoraInicio") != null){
                            descripcion_ta.setText(reparations.get("descripcion").get(0));
                            indexes[2] = Integer.valueOf(reparations.get("idReparacion").get(0));
                            updateMechanics();
                        }
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                }
        });
    }

    private void listenToMode(){
        switch (this.mode){
            case("VIEW"):
                send_bb.setText("Agregar Reparacion");
                descripcion_ta.editableProperty().setValue(false);
                if(!vBox.getChildren().contains(mecanicos_tbl))vBox.getChildren().add(mecanicos_tbl);
                addMechanic_bb.visibleProperty().setValue(true);
                break;
            case("ADD"):
                send_bb.setText("Enviar Formulario");
                descripcion_ta.editableProperty().setValue(true);
                vBox.getChildren().remove(mecanicos_tbl);
                addMechanic_bb.visibleProperty().setValue(false);
                break;
        }
    }

    private void listenToName(){
        cedula_tf.textProperty().addListener((observable, oldValue, newValue) -> {
            if(newValue.length() > 0 && newValue.matches("\\d+")){
                try {
                    HashMap<String, List<String>> clientId = dao.selectData(queries.OBTENER_ID_CLIENTE_POR_CEDULA,newValue);
                    System.out.println(clientId);
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
            System.out.println(matriculas);
            if(matriculas.get("matricula")!=null) {
                matricula_cb.getItems().setAll(matriculas.get("matricula"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void listenToMatricula(){
        matricula_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = matricula_cb.getSelectionModel().getSelectedIndex();
            if(indexes[1] != -1){
                try {
                    HashMap<String,List<String>> reparations = dao.selectData(queries.OBTENER_REPARACIONES,matricula_cb.valueProperty().getValue());
                    if(reparations.get("fechaHoraInicio").size() > 0){
                        fecha_cb.getItems().clear();
                        fecha_cb.getItems().setAll(reparations.get("fechaHoraInicio"));
                    }
                }catch (Exception e){

                }

            }
        });
    }

    private void listenToSend(){
        send_bb.setOnMouseClicked(event -> {
            if(this.mode.equals("VIEW")){
                this.mode = "ADD";
                listenToMode();
            }else if(this.mode.equals("ADD")) {
                boolean flag = true;
                if (cedula_tf.getText().equals("")) {
                    showErrorMessage("Ingrese la cedula.");
                    flag = false;
                }
                if (matricula_cb.valueProperty().getValue().equals("")) {
                    showErrorMessage("ingrese un numero de matricula.");
                    flag = false;
                }
                if (flag) {
                    if (indexes[0] == -1) {
                        try {
                            HashMap<String, List<String>> personIds = dao.selectData(queries.OBTENER_ID_PERSONA_POR_CEDULA, cedula_tf.getText());
                            if (personIds.get("idPersona") == null) {
                                showAddPersonStage(cedula_tf.getText());
                            }
                            HashMap<String, List<String>> id = dao.selectData(queries.OBTENER_ID_CLIENTE_POR_CEDULA, cedula_tf.getText());
                            if (id.get("idCliente") == null) {
                                dao.selectData(queries.AGREGAR_CLIENTE_POR_CEDULA, cedula_tf.getText());
                            }
                        } catch (Exception e) {
                            showErrorMessage(e.getMessage());
                        }
                    }
                    if (indexes[1] == -1) {
                        try {
                            showAddCar(matricula_cb.valueProperty().getValue(),cedula_tf.getText());
                        } catch (Exception e) {
                            showErrorMessage("No se pudo agregar el carro.");
                        }
                    }

                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                    Date dateobj = new Date();
                    try {
                        dao.pushData(queries.AGREGAR_REPARACION, df.format(dateobj), "NULL DATE", matricula_cb.valueProperty().getValue(), descripcion_ta.getText());
                        this.mode = "VIEW";
                        listenToMode();
                    } catch (Exception e) {
                        showErrorMessage(e.getMessage());
                        //e.printStackTrace();
                    }
                }
            }
        });
    }

    private void updateMechanics(){
        if(indexes[2] != -1) {
            try {
                Map<String, List<String>> mecanicos = dao.selectData(queries.OBTENER_MECANICOS_POR_REPARACION, indexes[2]);
                if(mecanicos.get("nombre") != null){
                    for(int i = 0; i < mecanicos.get("nombre").size(); ++i){
                        mecanicos_tbl.getItems().add(new Mecanico(mecanicos.get("nombre").get(i), mecanicos.get("horas").get(i)));
                    }
                }
            } catch (Exception e) {
                showErrorMessage(e.getMessage());
            }
        }
    }

    private void clear_cb(ComboBox<String> cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field
    }

    private void listenToCancel(){
        cancel_bb.setOnMouseClicked(e -> {
            exitForm();
        });
    }

    private void listenToAddMechanic(){
        addMechanic_bb.setOnMouseClicked(event -> {
            if(indexes[2] != -1){
                Dialog<Pair<String, String>> dialog = new Dialog<>();
                dialog.setTitle("Agregar Mecanico");

                ButtonType loginButtonType = new ButtonType("Listo", ButtonBar.ButtonData.OK_DONE);
                dialog.getDialogPane().getButtonTypes().addAll(loginButtonType, ButtonType.CANCEL);

                GridPane grid = new GridPane();
                grid.setHgap(10);
                grid.setVgap(10);
                grid.setPadding(new Insets(20, 150, 10, 10));

                TextField username = new TextField();
                username.setPromptText("Cedula");
                TextField horas = new TextField();
                horas.setPromptText("Horas");

                grid.add(new Label("Cedula:"), 0, 0);
                grid.add(username, 1, 0);
                grid.add(new Label("Horas:"), 0, 1);
                grid.add(horas, 1, 1);

                Node loginButton = dialog.getDialogPane().lookupButton(loginButtonType);
                loginButton.setDisable(true);

                username.textProperty().addListener((observable, oldValue, newValue) -> {
                    loginButton.setDisable(newValue.trim().isEmpty() || !newValue.matches("\\d+"));
                });

                horas.textProperty().addListener((observable, oldValue, newValue) -> {
                    loginButton.setDisable(!newValue.matches("\\d+"));
                });

                dialog.getDialogPane().setContent(grid);

                Platform.runLater(() -> username.requestFocus());

                dialog.setResultConverter(dialogButton -> {
                    if (dialogButton == loginButtonType) {
                        return new Pair<String, String>(username.getText(), horas.getText());
                    }
                    return null;
                });

                Optional<Pair<String, String>> result = dialog.showAndWait();

                result.ifPresent(data -> {
                    try {
                        Map<String, List<String>> mecanico = dao.selectData(queries.OBTENER_MECANICO_POR_CEDULA, data.getKey());
                        if(mecanico.get("idMecanico") != null) {
                            String hrs = (data.getValue().equals(""))? "0" : data.getValue();
                            dao.pushData(queries.AGREGAR_REPARACION_X_MECANICO,indexes[2],mecanico.get("idMecanico").get(0),hrs);
                            updateMechanics();
                        }else{
                            showErrorMessage("El mecanico no existe en la base de datos.");
                        }
                    }catch (Exception e){
                        showErrorMessage(e.getMessage());
                    }
                });
            }else{
                showErrorMessage("Debe seleccionar una reparacion para agragar un mecanico.");
            }
        });
    }

    private void exitForm(){
        try {
            Main.showMainMenu();
        } catch (IOException e1) {
            e1.printStackTrace();
        }
    }

    private void showErrorMessage(String msg){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Ooops!");
        alert.setContentText(msg);
        alert.showAndWait();
    }

    public class Mecanico{
        private String name;
        private String horas;

        public Mecanico(String name,String horas){
            this.name = name;
            this.horas = horas;
        }

        public String getName() {
            return name;
        }
        public String getHoras() {
            return horas;
        }
    }

}
