package stages.tables.mechanic;

import javafx.beans.property.SimpleStringProperty;

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

    private final SimpleStringProperty idPersona;
    private final SimpleStringProperty idMecanico;
    private final SimpleStringProperty idTaller;
    private final SimpleStringProperty idConcesionario;


    public Mechanic(String cedula, String nombre, String apellidos,
                    String edad, String telefono, String extension, String fecha,
                    String salario, String taller, String concesionario,
                    String idPersona, String idMecanico, String idTaller, String idConcesionario){
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

        this.idPersona = new SimpleStringProperty(idPersona);
        this.idMecanico = new SimpleStringProperty(idMecanico);
        this.idTaller = new SimpleStringProperty(idTaller);
        this.idConcesionario = new SimpleStringProperty(idConcesionario);

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

    public String getIdPersona() {
        return idPersona.get();
    }

    public SimpleStringProperty idPersonaProperty() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona.set(idPersona);
    }

    public String getIdMecanico() {
        return idMecanico.get();
    }

    public SimpleStringProperty idMecanicoProperty() {
        return idMecanico;
    }

    public void setIdMecanico(String idMecanico) {
        this.idMecanico.set(idMecanico);
    }

    public String getIdTaller() {
        return idTaller.get();
    }

    public SimpleStringProperty idTallerProperty() {
        return idTaller;
    }

    public void setIdTaller(String idTaller) {
        this.idTaller.set(idTaller);
    }

    public String getIdConcesionario() {
        return idConcesionario.get();
    }

    public SimpleStringProperty idConcesionarioProperty() {
        return idConcesionario;
    }

    public void setIdConcesionario(String idConcesionario) {
        this.idConcesionario.set(idConcesionario);
    }
}
