package stages.tables.mechanic;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import main.Main;

import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.queries;

public class MechanicVisualizationController implements Initializable {

    private ObservableList<Mechanic> mechanicList;

    @FXML TableView<Mechanic> tableView;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        mechanicList = FXCollections.observableArrayList();

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
        tbcExtension.setCellValueFactory(new PropertyValueFactory<>("fecha"));
        TableColumn<Mechanic,String> tbcSalario = new TableColumn<>("Salario");
        tbcExtension.setCellValueFactory(new PropertyValueFactory<>("salario"));
        TableColumn<Mechanic,String> tbcCNombre = new TableColumn<>("Concesionario");
        tbcExtension.setCellValueFactory(new PropertyValueFactory<>("cnombre"));
        TableColumn<Mechanic,String> tbcTNombre = new TableColumn<>("Taller");
        tbcExtension.setCellValueFactory(new PropertyValueFactory<>("tnombre"));

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
                    extension, fecha, salario, tnombre, cnombre);
            mechanicList.addAll(mechanic);
        }
        tableView.setItems(mechanicList);
    }
}
