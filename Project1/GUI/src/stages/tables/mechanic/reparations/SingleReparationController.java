package stages.tables.mechanic.reparations;

import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import main.Main;
import stages.tables.mechanic.Mechanic;

import java.util.HashMap;
import java.util.List;

import static main.Main.queries;

public class SingleReparationController {

    private ObservableList<SingleMechanicTable> reparationList;
    int idMechanic;
    @FXML TableView<SingleMechanicTable> tableView;
    @FXML Button return_bb;

    private void createTable(){
        reparationList = FXCollections.observableArrayList();

        //Crear columnas de la tabla
        TableColumn<SingleMechanicTable,String> tbcDescripcion = new TableColumn<>("Descripcion");
        tbcDescripcion.setCellValueFactory(new PropertyValueFactory<>("descripcion"));
        TableColumn<SingleMechanicTable,String> tbcFechaI = new TableColumn<>("Fecha Inicial");
        tbcFechaI.setCellValueFactory(new PropertyValueFactory<>("fechaI"));
        TableColumn<SingleMechanicTable,String> tbcFechaF = new TableColumn<>("Fecha Final");
        tbcFechaF.setCellValueFactory(new PropertyValueFactory<>("fechaF"));
        TableColumn<SingleMechanicTable,String> tbcMatricula = new TableColumn<>("Matricula");
        tbcMatricula.setCellValueFactory(new PropertyValueFactory<>("matricula"));
        TableColumn<SingleMechanicTable,String> tbcHoras = new TableColumn<>("Horas");
        tbcHoras.setCellValueFactory(new PropertyValueFactory<>("horas"));
        TableColumn<SingleMechanicTable,String> tbcId = new TableColumn<>("id Reparacion");
        tbcId.setCellValueFactory(new PropertyValueFactory<>("idReparacion"));


        tableView.getColumns().addAll(tbcDescripcion,tbcFechaI,tbcFechaF,
                tbcMatricula,tbcHoras,tbcId);

        HashMap<String, List<String>> data = null;
        try {
            data = Main.dao.selectData(queries.OBTENER_REPARACIONES_POR_MECANICO, idMechanic);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int n = data.get("idReparacion").size();
        for (int i = 0; i < n; ++i) {

            SingleMechanicTable mechanic = new SingleMechanicTable(
                    data.get("descripcion").get(i),
                    data.get("fechaI").get(i),
                    data.get("fechaF").get(i),
                    data.get("matricula").get(i),
                    data.get("horas").get(i),
                    data.get("idReparacion").get(i));
            reparationList.addAll(mechanic);
        }
        tableView.setItems(reparationList);
    }

    public void setId(String cedula){
        idMechanic = Integer.parseInt(cedula);
    }

}
