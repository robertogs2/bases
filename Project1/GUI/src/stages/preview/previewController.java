package stages.preview;

import javafx.beans.binding.Bindings;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;

import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import static main.Main.*;

public class previewController implements Initializable {
    private int imageCount = 0;
    private int pk;

    private ObservableList<carAttribute> carAttributes = FXCollections.observableArrayList();
    private ObservableList<String> urlList = FXCollections.observableArrayList();

    @FXML TableView<carAttribute> tbvAttribute;
    @FXML TableColumn<carAttribute,String> tbcName;
    @FXML TableColumn<carAttribute,String> tbcValue;
    @FXML ImageView photo;
    @FXML HBox hBox;
    @FXML Button btnComprar;
    @FXML TextField tfCedula;


    @Override
    public void initialize(URL location, ResourceBundle resources) {
        hBox.prefWidthProperty().bind(primaryStage.widthProperty().subtract(35));
        //hBox.prefHeightProperty().bind(primaryStage.heightProperty());

        tbcName.setCellValueFactory(new PropertyValueFactory<>("name"));
        tbcValue.setCellValueFactory(new PropertyValueFactory<>("value"));


        /*for (int i = 0; i < 10; ++i){
            carAttribute carAttribute = new carAttribute("Atributo " + i, "Valor " + i);
            carAttributes.addAll(carAttribute);
        }*/

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

    public void comprar() throws Exception {
        if (tfCedula.getText().length() > 0 && tfCedula.getText().matches("\\d+")){
            HashMap<String, List<String>> personIds = dao.selectData(queries.OBTENER_ID_PERSONA_POR_CEDULA, tfCedula.getText());
            if (personIds.get("idPersona") == null) {
                showAddPersonStage(tfCedula.getText());
            }
            HashMap<String, List<String>> id = dao.selectData(queries.OBTENER_ID_CLIENTE_POR_CEDULA, tfCedula.getText());
            if (id.get("idCliente") == null) {
                dao.selectData(queries.AGREGAR_CLIENTE_POR_CEDULA, tfCedula.getText());
            }
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date dateobj = new Date();
            System.out.println(df.format(dateobj) + "  " + tfCedula.getText() + "  " + this.pk);
            dao.pushData(queries.AGREGAR_COMPRA,df.format(dateobj),tfCedula.getText(),this.pk);
        } else {
            showErrorMessage("Formato de cédula inválida");
        }
    }

    private void showErrorMessage(String msg){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Ooops!");
        alert.setContentText(msg);
        alert.showAndWait();
    }

    public void shiftRightImage(){
        if (!urlList.isEmpty())
            photo.setImage(new Image(urlList.get(Math.abs(++imageCount)% urlList.size())));
    }

    public void leftRightImage(){
        if (!urlList.isEmpty())
            photo.setImage(new Image(urlList.get(Math.abs((--imageCount))% urlList.size())));
    }

    public void addAttributes(int pk,List<String> attributes, List<String> values, ObservableList<String> urls){
        this.pk = pk;
        urlList.addAll(urls);
        if (!urls.isEmpty())
            photo.setImage(new Image(urls.get(imageCount)));
        for (int i = 0; i < attributes.size(); ++i){
            carAttribute carAttribute = new carAttribute(attributes.get(i), values.get(i));
            carAttributes.addAll(carAttribute);
        }
    }
}
