package stages.shop;

import javafx.beans.InvalidationListener;
import javafx.beans.Observable;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.image.Image;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CarAlbum implements Observable {
    private ObservableList<CarView> carList = FXCollections.observableArrayList();
    private ObservableList<CarView> allCarList = FXCollections.observableArrayList();

    private List<String> colorList = new ArrayList<>();
    private HashMap<String, List<String>> brandModel = new HashMap<>();

    private BooleanProperty changed = new SimpleBooleanProperty();

    public final boolean getChanged() {
        return changed.get();
    }

    public final void setChanged(boolean value) {
        changed.set(value);
    }

    public BooleanProperty changedProperty() {
        return changed;
    }

    public CarAlbum() {
    }

    public ObservableList<CarView> getAllCarList() {
        return allCarList;
    }

    public ObservableList<CarView> getCarList() {
        return carList;
    }

    public void addCar(int pk, String brand, String model, String plate, String price, String color, ObservableList<Image> imageList) {
        CarView car = new CarView(pk, brand, model, plate, price, color, imageList);
        carList.addAll(car);
        allCarList.addAll(car);
        addBrandModel(brand, model);
        addColor(color);
    }

    public void removeCar(int pk) {

        for (CarView car : carList) {
            if (car.getPk() == pk) {
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
        FXCollections.sort(this.getCarList(),
                (car1, car2) -> car1.getName().compareToIgnoreCase(car2.getName()));
    }

    public void sortByPrice() {
        FXCollections.sort(this.getCarList(),
                (car1, car2) -> car1.getPrice().compareToIgnoreCase(car2.getPrice()));
    }

    public void filter(String brand, String model, String color) {
        carList.clear();
        for (CarView car : allCarList) {
            if (color.equals("")) {
                if (model.equals("")) {
                    if (brand.equals("")) {
                        carList.addAll(car);
                    } else if (brand.equals(car.getBrand())) {
                        carList.addAll(car);
                    }
                } else if (brand.equals(car.getBrand()) && model.equals(car.getModel())) {
                    carList.addAll(car);
                }
            } else if (brand.equals(car.getBrand()) && model.equals(car.getModel()) && color.equals(car.getColor())) {
                carList.addAll(car);
            }
        }
    }

    public void addBrandModel(String brand, String model) {
        if (!brandModel.containsKey(brand)) {
            List<String> temp = new ArrayList<>();
            temp.add(model);
            brandModel.put(brand, temp);
        } else {
            List<String> temp = brandModel.get(brand);
            if (!temp.contains(model)) {
                temp.add(model);
                brandModel.remove(brand);
                brandModel.put(brand, temp);
            }
        }
    }

    private void addColor(String color) {
        if (!colorList.contains(color)) {
            colorList.add(color);
        }
    }

    public HashMap<String, List<String>> getBrandModel() {
        return brandModel;
    }

    public List<String> getColorList() {
        return colorList;
    }

    @Override
    public void addListener(InvalidationListener listener) {

    }

    @Override
    public void removeListener(InvalidationListener listener) {

    }
}
