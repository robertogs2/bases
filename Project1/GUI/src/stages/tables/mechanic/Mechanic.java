package stages.tables.mechanic;

import javafx.beans.property.SimpleStringProperty;
import stages.tables.Persona;

public class Mechanic {

    Persona persona;
    private final SimpleStringProperty salario;
    private final SimpleStringProperty taller;
    private final SimpleStringProperty concesionario;

    Mechanic(String cedula, String nombre, String apellidos, String edad, String telefono, String extension, String salario, String taller, String concesionario){
        persona = new Persona(cedula, nombre, apellidos, edad, telefono, extension);
        this.salario = new SimpleStringProperty(salario);
        this.taller = new SimpleStringProperty(taller);
        this.concesionario = new SimpleStringProperty(concesionario);
    }
}
