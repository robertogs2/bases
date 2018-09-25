package stages.menu;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import static main.Main.primaryStage;
import static main.Main.showShopPane;
import static main.Main.showUserPane;
import static main.Main.showCarRegistrationForm;

public class MainMenuController implements Initializable {

    @FXML
    FlowPane flowPane;
    @FXML
    VBox vBox;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        vBox.setAlignment(Pos.CENTER);
        vBox.setSpacing(10);

        Button btn = new Button();
        btn.setText("SHOP");
        btn.setOnAction(event -> {
            try {
                showShopPane();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        vBox.getChildren().add(btn);

        Button btn1 = new Button();
        btn1.setText("ClientRegistration");
        btn1.setOnAction(event -> {
            try {
                showUserPane();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        vBox.getChildren().add(btn1);

        Button btn_ShowCarRegistrationForm = new Button();
        btn_ShowCarRegistrationForm.setText("CarRegistration");
        btn_ShowCarRegistrationForm.setOnAction(event -> {
            try {
                showCarRegistrationForm();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        vBox.getChildren().add(btn_ShowCarRegistrationForm);
    }

}
