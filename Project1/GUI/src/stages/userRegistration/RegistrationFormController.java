package stages.userRegistration;

import javafx.beans.Observable;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;

import java.net.URL;
import java.util.*;

import static main.Main.primaryStage;
import static main.Main.queries;
import static main.Main.dao;

public class RegistrationFormController implements Initializable {


    @FXML FlowPane flowPane;
    @FXML BorderPane borderPane;
    @FXML ComboBox country_cb;
    @FXML ComboBox province_cb;
    @FXML ComboBox city_cb;
    @FXML ComboBox direction_cb;
    @FXML TextField name_tf;
    @FXML TextField last_name_tf;
    @FXML TextField id_tf;
    @FXML TextField age_tf;
    @FXML TextField phone_tf;
    @FXML TextField extension_tf;
    @FXML Button send_bb;
    @FXML TextArea location_ta;
    private final int[] indexes = new int[4]; //index0 : country, index1 : province, index2: city, index3: direction
    private static List<String> country_indexes;
    private static List<String> province_indexes;
    private static List<String> city_indexes;
    private static List<String> direction_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());

        HashMap<String, List<String>> country_list = new HashMap<>();

        clear_cb(country_cb);
        clear_cb(province_cb);
        clear_cb(city_cb);
        clear_cb(direction_cb);

        try {
            country_list = dao.selectData(queries.OBTENER_PAISES);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Arrays.fill(indexes, -1);
        country_indexes = country_list.get("idPais");
        country_cb.getItems().setAll(country_list.get("nombre"));


        listenToCountry();
        listenToProvince();
        listenToCity();
        listenToDirection();
        listenToSend();
    }

    private void listenToCountry(){
        country_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[0] = country_cb.getSelectionModel().getSelectedIndex();
            if(indexes[0] != -1){
                indexes[0] = Integer.decode(country_indexes.get(indexes[0]));
                updateProvince(indexes[0]);
                //country_cb.setEditable(false);
            }
            else{
                clear_cb(province_cb);
            }
            clear_cb(city_cb);
            clear_cb(direction_cb);
            printInfo();
        });
    }
    private void listenToProvince(){
        province_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = province_cb.getSelectionModel().getSelectedIndex();
            if(indexes[1] != -1){
                indexes[1] = Integer.decode(province_indexes.get(indexes[1]));
                updateCity(indexes[1]);
                //province_cb.setEditable(false);
            }
            else{
                clear_cb(city_cb);
            }
            clear_cb(direction_cb);
            printInfo();

        });
    }
    private void listenToCity(){
        city_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[2] = city_cb.getSelectionModel().getSelectedIndex();
            if(indexes[2] != -1){
                indexes[2] = Integer.decode(city_indexes.get(indexes[2]));
                updateDirection(indexes[2]);
                //province_cb.setEditable(false);
            }
            else{
                direction_cb.getItems().clear();
            }
            printInfo();

        });
    }
    private void listenToDirection(){
        direction_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[3] = direction_cb.getSelectionModel().getSelectedIndex();
            if(indexes[3] != -1){
                indexes[3] = Integer.decode(direction_indexes.get(indexes[3]));
                //updateDirection(Integer.decode(direction_indexes.get(indexes[3])));
                //province_cb.setEditable(false);
            }
            else{
                //direction_cb.getItems().clear();
            }
            printInfo();

        });
    }
    private void updateProvince(int countryIndex){
        try {
            province_cb.getItems().clear();
            HashMap<String, List<String>> province_list = dao.selectData(queries.OBTENER_PROVINCIAS_POR_PAIS, countryIndex);
            province_indexes = province_list.get("idProvincia");
            if(province_list.size() > 0) {
                province_cb.getItems().setAll(province_list.get("nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void updateCity(int provinceIndex){
        try {
            city_cb.getItems().clear();
            HashMap<String, List<String>> city_list = dao.selectData(queries.OBTENER_CIUDADES_POR_PROVINCIA, provinceIndex);
            city_indexes = city_list.get("idCiudad");
            if(city_list.size() > 0) {
                city_cb.getItems().setAll(city_list.get("nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void updateDirection(int cityIndex){
        try {
            direction_cb.getItems().clear();
            HashMap<String, List<String>> direction_list = dao.selectData(queries.OBTENER_DIRECCION_POR_CIUDAD, cityIndex);
            direction_indexes = direction_list.get("idDireccion");
            if(direction_list.size() > 0) {
                direction_cb.getItems().setAll(direction_list.get("zipCode"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void clear_cb(ComboBox cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field

    }

    private void listenToSend() {
        send_bb.setOnMouseClicked (e -> {
            String name = name_tf.getText();
            String last_name = last_name_tf.getText();
            String id = id_tf.getText();
            String age = age_tf.getText();
            String phone = phone_tf.getText();
            String extension = extension_tf.getText();
            String location = location_ta.getText();
            String country = country_cb.valueProperty().getValue().toString();
            String province = province_cb.valueProperty().getValue().toString();
            String city = city_cb.valueProperty().getValue().toString();
            String direction = direction_cb.valueProperty().getValue().toString();
            //checks for something null
            if(name.length() <= 0){//There is not a name
                System.out.println("Missing ");
            }
            else if(last_name.length() <= 0){//There is not a last name
                System.out.println("Missing ");
            }
            else if(id.length() <= 0){//There is not an id
                System.out.println("Missing ");
            }
            else if(age.length() <= 0){//There is not an age
                System.out.println("Missing ");
            }
            else if(phone.length() <= 0){//There is not a phone number
                System.out.println("Missing ");
            }
            else if(extension.length() <= 0){//There is not an extension
                System.out.println("Missing ");
            }
            else if(location.length() <= 0){
                System.out.println("Missing ");
            }
            else if(country.length() <= 0){
                System.out.println("Missing country");
            }
            else if(province.length() <= 0){
                System.out.println("Missing province");
            }
            else if(city.length() <= 0){
                System.out.println("Missing city");
            }
            else if(direction.length() <= 0){
                System.out.println("Missing zipcode");
            }
            System.out.println(indexes[0]);
            //Checks if we need to add another country or whatever
            if(indexes[0] == -1){
                try {
                    addFromCountry(country);
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
                //Add from country
            }
            if(indexes[1] == -1){
                //Add from province
            }
            if(indexes[2] == -1){
                //Add from city
            }
            if(indexes[3] == -1){

                //Add from direction
            }

        });
    }

    private void addFromDirection(String zipCode, String location_description) throws Exception { //Direction is not in db
        int city_id = indexes[2];
        HashMap<String, List<String>> direction_id = dao.selectData(queries.AGREGAR_DIRECCION, zipCode);
        int new_direction_id = Integer.parseInt(direction_id.get("LAST_INSERT_ID()").get(0));
        HashMap<String, List<String>> location_id= dao.selectData(queries.AGREGAR_DIRECCION, zipCode);

        //dao.selectData(queries.Agregar);
    }


    private void addFromCountry(String name) throws Exception {
        HashMap<String, List<String>> country_id = dao.selectData(queries.AGREGAR_PAIS, name);
        int new_country_id = Integer.parseInt(country_id.get("LAST_INSERT_ID()").get(0));
        //System.out.println(new_country_id);
    }

    private void printInfo(){
        for (int indexe : indexes) {
            System.out.print(indexe);
        }
        System.out.println();
    }

}
