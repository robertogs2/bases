package stages.preview;

import javafx.beans.binding.Bindings;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;

import java.net.URL;
import java.util.ResourceBundle;

import static main.Main.primaryStage;

public class previewController implements Initializable {

    @FXML TableView<carAttribute> tbvAttribute;
    @FXML TableColumn<carAttribute,String> tbcName;
    @FXML TableColumn<carAttribute,String> tbcValue;
    @FXML HBox hBox;


    @Override
    public void initialize(URL location, ResourceBundle resources) {
        hBox.prefWidthProperty().bind(primaryStage.widthProperty().subtract(35));
        //hBox.prefHeightProperty().bind(primaryStage.heightProperty());

        tbcName.setCellValueFactory(new PropertyValueFactory<>("name"));
        tbcValue.setCellValueFactory(new PropertyValueFactory<>("value"));

        ObservableList<carAttribute> carAttributes = FXCollections.observableArrayList();
        for (int i = 0; i < 10; ++i){
            carAttribute carAttribute = new carAttribute("Atributo " + i, "Valor " + i);
            carAttributes.addAll(carAttribute);
        }

        tbvAttribute.setItems(carAttributes);
        tbvAttribute.widthProperty().addListener((ov, t, t1) -> {
            // Get the table header
            Pane header = (Pane)tbvAttribute.lookup("TableHeaderRow");
            if(header!=null && header.isVisible()) {
                header.setMaxHeight(0);
                header.setMinHeight(0);
                header.setPrefHeight(0);
                header.setVisible(false);
                header.setManaged(false);
            }
        });
        tbvAttribute.setFixedCellSize(25);
        tbvAttribute.prefHeightProperty().bind(tbvAttribute.fixedCellSizeProperty().multiply(Bindings.size(tbvAttribute.getItems()).add(0.1)));
        tbvAttribute.minHeightProperty().bind(tbvAttribute.prefHeightProperty());
        tbvAttribute.maxHeightProperty().bind(tbvAttribute.prefHeightProperty());
    }
}
