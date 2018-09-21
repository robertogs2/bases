package DBConnection;

public class Queries {

    public final String OBTENER_NOMBRE_MARCA = "{call ObtenerNombreMarca(?)}";

    public final String AGREGAR_PERSONA = "{call AgregarPersona(?,?,?,?,?,?,?)}";
    public final String AGREGAR_CLIENTE_POR_CEDULA = "{call AgregarClientePorCedula(?)}";
    public final String AGREGAR_CONCESIONARIO = "{call AgregarConcesionario(?,?)}";
    public final String AGREGAR_MARCA = "{call AgregarMarca(?)}";
    public final String AGREGAR_MODELO = "{call AgregarModelo(?,?)}";
    public final String AGREGAR_CARRO = "{call AgregarCoche(?,?,?,?,?,?,?)}";
    public final String AGERGAR_TALLER = "{call AgregarTaller(?,?,?)}";
    public final String AGREGAR_MECANICO = "{call AgregarMecanicoCompleto()}";

    public final String OBTENER_IFORMACION_PARA_VEHICULO = "{call ObtenerInfoCarroMatricula(?)}";
    public final String OBTENER_REPARACIONES = "{call ObtenerReparaciones(?)}";
    public final String OBTENER_REPARACIONES_POR_FECHA = "{call ObtenerReparacionesFecha(?,?)}";
    public final String OBTENER_REPARACIONES_POR_MECANICO = "{call ObtenerReparacionesMecanicoPorCedula(?)}";
    public final String OBTENER_COCHES_POR_CONCESIONARIO = "{call ObtenerCochesPorConcesionarioPorNombre(?)}";
    public final String OBTENER_PAISES = "{call ObtenerPaises()}";
    public final String OBTENER_PROVINCIAS_POR_PAIS = "{call ObtenerProvinciasPorPais(?)}";
    public final String OBTENER_CIUDADES_POR_PROVINCIA = "{call ObtenerCiudadPorProvincia(?)}";
    public final String OBTENER_DIRECCION_POR_CIUDAD = "{call ObtenerPaises()}";

    private static Queries instance;

    protected Queries(){
    }

    public static Queries getInstance(){
        if(instance == null) instance = new Queries();
        return instance;
    }
}
