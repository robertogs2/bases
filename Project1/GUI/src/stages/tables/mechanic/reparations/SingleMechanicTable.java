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
}
