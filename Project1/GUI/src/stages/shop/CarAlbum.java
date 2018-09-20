package stages.shop;

import javafx.beans.InvalidationListener;
import javafx.beans.Observable;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

public class CarAlbum implements Observable {
    private ObservableList<CarView> carList = FXCollections.observableArrayList();

    private BooleanProperty changed = new SimpleBooleanProperty();
    public final boolean getChanged(){return changed.get();}
    public final void setChanged(boolean value){changed.set(value);}
    public BooleanProperty changedProperty(){return changed;}

    public CarAlbum(){}

    public ObservableList<CarView> getCarList(){ return carList; }

    public void addCar(String name, String description, int pk) {
        carList.add(0, new CarView(name, description, pk));
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
