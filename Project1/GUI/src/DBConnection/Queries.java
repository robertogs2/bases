package DBConnection;

public class Queries {

    public final String AGREGAR_PAIS = "{call AgregarPais(?)}";                                                  //args: nombre
    public final String AGREGAR_DIRECCION = "{call AgregarDireccion(?, ?)}";
    public final String AGREGAR_UBICACION = "{call AgregarUbicacion(?, ?)}";
    public final String AGREGAR_CIUDAD = "{call AgregarCiudad(?, ?)}";
    public final String AGREGAR_PROVINCIA = "{call AgregarProvincia(?, ?)}";

    public final String AGREGAR_PERSONA = "{call AgregarPersona(?,?,?,?,?,?,?)}";                               // args: cedula,nombre,apellidos,edad,telefono,extencionTelefonica,idUbicacion
    public final String AGREGAR_CLIENTE_POR_CEDULA = "{call AgregarClientePorCedula(?)}";                       // args: cedula
    public final String AGREGAR_CONCESIONARIO = "{call AgregarConcesionario(?,?)}";                             // args: nombre,idUbicacion
    public final String AGREGAR_MARCA = "{call AgregarMarca(?)}";                                               // args: nombre
    public final String AGREGAR_MODELO = "{call AgregarModelo(?,?)}";                                           // args: nombre,idMarca
    public final String AGREGAR_CARRO = "{call AgregarCoche(?,?,?,?,?,?,?,?)}";                                   // args: matricula,idModelo,color,estado,kilometraje,precio,idConcesionario,idCliente
    public final String AGREGAR_FOTO = "{call AgregarFoto(?,?)}";                                              // args: idCarro, urlFoto
    public final String AGREGAR_TALLER = "{call AgregarTaller(?,?,?)}";                                         // args: nombre,idUbicacion,idConcesionario
    public final String AGREGAR_MECANICO = "{call AgregarMecanicoCompleto(?,?,?,?)}";                           // args: fechaContratacion,salario,cedula,idTaller
    public final String AGREGAR_COMPRA = "{call AgregarCompraCompleto(?,?,?)}";                                 // args: fechaHora,idCiente,idCoche
    public final String AGREGAR_REPARACION = "{call AgregarReparacionCompleto(?,?,?,?)}";                       // args: fechaHoraInicio,fechaHoraFinal,Matricula,Descripcion
    public final String AGREGAR_REPARACION_X_MECANICO = "{call AgregarReparacionXMecanico(?,?,?)}";             // args: idReparacion,idMecanico,horas

    public final String OBTENER_CONCESIONARIOS = "{call ObtenerConcesionarios()}";                               // args:NO-ARGS
    public final String OBTENER_TALLER_POR_CONCESIONARIO = "{call ObtenerTallerPorConcesionario(?)}";            // args: idConcesionario
    public final String OBTENER_DIRECCION = "{call ObtenerDireccionCompleta(?)}";                               // args: idUbicacion
    public final String OBTENER_INFORMACION_PARA_VEHICULO = "{call ObtenerInfoCarroMatricula(?)}";              // args: matricula
    public final String OBTENER_REPARACIONES = "{call ObtenerReparaciones(?)}";                                 // args: matricula
    public final String OBTENER_REPARACIONES_POR_FECHA = "{call ObtenerReparacionesFecha(?,?)}";                // args: matricula,fecjaInicio
    public final String OBTENER_REPARACIONES_POR_MECANICO = "{call ObtenerReparacionesMecanicoPorCedula(?)}";   // args: cedula
    public final String OBTENER_COCHES_POR_CONCESIONARIO = "{call ObtenerCochesPorConcesionarioPorNombre(?)}";  // args: nombreConcesionario
    public final String OBTENER_PAISES = "{call ObtenerPaises()}";                                              // args: NO-ARGS
    public final String OBTENER_PROVINCIAS_POR_PAIS = "{call ObtenerProvinciasPorPais(?)}";                     // args: idPais
    public final String OBTENER_CIUDADES_POR_PROVINCIA = "{call ObtenerCiudadPorProvincia(?)}";                 // args: idProvincia
    public final String OBTENER_DIRECCION_POR_CIUDAD = "{call ObtenerDireccionPorCiudad(?)}";                   // args: idCiudad
    public final String OBTENER_UBICACION_POR_DIRECCION = "{call ObtenerUbicacionPorDireccion(?)}";             // args: idDireccion
    public final String OBTENER_MARCAS_REGISTRADAS = "{call ObtenerMarcasRegistradas()}";                       // args: NO-ARGS
    public final String ObTENER_MODELOS_POR_MARCA = "{call ObtenerModelosPorMarca(?)}";                         // args: idMarca
    public final String OBTENER_ID_CLIENTE_POR_CEDULA = "{call ObtenerIdClientePorCedula(?)}";                  // args: cedula
    public final String OBTENER_MATRICULAS_POR_CLIENTE = "{call ObtenerMatriculasPorCliente(?)}";               // args: idCliente
    public final String ObTENER_INFO_CARRO_POR_CONCESIONARIO = "{call ObtenerInfoCarroPorConcesionario(?)}";
    public final String ObTENER_INFO_CARRO = "{call ObtenerInfoCarro(?)}";
    public final String OBTENER_PERSONAS = "{call ObtenerPersonas()}";

    public final String ACTUALIZAR_FINALIZAR_REPARACION = "{call TerminarReparacion(?)}";                       // args: idReparacion
    public final String OBTENER_ULTIMO_ID = "{call ObtenerUltimoID()}";                       // args: NO-ARGS

    private static Queries instance;

    protected Queries(){
    }

    public static Queries getInstance(){
        if(instance == null) instance = new Queries();
        return instance;
    }
}
