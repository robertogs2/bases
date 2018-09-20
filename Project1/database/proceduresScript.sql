use p1;
DROP PROCEDURE IF EXISTS AgregarPais;
DROP PROCEDURE IF EXISTS AgregarProvincia;
DROP PROCEDURE IF EXISTS AgregarCiudad;
DROP PROCEDURE IF EXISTS AgregarDireccion;
DROP PROCEDURE IF EXISTS AgregarUbicacion;
DROP PROCEDURE IF EXISTS AgregarPersona;
DROP PROCEDURE IF EXISTS AgregarCliente;
DROP PROCEDURE IF EXISTS AgregarClientePorCedula;
DROP PROCEDURE IF EXISTS AgregarConcesionario;
DROP PROCEDURE IF EXISTS AgregarMarca;
DROP PROCEDURE IF EXISTS AgregarModelo;
DROP PROCEDURE IF EXISTS AgregarCoche;
DROP PROCEDURE IF EXISTS AgregarTaller;
DROP PROCEDURE IF EXISTS AgregarMecanico;
DROP PROCEDURE IF EXISTS AgregarMecanicoCompleto;
DROP PROCEDURE IF EXISTS AgregarCompra;
DROP PROCEDURE IF EXISTS AgregarCompraCompleto;
DROP PROCEDURE IF EXISTS AgregarReparacion;
DROP PROCEDURE IF EXISTS AgregarReparacionCompleto;
DROP PROCEDURE IF EXISTS AgregarReparacionXMecanico;
DROP PROCEDURE IF EXISTS AgregarProvincia2;

DROP PROCEDURE IF EXISTS ObtenerDireccionCompleta;
DROP PROCEDURE IF EXISTS CambiarEstado;       
DROP PROCEDURE IF EXISTS TerminarReparacion;

DROP PROCEDURE IF EXISTS ObtenerNombreMarca;
DROP PROCEDURE IF EXISTS ObtenerNombreModelo;
DROP PROCEDURE IF EXISTS ObtenerInfoCarro;
DROP PROCEDURE IF EXISTS ObtenerInfoCarroMatricula;
DROP PROCEDURE IF EXISTS ObtenerReparaciones;
DROP PROCEDURE IF EXISTS ObtenerReparacionesFecha;
DROP PROCEDURE IF EXISTS ObtenerReparacionesMecanico;
DROP PROCEDURE IF EXISTS ObtenerReparacionesMecanicoPorCedula;
DROP PROCEDURE IF EXISTS ObtenerCochesPorConcesionario;
DROP PROCEDURE IF EXISTS ObtenerCochesPorConcesionarioPorNombre;

DELIMITER $$
CREATE PROCEDURE AgregarPais (IN eNombre varchar(50)) BEGIN
	INSERT INTO Pais (nombre)
    VALUES(eNombre);
END$$
CREATE PROCEDURE AgregarProvincia (IN eNombre varchar(50), IN eIdPais INT) BEGIN
	INSERT INTO Provincia (nombre, idPais_fk)
    VALUES(eNombre, eIdPais);
END$$
CREATE PROCEDURE AgregarCiudad (IN eNombre varchar(50), IN eIdProvincia INT) BEGIN
	INSERT INTO Ciudad (nombre, idProvincia_fk)
    VALUES(eNombre, eIdProvincia);
END$$
CREATE PROCEDURE AgregarDireccion (IN eZipCode INT, IN eIdCiudad INT) BEGIN
	INSERT INTO Direccion (zipCode, idCiudad_fk)
    VALUES(eZipCode, eIdCiudad);
END$$
CREATE PROCEDURE AgregarUbicacion (IN eDescripcion varchar(100), IN eIdDireccion INT) BEGIN
	INSERT INTO Ubicacion (descripcion, idDireccion_fk)
    VALUES(eDescripcion, eIdDireccion);
END$$
CREATE PROCEDURE AgregarPersona (IN eCedula INT, 
								 IN eNombre VARCHAR(50),
								 IN eApellidos VARCHAR(50),
                                 IN eEdad INT,
                                 IN eTelefono INT,
                                 IN eExtension INT,
                                 IN eIdUbicacion INT) BEGIN
	INSERT INTO Persona (cedula, nombre, apellidos, edad, telefono, extension, idUbicacion_fk)
    VALUES(eCedula, eNombre, eApellidos, eEdad, eTelefono, eExtension, eIdUbicacion);
END$$
CREATE PROCEDURE AgregarCliente (IN eIdPersona INT) BEGIN
	INSERT INTO Cliente (idPersona_fk)
    VALUES(eIdPersona);
END$$
CREATE PROCEDURE AgregarClientePorCedula(IN eCedula INT) BEGIN
    DECLARE vIdPersona INT;
	
    -- This takes the idPersona from the eCedula input
	SELECT idPersona into vIdPersona FROM Persona
    WHERE cedula = eCedula
    LIMIT 1;
    
    CALL AgregarCliente(vIdPersona);
    
END$$
CREATE PROCEDURE AgregarConcesionario (IN eNombre VARCHAR(50), IN eIdUbicacion INT) BEGIN
	INSERT INTO Concesionario (nombre, idUbicacion_fk)
    VALUES(eNombre, eIdUbicacion);
END$$
CREATE PROCEDURE AgregarMarca(IN eNombre VARCHAR(50)) BEGIN
	INSERT INTO Marca(nombre)
    VALUES(eNombre);
END$$
CREATE PROCEDURE AgregarModelo(IN eNombre VARCHAR(50), IN eIdMarca INT) BEGIN
	INSERT INTO Modelo(nombre, idMarca_fk)
    VALUES(eNombre, eIdMarca);
END$$
CREATE PROCEDURE AgregarCoche (IN eMatricula INT, 
								 IN eIdModelo INT,
                                 IN eColor VARCHAR(30),
                                 IN eEstado VARCHAR(30),
                                 IN eKilometraje INT,
                                 IN ePrecio INT,
                                 IN eIdConcesionario INT) BEGIN
	
    -- This takes the idMarca from the idModelo input
    DECLARE vIdMarca INT;
	SELECT idMarca_fk into vIdMarca FROM Modelo
    WHERE idModelo = eIdModelo
    LIMIT 1;
    
	INSERT INTO Coche (matricula, idModelo_fk, idMarca_fk, color, estado, kilometraje, precio, idConcesionario_fk)
    VALUES(eMatricula, eIdModelo, vIdMarca, eColor, eEstado, eKilometraje, ePrecio, eIdConcesionario);
    
END$$
CREATE PROCEDURE AgregarTaller (IN eNombre VARCHAR(50), IN eIdUbicacion INT, IN eIdConcesionario INT) BEGIN
	INSERT INTO Taller (nombre, idUbicacion_fk, idConcesionario_fk)
    VALUES(eNombre, eIdUbicacion, eIdConcesionario);
END$$
CREATE PROCEDURE AgregarMecanico (IN eFechaContratacion DATE, 
								 IN eSalario INT,
                                 IN eIdPersona INT,
                                 IN eIdConcesionario INT,
                                 IN eIdTaller INT) BEGIN
	INSERT INTO Mecanico (fechaContratacion, salario, idPersona_fk, idConcesionario_fk, idTaller_fk)
    VALUES(eFechaContratacion, eSalario, eIdPersona, eIdConcesionario, eIdTaller);
END$$
-- Usa la cédula de la persona, e infiere el concesionario a partir del taller
CREATE PROCEDURE AgregarMecanicoCompleto (IN eFechaContratacion DATE, 
								 IN eSalario INT,
                                 IN eCedula INT,
                                 IN eIdTaller INT) BEGIN
	DECLARE vIdPersona INT;
    DECLARE vIdConcesionario INT;
    -- This takes the idPersona from the eCedula input
	SELECT idPersona into vIdPersona FROM Persona
    WHERE cedula = eCedula
    LIMIT 1;                             
                                 
    -- This takes the idTaller from the eIdTaller input and gives IdConcesionario
	SELECT idConcesionario_fk into vIdConcesionario FROM Taller
    WHERE idTaller = eIdTaller
    LIMIT 1;   
    
	CALL AgregarMecanico(eFechaContratacion, eSalario, vIdPersona, vIdConcesionario, eIdTaller);
END$$
CREATE PROCEDURE AgregarCompra (IN eFechaHora DATETIME, IN eMonto INT, IN eIdCliente INT, IN eIdConcesionario INT, IN eIdCoche INT) BEGIN
	INSERT INTO Compra (idCliente_fk, idConcesionario_fk, idCoche_fk, monto, fechaHora)
    VALUES(eIdCliente, eIdConcesionario, eIdCoche, eMonto, eFechaHora);
END$$
-- Infiere monto a partir de precio del carro, infiere concesionario a partir del carro
CREATE PROCEDURE AgregarCompraCompleto (IN eFechaHora DATETIME, IN eIdCliente INT, IN eIdCoche INT) BEGIN

    DECLARE vIdConcesionario INT;
    DECLARE vMonto INT;
    -- This takes the idCoche from the eIdCoche input and gives monto
	SELECT precio, idConcesionario_fk into vMonto, vIdConcesionario FROM Coche
    WHERE idCoche = eIdCoche
    LIMIT 1;   
    
    CALL AgregarCompra(eFechaHora, vMonto, eIdCliente, vIdConcesionario, eIdCoche);
END$$
CREATE PROCEDURE AgregarReparacion (IN eFechaHoraInicio DATETIME, 
								 IN eFechaHoraFinal DATETIME,
                                 IN eDescripcion VARCHAR(50),
                                 IN eIdCoche INT) BEGIN
	INSERT INTO Reparacion (fechaHoraInicio, fechaHoraFinal, descripcion, idCoche_fk)
    VALUES(eFechahoraInicio, eFechaHoraFinal, eDescripcion, eIdCoche);
END$$
-- Cambia el estado del carro y además se le ingresa la matrícula
CREATE PROCEDURE AgregarReparacionCompleto (IN eFechaHoraInicio DATETIME, 
								 IN eFechaHoraFinal DATETIME, 
                                 IN eMatricula INT, 
                                 IN eDescripcion VARCHAR(50)) BEGIN
	DECLARE vIdCoche INT;  
    -- Takes matricula too
	SELECT idCoche into vIdCoche FROM Coche
    WHERE matricula = eMatricula
    LIMIT 1;
	-- This takes the idCoche from the eIdCoche input
	UPDATE Coche
    SET estado = "reparacion"
    WHERE idCoche = vIdCoche;
	CALL AgregarReparacion(eFechahoraInicio, eFechaHoraFinal, eDescripcion, vIdCoche);
END$$
-- Infiere monto a partir de precio del carro, infiere concesionario a partir del carro
CREATE PROCEDURE AgregarReparacionXMecanico (IN eIdReparacion INT, IN eIdMecanico INT, IN horas INT) BEGIN
	
    INSERT INTO ReparacionXMecanico (idReparacion_fk, idMecanico_fk, horas)
    VALUES(eIdReparacion, eIdMecanico, horas);
    
END$$
CREATE PROCEDURE AgregarProvincia2 (IN eNombre varchar(50), IN eNombrePais varchar(50)) BEGIN
	DECLARE vIdPais INT;
	SELECT idPais into vIdPais FROM Pais
    WHERE nombre = eNombrePais
    LIMIT 1;
	INSERT INTO Provincia (nombre, idPais_fk)
    VALUES(eNombre, vIdPais);
END$$
CREATE PROCEDURE ObtenerDireccionCompleta(IN eIdUbicacion INT) BEGIN
	SELECT descripcion AS "Descripción", 
		   Direccion.zipCode as "Código Postal", 
           Ciudad.nombre AS "Ciudad",
           Provincia.nombre AS "Provincia",
           Pais.nombre AS "Pais"
    FROM Ubicacion
    INNER JOIN Direccion ON Ubicacion.idDireccion_fk = Direccion.idDireccion
    INNER JOIN Ciudad ON Direccion.idCiudad_fk = Ciudad.idCiudad
    INNER JOIN Provincia ON Ciudad.idProvincia_fk = Provincia.idProvincia
    INNER JOIN Pais ON Provincia. idPais_fk = Pais.idPais
    WHERE Ubicacion.idUbicacion = eIdUbicacion;
END$$  
CREATE PROCEDURE CambiarEstado (IN eIdCoche INT) BEGIN
	-- This takes the idCoche from the eIdCoche input
	UPDATE Coche
    SET estado = (CASE WHEN kilometraje = 0 THEN "nuevo" ELSE "usado" END)
    WHERE idCoche = eIdCoche;
END$$         
CREATE PROCEDURE TerminarReparacion (IN eIdReparacion INT) BEGIN
	-- Saca el id del carro reparado
    DECLARE vIdCoche INT;
	SELECT idCoche_fk into vIdCoche FROM Reparacion
    WHERE idReparacion = eIdReparacion
    LIMIT 1;
    -- Cambia el estado del coche a usado o nuevo de nuevo
	CALL CambiarEstado(vIdCoche);
    
    -- This takes the idReparacion from the eIdReparacion input
	UPDATE Reparacion
    SET fechaHoraFinal = NOW()
    WHERE idReparacion = eIdReparacion;
END$$

CREATE PROCEDURE ObtenerNombreMarca(
	IN eIdMarca INT) BEGIN
	SELECT
		nombre
    FROM Marca as Ma
    WHERE Ma.idMarca = eIdMarca
	LIMIT 1;
END$$

CREATE PROCEDURE ObtenerNombreModelo(
	IN eIdModelo INT) BEGIN
	SELECT
		nombre
    FROM Modelo as Mo
    WHERE Mo.idModelo = eIdModelo
	LIMIT 1;
END$$

CREATE PROCEDURE ObtenerInfoCarro (IN eIdCoche INT) BEGIN
	SELECT 
		C.matricula AS "Matricula",
        Mo.nombre AS "Modelo",
		Ma.nombre AS "Marca",
        C.color AS "Color"
	FROM 
		Coche AS C
	INNER JOIN Marca AS Ma ON Ma.idMarca = C.idMarca_fk
    INNER JOIN Modelo AS Mo ON Mo.idModelo = C.idModelo_fk
    WHERE C.idCoche = eIdCoche
    LIMIT 1;
END$$
CREATE PROCEDURE ObtenerInfoCarroMatricula (IN eMatricula INT) BEGIN
	-- Saca el id del carro reparado
	SELECT 
		C.matricula AS "Matricula",
        Mo.nombre AS "Modelo",
		Ma.nombre AS "Marca",
        C.color AS "Color"
	FROM 
		Coche AS C
	INNER JOIN Marca AS Ma ON Ma.idMarca = C.idMarca_fk
    INNER JOIN Modelo AS Mo ON Mo.idModelo = C.idModelo_fk
    WHERE C.matricula = eMatricula
    LIMIT 1;
END$$
CREATE PROCEDURE ObtenerReparaciones (
	IN eMatricula INT) BEGIN
	SELECT
    R.descripcion,
    R.fechaHoraInicio,
    R.fechaHoraFinal
    FROM Reparacion AS R
    INNER JOIN Coche ON R.idCoche_fk = Coche.idCoche
    WHERE Coche.matricula = eMatricula;
END$$
CREATE PROCEDURE ObtenerReparacionesFecha (
	IN eMatricula INT, IN eFechaInicio DATETIME) BEGIN
	SELECT
    R.descripcion,
    R.fechaHoraInicio,
    R.fechaHoraFinal
    FROM Reparacion AS R
    INNER JOIN Coche ON R.idCoche_fk = Coche.idCoche
    WHERE Coche.matricula = eMatricula && R.fechaHoraInicio > eFechaInicio;
END$$
CREATE PROCEDURE ObtenerReparacionesMecanico(
	IN eIdMecanico INT) BEGIN
	SELECT
    R.descripcion,
    R.fechaHoraInicio,
    R.fechaHoraFinal,
    C.matricula,
    RXM.horas AS "horas"
    FROM Reparacion AS R
    INNER JOIN ReparacionXMecanico AS RXM ON RXM.idReparacion_fk = R.idReparacion
    INNER JOIN Mecanico AS M ON RXM.idMecanico_fk = M.idMecanico
    INNER JOIN Coche AS C ON C.idCoche = R.idCoche_fk
    WHERE eIdMecanico = M.idMecanico;
END$$
CREATE PROCEDURE ObtenerReparacionesMecanicoPorCedula(
	IN eCedMecanico INT) BEGIN
    DECLARE eidMecanico INT;
	SELECT
		M.idMecanico INTO eidMecanico
    FROM Mecanico AS M
    INNER JOIN Persona AS P ON P.idPersona = M.idPersona_fk
    WHERE eCedMecanico = P.cedula;
	
    CALL ObtenerReparacionesMecanico(eidMecanico);
END$$
CREATE PROCEDURE ObtenerCochesPorConcesionario(
	IN eIdConcesionario INT) BEGIN
	SELECT
		*
    FROM Coche AS C
    WHERE C.idConcesionario_fk = eIdConcesionario;
END$$
CREATE PROCEDURE ObtenerCochesPorConcesionarioPorNombre(
	IN eNombreConcesionario VARCHAR(50)) BEGIN
    DECLARE vIdConcesionario INT;
	SELECT
		idConcesionario INTO vIdConcesionario
    FROM Concesionario as C
    WHERE C.nombre = eNombreConcesionario;
    CALL ObtenerCochesPorConcesionario(vIdConcesionario);
END$$

CALL ObtenerInfoCarro(1);$$
CALL ObtenerInfoCarroMatricula(579390);$$
CALL ObtenerReparaciones(579390);$$
CALL ObtenerReparacionesFecha(579390, "2008-1-1");$$
CALL ObtenerReparacionesMecanico(1);$$
CALL ObtenerReparacionesMecanicoPorCedula(159);$$
CALL ObtenerCochesPorConcesionario(1);$$
CALL ObtenerCochesPorConcesionarioPorNombre("Concesionario la UNO");$$