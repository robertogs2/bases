package stages.tables;

import javafx.beans.property.SimpleStringProperty;

public class Persona {

    private final SimpleStringProperty cedula;
    private final SimpleStringProperty nombre;
    private final SimpleStringProperty apellidos;
    private final SimpleStringProperty edad;
    private final SimpleStringProperty telefono;
    private final SimpleStringProperty extension;

    public Persona(String cedula, String nombre, String apellidos, String edad, String telefono, String extension){
        this.cedula = new SimpleStringProperty(cedula);
        this.nombre = new SimpleStringProperty(nombre);
        this.apellidos = new SimpleStringProperty(apellidos);
        this.edad = new SimpleStringProperty(edad);
        this.telefono = new SimpleStringProperty(telefono);
        this.extension = new SimpleStringProperty(extension);
    }

    public String getCedula() {
        return cedula.get();
    }

    public SimpleStringProperty cedulaProperty() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula.set(cedula);
    }

    public String getNombre() {
        return nombre.get();
    }

    public SimpleStringProperty nombreProperty() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre.set(nombre);
    }

    public String getApellidos() {
        return apellidos.get();
    }

    public SimpleStringProperty apellidosProperty() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos.set(apellidos);
    }

    public String getEdad() {
        return edad.get();
    }

    public SimpleStringProperty edadProperty() {
        return edad;
    }

    public void setEdad(String edad) {
        this.edad.set(edad);
    }

    public String getTelefono() {
        return telefono.get();
    }

    public SimpleStringProperty telefonoProperty() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono.set(telefono);
    }

    public String getExtension() {
        return extension.get();
    }

    public SimpleStringProperty extensionProperty() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension.set(extension);
    }
}
