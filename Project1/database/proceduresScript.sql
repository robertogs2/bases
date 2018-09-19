use p1;
DELIMITER $$
DROP PROCEDURE IF EXISTS AgregarPais;

CREATE PROCEDURE AgregarPais (IN eNombre varchar(50)) BEGIN
	INSERT INTO Pais (nombre)
    VALUES(eNombre);
END$$

DROP PROCEDURE IF EXISTS AgregarProvincia;

CREATE PROCEDURE AgregarProvincia (IN eNombre varchar(50), IN eIdPais INT) BEGIN
	INSERT INTO Provincia (nombre, idPais_fk)
    VALUES(eNombre, eIdPais);
END$$

DROP PROCEDURE IF EXISTS AgregarCiudad;
DELIMITER $$
CREATE PROCEDURE AgregarCiudad (IN eNombre varchar(50), IN eIdProvincia INT) BEGIN
	INSERT INTO Ciudad (nombre, idProvincia_fk)
    VALUES(eNombre, eIdProvincia);
END$$

DROP PROCEDURE IF EXISTS AgregarDireccion;
DELIMITER $$
CREATE PROCEDURE AgregarDireccion (IN eZipCode INT, IN eIdCiudad INT) BEGIN
	INSERT INTO Direccion (zipCode, idCiudad_fk)
    VALUES(eZipCode, eIdCiudad);
END$$

DROP PROCEDURE IF EXISTS AgregarUbicacion;
DELIMITER $$
CREATE PROCEDURE AgregarUbicacion (IN eDescripcion varchar(100), IN eIdDireccion INT) BEGIN
	INSERT INTO Ubicacion (descripcion, idDireccion_fk)
    VALUES(eDescripcion, eIdDireccion);
END$$

DROP PROCEDURE IF EXISTS AgregarPersona;
DELIMITER $$
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

DROP PROCEDURE IF EXISTS AgregarCliente;
DELIMITER $$
CREATE PROCEDURE AgregarCliente (IN eIdPersona INT) BEGIN
	INSERT INTO Cliente (idPersona_fk)
    VALUES(eIdPersona);
END$$

DROP PROCEDURE IF EXISTS AgregarClientePorCedula;
DELIMITER $$
CREATE PROCEDURE AgregarClientePorCedula(IN eCedula INT) BEGIN
    DECLARE vIdPersona INT;
	
    -- This takes the idPersona from the eCedula input
	SELECT idPersona into vIdPersona FROM Persona
    WHERE cedula = eCedula
    LIMIT 1;
    
    CALL AgregarCliente(vIdPersona);
    
END$$

DROP PROCEDURE IF EXISTS AgregarConcesionario;
DELIMITER $$
CREATE PROCEDURE AgregarConcesionario (IN eNombre VARCHAR(50), IN eIdUbicacion INT) BEGIN
	INSERT INTO Concesionario (nombre, idUbicacion_fk)
    VALUES(eNombre, eIdUbicacion);
END$$

DROP PROCEDURE IF EXISTS AgregarMarca;
DELIMITER $$
CREATE PROCEDURE AgregarMarca(IN eNombre VARCHAR(50)) BEGIN
	INSERT INTO Marca(nombre)
    VALUES(eNombre);
END$$

DROP PROCEDURE IF EXISTS AgregarModelo;
DELIMITER $$
CREATE PROCEDURE AgregarModelo(IN eNombre VARCHAR(50), IN eIdMarca INT) BEGIN
	INSERT INTO Modelo(nombre, idMarca_fk)
    VALUES(eNombre, eIdMarca);
END$$

DROP PROCEDURE IF EXISTS AgregarCoche;
DELIMITER $$
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

DROP PROCEDURE IF EXISTS AgregarTaller;
DELIMITER $$
CREATE PROCEDURE AgregarTaller (IN eNombre VARCHAR(50), IN eIdUbicacion INT, IN eIdConcesionario INT) BEGIN
	INSERT INTO Taller (nombre, idUbicacion_fk, idConcesionario_fk)
    VALUES(eNombre, eIdUbicacion, eIdConcesionario);
END$$

DROP PROCEDURE IF EXISTS AgregarMecanico;
DELIMITER $$
CREATE PROCEDURE AgregarMecanico (IN eFechaContratacion DATE, 
								 IN eSalario INT,
                                 IN eIdPersona INT,
                                 IN eIdConcesionario INT,
                                 IN eIdTaller INT) BEGIN
	INSERT INTO Mecanico (fechaContratacion, salario, idPersona_fk, idConcesionario_fk, idTaller_fk)
    VALUES(eFechaContratacion, eSalario, eIdPersona, eIdConcesionario, eIdTaller);
END$$

DROP PROCEDURE IF EXISTS AgregarMecanicoCompleto;
DELIMITER $$
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

DROP PROCEDURE IF EXISTS AgregarCompra;
DELIMITER $$
CREATE PROCEDURE AgregarCompra (IN eFechaHora DATETIME, IN eMonto INT, IN eIdCliente INT, IN eIdConcesionario INT, IN eIdCoche INT) BEGIN
	INSERT INTO Compra (idCliente_fk, idConcesionario_fk, idCoche_fk, monto, fechaHora)
    VALUES(eIdCliente, eIdConcesionario, eIdCoche, eMonto, eFechaHora);
END$$

DROP PROCEDURE IF EXISTS AgregarCompraCompleto;
-- Infiere monto a partir de precio del carro, infiere concesionario a partir del carro
DELIMITER $$
CREATE PROCEDURE AgregarCompraCompleto (IN eFechaHora DATETIME, IN eIdCliente INT, IN eIdCoche INT) BEGIN

    DECLARE vIdConcesionario INT;
    DECLARE vMonto INT;
    -- This takes the idCoche from the eIdCoche input and gives monto
	SELECT precio, idConcesionario_fk into vMonto, vIdConcesionario FROM Coche
    WHERE idCoche = eIdCoche
    LIMIT 1;   
    
    CALL AgregarCompra(eFechaHora, vMonto, eIdCliente, vIdConcesionario, eIdCoche);
END$$

DROP PROCEDURE IF EXISTS AgregarReparacion;
DELIMITER $$
CREATE PROCEDURE AgregarReparacion (IN eFechaHoraInicio DATETIME, 
								 IN eFechaHoraFinal DATETIME,
                                 IN eDescripcion VARCHAR(50),
                                 IN eIdCoche INT) BEGIN
	INSERT INTO Reparacion (fechaHoraInicio, fechaHoraFinal, descripcion, idCoche_fk)
    VALUES(eFechahoraInicio, eFechaHoraFinal, eDescripcion, eIdCoche);
END$$

-- Cambia el estado del carro y además se le ingresa la matrícula
DROP PROCEDURE IF EXISTS AgregarReparacionCompleto;
DELIMITER $$
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
DROP PROCEDURE IF EXISTS AgregarReparacionXMecanico;
DELIMITER $$
CREATE PROCEDURE AgregarReparacionXMecanico (IN eIdReparacion INT, IN eIdMecanico INT, IN horas INT) BEGIN
	
    INSERT INTO ReparacionXMecanico (idReparacion_fk, idMecanico_fk, horas)
    VALUES(eIdReparacion, eIdMecanico, horas);
    
END$$

DROP PROCEDURE IF EXISTS AgregarProvincia2;
DELIMITER $$
CREATE PROCEDURE AgregarProvincia2 (IN eNombre varchar(50), IN eNombrePais varchar(50)) BEGIN
	DECLARE vIdPais INT;
	SELECT idPais into vIdPais FROM Pais
    WHERE nombre = eNombrePais
    LIMIT 1;
	INSERT INTO Provincia (nombre, idPais_fk)
    VALUES(eNombre, vIdPais);
END$$

DROP PROCEDURE IF EXISTS ObtenerDireccionCompleta;
DELIMITER $$
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

DROP PROCEDURE IF EXISTS CambiarEstado;           
DELIMITER $$
CREATE PROCEDURE CambiarEstado (IN eIdCoche INT) BEGIN
	-- This takes the idCoche from the eIdCoche input
	UPDATE Coche
    SET estado = (CASE WHEN kilometraje = 0 THEN "nuevo" ELSE "usado" END)
    WHERE idCoche = eIdCoche;
END$$           

DROP PROCEDURE IF EXISTS TerminarArreglo;
DELIMITER $$
CREATE PROCEDURE TerminarArreglo (IN eIdArreglo INT) BEGIN
	-- Saca el id del carro reparado
    DECLARE vIdCoche INT;
	SELECT idCoche_fk into vIdCoche FROM Arreglo
    WHERE idArreglo = eIdArreglo
    LIMIT 1;
    -- Cambia el estado del coche a usado o nuevo de nuevo
	CALL CambiarEstado(vIdCoche);
    
    -- This takes the idArreglo from the eIdArreglo input
	UPDATE Arreglo
    SET progreso = 100
    WHERE idArreglo = eIdArreglo;
    
END$$

DROP PROCEDURE IF EXISTS ObtenerInfoCarro;
DELIMITER $$
CREATE PROCEDURE ObtenerInfoCarro (
	IN eIdCoche INT) 
    BEGIN
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
    WHERE C.idCoche = eIdCoche
    LIMIT 1;
END$$
 
 DROP PROCEDURE IF EXISTS ObtenerReparaciones;
 DELIMITER $$
CREATE PROCEDURE ObtenerReparaciones (
	IN eMatricula INT) 
    BEGIN
	SELECT
    R.descripcion,
    R.fechaHoraInicio,
    R.fechaHoraFinal
    FROM Reparacion AS R
    INNER JOIN Coche ON R.idCoche_fk = Coche.idCoche
    WHERE Coche.matricula = eMatricula;
END$$
 
 DROP PROCEDURE IF EXISTS ObtenerReparacionesFecha;
  DELIMITER $$
CREATE PROCEDURE ObtenerReparacionesFecha (
	IN eMatricula INT, IN eFechaInicio DATETIME) 
    BEGIN
	SELECT
    R.descripcion,
    R.fechaHoraInicio,
    R.fechaHoraFinal
    FROM Reparacion AS R
    INNER JOIN Coche ON R.idCoche_fk = Coche.idCoche
    WHERE Coche.matricula = eMatricula && R.fechaHoraInicio > eFechaInicio;
END$$

DROP PROCEDURE IF EXISTS ObtenerReparacionesMecanico;
  DELIMITER $$
CREATE PROCEDURE ObtenerReparacionesMecanico(
	IN eIdMecanico INT) 
    BEGIN
	SELECT
    R.descripcion,
    R.fechaHoraInicio,
    R.fechaHoraFinal,
    C.matricula,
    RXM.horas AS "HorasLaboradas"
    FROM Reparacion AS R
    INNER JOIN ReparacionXMecanico AS RXM ON RXM.idReparacion_fk = R.idReparacion
    INNER JOIN Mecanico AS M ON RXM.idMecanico_fk = M.idMecanico
    INNER JOIN Coche AS C ON C.idCoche = R.idCoche_fk
    WHERE eIdMecanico = M.idMecanico;
END$$

DROP PROCEDURE IF EXISTS ObtenerReparacionesMecanicoPorCedula;
  DELIMITER $$
CREATE PROCEDURE ObtenerReparacionesMecanicoPorCedula(
	IN eCedMecanico INT) 
    BEGIN
    DECLARE eidMecanico INT;
	SELECT
		M.idMecanico INTO eidMecanico
    FROM Mecanico AS M
    INNER JOIN Persona AS P ON P.idPersona = M.idPersona_fk
    WHERE eCedMecanico = P.cedula;
	
    CALL ObtenerReparacionesMecanico(eidMecanico);
END$$

  DELIMITER $$
CREATE PROCEDURE ObtenerCochesPorConcesionario(
	IN eIdConcesionario INT) 
    BEGIN
	SELECT
		*
    FROM Coche AS C
    WHERE C.idConcesionario_fk = eIdConcesionario;
END$$

  DELIMITER $$
CREATE PROCEDURE ObtenerCochesPorConcesionarioPorNombre(
	IN eNombreConcesionario VARCHAR(50)) 
    BEGIN
    DECLARE eIdConcesionario INT;
	SELECT
		idConcesionario INTO eIdConcesionario
    FROM Concesionario as C
    WHERE C.nombre = eNombreConcesionario;
    
    CALL ObtenerCochesPorConcesionario(eIdConcesionario);
END$$
 
CALL ObtenerInfoCarro(1);
CALL ObtenerReparaciones(579390);
CALL ObtenerReparacionesFecha(579390, "2008-1-1");
  
CALL ObtenerReparacionesMecanico(1);
CALL ObtenerReparacionesMecanicoPorCedula(159);

CALL ObtenerCochesPorConcesionarioPorNombre("Concesionario la UNO");

SELECT * EXCEPT C.idCoche
FROM Coche AS C;