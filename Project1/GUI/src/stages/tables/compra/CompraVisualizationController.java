package stages.tables.compra;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import main.Main;
import stages.menu.MainMenuController;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.queries;
import static main.Main.showMainMenu;
import static main.Main.showShopPane;

public class CompraVisualizationController implements Initializable {

    private ObservableList<Compra> compraList;

    @FXML TableView<Compra> tableView;
    @FXML Button return_btn;
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        listenToReturn();
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
            data = Main.dao.selectData(queries.OBTENER_VENTAS_POR_CONCESIONARIO,MainMenuController.concesionario);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int n = data.get("marca").size();
        for (int i = 0; i < n; ++i) {
            String marca = data.get("marca").get(i);
            String modelo = data.get("modelo").get(i);
            String nombre = data.get("nombre").get(i);
            String apellidos = data.get("apellidos").get(i);
            String persona = nombre + " " + apellidos;
            String precio = data.get("precio").get(i);
            String estado = data.get("estado").get(i);
            String fecha = data.get("fechaHora").get(i);

            Compra compra = new Compra(marca,modelo,persona,precio,estado,fecha);
            compraList.addAll(compra);
        }
        tableView.setItems(compraList);
    }

    private void listenToReturn(){
        return_btn.setOnMouseClicked(event -> {
            try {
                showShopPane(MainMenuController.indexes[0]);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
}
