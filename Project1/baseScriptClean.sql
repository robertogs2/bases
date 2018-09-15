-- Starts Database

DROP DATABASE IF EXISTS p1;
CREATE DATABASE IF NOT EXISTS p1;
USE p1;

-- -----------------------------------------------------
-- Table Pais
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pais (
  idPais INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (idPais))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Provincia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Provincia (
  idProvincia INT NOT NULL,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  idPais INT NULL,
  PRIMARY KEY (idProvincia),
  FOREIGN KEY (idPais) REFERENCES Pais(idPais))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Ciudad
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Ciudad (
  idCiudad INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  idProvincia INT NULL,
  PRIMARY KEY (idCiudad),
  FOREIGN KEY(idProvincia) REFERENCES Provincia(idProvincia))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Direccion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Direccion (
  idDireccion INT NOT NULL,
  zipCode INT NOT NULL,
  idCiudad INT NULL,
  PRIMARY KEY (idDireccion),
  FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Ubicacion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Ubicacion (
  idUbicacion INT NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  idDireccion INT NULL,
  PRIMARY KEY (idUbicacion),
  FOREIGN KEY (idDireccion) REFERENCES Direccion(idDireccion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Persona
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Persona (
  idPersona INT NOT NULL,
  cedula INT NOT NULL,
  nombre VARCHAR(40) NULL,
  apellidos VARCHAR(40) NULL,
  telefono INT NULL,
  extension INT NULL,
  idUbicacion INT NULL,
  PRIMARY KEY (idPersona),
  FOREIGN KEY (idUbicacion) REFERENCES Ubicacion(idUbicacion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL,
  idPersona INT NOT NULL,
  PRIMARY KEY (idCliente),
  FOREIGN KEY (idPersona) REFERENCES Persona(idPersona))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Concesionario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Concesionario (
  idConcesionario INT NOT NULL,
  nombre VARCHAR(50) NULL,
  idUbicacion INT NULL,
  idTaller INT NULL,
  PRIMARY KEY (idConcesionario))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Coche
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Coche (
  idCoche INT NOT NULL AUTO_INCREMENT,
  matricula VARCHAR(6) NULL,
  modelo VARCHAR(20) NULL,
  marca VARCHAR(20) NULL,
  color VARCHAR(30) NULL,
  estado VARCHAR(30) NULL,
  kilometraje INT NULL,
  idConcesionario INT NULL,
  PRIMARY KEY (idCoche),
  FOREIGN KEY (idConcesionario) REFERENCES Concesionario(idConcesionario))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Taller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Taller (
  idTaller INT NOT NULL,
  nombre VARCHAR(45) NULL,
  idUbicacion INT NULL,
  PRIMARY KEY (idTaller),
  FOREIGN KEY (idUbicacion) REFERENCES Ubicacion(idUbicacion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Mecanico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Mecanico (
  idMecanico INT NOT NULL,
  idPersona INT NOT NULL,
  idConcesionario INT NULL,
  idTaller INT NULL,
  fechaContratacion DATE NULL,
  salario INT NULL,
  PRIMARY KEY (idMecanico),
  FOREIGN KEY (idPersona) REFERENCES Persona(idPersona),
  FOREIGN KEY (idConcesionario) REFERENCES Concesionario(idConcesionario),
  FOREIGN KEY (idTaller) REFERENCES Taller(idTaller))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Compra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Compra (
  idCompra INT NOT NULL,
  idCliente INT NULL,
  idConcesionario INT NULL,
  monto INT NULL,
  fechaHora DATETIME NULL,
  PRIMARY KEY (idCompra),
  FOREIGN KEY (idConcesionario) REFERENCES Concesionario(idConcesionario),
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Reparacion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Reparacion (
  idReparacion INT NOT NULL,
  idMecanico INT NULL,
  idCoche INT NULL,
  fechaHoraInicio DATETIME NULL,
  fechaHoraFinal DATETIME NULL,
  PRIMARY KEY (idReparacion),
  FOREIGN KEY (idMecanico) REFERENCES Mecanico(idMecanico),
  FOREIGN KEY (idCoche) REFERENCES Coche(idCoche))
ENGINE = InnoDB;





