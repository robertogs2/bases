package stages.shop;

import javafx.beans.InvalidationListener;
import javafx.beans.Observable;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.image.Image;

public class CarAlbum implements Observable {
    private ObservableList<CarView> carList = FXCollections.observableArrayList();

    private BooleanProperty changed = new SimpleBooleanProperty();
    public final boolean getChanged(){return changed.get();}
    public final void setChanged(boolean value){changed.set(value);}
    public BooleanProperty changedProperty(){return changed;}

    public CarAlbum(){}

    public ObservableList<CarView> getCarList(){ return carList; }

    public void addCar(int pk, String name, String description, ObservableList<Image> imageList) {
        carList.add(0, new CarView(pk, name, description, imageList));
    }

    public void removeCar(int pk){

        for(CarView car: carList){
            if(car.getPk() == pk){
                carList.removeAll(car);
                break;
            }
        }
        if (this.getChanged())
            this.setChanged(false);
        else
            this.setChanged(true);
    }

    public void sortByName() {
        System.out.println("Sort by Title");
        FXCollections.sort(this.getCarList(),
                (car1, car2) -> car1.getName().compareToIgnoreCase(car2.getName()));
    }

    @Override
    public void addListener(InvalidationListener listener) {

    }

    @Override
    public void removeListener(InvalidationListener listener) {

    }
}
