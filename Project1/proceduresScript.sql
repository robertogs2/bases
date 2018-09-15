use p1;
DROP PROCEDURE IF EXISTS AgregarPais;
DROP PROCEDURE IF EXISTS AgregarProvincia;
DROP PROCEDURE IF EXISTS AgregarCiudad;
DROP PROCEDURE IF EXISTS AgregarDireccion;
DROP PROCEDURE IF EXISTS AgregarUbicacion;
DROP PROCEDURE IF EXISTS AgregarPersona;
DROP PROCEDURE IF EXISTS AgregarCliente;
DROP PROCEDURE IF EXISTS AgregarConcesionario;
DROP PROCEDURE IF EXISTS AgregarCoche;
DROP PROCEDURE IF EXISTS AgregarTaller;
DROP PROCEDURE IF EXISTS AgregarMecanico;
DROP PROCEDURE IF EXISTS AgregarCompra;
DROP PROCEDURE IF EXISTS AgregarReparacion;
DROP PROCEDURE IF EXISTS AgregarProvincia2;
DROP PROCEDURE IF EXISTS ObtenerDireccionCompleta;
DELIMITER $$
CREATE PROCEDURE AgregarPais (IN eNombre varchar(50)) BEGIN
	INSERT INTO Pais (nombre)
    VALUES(eNombre);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarProvincia (IN eNombre varchar(50), IN eIdPais INT) BEGIN
	INSERT INTO Provincia (nombre, idPais_fk)
    VALUES(eNombre, eIdPais);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarCiudad (IN eNombre varchar(50), IN eIdProvincia INT) BEGIN
	INSERT INTO Ciudad (nombre, idProvincia_fk)
    VALUES(eNombre, eIdProvincia);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarDireccion (IN eZipCode INT, IN eIdCiudad INT) BEGIN
	INSERT INTO Direccion (zipCode, idCiudad_fk)
    VALUES(eZipCode, eIdCiudad);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarUbicacion (IN eDescripcion varchar(50), IN eIdDireccion INT) BEGIN
	INSERT INTO Ubicacion (descripcion, idDireccion_fk)
    VALUES(eDescripcion, eIdDireccion);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarPersona (IN eCedula INT, 
								 IN eNombre VARCHAR(40),
								 IN eApellidos VARCHAR(40),
                                 IN eEdad INT,
                                 IN eTelefono INT,
                                 IN eExtension INT,
                                 IN eIdUbicacion INT) BEGIN
	INSERT INTO Persona (cedula, nombre, apellidos, edad, telefono, extension, idUbicacion_fk)
    VALUES(eCedula, eNombre, eApellidos, eEdad, eTelefono, eExtension, eIdUbicacion);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarCliente (IN eIdPersona INT) BEGIN
	INSERT INTO Cliente (idPersona_fk)
    VALUES(eIdPersona);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarConcesionario (IN eNombre VARCHAR(50), IN eIdUbicacion INT) BEGIN
	INSERT INTO Concesionario (nombre, idUbicacion_fk)
    VALUES(eNombre, eIdUbicacion);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarCoche (IN eMatricula INT, 
								 IN eModelo VARCHAR(20),
								 IN eMarca VARCHAR(20),
                                 IN eColor VARCHAR(30),
                                 IN eEstado VARCHAR(20),
                                 IN eKilometraje INT,
                                 IN eIdConcesionario INT) BEGIN
	INSERT INTO Coche (matricula, modelo, marca, color, estado, kilometraje, idConcesionario_fk)
    VALUES(eMatricula, eModelo, eMarca, eColor, eEstado, eKilometraje, eIdConcesionario);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarTaller (IN eNombre VARCHAR(50), IN eIdUbicacion INT, IN eIdConcesionario INT) BEGIN
	INSERT INTO Taller (nombre, idUbicacion_fk, idConcesionario_fk)
    VALUES(eNombre, eIdUbicacion, eIdConcesionario);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarMecanico (IN eFechaContratacion DATE, 
								 IN eSalario INT,
								 IN eMarca VARCHAR(20),
                                 IN eIdPersona INT,
                                 IN eIdConcesionario INT,
                                 IN eIdTaller INT) BEGIN
	INSERT INTO Mecanico (fechaContratacion, salario, idPersona_fk, idConcesionario_fk, idTaller_fk)
    VALUES(eSalario, eMarca, eIdPersona, eIdConcesionario, eIdTaller);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarCompra (IN eFechaHora DATETIME, IN eMonto INT, IN eIdCliente INT, IN eIdConcesionario INT) BEGIN
	INSERT INTO Compra (idCliente_fk, idConcesionario_fk, monto, fechaHora)
    VALUES(eIdConcesionario, eIdCliente, eMonto, eFechaHora);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarReparacion (IN eFechaHoraInicio DATETIME, 
								 IN eFechaHoraFinal DATETIME,
								 IN eIdMecanico INT,
                                 IN eIdCoche INT) BEGIN
	INSERT INTO Reparacion (fechaHoraInicio, fechaHoraFinal, idMecanico_fk, idCoche_fk)
    VALUES(eFechahoraInicial, eFechaHoraFinal, eIdMecanico, eIdCoche);
END$$

DELIMITER $$
CREATE PROCEDURE AgregarProvincia2 (IN eNombre varchar(50), IN eNombrePais varchar(50)) BEGIN
	DECLARE vIdPais INT;
	SELECT idPais into vIdPais FROM Pais
    WHERE nombre = eNombrePais
    LIMIT 1;
	INSERT INTO Provincia (nombre, idPais_fk)
    VALUES(eNombre, vIdPais);
END$$

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
     
