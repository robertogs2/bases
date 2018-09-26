package stages.tables;

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

public class TableVisualizationController implements Initializable {

    private ObservableList<Persona> personList;

    @FXML TableView<Persona> tableView;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        personList = FXCollections.observableArrayList();

        //Crear columnas de la tabla
        TableColumn<Persona,String> tbcCedula = new TableColumn<>("Cédula");
        tbcCedula.setCellValueFactory(new PropertyValueFactory<>("cedula"));
        TableColumn<Persona,String> tbcNombre = new TableColumn<>("Nombre");
        tbcNombre.setCellValueFactory(new PropertyValueFactory<>("nombre"));
        TableColumn<Persona,String> tbcApellidos = new TableColumn<>("Apellidos");
        tbcApellidos.setCellValueFactory(new PropertyValueFactory<>("apellidos"));
        TableColumn<Persona,String> tbcEdad = new TableColumn<>("Edad");
        tbcEdad.setCellValueFactory(new PropertyValueFactory<>("edad"));
        TableColumn<Persona,String> tbcTelefono = new TableColumn<>("Telefono");
        tbcTelefono.setCellValueFactory(new PropertyValueFactory<>("telefono"));
        TableColumn<Persona,String> tbcExtension = new TableColumn<>("Estensión");
        tbcExtension.setCellValueFactory(new PropertyValueFactory<>("extension"));

        tableView.getColumns().addAll(tbcCedula,tbcNombre,tbcApellidos,tbcEdad,tbcTelefono,tbcExtension);


        HashMap<String, List<String>> data = null;
        try {
            data = Main.dao.selectData(queries.OBTENER_PERSONAS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int n = data.get("cedula").size();
        for (int i = 0; i < n; ++i) {
            String cedula = data.get("cedula").get(i);
            String nombre = data.get("nombre").get(i);
            String apellidos = data.get("apellidos").get(i);
            String edad = data.get("edad").get(i);
            String telefono = data.get("telefono").get(i);
            String extension = data.get("extension").get(i);

            Persona persona = new Persona(cedula,nombre,apellidos,edad,telefono,extension);
            personList.addAll(persona);
        }
        tableView.setItems(personList);
    }
}
