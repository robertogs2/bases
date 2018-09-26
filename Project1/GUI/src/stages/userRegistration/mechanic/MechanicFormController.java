package stages.userRegistration.mechanic;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import main.Main;
import stages.menu.MainMenuController;
import stages.userRegistration.client.RegistrationFormController;

import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.dao;
import static main.Main.queries;

public class MechanicFormController implements Initializable {


    @FXML FlowPane flowPane;
    @FXML BorderPane borderPane;
    @FXML TextField id_tf, salary_tf;
    @FXML Button send_bb, cancel_bb;
    public static String past;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        int concesionary = MainMenuController.indexes[0];
        int car_shop = MainMenuController.indexes[1];

        listenToSend(car_shop, concesionary);

    }

    private void listenToSend(int car_shop, int concesionary) {
        send_bb.setOnMouseClicked (e -> {
            if(RegistrationFormController.showConfirmation("¿Continuar?", "Agregar mecánico") == 1) {

                String id = id_tf.getText();
                String salary = salary_tf.getText();

                dao.selectData(queries.OBTENER_ID_PERSONA_POR_CEDULA, )

                if (false) {//There is a person with that id already

                } else {
                    try {
                        Main.showUserPane();
                    } catch (IOException e1) {
                        e1.printStackTrace();
                    }
                }
                try {
                    //RegistrationFormController.showInformation("Se ha agregado un nuevo mecánico", "Agregar mecánico");
                    dao.selectData(queries.AGREGAR_MECANICO, "", salary, car_shop);
                    Main.showString(past);
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
            }

        });
    }

}
