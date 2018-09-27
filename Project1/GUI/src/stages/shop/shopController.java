package stages.shop;

import javafx.collections.FXCollections;
import javafx.collections.ListChangeListener;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.primaryStage;
import static main.Main.queries;
import static main.Main.showMainMenu;

public class shopController implements Initializable {

    private CarAlbum carAlbum;

    //https://stackoverflow.com/questions/32940399/javafx-update-flowpane-after-list-changes
    @FXML FlowPane flowPane;
    @FXML BorderPane borderPane;
    @FXML ChoiceBox<String> cbMarca;
    @FXML ChoiceBox<String> cbModelo;
    @FXML ChoiceBox<String> cbColor;
    @FXML VBox vBox;
    @FXML Button btnReturn;
    @FXML MenuBar menuBar;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        flowPane.prefWidthProperty().bind(primaryStage.widthProperty().subtract(50));
        vBox.prefHeightProperty().bind(primaryStage.heightProperty().subtract(60));

        carAlbum = new CarAlbum();
        cbMarca.getItems().addAll("");
        cbMarca.getItems().addAll(carAlbum.getBrandModel().keySet());
        cbMarca.getSelectionModel().selectedIndexProperty().addListener(observable -> {
            int i = cbMarca.getSelectionModel().getSelectedIndex();
            cbModelo.getItems().clear();
            String marca = cbMarca.getItems().get(i);
            cbModelo.getItems().addAll("");
            cbModelo.getItems().addAll(carAlbum.getBrandModel().get(marca));
            filter();
        });

        cbColor.getItems().addAll("");
        cbColor.getItems().addAll(carAlbum.getColorList());
        cbColor.getSelectionModel().selectedIndexProperty().addListener(observable -> filter());

        cbModelo.getSelectionModel().selectedIndexProperty().addListener(observable -> filter());

        //carAlbum.sortByName();
        Menu sortMenu = new Menu("_Sort");
        MenuItem sortName = new MenuItem("_Name");
        sortName.setOnAction(e -> {
            carAlbum.sortByName();
            refresh();
        });
        MenuItem sortPrice = new MenuItem("_Price");
        sortPrice.setOnAction( event -> {
            carAlbum.sortByPrice();
            refresh();
        });
        sortMenu.getItems().addAll(sortName,sortPrice);
        menuBar.getMenus().addAll(sortMenu);

    }

    public void fillCars(int concesionario){
        HashMap<String, List<String>> data = null;
        try {
            data = Main.dao.selectData(queries.ObTENER_INFO_CARRO_POR_CONCESIONARIO,concesionario);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (data != null){
            int n = data.get("idCoche").size();
            for (int i = 0; i < n; ++i){
                String pk = data.get("idCoche").get(i);
                String precio = data.get("precio").get(i);
                String matricula = data.get("matricula").get(i);
                String marca = data.get("marca").get(i);
                String modelo = data.get("modelo").get(i);
                String color = data.get("color").get(i);

                HashMap<String, List<String>> dataPhoto = null;
                try {
                    dataPhoto = Main.dao.selectData(queries.OBTENER_FOTOS,Integer.valueOf(pk));
                } catch (Exception e) {
                    e.printStackTrace();
                }

                ObservableList<String> photos = FXCollections.observableArrayList();
                if(!dataPhoto.keySet().isEmpty()){
                    int m = dataPhoto.get("url").size();
                    for (int j = 0; j < m; ++j) {
                        String url = dataPhoto.get("url").get(j);
                        photos.addAll(url);
                    }
                }


                carAlbum.addCar( Integer.valueOf(pk), marca, modelo, matricula, precio, color, photos);
                carAlbum.getCarList().addListener((ListChangeListener<CarView>) change -> refresh());
            }
        }
    }

    private void filter(){
        int i = cbMarca.getSelectionModel().getSelectedIndex();
        int j = cbModelo.getSelectionModel().getSelectedIndex();
        int k = cbColor.getSelectionModel().getSelectedIndex();
        String marca;
        String modelo;
        String color;
        if (i > 0) marca = cbMarca.getItems().get(i);
        else marca ="";
        if (j > 0) modelo = cbModelo.getItems().get(j);
        else modelo = "";
        if (k > 0) color = cbColor.getItems().get(k);
        else color = "";
        carAlbum.filter(marca, modelo, color);
        refresh();
    }

    private void refresh(){
        flowPane.getChildren().clear();

        for (int i = 0; i < carAlbum.getCarList().size(); i++) {
            flowPane.getChildren()
                    .add(carAlbum.getCarList().get(i));
        }
    }

    public void retornar() throws IOException {
        showMainMenu();
    }

}
