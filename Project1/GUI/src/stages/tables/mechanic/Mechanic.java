package stages.tables.mechanic;

import javafx.beans.property.SimpleStringProperty;
import stages.tables.Persona;

public class Mechanic {

    private final SimpleStringProperty cedula;
    private final SimpleStringProperty pnombre;
    private final SimpleStringProperty apellidos;
    private final SimpleStringProperty edad;
    private final SimpleStringProperty telefono;
    private final SimpleStringProperty extension;
    private final SimpleStringProperty fecha;
    private final SimpleStringProperty salario;
    private final SimpleStringProperty tnombre;
    private final SimpleStringProperty cnombre;

    public Mechanic(String cedula, String nombre, String apellidos,
                    String edad, String telefono, String extension, String fecha,
                    String salario, String taller, String concesionario){
        this.cedula = new SimpleStringProperty(cedula);
        this.pnombre = new SimpleStringProperty(nombre);
        this.apellidos = new SimpleStringProperty(apellidos);
        this.edad = new SimpleStringProperty(edad);
        this.telefono = new SimpleStringProperty(telefono);
        this.extension = new SimpleStringProperty(extension);
        this.fecha = new SimpleStringProperty(fecha);
        this.salario = new SimpleStringProperty(salario);
        this.tnombre = new SimpleStringProperty(taller);
        this.cnombre = new SimpleStringProperty(concesionario);
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

    public String getPnombre() {
        return pnombre.get();
    }

    public SimpleStringProperty pnombreProperty() {
        return pnombre;
    }

    public void setPnombre(String pnombre) {
        this.pnombre.set(pnombre);
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

    public String getFecha() {
        return fecha.get();
    }

    public SimpleStringProperty fechaProperty() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha.set(fecha);
    }

    public String getSalario() {
        return salario.get();
    }

    public SimpleStringProperty salarioProperty() {
        return salario;
    }

    public void setSalario(String salario) {
        this.salario.set(salario);
    }

    public String getTnombre() {
        return tnombre.get();
    }

    public SimpleStringProperty tnombreProperty() {
        return tnombre;
    }

    public void setTnombre(String tnombre) {
        this.tnombre.set(tnombre);
    }

    public String getCnombre() {
        return cnombre.get();
    }

    public SimpleStringProperty cnombreProperty() {
        return cnombre;
    }

    public void setCnombre(String cnombre) {
        this.cnombre.set(cnombre);
    }
}
