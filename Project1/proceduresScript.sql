use p1;
DROP PROCEDURE IF EXISTS AgregarPais;

DELIMITER $$
CREATE PROCEDURE AgregarPais (IN Nombre varchar(50)) BEGIN
	INSERT INTO Pais (nombre)
    VALUES(Nombre);
END$$



CALL AgregarPais("Costa Rica");

CALL AgregarPais("Nicaragua");

