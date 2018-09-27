package stages.tables.mechanic.reparations;


import javafx.beans.property.SimpleStringProperty;

public class SingleMechanicTable {

    private final SimpleStringProperty descripcion;
    private final SimpleStringProperty fechaI;
    private final SimpleStringProperty fechaF;
    private final SimpleStringProperty matricula;
    private final SimpleStringProperty horas;

    private final SimpleStringProperty idReparacion;

    public SingleMechanicTable(String descripcion, String fechaI, String fechaF, String matricula, String horas, String idReparacion){
        this.descripcion = new SimpleStringProperty(descripcion);
        this.fechaI = new SimpleStringProperty(fechaI);
        this.fechaF = new SimpleStringProperty(fechaF);
        this.matricula = new SimpleStringProperty(matricula);
        this.horas = new SimpleStringProperty(horas);
        this.idReparacion = new SimpleStringProperty(idReparacion);
    }

    public String getDescripcion() {
        return descripcion.get();
    }

    public SimpleStringProperty descripcionProperty() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion.set(descripcion);
    }

    public String getFechaI() {
        return fechaI.get();
    }

    public SimpleStringProperty fechaIProperty() {
        return fechaI;
    }

    public void setFechaI(String fechaI) {
        this.fechaI.set(fechaI);
    }

    public String getFechaF() {
        return fechaF.get();
    }

    public SimpleStringProperty fechaFProperty() {
        return fechaF;
    }

    public void setFechaF(String fechaF) {
        this.fechaF.set(fechaF);
    }

    public String getMatricula() {
        return matricula.get();
    }

    public SimpleStringProperty matriculaProperty() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula.set(matricula);
    }

    public String getHoras() {
        return horas.get();
    }

    public SimpleStringProperty horasProperty() {
        return horas;
    }

    public void setHoras(String horas) {
        this.horas.set(horas);
    }

    public String getIdReparacion() {
        return idReparacion.get();
    }

    public SimpleStringProperty idReparacionProperty() {
        return idReparacion;
    }

    public void setIdReparacion(String idReparacion) {
        this.idReparacion.set(idReparacion);
    }
}
