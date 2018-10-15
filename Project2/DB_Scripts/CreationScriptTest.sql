USE master;
GO
DROP DATABASE BASESTEC;
CREATE DATABASE BASESTEC;
USE BASESTEC;
GO

IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL DROP TABLE dbo."Location"; -- Drop Location table in case it already exists
IF OBJECT_ID('dbo.City', 'U') IS NOT NULL DROP TABLE dbo.City; -- Drop City table in case it already exists
IF OBJECT_ID('dbo.State', 'U') IS NOT NULL DROP TABLE dbo."State"; -- Drop State table in case it already exists
IF OBJECT_ID('dbo.Country', 'U') IS NOT NULL DROP TABLE dbo.Country; -- Drop Country table in case it already exists
IF OBJECT_ID('dbo.Community', 'U') IS NOT NULL DROP TABLE dbo.Community; -- Drop Community table in case it already exists
IF OBJECT_ID('dbo.Park', 'U') IS NOT NULL DROP TABLE dbo.Park; -- Drop Park table in case it already exists
IF OBJECT_ID('dbo.CommunityXPark', 'U') IS NOT NULL DROP TABLE dbo.CommunityXPark; -- Drop CommunityXPark table in case it already exists
IF OBJECT_ID('dbo.Area', 'U') IS NOT NULL DROP TABLE dbo.Area; -- Drop Area table in case it already exists
IF OBJECT_ID('dbo.Species', 'U') IS NOT NULL DROP TABLE dbo.Species; -- Drop Species table in case it already exists
IF OBJECT_ID('dbo.AreaXSpecies', 'U') IS NOT NULL DROP TABLE dbo.AreaXSpecies; -- Drop AreaXSpecies table in case it already exists
IF OBJECT_ID('dbo.Person', 'U') IS NOT NULL DROP TABLE dbo.Person; -- Drop Person table in case it already exists
IF OBJECT_ID('dbo.Vehicle', 'U') IS NOT NULL DROP TABLE dbo.Vehicle; -- Drop Vehicle table in case it already exists
IF OBJECT_ID('dbo.SecurityGuard', 'U') IS NOT NULL DROP TABLE dbo.SecurityGuard; -- Drop SecurityGuard table in case it already exists
IF OBJECT_ID('dbo.Researcher', 'U') IS NOT NULL DROP TABLE dbo.Researcher; -- Drop Researcher table in case it already exists
IF OBJECT_ID('dbo.ResearchProject', 'U') IS NOT NULL DROP TABLE dbo.ResearchProject; -- Drop ResearchProject table in case it already exists
IF OBJECT_ID('dbo.ResearchProjectXResearcher', 'U') IS NOT NULL DROP TABLE dbo.ResearchProjectXResearcher; -- Drop ResearchProjectXResearcher table in case it already exists
IF OBJECT_ID('dbo.Conservationist', 'U') IS NOT NULL DROP TABLE dbo.Conservationist; -- Drop Conservationist table in case it already exists
IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL DROP TABLE dbo.Employee; -- Drop Employee table in case it already exists
IF OBJECT_ID('dbo.Reseptionist', 'U') IS NOT NULL DROP TABLE dbo.Reseptionist; -- Drop Reseptionist table in case it already exists
IF OBJECT_ID('dbo.Acommodation', 'U') IS NOT NULL DROP TABLE dbo.Acommodation; -- Drop Acommodation table in case it already exists
IF OBJECT_ID('dbo.Visitor', 'U') IS NOT NULL DROP TABLE dbo.Visitor; -- Drop Visitor table in case it already exists
IF OBJECT_ID('dbo.Excursion', 'U') IS NOT NULL DROP TABLE dbo.Excursion; -- Drop Excursion table in case it already exists
IF OBJECT_ID('dbo.AcommodationXExcursion', 'U') IS NOT NULL DROP TABLE dbo.AcommodationXExcursion; -- Drop AcommodationXExcursion table in case it already exists

-- Country table creation.
CREATE TABLE Country(
	idCountry INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL
);

-- State table creation.
CREATE TABLE "State"( -- Double quotes because state is a key word
	idState INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	fk_idCountry INT FOREIGN KEY REFERENCES Country(idCountry) NOT NULL
);

-- State table creation.
CREATE TABLE City(
	idCity INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	fk_idState INT FOREIGN KEY REFERENCES "State"(idState) NOT NULL-- Double quotes because state is a key word
);

-- Location table creation.
CREATE TABLE "Location"(-- Double quotes because location is a key word
	idLocation INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idCity INT FOREIGN KEY REFERENCES City(idCity) NOT NULL,
	"Description" VARCHAR(50) NULL -- Null as default value, and double quotation as description is a keyword
);

-- Community table creation.
CREATE TABLE Community(
	idCommunity INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	fk_idLocation INT FOREIGN KEY REFERENCES "Location"(idLocation) NOT NULL,
	NumberOfParks INT NULL,	-- Null as default value, this data is included for high performance query
	TotalProtectedArea FLOAT NULL	-- Null as default value, this data is include for high performance query
);

-- Natural park table creation.
CREATE TABLE Park(
	idPark INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	foundationDate DATETIME	NOT NULL
);

-- CommunityXPark table creation.
CREATE TABLE CommunityXPark(
	fk_idCommunity INT FOREIGN KEY REFERENCES Community(idCommunity) NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL
);

-- Area table creation.
CREATE TABLE Area(
	idArea INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	Size INT	NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark)
);

-- Species table creation.
CREATE TABLE Species(
	idSpecies INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(1,1) for autoincrement of primary key
	SicientificName VARCHAR(15) NOT NULL, -- Double quotes because name is a key word
	NonScientificName VARCHAR(15)	NOT NULL,
	"Type" VARCHAR(15)	NOT NULL,
	CharacteristicFeature VARCHAR(25)	NULL, -- According to the type, this field can take the value: plant (blooming), animal (alimentation), mineral (type: crystal or rock).
	CharacteristicPeriodStart DATETIME NULL,  -- According to the type, this field can take the value: plant (start of blooming period), animal (start of reproductive period)
	CharacteristicPeriodEnd DATETIME NULL  -- According to the type, this field can take the value: plant (end of blooming period), animal (end of reproductive period)
);

-- Plant table creation
-- Animal table creation
-- Rock table creation

-- AreaXSpecies table creation.
CREATE TABLE AreaXSpecies(
	fk_idArea INT FOREIGN KEY REFERENCES Area(idArea) NOT NULL,
	fk_idSpecies INT FOREIGN KEY REFERENCES Species(idSpecies) NOT NULL
);

-- FoodChainLink table creation.
CREATE TABLE FoodChainLink(
	fk_idConsumer INT FOREIGN KEY REFERENCES Species(idSpecies) NOT NULL,
	fk_idFood INT FOREIGN KEY REFERENCES Species(idSpecies) NOT NULL
);

-- Person table creation
CREATE TABLE Person(
	idPerson INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	IdNumber INT UNIQUE NOT NULL,
	"Name" VARCHAR(15) NOT NULL,
	Surname VARCHAR(15) NOT NULL,
	fk_idLocation INT FOREIGN KEY REFERENCES "Location"(idLocation) NULL,
	PhoneNumber INT NULL
);

-- Employee table creation

CREATE TABLE Employee(
	idEmployee INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idPerson INT FOREIGN KEY REFERENCES Person(idPerson) NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL
);

-- Reseptionist table clreation
CREATE TABLE Reseptionist(
	idReseptionist INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idEmployee INT FOREIGN KEY REFERENCES Employee(idEmployee) NOT NULL,
	AssignedEntrance INT NOT NULL
);


-- Vehicle table creation
CREATE TABLE Vehicle(
	idVehicle INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	"Type" VARCHAR(15) NOT NULL,
	RegistrationPlate VARCHAR(15) NOT NULL,
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL
);

-- SecurityGuard table creation
CREATE TABLE SecurityGuard(
	idSecurityGuard INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idEmployee INT FOREIGN KEY REFERENCES Employee(idEmployee) NOT NULL,
	AssignedArea VARCHAR(15) NOT NULL,
	fk_idVehicle INT FOREIGN KEY REFERENCES Vehicle(idVehicle) NOT NULL
);

-- Researcher table creation
CREATE TABLE Researcher(
	idResearcher INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idEmployee INT FOREIGN KEY REFERENCES Employee(idEmployee) NOT NULL,
	Diploma VARCHAR(15) NULL
);

-- InvestigationProject table creation
CREATE TABLE ResearchProject(
	idResearchProject INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	Budget INT NOT NULL,
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NULL,
	"Description" VARCHAR(50)
);

-- ResearchProjectXResearcher table creation
CREATE TABLE ResearchProjectXResearcher(
	fk_idResearchProject INT FOREIGN KEY REFERENCES ResearchProject(idResearchProject) NOT NULL,
	fk_idResearcher INT FOREIGN KEY REFERENCES Researcher(idResearcher) NOT NULL,
	ColabStartTime DATETIME NOT NULL,
	ColabEndTime DATETIME NULL
);

-- Conservationist table creation
CREATE TABLE Conservationist(
	idConservationist INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idEmployee INT FOREIGN KEY REFERENCES Employee(idEmployee) NOT NULL,
	Speciality VARCHAR(25) NOT NULL,
	AssignedArea VARCHAR(15) NOT NULL
);

-- Accommodation table creation
CREATE TABLE Acommodation(
	idAcommodation INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idPark INT FOREIGN KEY REFERENCES Park(idPark) NOT NULL,
	Category VARCHAR(15) NOT NULL,
	Capacity  INT NOT NULL
);

-- Visitor table creation
CREATE TABLE Visitor(
	idVisitor INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	fk_idPerson INT FOREIGN KEY REFERENCES Person(idPerson) NOT NULL,
	Profession VARCHAR(15) NULL,
	fk_idAcommodation INT FOREIGN KEY REFERENCES Acommodation(idAcommodation) NOT NULL
);

-- Excursion table creation
CREATE TABLE Excursion(
	idExcursion INT IDENTITY(1,1) PRIMARY KEY NOT NULL, -- IDENTITY(1,1) for autoincrement of primary key
	"Name" VARCHAR(15) NULL, -- Double quotes because name is a key word
	"Description" VARCHAR(50) NULL, -- Double quotes because description is a key word
	Price INT NULL,
	Capacity INT NULL,
	fk_idVehicle INT FOREIGN KEY REFERENCES Vehicle(idVehicle) 
); 

-- AcommodationXExcursion table creation
CREATE TABLE AcommodationXExcursion(
	fk_idAcommodation INT FOREIGN KEY REFERENCES Acommodation(idAcommodation) NOT NULL,
	fk_idExcursion INT FOREIGN KEY REFERENCES Excursion(idExcursion) NOT NULL,
	"Day" VARCHAR(15) NOT NULL, -- Double quotes because day is a key word
	"Hour" VARCHAR(15) NOT NULL -- Double quotes because hour is a key word
);