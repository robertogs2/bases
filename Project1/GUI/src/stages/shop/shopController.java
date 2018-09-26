package stages.shop;

import javafx.collections.FXCollections;
import javafx.collections.ListChangeListener;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.image.Image;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import main.Main;

import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.primaryStage;
import static main.Main.queries;

public class shopController implements Initializable {

    private CarAlbum carAlbum;

    //https://stackoverflow.com/questions/32940399/javafx-update-flowpane-after-list-changes
    @FXML FlowPane flowPane;
    @FXML BorderPane borderPane;


    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        carAlbum = new CarAlbum();

        HashMap<String, List<String>> data = null;
        try {
             data = Main.dao.selectData(queries.ObTENER_INFO_CARRO_POR_CONCESIONARIO,1);
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

                ObservableList<Image> photos = FXCollections.observableArrayList();

                carAlbum.addCar( Integer.valueOf(pk),
                        marca + " " + modelo,
                        "$ " + precio + "\n" + "Matrícula: " + matricula,
                        photos);
                carAlbum.getCarList().addListener((ListChangeListener<CarView>) change -> refresh());
            }
        }

        /*for (int i = 0; i < 100; i++){
            String description =
                    "Ah sí man, solo calidad este carro, acelera, frena, gira, hace de todo man, comprelo bro.";

            carAlbum.addCar("Carro " + i, description, i);
        }*/
        //carAlbum.sortByName();
        Menu sortMenu = new Menu("_Sort");
        MenuItem sortName = new MenuItem("_Name");
        sortName.setOnAction(e -> {
            carAlbum.sortByName();
            refresh();
        });
        sortMenu.getItems().addAll(sortName);
        MenuBar menuBar = new MenuBar();
        menuBar.getMenus().addAll(sortMenu);

        borderPane.setTop(menuBar);
    }

    private void refresh(){
        flowPane.getChildren().clear();

        for (int i = 0; i < carAlbum.getCarList().size(); i++) {
            flowPane.getChildren()
                    .add(carAlbum.getCarList().get(i));
        }
    }
}
