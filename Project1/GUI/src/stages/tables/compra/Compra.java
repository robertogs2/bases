package stages.tables.compra;

import javafx.beans.property.SimpleStringProperty;

public class Compra {

    private final SimpleStringProperty marca;
    private final SimpleStringProperty modelo;
    private final SimpleStringProperty persona;
    private final SimpleStringProperty precio;
    private final SimpleStringProperty estado;
    private final SimpleStringProperty fecha;

    public Compra(String marca, String modelo, String persona, String precio, String estado, String fecha){
        this.marca = new SimpleStringProperty(marca);
        this.modelo = new SimpleStringProperty(modelo);
        this.persona = new SimpleStringProperty(persona);
        this.precio = new SimpleStringProperty(precio);
        this.estado = new SimpleStringProperty(estado);
        this.fecha = new SimpleStringProperty(fecha);
    }

    public String getMarca() {
        return marca.get();
    }

    public SimpleStringProperty marcaProperty() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca.set(marca);
    }

    public String getModelo() {
        return modelo.get();
    }

    public SimpleStringProperty modeloProperty() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo.set(modelo);
    }

    public String getPersona() {
        return persona.get();
    }

    public SimpleStringProperty personaProperty() {
        return persona;
    }

    public void setPersona(String persona) {
        this.persona.set(persona);
    }

    public String getPrecio() {
        return precio.get();
    }

    public SimpleStringProperty precioProperty() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio.set(precio);
    }

    public String getEstado() {
        return estado.get();
    }

    public SimpleStringProperty estadoProperty() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado.set(estado);
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
}
