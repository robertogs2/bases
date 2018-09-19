package stages.shop;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.TextAlignment;

import java.net.URL;
import java.util.ResourceBundle;

import static main.Main.primaryStage;

public class shopController implements Initializable {

    @FXML FlowPane flowPane;


    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        for (int i = 0; i < 100; i++){
            VBox vBox = new VBox();
            ImageView imageView = new ImageView();
            imageView.setFitWidth(50);
            imageView.setFitHeight(150);
            Label name = new Label("Carro " + i);
            name.setFont(Font.font("System",FontWeight.BOLD,14));
            Label description = new Label(
                    "Ah sí man, solo calidad este carro, acelera, frena, gira, hace de todo man, comprelo bro."
            );
            description.setWrapText(true);
            description.setTextAlignment(TextAlignment.JUSTIFY);
            description.setMaxWidth(200);
            vBox.getChildren().addAll(imageView,name,description);
            vBox.prefWidth(100);
            vBox.maxHeight(200);
            //VBox.setVgrow(description,Priority.ALWAYS);
            vBox.setAlignment(Pos.TOP_CENTER);
            flowPane.getChildren().addAll(vBox);
        }

    }
}
