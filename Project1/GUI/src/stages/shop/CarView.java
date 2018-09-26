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

    private String name;
    private String description;
    private int pk;
    private ImageView photo;
    private ObservableList<Image> imageList;
    private Label lbName;
    private Label lbDescription;
    private int imageCount = 0;

    public CarView ( int pk, String name, String description, ObservableList<Image> imageList){
        this.name = name;
        this.description = description;
        this.pk = pk;
        this.imageList = imageList;
        if(!imageList.isEmpty())
            photo = new ImageView(imageList.get(0));
        else photo = new ImageView();
        photo = new ImageView();
        photo.setFitWidth(100);
        photo.setFitHeight(100);
        lbName = new Label(name);
        lbName.setFont(Font.font("System",FontWeight.BOLD,14));
        lbDescription = new Label();
        lbDescription.setText(description);
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
                Main.showPreviewStage(attributes,values);
            } catch (Exception e) {
                e.printStackTrace();
            }

            event.consume();
        });
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
        lbName.setText(name);
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
        lbDescription.setText(description);
    }

    public void shiftRightImage(){
        photo = new ImageView(imageList.get((++imageCount)%imageList.size()));
    }

    public void leftRightImage(){
        photo = new ImageView(imageList.get((--imageCount)%imageList.size()));
    }

    public int getPk() {
        return pk;
    }
}
