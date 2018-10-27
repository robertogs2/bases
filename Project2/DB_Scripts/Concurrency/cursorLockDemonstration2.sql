USE BASESTEC;
GO

SELECT Tour.Price
FROM Tour 
-- If we use an id that the curson has already visited, 
-- we wont be able to access its data since its blocked,
-- if we use an id it hast visited we can see its data normally
WHERE Tour.idTour = 2