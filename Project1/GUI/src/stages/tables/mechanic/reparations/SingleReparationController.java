package stages.tables.mechanic.reparations;

import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import main.Main;
import stages.tables.mechanic.Mechanic;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.popUpStage;
import static main.Main.queries;
import static main.Main.showMainMenu;

public class SingleReparationController  implements Initializable {

    private ObservableList<SingleMechanicTable> reparationList;
    int idMechanic;
    @FXML TableView<SingleMechanicTable> tableView;
    @FXML Button return_bb;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        listenToReturn();
    }

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

            String fechaFinal = data.get("fechaF").get(i);
            if(fechaFinal == null){
                fechaFinal = "En curso";
            }
            SingleMechanicTable mechanic = new SingleMechanicTable(
                    data.get("descripcion").get(i),
                    data.get("fechaI").get(i),
                    fechaFinal,
                    data.get("matricula").get(i),
                    data.get("horas").get(i),
                    data.get("idReparacion").get(i));
            reparationList.addAll(mechanic);
        }
        tableView.setItems(reparationList);
    }

    public void setId(String cedula){
        idMechanic = Integer.parseInt(cedula);
        createTable();
    }

    private void listenToReturn(){
        return_bb.setOnMouseClicked(event -> {
                exitForm();
        });
    }

    private void exitForm(){
        if(popUpStage!=null){
            popUpStage.close();
        }else {
            try {
                Main.showMainMenu();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

}
