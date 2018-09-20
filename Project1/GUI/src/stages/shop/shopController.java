package stages.shop;

import javafx.collections.ListChangeListener;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;

import java.net.URL;
import java.util.ResourceBundle;

import static main.Main.primaryStage;

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

        for (int i = 0; i < 100; i++){
            String description =
                    "Ah sí man, solo calidad este carro, acelera, frena, gira, hace de todo man, comprelo bro.";

            carAlbum.addCar("Carro " + i, description, i);

            carAlbum.getCarList().addListener(new ListChangeListener<CarView>() {
                @Override
                public void onChanged(ListChangeListener.Change change) {
                    refresh();
                }
            });
        }

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
