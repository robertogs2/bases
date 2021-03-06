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
    IdRestaurant INTEGER NOT NULL,
    Score Numeric NOT NULL,
    Comment TEXT,
    DateTime NUMERIC,
    FOREIGN KEY (IdStudent) REFERENCES Student(IdStudent),
    FOREIGN KEY (IdPlate) REFERENCES Plate(IdPlate),
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurant(IdRestaurant)
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
VALUES (1, 3);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (1, 4);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (1, 5);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate) 
VALUES (2, 1);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (2, 2);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (2, 3);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (2, 4);

INSERT INTO RestaurantXPlate(IdRestaurant, IdPlate)
VALUES (2, 5);

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
INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (1, 1, 1, 10, 'Muy bueno', '2018-09-04 08:20:00');

INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (1, 1, 1, 10, 'Muy bueno', '2018-04-04 08:20:00');

INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (2, 4, 2, 8, 'Bastante rico', '2018-09-04 09:00:00');

INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (3, 2, 1, 5, 'Excelente', '2018-09-05 09:30:00');

INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (3, 2, 1, 5, 'Excelente', '2018-04-05 09:30:00');

INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (3, 2, 1, 1, '', '2018-04-05 09:30:00');


INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (3, 2, 1, 5, '', '2018-04-05 09:30:00');


INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (3, 2, 1, 0, 'Malo', '2018-04-05 09:30:00');


INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (5, 1, 1, 10, 'Muy Rico', '2018-09-05 08:20:00');

INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (5, 4, 2, 10, 'Buenisimo', '2018-09-05 08:20:00');

INSERT INTO PlateRating (IdStudent, IdPlate, IdRestaurant, Score, Comment, DateTime)
VALUES (4, 4, 2, 10, 'Buenisimo', '2018-09-05 08:20:00');

INSERT INTO RestaurantRating (IdStudent, IdRestaurant, Score, Comment, DateTime)
VALUES (1, 1, 10, 'Excelente', '2018-09-06 09:20:00');

INSERT INTO RestaurantRating (IdStudent, IdRestaurant, Score, Comment, DateTime)
VALUES (3, 2, 7, 'Bastante Bueno', '2018-09-06 10:20:00');

INSERT INTO RestaurantRating (IdStudent, IdRestaurant, Score, Comment, DateTime)
VALUES (5, 1, 8, 'Muy Bueno', '2018-09-06 09:35:00');

INSERT INTO RestaurantRating (IdStudent, IdRestaurant, Score, Comment, DateTime)
VALUES (5, 1, 5, 'Muy Bueno', '2018-05-06 09:35:00');

/*
*-------------------------------------------------------------
*                Selects for the Plate Ratings
*-------------------------------------------------------------
*/
 
/*By Day Max*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Date Date,
    MAX(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     date(PlateRating.DateTime) Date,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     PlateRating.DateTime) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Date
ORDER BY 
 DateXAvgScore.Date DESC;
 
/*By Day Max by Restaurant*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Date Date,
    MAX(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     date(PlateRating.DateTime) Date,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     PlateRating.DateTime) AS DateXAvgScore
GROUP BY
 DateXAvgScore.ResName,
 DateXAvgScore.Date
 
ORDER BY 
 DateXAvgScore.Date DESC;

/*By Day Min*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Date Date,
    MIN(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     date(PlateRating.DateTime) Date,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     PlateRating.DateTime) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Date
ORDER BY 
 DateXAvgScore.Date DESC;
 
/*By Day Min by Restaurant*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Date Date,
    MIN(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     date(PlateRating.DateTime) Date,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     PlateRating.DateTime) AS DateXAvgScore
GROUP BY
 DateXAvgScore.ResName,
 DateXAvgScore.Date
 
ORDER BY 
 DateXAvgScore.Date DESC;

/*By Week Max*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Week Week,
    DateXAvgScore.Year Year,
    MAX(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     strftime('%W', PlateRating.DateTime) Week,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     PlateRating.IdPlate,
     Week) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Week
ORDER BY 
 DateXAvgScore.Week DESC; 

/*By Week Max by Restaurant*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Week Week,
    DateXAvgScore.Year Year,
    MAX(DateXAvgScore.Avg_Score) Average
    
FROM(
    SELECT
     Plate.Name,
     strftime('%W', PlateRating.DateTime) Week,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     Week) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Week,
 DateXAvgScore.ResName
ORDER BY 
 DateXAvgScore.Week DESC;

/*By Week Min*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Week Week,
    DateXAvgScore.Year Year,
    MIN(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     strftime('%W', PlateRating.DateTime) Week,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     PlateRating.IdPlate,
     Week) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Week
ORDER BY 
 DateXAvgScore.Week DESC; 


/*By Week min by Restaurant*/
SELECT 
    DateXAvgScore.Name PlateName,
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Week Week,
    DateXAvgScore.Year Year,
    MIN(DateXAvgScore.Avg_Score) Average
    
FROM(
    SELECT
     Plate.Name,
     strftime('%W', PlateRating.DateTime) Week,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     Week) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Week,
 DateXAvgScore.ResName
ORDER BY 
 DateXAvgScore.Week DESC;

/*By Month Max*/
SELECT 
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Name PlateName,
    DateXAvgScore.Month Month,
    DateXAvgScore.Year Year,
    MAX(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     strftime('%m', PlateRating.DateTime) Month,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     PlateRating.IdPlate,
     Month) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Month
ORDER BY 
 DateXAvgScore.Month DESC;

/*By Month Max by Restaurant*/
SELECT 
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Name PlateName,
    DateXAvgScore.Month Month,
    DateXAvgScore.Year Year,
    MAX(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     strftime('%m', PlateRating.DateTime) Month,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     Month) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Month,
 DateXAvgScore.ResName
ORDER BY 
 DateXAvgScore.Month DESC;

/*By Month Min*/
SELECT 
    DateXAvgScore.Name Name,
    DateXAvgScore.Month Month,
    DateXAvgScore.Year Year,
    MIN(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     strftime('%m', PlateRating.DateTime) Month,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    GROUP BY
     PlateRating.IdPlate,
     Month) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Month
ORDER BY 
 DateXAvgScore.Month DESC;

/*By Month Min by Restaurant*/
SELECT 
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Name PlateName,
    DateXAvgScore.Month Month,
    DateXAvgScore.Year Year,
    Min(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     strftime('%m', PlateRating.DateTime) Month,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     Month) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Month,
 DateXAvgScore.ResName
ORDER BY 
 DateXAvgScore.Month DESC;

/*By Semester Max*/
SELECT 
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Name PlateName,
    DateXAvgScore.Semester Semester,
    MAX(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     CASE
     WHEN strftime('%m', PlateRating.DateTime) > '06' THEN 'Segundo'
     ELSE 'Primer' END Semester,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     PlateRating.IdPlate,
     Semester) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Semester
ORDER BY 
 DateXAvgScore.Semester DESC,
 DateXAvgScore.Year DESC;

/*By Semester Max by Restaurant*/
SELECT 
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Name PlateName,
    DateXAvgScore.Year Year,
    DateXAvgScore.Semester Semester,
    MAX(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     CASE
     WHEN strftime('%m', PlateRating.DateTime) > '06' THEN 'Segundo'
     ELSE 'Primer' END Semester,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     Semester) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Semester,
 DateXAvgScore.ResName
ORDER BY 
 DateXAvgScore.Semester DESC,
 DateXAvgScore.Year DESC;

/*By Semester Min*/
SELECT 
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Name PlateName,
    DateXAvgScore.Semester Semester,
    MIN(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     CASE
     WHEN strftime('%m', PlateRating.DateTime) > '06' THEN 'Segundo'
     ELSE 'Primer' END Semester,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     PlateRating.IdPlate,
     Semester) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Semester
ORDER BY 
 DateXAvgScore.Semester DESC,
 DateXAvgScore.Year DESC;

/*By Semester Min by Restaurant*/
SELECT 
    DateXAvgScore.ResName RestaurantName,
    DateXAvgScore.Name PlateName,
    DateXAvgScore.Year Year,
    DateXAvgScore.Semester Semester,
    MIN(DateXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Plate.Name,
     CASE
     WHEN strftime('%m', PlateRating.DateTime) > '06' THEN 'Segundo'
     ELSE 'Primer' END Semester,
     strftime('%Y', PlateRating.DateTime) Year,
     AVG(PlateRating.Score) Avg_score,
     Restaurant.Name ResName
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON PlateRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     PlateRating.IdPlate,
     Semester) AS DateXAvgScore
GROUP BY
 DateXAvgScore.Semester,
 DateXAvgScore.ResName
ORDER BY 
 DateXAvgScore.Semester DESC,
 DateXAvgScore.Year DESC;

/*By Restaurant Max*/
SELECT 
    RestaurantXAvgScore.RestaurantName RestaurantName,
    RestaurantXAvgScore.PlateName PlateName,
    MAX(RestaurantXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Restaurant.Name RestaurantName,
     Restaurant.IdRestaurant IdRes,
     Plate.Name PlateName,
     Plate.IdPlate,
     AVG(PlateRating.Score) Avg_score
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN RestaurantXPlate ON RestaurantXPlate.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON RestaurantXPlate.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
         PlateRating.IdPlate,
         Restaurant.Name) AS RestaurantXAvgScore
GROUP BY
    RestaurantXAvgScore.IdRes;

/*By Restaurant Min*/
SELECT 
    RestaurantXAvgScore.RestaurantName RestaurantName,
    RestaurantXAvgScore.PlateName PlateName,
    MIN(RestaurantXAvgScore.Avg_Score) Average
FROM(
    SELECT
     Restaurant.Name RestaurantName,
     Restaurant.IdRestaurant IdRes,
     Plate.Name PlateName,
     Plate.IdPlate,
     AVG(PlateRating.Score) Avg_score
    FROM
     Plate
    INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
    INNER JOIN RestaurantXPlate ON RestaurantXPlate.IdPlate = Plate.IdPlate
    INNER JOIN Restaurant ON RestaurantXPlate.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
         PlateRating.IdPlate,
         Restaurant.Name) AS RestaurantXAvgScore
GROUP BY
    RestaurantXAvgScore.IdRes;    

/*Overall Max*/
SELECT
 Plate.Name PlateName,
 Restaurant.Name RestaurantName,
 avg(Score) Avg_score
FROM
 Plate
INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
INNER JOIN Restaurant ON Restaurant.IdRestaurant = PlateRating.IdRestaurant
GROUP BY
 PlateRating.IdPlate
ORDER BY 
 Avg_Score DESC
LIMIT (1);
 
/*Overall Min*/
SELECT
 Plate.Name PlateName,
 Restaurant.Name RestaurantName,
 avg(Score) Avg_score
FROM
 Plate
INNER JOIN PlateRating ON PlateRating.IdPlate = Plate.IdPlate
INNER JOIN Restaurant ON Restaurant.IdRestaurant = PlateRating.IdRestaurant
GROUP BY
 PlateRating.IdPlate
ORDER BY 
 Avg_Score ASC
LIMIT (1);

/*
*-------------------------------------------------------------
*               Select the time that visits the most
*-------------------------------------------------------------
*/

/*Needs to consider plate rating and restaurant rating*/
SELECT TimeXVisits.RestaurantName,
     TimeXVisits.Hours Hour,
     MAX(TimeXVisits.Visits) TotalVisits
FROM(
    SELECT
     Restaurant.Name AS RestaurantName,
     strftime('%H', PlateRating.DateTime) Hours,
     Restaurant.IdRestaurant AS IdRes,
     COUNT(Restaurant.IdRestaurant) Visits
    FROM
     Restaurant
    INNER JOIN PlateRating ON Restaurant.IdRestaurant = PlateRating.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant,
     Hours) 
AS TimeXVisits
Group By TimeXVisits.IdRes;

/*
*-------------------------------------------------------------
*               Select the career that visits the most
*-------------------------------------------------------------
*/

/*Needs to consider plate rating and restaurant rating*/
SELECT VisitsXCareer.RestaurantName,
     VisitsXCareer.CareerName,
     MAX(VisitsXCareer.Visits) Visits
FROM(
    SELECT
     Restaurant.Name AS RestaurantName,
     Career.Name AS CareerName,
     Restaurant.IdRestaurant AS IdRes,
     COUNT(Career.IdCareer) Visits
    FROM
     Restaurant
     
    INNER JOIN Career ON Student.IdCareer = Career.IdCareer
    INNER JOIN Student ON PlateRating.IdStudent = Student.IdStudent
    INNER JOIN PlateRating ON Restaurant.IdRestaurant = PlateRating.IdRestaurant
    
    GROUP BY
     Restaurant.IdRestaurant,
     Career.IdCareer) 
AS VisitsXCareer
Group By VisitsXCareer.IdRes;

/*
*-------------------------------------------------------------
*                Select for the most Active Student with platerating
*-------------------------------------------------------------
*/

/*Needs to consider plate rating and restaurant rating*/
SELECT
 Person.Name,
 COUNT(Student.IdStudent) Rates1

FROM
 Student
 
INNER JOIN Person ON  Person.IdPerson = Student.IdPerson
LEFT JOIN PlateRating ON  PlateRating.IdStudent = Student.IdStudent

/*WHERE PlateRating.IdStudent = Student.IdStudent OR RestaurantRating.IdStudent = Student.IdStudent*/

GROUP BY
 Student.IdStudent
ORDER BY 
 Rates1 DESC;


/*
*-------------------------------------------------------------
*                Selects rating for Restaurant
*-------------------------------------------------------------
*/

SELECT res.Name, res.Good_ratings, res.Bad_ratings,  10 * ((res.Good_ratings - res.Bad_ratings) / (res.Bad_ratings +  res.Good_ratings)) Average
FROM(
    SELECT
     Restaurant.Name AS Name,
     SUM (CASE WHEN RestaurantRating.Score >= 5 THEN 1 ELSE 0 END) AS Good_ratings,
     SUM (CASE WHEN RestaurantRating.Score < 5 THEN 1 ELSE 0 END) AS Bad_ratings
    FROM
     Restaurant
    INNER JOIN RestaurantRating ON RestaurantRating.IdRestaurant = Restaurant.IdRestaurant
    GROUP BY
     Restaurant.IdRestaurant) 
AS res;

/*
*-------------------------------------------------------------
*                Update, set, or, is null, not null, and, where
*-------------------------------------------------------------
*/ 

UPDATE Person
SET Email = 'estudiante@email.com'
WHERE 
Email IS NULL
OR
(Email IS NOT NULL AND Name = 'Andres');

/*
*-------------------------------------------------------------
*                Delete 
*-------------------------------------------------------------
*/ 
DELETE 
FROM 
    PlateRating
WHERE
   PlateRating.IdStudent = 3;
/*
*-------------------------------------------------------------
*                Distinct 
*-------------------------------------------------------------
*/ 

SELECT DISTINCT
 Person.Name
FROM 
 Person;