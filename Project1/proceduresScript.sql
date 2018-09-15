use p1;
DROP PROCEDURE IF EXISTS AgregarPais;
DROP PROCEDURE IF EXISTS AgregarProvincia;
DROP PROCEDURE IF EXISTS AgregarProvincia2;

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
CREATE PROCEDURE AgregarProvincia2 (IN eNombre varchar(50), IN eNombrePais varchar(50)) BEGIN
	DECLARE vIdPais INT;
    
	SELECT idPais into vIdPais FROM Pais
    WHERE nombre = eNombrePais
    LIMIT 1;
    
	INSERT INTO Provincia (nombre, idPais_fk)
    VALUES(eNombre, vIdPais);
    
END$$

CALL AgregarPais("Costa Rica");
CALL AgregarPais("Nicaragua");
CALL AgregarProvincia("Cartago", 1);
CALL AgregarProvincia2("Alajuela", "Costa Rica");
CALL AgregarProvincia2("Managua", "Nicaragua");