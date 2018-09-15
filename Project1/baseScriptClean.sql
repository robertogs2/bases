-- Starts Database

DROP DATABASE IF EXISTS p1;
CREATE DATABASE IF NOT EXISTS p1;
USE p1;

-- -----------------------------------------------------
-- Table Pais
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pais (
  idPais INT AUTO_INCREMENT NOT NULL UNIQUE,  
  PRIMARY KEY (idPais))
ENGINE = InnoDB;

ALTER TABLE Pais
ADD nombre VARCHAR(50) NOT NULL UNIQUE;

CREATE INDEX indexPaisNombre ON Pais(nombre);
-- -----------------------------------------------------
-- Table Provincia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Provincia (
  idProvincia INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  idPais_fk INT NOT NULL,
  PRIMARY KEY (idProvincia),
  FOREIGN KEY (idPais_fk) REFERENCES Pais(idPais))
ENGINE = InnoDB;

CREATE INDEX indexProvinciaNombre ON Provincia(nombre);
-- -----------------------------------------------------
-- Table Ciudad
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Ciudad (
  idCiudad INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  idProvincia_fk INT NOT NULL,
  PRIMARY KEY (idCiudad),
  FOREIGN KEY(idProvincia_fk) REFERENCES Provincia(idProvincia))
ENGINE = InnoDB;

CREATE INDEX indexCiudadNombre ON Ciudad(nombre);
-- -----------------------------------------------------
-- Table Direccion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Direccion (
  idDireccion INT AUTO_INCREMENT NOT NULL UNIQUE,
  zipCode INT NOT NULL,
  idCiudad_fk INT NOT NULL,
  PRIMARY KEY (idDireccion),
  FOREIGN KEY (idCiudad_fk) REFERENCES Ciudad(idCiudad))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Ubicacion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Ubicacion (
  idUbicacion INT AUTO_INCREMENT NOT NULL UNIQUE,
  descripcion VARCHAR(50) NOT NULL,
  idDireccion_fk INT NOT NULL,
  PRIMARY KEY (idUbicacion),
  FOREIGN KEY (idDireccion_fk) REFERENCES Direccion(idDireccion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Persona
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Persona (
  idPersona INT AUTO_INCREMENT NOT NULL UNIQUE,
  cedula INT NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  apellidos VARCHAR(40) NOT NULL,
  telefono INT NOT NULL,
  extension INT NOT NULL,
  idUbicacion_fk INT NOT NULL,
  PRIMARY KEY (idPersona),
  FOREIGN KEY (idUbicacion_fk) REFERENCES Ubicacion(idUbicacion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT AUTO_INCREMENT NOT NULL UNIQUE,
  idPersona_fk INT NOT NULL,
  PRIMARY KEY (idCliente),
  FOREIGN KEY (idPersona_fk) REFERENCES Persona(idPersona))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Concesionario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Concesionario (
  idConcesionario INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  idUbicacion_fk INT NOT NULL,
  PRIMARY KEY (idConcesionario))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Coche
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Coche (
  idCoche INT AUTO_INCREMENT NOT NULL UNIQUE,
  matricula VARCHAR(6) NOT NULL,
  modelo VARCHAR(20) NOT NULL,
  marca VARCHAR(20) NOT NULL,
  color VARCHAR(30) NOT NULL,
  estado VARCHAR(30) NOT NULL,
  kilometraje INT NULL,
  idConcesionario_fk INT NOT NULL,
  PRIMARY KEY (idCoche),
  FOREIGN KEY (idConcesionario_fk) REFERENCES Concesionario(idConcesionario))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Taller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Taller (
  idTaller INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(45) NOT NULL,
  idUbicacion_fk INT NOT NULL,
  PRIMARY KEY (idTaller),
  FOREIGN KEY (idUbicacion_fk) REFERENCES Ubicacion(idUbicacion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Mecanico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Mecanico (
  idMecanico INT AUTO_INCREMENT NOT NULL UNIQUE,
  idPersona_fk INT NOT NULL,
  idConcesionario_fk INT NOT NULL,
  idTaller_fk INT NOT NULL,
  fechaContratacion DATE NOT NULL,
  salario INT NOT NULL,
  PRIMARY KEY (idMecanico),
  FOREIGN KEY (idPersona_fk) REFERENCES Persona(idPersona),
  FOREIGN KEY (idConcesionario_fk) REFERENCES Concesionario(idConcesionario),
  FOREIGN KEY (idTaller_fk) REFERENCES Taller(idTaller))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Compra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Compra (
  idCompra INT AUTO_INCREMENT NOT NULL UNIQUE,
  idCliente_fk INT NOT NULL,
  idConcesionario_fk INT NOT NULL,
  monto INT NOT NULL,
  fechaHora DATETIME NOT NULL,
  PRIMARY KEY (idCompra),
  FOREIGN KEY (idConcesionario_fk) REFERENCES Concesionario(idConcesionario),
  FOREIGN KEY (idCliente_fk) REFERENCES Cliente(idCliente))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Reparacion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Reparacion (
  idReparacion INT AUTO_INCREMENT NOT NULL UNIQUE,
  idMecanico_fk INT NOT NULL,
  idCoche_fk INT NOT NULL,
  fechaHoraInicio DATETIME NOT NULL,
  fechaHoraFinal DATETIME NOT NULL,
  PRIMARY KEY (idReparacion),
  FOREIGN KEY (idMecanico_fk) REFERENCES Mecanico(idMecanico),
  FOREIGN KEY (idCoche_fk) REFERENCES Coche(idCoche))
ENGINE = InnoDB;





