package stages.shop;

import javafx.collections.ObservableList;
import javafx.geometry.Pos;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.TextAlignment;
import main.Main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static main.Main.queries;

public class CarView extends VBox {

    private String brand;
    private String model;
    private String plate;
    private String price;
    private String color;
    private int pk;
    private ImageView photo;
    private ObservableList<String> urlList;
    private Label lbName;
    private Label lbDescription;

    public CarView ( int pk, String brand, String model, String plate, String price, String color, ObservableList<String> imageList){
        this.brand = brand;
        this.model = model;
        this.plate = plate;
        this.price = price;
        this.color = color;
        this.pk = pk;
        this.urlList = imageList;
        if(!imageList.isEmpty())
            photo = new ImageView( new Image(imageList.get(0)));
        else photo = new ImageView();
        photo.setFitWidth(100);
        photo.setFitHeight(100);
        lbName = new Label(this.getName());
        lbName.setFont(Font.font("System",FontWeight.BOLD,14));
        lbDescription = new Label();
        lbDescription.setText(this.getDescription());
        lbDescription.setWrapText(true);
        lbDescription.setTextAlignment(TextAlignment.JUSTIFY);
        lbDescription.setMaxWidth(200);
        this.getChildren().addAll(photo,lbName,lbDescription);
        this.prefWidth(100);
        this.maxHeight(200);
        //VBox.setVgrow(description,Priority.ALWAYS);
        this.setAlignment(Pos.TOP_CENTER);

        this.addEventHandler(MouseEvent.MOUSE_CLICKED, event -> {
            System.out.println("Escogiste el carro " + this.getPk());
            try {
                HashMap<String, List<String>> data = Main.dao.selectData(queries.ObTENER_INFO_CARRO,this.getPk());
                List<String> attributes = new ArrayList<>(data.keySet());
                List<String> values = new ArrayList<>();
                for (int i = 0; i < attributes.size(); ++i){
                    values.add(data.get(attributes.get(i)).get(0));
                }
                Main.showPreviewStage(this.pk,attributes,values,this.urlList);
            } catch (Exception e) {
                e.printStackTrace();
            }
            event.consume();
        });
    }

    public String getName() {
        String rtn = brand + " " + model;
        return rtn;

    }


    public String getDescription() {
        String rtn = "$ " + price + "\n" + "Matrícula: " + plate;
        return rtn;
    }

    public String getBrand() {
        return brand;
    }

    public String getModel() {
        return model;
    }

    public String getColor() {
        return color;
    }

    public String getPrice() {
        return price;
    }

    public int getPk() {
        return pk;
    }
}
