package stages.shop;

import javafx.geometry.Pos;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.TextAlignment;

public class CarView extends VBox {

    private String name;
    private String description;
    private int pk;
    Label lbName;
    Label lbDescription;

    public CarView (String name, String description, int pk){
        this.name = name;
        this.description = description;
        this.pk = pk;

        ImageView photo = new ImageView();
        photo.setFitWidth(50);
        photo.setFitHeight(150);
        lbName = new Label();
        lbName.setText(name);
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

    public int getPk() {
        return pk;
    }
}
