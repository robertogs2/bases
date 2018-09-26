package stages.userRegistration.mechanic;

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
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.dao;
import static main.Main.queries;

public class FormMechanicController implements Initializable {


    @FXML FlowPane flowPane;
    @FXML BorderPane borderPane;
    @FXML ComboBox country_cb, province_cb, city_cb, direction_cb;
    @FXML TextField name_tf, last_name_tf, id_tf, age_tf, phone_tf, extension_tf;
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


            String country = country_cb.valueProperty().getValue().toString();
            String province = province_cb.valueProperty().getValue().toString();
            String city = city_cb.valueProperty().getValue().toString();
            String zipCode = direction_cb.valueProperty().getValue().toString();
            String locationDescription = location_ta.getText();
            int ubicacion = 0;
            //checks for something null
            if(name.length() <= 0){//There is not a name
                System.out.println("Missing name");
            }
            else if(last_name.length() <= 0){//There is not a last name
                System.out.println("Missing last name");
            }
            else if(id.length() <= 0){//There is not an id
                System.out.println("Missing id");
            }
            else if(age.length() <= 0){//There is not an age
                System.out.println("Missing age");
            }
            else if(phone.length() <= 0){//There is not a phone number
                System.out.println("Missing phone");
            }
            else if(extension.length() <= 0){//There is not an extension
                System.out.println("Missing extension");
            }
            else if(zipCode.length() <= 0){
                System.out.println("Missing zipcode");
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
            else if(locationDescription.length() <= 0){
                System.out.println("Missing description");
            }
            else{
                //Checks if we need to add another country or whatever
                try {
                    if(indexes[0] == -1){
                        ubicacion = addFromCountry(country, province, city, zipCode, locationDescription);
                        //Add from country
                    }
                    else if(indexes[1] == -1){
                        //Add from province
                        ubicacion = addFromProvince(indexes[0], province, city, zipCode, locationDescription);
                    }
                    else if(indexes[2] == -1){
                        //Add from city
                        ubicacion = addFromCity(indexes[1], city, zipCode, locationDescription);
                    }
                    else if(indexes[3] == -1){
                        ubicacion = addFromDirection(indexes[2], zipCode, locationDescription);
                        //Add from direction
                    }
                    else{
                        //Add pure
                        ubicacion = addLocation(indexes[3], locationDescription);
                    }
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
                //Generates new person
                HashMap<String, List<String>> person_id = null;
                int new_person_id, new_client_id;
                boolean avaliable = true;
                try {
                    System.out.println(ubicacion);
                    person_id = dao.selectData(queries.AGREGAR_PERSONA,
                            id, name, last_name, age, phone, extension, ubicacion);
                    new_person_id = Integer.parseInt(person_id.get("LAST_INSERT_ID()").get(0));
                } catch (Exception e1) {
                    System.out.println("La cedula esta repetida");
                    e1.printStackTrace();
                    avaliable = false;
                }


                //Generates new client with the person id, could be done with the table id
                HashMap<String, List<String>> client_id = null;
                if(avaliable){
                    try {
                        client_id = dao.selectData(queries.AGREGAR_CLIENTE_POR_CEDULA, id);
                        new_client_id = Integer.parseInt(client_id.get("LAST_INSERTED_ID()").get(0));
                    } catch (Exception e1) {
                        System.out.println("La persona no existe");
                        e1.printStackTrace();
                    }
                }
            }

        });
    }

    private int addLocation(int direction_id, String location_description)throws Exception {
        //Generates new location
        HashMap<String, List<String>> location_id = dao.selectData(queries.AGREGAR_UBICACION, location_description, direction_id);
        int new_location_id = Integer.parseInt(location_id.get("LAST_INSERT_ID()").get(0));
        return new_location_id;
    }

    private int addFromDirection(int city_id, String zipCode, String location_description) throws Exception { //Direction is not in db
        //Generates new direction
        HashMap<String, List<String>> direction_id = dao.selectData(queries.AGREGAR_DIRECCION, zipCode, city_id);
        int new_direction_id = Integer.parseInt(direction_id.get("LAST_INSERT_ID()").get(0));
        return addLocation(new_direction_id, location_description);
    }

    private int addFromCity(int province_id, String city_name,String zip_code, String location_description) throws Exception {
        //Generates new city
        HashMap<String, List<String>> city_id = dao.selectData(queries.AGREGAR_CIUDAD, city_name, province_id);
        int new_city_id = Integer.parseInt(city_id.get("LAST_INSERT_ID()").get(0));
        return addFromDirection(new_city_id, zip_code, location_description);
    }

    private int addFromProvince(int country_id, String province_name, String city_name, String zip_code, String location_description) throws Exception {
        //Generates new province
        HashMap<String, List<String>> province_id = dao.selectData(queries.AGREGAR_PROVINCIA, province_name, country_id);
        int new_province_id = Integer.parseInt(province_id.get("LAST_INSERT_ID()").get(0));
        return addFromCity(new_province_id, city_name, zip_code, location_description);
    }

    private int addFromCountry(String country_name, String province_name, String city_name, String zip_code, String location_description) throws Exception {
        //Generate new country
        HashMap<String, List<String>> country_id = dao.selectData(queries.AGREGAR_PAIS, country_name);
        int new_country_id = Integer.parseInt(country_id.get("LAST_INSERT_ID()").get(0));
        return addFromProvince(new_country_id, province_name, city_name, zip_code, location_description);
    }

    private void printInfo(){
        for (int indexe : indexes) {
            System.out.print(indexe);
        }
        System.out.println();
    }

}
