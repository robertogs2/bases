package stages.tables.compra;

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

public class CompraVisualizationController implements Initializable {

    private ObservableList<Compra> compraList;

    @FXML TableView<Compra> tableView;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        compraList = FXCollections.observableArrayList();

        //Crear columnas de la tabla
        TableColumn<Compra,String> tbcMarca = new TableColumn<>("Marca");
        tbcMarca.setCellValueFactory(new PropertyValueFactory<>("marca"));
        TableColumn<Compra,String> tbcModelo = new TableColumn<>("Modelo");
        tbcModelo.setCellValueFactory(new PropertyValueFactory<>("modelo"));
        TableColumn<Compra,String> tbcPersona = new TableColumn<>("Comprador");
        tbcPersona.setCellValueFactory(new PropertyValueFactory<>("persona"));
        TableColumn<Compra,String> tbcPrecio = new TableColumn<>("Precio");
        tbcPrecio.setCellValueFactory(new PropertyValueFactory<>("precio"));
        TableColumn<Compra,String> tbcEstado = new TableColumn<>("Estado");
        tbcEstado.setCellValueFactory(new PropertyValueFactory<>("estado"));
        TableColumn<Compra,String> tbcFecha = new TableColumn<>("Fecha");
        tbcFecha.setCellValueFactory(new PropertyValueFactory<>("fecha"));

        tableView.getColumns().addAll(tbcMarca,tbcModelo,tbcPersona,tbcPrecio,tbcEstado,tbcFecha);

        HashMap<String, List<String>> data = null;
        try {
            data = Main.dao.selectData(queries.OBTENER_PERSONAS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int n = data.get("marca").size();
        for (int i = 0; i < n; ++i) {
            String marca = data.get("marca").get(i);
            String modelo = data.get("modelo").get(i);
            String persona = data.get("persona").get(i);
            String precio = data.get("precio").get(i);
            String estado = data.get("estado").get(i);
            String fecha = data.get("fecha").get(i);

            Compra compra = new Compra(marca,modelo,persona,precio,estado,fecha);
            compraList.addAll(compra);
        }
        tableView.setItems(compraList);
    }
}
