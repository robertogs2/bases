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
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import static main.Main.*;
import static main.Main.popUpStage;

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
        listenToCancel();
    }

    private void listenToSend(int car_shop, int concesionary) {
        send_bb.setOnMouseClicked (e -> {
            boolean ready = true;
            if(id_tf.getText().length() <= 0){
                ready = false;
                RegistrationFormController.showErrorMessage("Por favor inserte una cédula");
            }
            else if(salary_tf.getText().length() <= 0){
                ready = false;
                RegistrationFormController.showErrorMessage("Por favor inserte un salario");
            }
            if(ready){
                try {
                    Integer.parseInt(id_tf.getText());
                }
                catch(Exception e1){
                    RegistrationFormController.showErrorMessage("Por favor inserte un número en la cédula");
                    ready = false;
                }
            }

            if(ready){
                try {
                    Integer.parseInt(salary_tf.getText());
                }
                catch(Exception e1){
                    RegistrationFormController.showErrorMessage("Por favor inserte un número en el salario");
                    ready = false;
                }
            }
            if(ready && RegistrationFormController.showConfirmation("¿Continuar?", "Agregar mecánico") == 1) {

                String id = id_tf.getText();
                String salary = salary_tf.getText();
                boolean avaliable, add_mechanic = false;

                try {
                    avaliable = dao.selectData(queries.OBTENER_ID_PERSONA_POR_CEDULA, id).get("idPersona") == null;
                    if (!avaliable) {//There is a person with that id already
                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                        Date dateobj = new Date();
                        dao.selectData(queries.AGREGAR_MECANICO, df.format(dateobj), salary, id, car_shop);
                    } else {//We need to add the person
                        int new_id = showAddPersonStage(id);
                        if(new_id != -1){
                            add_mechanic = true;
                        }
                    }
                }
                catch (Exception e1) {
                    int errorCode = ((SQLException)e1).getErrorCode();
                    if(errorCode == 1062){
                        RegistrationFormController.showErrorMessage("Ya esta persona está registrada como mecánico");
                        exitForm();
                    }
                    else{
                        e1.printStackTrace();
                    }
                }

                if(add_mechanic){
                    try {
                        //RegistrationFormController.showInformation("Se ha agregado un nuevo mecánico", "Agregar mecánico");
                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                        Date dateobj = new Date();
                        dao.selectData(queries.AGREGAR_MECANICO, df.format(dateobj), salary, id, car_shop);
                        exitForm();
                    } catch (Exception e1) {
                        int errorCode = ((SQLException)e1).getErrorCode();
                        if(errorCode == 1062){
                            RegistrationFormController.showErrorMessage("Ya esta persona está registrada como mecánico");
                            exitForm();
                        }
                        else{
                            e1.printStackTrace();
                        }
                    }
                }

            }

        });
    }

    private void listenToCancel(){
        cancel_bb.setOnMouseClicked (e -> {
            exitForm();
        });
    }

    private void exitForm(){
        if(popUpStage!=null){
            popUpStage.close();
        }else {
            try {
                Main.showMainMenu();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

}
