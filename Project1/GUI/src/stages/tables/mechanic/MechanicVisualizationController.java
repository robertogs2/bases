package stages.tables.mechanic;

import javafx.beans.Observable;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.*;

public class MechanicVisualizationController implements Initializable {

    private ObservableList<Mechanic> mechanicList;

    @FXML TableView<Mechanic> tableView;
    @FXML Button return_bb, add_bb;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        createTable();
        listenToTable();
        listenToAdd();
        listenToReturn();
    }

    private void createTable(){
        mechanicList = FXCollections.observableArrayList();
        tableView.getItems().clear();
        tableView.getColumns().clear();
        //Crear columnas de la tabla
        TableColumn<Mechanic,String> tbcPNombre = new TableColumn<>("Nombre");
        tbcPNombre.setCellValueFactory(new PropertyValueFactory<>("pnombre"));
        TableColumn<Mechanic,String> tbcApellidos = new TableColumn<>("Apellidos");
        tbcApellidos.setCellValueFactory(new PropertyValueFactory<>("apellidos"));
        TableColumn<Mechanic,String> tbcCedula = new TableColumn<>("Cédula");
        tbcCedula.setCellValueFactory(new PropertyValueFactory<>("cedula"));
        TableColumn<Mechanic,String> tbcEdad = new TableColumn<>("Edad");
        tbcEdad.setCellValueFactory(new PropertyValueFactory<>("edad"));
        TableColumn<Mechanic,String> tbcTelefono = new TableColumn<>("Telefono");
        tbcTelefono.setCellValueFactory(new PropertyValueFactory<>("telefono"));
        TableColumn<Mechanic,String> tbcExtension = new TableColumn<>("Extensión");
        tbcExtension.setCellValueFactory(new PropertyValueFactory<>("extension"));
        TableColumn<Mechanic,String> tbcFechaContratacion = new TableColumn<>("Fecha de Contratación");
        tbcFechaContratacion.setCellValueFactory(new PropertyValueFactory<>("fecha"));
        TableColumn<Mechanic,String> tbcSalario = new TableColumn<>("Salario");
        tbcSalario.setCellValueFactory(new PropertyValueFactory<>("salario"));
        TableColumn<Mechanic,String> tbcCNombre = new TableColumn<>("Concesionario");
        tbcCNombre.setCellValueFactory(new PropertyValueFactory<>("cnombre"));
        TableColumn<Mechanic,String> tbcTNombre = new TableColumn<>("Taller");
        tbcTNombre.setCellValueFactory(new PropertyValueFactory<>("tnombre"));

        tableView.getColumns().addAll(tbcCedula,tbcPNombre,tbcApellidos,
                tbcEdad,tbcTelefono,tbcExtension, tbcFechaContratacion,
                tbcSalario, tbcCNombre, tbcTNombre);

        HashMap<String, List<String>> data = null;
        try {
            data = Main.dao.selectData(queries.OBTENER_MECANICOS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int n = data.get("cedula").size();
        for (int i = 0; i < n; ++i) {
            String cedula = data.get("cedula").get(i);
            String pnombre = data.get("pnombre").get(i);
            String apellidos = data.get("apellidos").get(i);
            String edad = data.get("edad").get(i);
            String telefono = data.get("telefono").get(i);
            String extension = data.get("extension").get(i);
            String fecha = data.get("fecha").get(i);
            String salario = data.get("salario").get(i);
            String tnombre = data.get("tnombre").get(i);
            String cnombre = data.get("cnombre").get(i);
            Mechanic mechanic = new Mechanic(cedula, pnombre, apellidos, edad, telefono,
                    extension, fecha, salario, tnombre, cnombre,
                    data.get("idPersona").get(i), data.get("idMecanico").get(i),
                    data.get("idTaller").get(i), data.get("idConcesionario").get(i));
            mechanicList.addAll(mechanic);
        }
        tableView.getItems().clear();
        tableView.setItems(mechanicList);
    }

    private void listenToAdd(){
        add_bb.setOnMouseClicked(event -> {
            try {
                showAddMechanicStage();
                createTable();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }

    private void listenToReturn(){
        return_bb.setOnMouseClicked(event -> {
            try {
                showMainMenu();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }

    private void listenToTable(){
        tableView.setOnMouseClicked((MouseEvent event) -> {
            if (event.getButton().equals(MouseButton.PRIMARY) && event.getClickCount() == 2){
                int selected = tableView.getSelectionModel().getSelectedIndex();
                try {
                    showReparationsByMechanicStage(mechanicList.get(selected).getCedula());
                } catch (IOException e) {
                    e.printStackTrace();
                }
                System.out.println("Ver reparaciones para " + mechanicList.get(selected).getCedula());
            }
        });
    }
}
