package stages.preview;

import javafx.beans.property.SimpleStringProperty;

public class carAttribute implements Comparable<carAttribute>{
    private final SimpleStringProperty name;
    private final SimpleStringProperty value;

    carAttribute(String name, String value){
        this.name = new SimpleStringProperty(name);
        this.value = new SimpleStringProperty(value);
    }

    public String getName(){
        return name.get();
    }

    public void setName(String name){
        this.name.set(name);
    }

    public String getValue(){
        return value.get();
    }

    public void setValue(String value){
        this.value.set(value);
    }

    @Override
    public int compareTo(carAttribute o) {
        return this.getName().compareTo(o.getName());
    }
}
