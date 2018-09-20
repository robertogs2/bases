package DBConnection;

public class Queries {

    public final String OBTENER_NOMBRE_MARCA = "{call ObtenerNombreMarca(?)}";


    public final String OBTENER_IFORMACION_PARA_VEHICULO = "{call ObtenerInfoCarroMatricula(?)}";
    public final String OBTENER_REPARACIONES = "{call ObtenerReparaciones(?)}";
    public final String OBTENER_REPARACIONES_POR_FECHA = "{call ObtenerReparacionesFecha(?,?)}";
    public final String OBTENER_REPARACIONES_POR_MECANICO = "{call ObtenerReparacionesMecanicoPorCedula(?)}";
    public final String OBTENER_COCHES_POR_CONCESIONARIO = "{call ObtenerCochesPorConcesionarioPorNombre(?)}";

    private static Queries instance;

    protected Queries(){
    }

    public static Queries getInstance(){
        if(instance == null) instance = new Queries();
        return instance;
    }
}
