PRAGMA foreign_keys = ON;

/*
*                  ____________________
*_________________/ DATABASE CREATION  \_____________________
*/

CREATE TABLE Institution(
    IdInstitution INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    IdLocation INTEGER
);

CREATE TABLE Location(
    IdLocation INTEGER PRIMARY KEY AUTOINCREMENT,
    IdInstitution INTEGER,
    IdAddress INTEGER NOT NULL,
    Description TEXT,
    FOREIGN KEY (IdInstitution) REFERENCES Institution(IdInstitution),
    FOREIGN KEY (IdAddress) REFERENCES Address(IdAddress)
);

CREATE TABLE Address(
    IdAddress INTEGER PRIMARY KEY AUTOINCREMENT,
    IdCity INTEGER,
    ZipCode INTEGER,
    FOREIGN KEY (IdCity) REFERENCES City(IdCity)
);

CREATE TABLE City(
  IdCity INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT,
  IdState INTEGER,
  FOREIGN KEY (IdState) REFERENCES State(IdState)  
);

CREATE TABLE State(
    IdState INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT,
    IdCountry INTEGER,
    FOREIGN KEY (IdCountry) REFERENCES Country(IdCountry)
);

CREATE TABLE Restaurant(
    IdRestaurant INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT,
    IdInstitution INTEGER,
    FOREIGN KEY (IdInstitution) REFERENCES Institution(IdInstitution)
);

CREATE TABLE Plate(
    IdPlate INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT,
    Price NUMERIC NOT NULL
);

CREATE TABLE RestaurantXPlate(
    IdRestauran INTEGER NOT NULL,
    IdPlate INTEGER NOT NULL,
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurant(IdRestaurant),
    FOREIGN KEY (IdPlate) REFERENCES Plate(IdPlate)
);

CREATE TABLE Drink(
    IdDrink INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Description TEXT,
    Price NUMERIC NOT NULL
);

CREATE TABLE Meal(
    IdMeal INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT,
    IdPlate INTEGER,
    IdDrink INTEGER,
    Description TEXT,
    FOREIGN KEY (IdPlate) REFERENCES Plate(IdPlate),
    FOREIGN KEY (IdDrink) REFERENCES Drink(IdDrink)
);

CREATE TABLE Menu(
    IdMenu INTEGER PRIMARY KEY AUTOINCREMENT,
    DateTime DATETIME NOT NULL,
    IdRestaurant INTEGER NOT NULL,
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurant(IdRestaurant)
);

CREATE TABLE MenuXMeal(
    IdMenu INTEGER NOT NULL,
    IdMeal INTEGER NOT NULL,
    FOREIGN KEY (IdMenu) REFERENCES Menu(IdMenu),
    FOREIGN KEY (IdMeal) REFERENCES Meal(IdMeal)
);

CREATE TABLE Person(
    IdPerson INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    PhoneNumber INTEGER(10),
    Email TEXT(50),
    IdAddress INTEGER,
    FOREIGN KEY (IdAddress) REFERENCES Address(IdAddress)
);

CREATE TABLE Student(
    IdStudent INTEGER PRIMARY KEY AUTOINCREMENT,
    IdPerson INTEGER,
    IdCareer INTEGER,
    IdInstitution INTEGER,
    FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson),
    FOREIGN KEY (IdCareer) REFERENCES Career(IdCareer),
    FOREIGN KEY (IdInstitution) REFERENCES Institution(IdInstitution)
);

CREATE TABLE Career(
    IdCareer INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Code TEXT
);

CREATE TABLE RestaurantRating(
    IdStudent INTEGER NOT NULL,
    IdRestaurant INTEGER NOT NULL,
    Score Numeric NOT NULL,
    Comment TEXT,
    DateTime NUMERIC,
    FOREIGN KEY (IdStudent) REFERENCES Student(IdStudent),
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurant(IdRestaurant)
);

CREATE TABLE PlateRating(
    IdStudent INTEGER NOT NULL,
    IdPlate INTEGER NOT NULL,
    Score Numeric NOT NULL,
    Comment TEXT,
    DateTime NUMERIC,
    FOREIGN KEY (IdStudent) REFERENCES Student(IdStudent),
    FOREIGN KEY (IdPlate) REFERENCES Plate(IdPlate)
);


/*
*                  _______________________________
*_________________/ DATABASE TEST DATA INSERTION  \_____________________
*/

/*
*-------------------------------------------------------------
*          Inserting Address Information for testing
*-------------------------------------------------------------
*/

INSERT INTO Country (Name)
VALUES ('Costa Rica');

INSERT INTO State (Name, IdCountry)
VALUES ('Cartago', 1);

INSERT INTO City (Name, IdState)
VALUES ('Central', 1);

INSERT INTO Address (IdCiy)
VALUES (1);

/*
*-------------------------------------------------------------
*          Inserting TEC As Test institution
*-------------------------------------------------------------
*/
INSERT INTO Institution (Name)
VALUES ('TEC');


/*
*-------------------------------------------------------------
*          Adding a location corresponding to TEC
*               located in Cartago province
*-------------------------------------------------------------
*/
    
INSERT INTO Location (IdInstitution, IdDirection)
VALUES (1, 1);

/*
*-------------------------------------------------------------
*          Creating Dummy Restaurant Data
*-------------------------------------------------------------
*/

INSERT INTO Restaurant (Name, IdInstitution) /* Id = 1 */
VALUES ('Restaurante Institucional', 1);

INSERT INTO Restaurant (Name, IdInstitution) /* Id = 2 */
VALUES ('Casa Luna', 1);

/*
*-------------------------------------------------------------
*          Creating Dummy Food Data
*-------------------------------------------------------------
*/

INSERT INTO Plate (Name, Description, Price)
VALUES ('Pinto', 'Desayuno típico de Costa Rica', 1000); /* Id = 1 */

INSERT INTO Plate (Name, Description, Price)
VALUES ('ArrozConPollo', 'Delicioso almuerzo.', 2000); /* Id = 2 */

INSERT INTO Plate (Name, Description, Price)
VALUES ('ArrozConLeche', 'Postre, muy rico.', 500); /* Id = 3 */

INSERT INTO Plate (Name, Description, Price)
VALUES ('PintoCasaLuna', '', 2000); /* Id = 4 */

INSERT INTO Plate (Name, Description, Price)
VALUES ('Chuleta', 'Deliciosa culeta de cerdo.', 2500); /* Id = 5 */

/***************************************************************/

INSERT INTO Drink (Name, Description, Price)
VALUES ('Café', 'Excelente para iniciar el dia.', 500); /* Id = 1 */

INSERT INTO Drink (Name, Description, Price)
VALUES ('Birra', 'Apenas bueno para el calor', 700); /* Id = 2 */

INSERT INTO Drink (Name, Description, Price)
VALUES ('Café', 'El café de Casa Luna es muy bueno.', 700); /* Id = 3 */

INSERT INTO Drink (Name, Description, Price)
VALUES ('Birra', '', 2000);  /* Id = 4 */

/*-----------------------MEALS------------------------------*/
INSERT INTO Meal (Name, IdPlate, IdDrink, Description)
VALUES ('Desayuno Institucional', 1, 1, '');

INSERT INTO Meal (Name, IdPlate, IdDrink, Description)
VALUES ('Desayuno CasaLuna', 4, 3, '');
/*----------------------------------------------------------*/

/*
*-------------------------------------------------------------
*                Creating Dummy Test Menus
*-------------------------------------------------------------
*/

INSERT INTO Menu(DateTime,IdRestaurant) /* Id = 1 */
VALUES ('now', 1);

INSERT INTO Menu(DateTime, IdRestaurant) /* Id = 2 */
VALUES ('now', 1);

/*
*-------------------------------------------------------------
*                Creating RestaurantXPlatillo
*-------------------------------------------------------------
*/

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate) 
VALUES (1, 1);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (1, 2);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (2, 2);

/*
*-------------------------------------------------------------
*                Career Test Data Creation
*-------------------------------------------------------------
*/

INSERT INTO Career (Name, Code)  /* Id = 1*/
VAlUES ('Computadores', 'CE'); 

INSERT INTO Career (Name, Code) /* Id = 2*/
VAlUES ('Electro', 'EL');

INSERT INTO Career (Name, Code) /* Id = 3*/
VAlUES ('Computación', 'C');

/*
*-------------------------------------------------------------
*                Person Test Data Creation
*-------------------------------------------------------------
*/

INSERT INTO Person (Name, Email)       /* Id = 1*/
VALUES ('Andres', 'andres@gmail.com');

INSERT INTO Person (Name, Email)       /* Id = 2*/
VALUES ('Roberto', 'roberto@gmail.com');

INSERT INTO Person (Name, Email)       /* Id = 3*/
VALUES ('Alejandro', 'alejadro@gmail.com');

INSERT INTO Person (Name, Email)       /* Id = 4*/
VALUES ('Andres', 'andres@gmail.com');

INSERT INTO Person (Name, Email)       /* Id = 5*/
VALUES ('Raúl', 'raul@gmail.com');

/*
*-------------------------------------------------------------
*                Person Test Data Creation
*-------------------------------------------------------------
*/

INSERT INTO Student (IdPerson, IdCareer, IdInstitution)
VALUES (1,1,1);

INSERT INTO Student(IdPerson, IdCareer, IdInstitution)
VALUES (2,1,1);

INSERT INTO Student(IdPerson, IdCareer, IdInstitution)
VALUES (3,1,1);

INSERT INTO Student(IdPerson, IdCareer, IdInstitution)
VALUES (4,2,1);

INSERT INTO Student(IdPerson, IdCareer, IdInstitution)
VALUES (5,3,1);

/*
*-------------------------------------------------------------
*                Ratings Test Data Creation
*-------------------------------------------------------------
*/
INSERT INTO PlateRating (IdStudent, IdPlate, Score, Comment, DateTime)
VALUES (1, 1, 10, 'Muy bueno', '2018-09-04 08:20:00');

INSERT INTO PlateRating (IdStudent, IdPlate, Score, Comment, DateTime)
VALUES (2, 1, 8, 'Bastante rico', '2018-09-04 09:00:00');

INSERT INTO PlateRating (IdStudent, IdPlate, Score, Comment, DateTime)
VALUES (3, 2, 5, 'Excelente', '2018-09-05 09:30:00');

INSERT INTO PlateRating (IdStudent, IdPlate, Score, Comment, DateTime)
VALUES (5, 4, 10, 'Muy Rico', '2018-09-05 08:20:00');

INSERT INTO RestaurantRating (IdStudent, IdRestaurant, Score, Comment, DateTime)
VALUES (1, 1, 10, 'Excelente', '2018-09-06 09:20:00');

INSERT INTO RestaurantRating (IdStudent, IdRestaurant, Score, Comment, DateTime)
VALUES (3, 2, 7, 'Bastante Bueno', '2018-09-06 10:20:00');

INSERT INTO RestaurantRating (IdStudent, IdRestaurant, Score, Comment, DateTime)
VALUES (5, 1, 8, 'Muy Bueno', '2018-09-06 09:35:00');

/*
*-------------------------------------------------------------
*                Selects for the Plate Ratings
*-------------------------------------------------------------
*/

/*Overall*/
SELECT
 PlateRating.IdPlate,
 avg(Score) Avg_score
FROM
 PlateRating
GROUP BY
 PlateRating.IdPlate
ORDER BY 
 Avg_Score DESC;
 
/*By Day*/
SELECT
 PlateRating.IdPlate,
 avg(Score) Avg_score
FROM
 PlateRating
WHERE
 date(PlateRating.DateTime) = '2018-09-05'
GROUP BY
 PlateRating.IdPlate
ORDER BY 
 Avg_Score DESC;
 
/*By Month*/
SELECT
 PlateRating.IdPlate,
 avg(Score) Avg_score
FROM
 PlateRating
WHERE
 strftime('%m', PlateRating.DateTime) = '09'
GROUP BY
 PlateRating.IdPlate
ORDER BY 
 Avg_Score DESC;

/*By Restaurant*/
SELECT
 Plate.Name,
 Plate.IdPlate,
 AVG(PlateRating.Score) Avg_score
FROM
 Plate
INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
INNER JOIN RestaurantXPlate ON RestaurantXPlate.IdPlate = Plate.IdPlate
WHERE RestaurantXPlate.IdRestaurant = 1;