package stages.inventory;

import javafx.beans.Observable;
import javafx.collections.FXCollections;
import javafx.collections.ListChangeListener;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.FileChooser;
import main.Main;
import tools.ImageUploader;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.*;
import java.util.List;

import static main.Main.primaryStage;
import static main.Main.queries;
import static main.Main.dao;
import static main.Main.showAddPersonStage;
import static main.Main.popUpStage;

public class CarRegistrationFormController implements Initializable {

    @FXML ComboBox<String> marca_cb;
    @FXML ComboBox<String> modelo_cb;
    @FXML TextField matricula_tf, color_tf, kilometraje_tf, precio_tf, cedula_tf;
    @FXML Button send_bb,cancel_bb;
    @FXML VBox vBox;
    @FXML HBox cb_box;
    @FXML HBox img_hb;
    @FXML Button upload_img_bb;

    private final FileChooser fileChooser = new FileChooser();
    private final Desktop desktop = Desktop.getDesktop();
    private final ImageUploader imageUploader = ImageUploader.getInstance();
    private ObservableList<File> imgFiles;
    ProgressIndicator p1 = new ProgressIndicator();

    private final int[] indexes = new int[4]; //index0 : brand, index1 : modelo
    private static List<String> brand_indexes;
    private static List<String> model_indexes;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Dinamycally change size of flow pane according to parent stage
        //flowPane.prefWidthProperty().bind(primaryStage.widthProperty());
        //flowPane.prefHeightProperty().bind(primaryStage.heightProperty());


        img_hb.getChildren().add(p1);
        p1.setVisible(false);

        HashMap<String, List<String>> brand_list = new HashMap<>();
        imgFiles = FXCollections.observableArrayList();

        clear_cb(marca_cb);
        clear_cb(modelo_cb);

        try {
            brand_list = dao.selectData(queries.OBTENER_MARCAS_REGISTRADAS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Arrays.fill(indexes, -1);
        brand_indexes = brand_list.get("idMarca");
        marca_cb.getItems().setAll(brand_list.get("nombre"));

        listenToBrand();
        listenToModel();
        listenToImg();
        listenToCancel();
        listenToSend();
    }

    private void clear_cb(ComboBox<String> cb){
        cb.getItems().clear(); //removes list
        cb.valueProperty().set(""); //removes string in the field
    }

    private void listenToBrand(){
        marca_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[0] = marca_cb.getSelectionModel().getSelectedIndex();
            if(indexes[0] != -1){
                indexes[0] = Integer.decode(brand_indexes.get(indexes[0]));
                updateModel(indexes[0]);
                //country_cb.setEditable(false);
            }
            else{
                clear_cb(modelo_cb);
            }
        });
    }

    private void updateModel(int brandIndex){
        try {
            modelo_cb.getItems().clear();
            HashMap<String, List<String>> province_list = dao.selectData(queries.ObTENER_MODELOS_POR_MARCA, brandIndex);
            model_indexes = province_list.get("idModelo");
            if(province_list.size() > 0) {
                modelo_cb.getItems().setAll(province_list.get("nombre"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void listenToModel(){
        modelo_cb.getSelectionModel().selectedIndexProperty().addListener((Observable o) -> {
            indexes[1] = modelo_cb.getSelectionModel().getSelectedIndex();
            if(indexes[1] != -1){
                indexes[1] = Integer.decode(model_indexes.get(indexes[1]));
            }
        });
    }

    private void listenToSend(){
        send_bb.setOnMouseClicked(event -> {
            boolean flag = true;
            for( Node node: vBox.getChildren()) {
                if( node instanceof TextField) {
                    if(((TextField) node).getText().replace(" ","").equals("") && !node.getId().contains("cedula")){
                        showErrorMessage("El campo "+node.getId().split("_")[0] + " no puede ser vacio.");
                        flag = false;
                        break;
                    }
                }
            }

            for(Node node: cb_box.getChildren()){
                if(node instanceof ComboBox){
                    if(((ComboBox)node).valueProperty().getValue().equals("")){
                        showErrorMessage("El campo "+node.getId().split("_")[0] + " no puede ser vacio.");
                        flag = false;
                        break;
                    }
                }
            }
            String clientId = "NUll INT";
            if(cedula_tf.getText().length() > 0 && !cedula_tf.getText().matches("\\d+")){
                showErrorMessage("La cedula debe ser un numero, o nula en caso de ser un concecionario.");
                flag = false;
            }else if(cedula_tf.getText().length() > 0){
                try {
                    HashMap<String, List<String>> personIds = dao.selectData(queries.OBTENER_ID_PERSONA_POR_CEDULA, cedula_tf.getText());

                    if(personIds.get("idPersona") == null) {
                        showAddPersonStage(cedula_tf.getText());
                    }
                    HashMap<String, List<String>> id = dao.selectData(queries.OBTENER_ID_CLIENTE_POR_CEDULA, cedula_tf.getText());
                    if(id.get("idCliente") == null){
                        clientId = id.get("idCliente").get(0);
                    }else{
                        HashMap<String, List<String>> client_id = dao.selectData(queries.AGREGAR_CLIENTE_POR_CEDULA, cedula_tf.getText());
                        clientId = client_id.get("LAST_INSERTED_ID()").get(0);
                    }
                }catch (Exception e){}
            }

            if(flag) {
                try {
                    if (indexes[0] == -1) {
                        HashMap<String, List<String>> city_id = dao.selectData(queries.AGREGAR_MARCA, marca_cb.valueProperty().getValue());
                        indexes[0] = Integer.parseInt(city_id.get("LAST_INSERT_ID()").get(0));
                    }
                    if (indexes[1] == -1) {
                        HashMap<String, List<String>> city_id = dao.selectData(queries.AGREGAR_CIUDAD, modelo_cb.valueProperty().getValue(), indexes[0]);
                        indexes[1] = Integer.parseInt(city_id.get("LAST_INSERT_ID()").get(0));
                    }

                    String estado = (kilometraje_tf.getText().equals("0"))? "nuevo" : "usado";

                    //Generates new car
                    HashMap<String, List<String>> car_id = dao.selectData(queries.AGREGAR_CARRO,
                            matricula_tf.getText(), indexes[1], color_tf.getText(), estado, kilometraje_tf.getText(), precio_tf.getText(), 1, clientId);
                    int new_car_id = Integer.parseInt(car_id.get("LAST_INSERT_ID()").get(0));

                    p1.progressProperty().unbind();
                    p1.setVisible(true);
                    for(File file: imgFiles){
                        try {
                            String imgUrl = imageUploader.uploadImage(String.valueOf(new_car_id) + "-" +  imgFiles.indexOf(file), file);
                            dao.pushData(queries.AGREGAR_FOTO,new_car_id,imgUrl);
                        }catch (Exception e){
                            e.printStackTrace();
                        }
                    }
                    Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
                    alert.setTitle("Awesome!");
                    alert.setContentText("El carro se agrego correctamente.");
                    alert.showAndWait();
                    Main.showMainMenu();
                } catch (Exception e1) {
                    showErrorMessage(e1.getMessage());
                }
            }
        });
    }

    private void listenToImg(){
        imgFiles.addListener((ListChangeListener<File>) c -> {
            try {
                Image image = new Image(imgFiles.get(imgFiles.size() - 1).toURI().toString());//ImageIO.read(imgFiles.get(imgFiles.size() - 1));
                ImageView iv = new ImageView(image);
                iv.setFitHeight(100);
                iv.setFitWidth(100);
                img_hb.getChildren().add(0, iv);
            }catch (Exception e){
                showErrorMessage("No se puede mostrar la imagen.");
            }
        });
        upload_img_bb.setOnMouseClicked(event -> {
            File file = fileChooser.showOpenDialog(primaryStage);
            if (file != null) {
                try {
                    if(imgFiles.size() < 6){
                        imgFiles.add(file);
                    }else{
                        showErrorMessage("Solo puede subir 5 imagenes.");
                    }
                    //imageUploader.uploadImage("TEST", file);
                }catch (Exception e){
                    showErrorMessage(e.getMessage());
                }
            }
        });
    }

    private void openFile(File file){
        try {
            desktop.open(file);
        } catch (IOException ex) {
            showErrorMessage("No se  pudo acceder al archivo.");
        }
    }

    private void listenToCancel(){
        cancel_bb.setOnMouseClicked(e -> {
            try {
                Main.showMainMenu();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        });
    }

    private void showErrorMessage(String msg){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Ooops!");
        alert.setContentText(msg);
        alert.showAndWait();
    }

    public void setMatricula(String matricula){
        matricula_tf.setText(matricula);
    }

}
