package stages.userRegistration;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.layout.FlowPane;

import java.net.URL;
import java.util.ResourceBundle;

import static main.Main.primaryStage;

public class RegistrationFormController implements Initializable {
    @FXML
    FlowPane flowPane;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        flowPane.prefHeightProperty().bind(primaryStage.heightProperty());
    }

}