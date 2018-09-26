-- Starts Database

DROP DATABASE IF EXISTS p1;
CREATE DATABASE IF NOT EXISTS p1;
USE p1;

-- -----------------------------------------------------
-- Table Pais
-- -----------------------------------------------------
DROP TABLE IF EXISTS Pais;
CREATE TABLE Pais (
  idPais INT AUTO_INCREMENT NOT NULL UNIQUE,  
  PRIMARY KEY (idPais))
ENGINE = InnoDB;

ALTER TABLE Pais
ADD nombre VARCHAR(50) NOT NULL UNIQUE;

-- -----------------------------------------------------
-- Table Provincia
-- -----------------------------------------------------
DROP TABLE IF EXISTS Provincia;
CREATE TABLE Provincia (
  idProvincia INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  idPais_fk INT NOT NULL,
  PRIMARY KEY (idProvincia),
  FOREIGN KEY (idPais_fk) REFERENCES Pais(idPais))
ENGINE = InnoDB;

CREATE INDEX indexProvincia ON Provincia(idPais_fk);
-- -----------------------------------------------------
-- Table Ciudad
-- -----------------------------------------------------
DROP TABLE IF EXISTS Ciudad;
CREATE TABLE Ciudad (
  idCiudad INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  idProvincia_fk INT NOT NULL,
  PRIMARY KEY (idCiudad),
  FOREIGN KEY(idProvincia_fk) REFERENCES Provincia(idProvincia))
ENGINE = InnoDB;

CREATE INDEX indexCiudad ON Ciudad(idProvincia_fk);
-- -----------------------------------------------------
-- Table Direccion
-- -----------------------------------------------------
DROP TABLE IF EXISTS Direccion;
CREATE TABLE Direccion (
  idDireccion INT AUTO_INCREMENT NOT NULL UNIQUE,
  zipCode INT NOT NULL DEFAULT 0,
  idCiudad_fk INT NOT NULL,
  PRIMARY KEY (idDireccion),
  FOREIGN KEY (idCiudad_fk) REFERENCES Ciudad(idCiudad))
ENGINE = InnoDB;

CREATE INDEX indexDireccion ON Direccion(idCiudad_fk);
-- -----------------------------------------------------
-- Table Ubicacion
-- -----------------------------------------------------
DROP TABLE IF EXISTS Ubicacion;
CREATE TABLE Ubicacion (
  idUbicacion INT AUTO_INCREMENT NOT NULL UNIQUE,
  descripcion VARCHAR(100) NOT NULL,
  idDireccion_fk INT NOT NULL,
  PRIMARY KEY (idUbicacion),
  FOREIGN KEY (idDireccion_fk) REFERENCES Direccion(idDireccion))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Persona
-- -----------------------------------------------------
DROP TABLE IF EXISTS Persona;
CREATE TABLE Persona (
  idPersona INT AUTO_INCREMENT NOT NULL UNIQUE,
  cedula INT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  apellidos VARCHAR(50) NOT NULL,
  edad INT NOT NULL, CHECK (edad>=18),
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
  idConcesionario INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  idUbicacion_fk INT NOT NULL,
  PRIMARY KEY (idConcesionario))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Taller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Taller (
  idTaller INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  idUbicacion_fk INT NOT NULL,
  idConcesionario_fk INT NOT NULL,
  PRIMARY KEY (idTaller),
  FOREIGN KEY (idUbicacion_fk) REFERENCES Ubicacion(idUbicacion),
  FOREIGN KEY (idConcesionario_fk) REFERENCES Concesionario(idConcesionario))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Marca
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Marca (
  idMarca INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (idMarca))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Modelo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Modelo (
  idModelo INT AUTO_INCREMENT NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  idMarca_fk INT NOT NULL,
  PRIMARY KEY (idModelo),
  FOREIGN KEY (idMarca_fk) REFERENCES Marca(idMarca))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Coche
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Coche (
  idCoche INT AUTO_INCREMENT NOT NULL UNIQUE,
  matricula VARCHAR(6) NOT NULL UNIQUE,
  idModelo_fk INT NOT NULL,
  idMarca_fk INT NOT NULL,
  color VARCHAR(30) NOT NULL,
  estado VARCHAR(30) NOT NULL,
  kilometraje INT NOT NULL DEFAULT 0,
  precio INT NOT NULL DEFAULT 10000,
  idConcesionario_fk INT NOT NULL,
  idCliente_fk INT NULL,
  PRIMARY KEY (idCoche),
  FOREIGN KEY (idConcesionario_fk) REFERENCES Concesionario(idConcesionario),
  FOREIGN KEY (idCliente_fk) REFERENCES Cliente(idCliente),
  FOREIGN KEY (idMarca_fk) REFERENCES Marca(idMarca),
  FOREIGN KEY (idModelo_fk) REFERENCES Modelo(idModelo))
ENGINE = InnoDB;

-- ------------------------------------------------------
-- Table CocheXFoto
-- ------------------------------------------------------

CREATE TABLE IF NOT EXISTS CocheXFoto(
		idCoche_fk INT NOT NULL, 
		url TEXT,
        FOREIGN KEY (idCOche_fk) REFERENCES Coche(idCoche)
)
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
  idCoche_fk INT NOT NULL,
  monto INT NOT NULL,
  fechaHora DATETIME NOT NULL,
  PRIMARY KEY (idCompra),
  FOREIGN KEY (idConcesionario_fk) REFERENCES Concesionario(idConcesionario),
  FOREIGN KEY (idCoche_fk) REFERENCES Coche(idCoche),
  FOREIGN KEY (idCliente_fk) REFERENCES Cliente(idCliente))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Reparacion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Reparacion (
  idReparacion INT AUTO_INCREMENT NOT NULL UNIQUE,
  fechaHoraInicio DATE NOT NULL,
  fechaHoraFinal DATE NULL,
  descripcion VARCHAR(50),
  idCoche_fk INT NOT NULL,
  PRIMARY KEY (idReparacion),
  FOREIGN KEY (idCoche_fk) REFERENCES Coche(idCoche))
ENGINE = InnoDB;

CREATE INDEX indexReparacion ON Reparacion(idCoche_fk);

-- -----------------------------------------------------
-- Table ReparacionXMecanico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ReparacionXMecanico (
  idReparacion_fk INT,
  idMecanico_fk INT,
  horas INT,
  FOREIGN KEY (idReparacion_fk) REFERENCES Reparacion(idReparacion),
  FOREIGN KEY (idMecanico_fk) REFERENCES Mecanico(idMecanico))
ENGINE = InnoDB;


