USE p1;

CALL AgregarPais("Costa Rica");
CALL AgregarPais("México");
CALL AgregarPais("Estados Unidos");
-- Agregar provincias
-- Provincias Costa Rica
CALL AgregarProvincia("Cartago", 1);
CALL AgregarProvincia("Alajuela", 1);
CALL AgregarProvincia("San José", 1);
CALL AgregarProvincia("Heredia", 1);
CALL AgregarProvincia("Guanacaste", 1);
CALL AgregarProvincia("Puntarenas", 1);
CALL AgregarProvincia("Limón", 1);

-- Provincias/Estados México
CALL AgregarProvincia("Ciudad de México", 2);
CALL AgregarProvincia("Chiapas", 2);
CALL AgregarProvincia("Guanajuato", 2);
CALL AgregarProvincia("Guerrero", 2);
CALL AgregarProvincia("Jalisco", 2);
CALL AgregarProvincia("Morelos", 2);
CALL AgregarProvincia("Puebla", 2);
CALL AgregarProvincia("Zacatecas", 2);
CALL AgregarProvincia("Sinaloa", 2);

-- Provincias/Estados Estados Unidos
CALL AgregarProvincia("Nueva York", 3);
CALL AgregarProvincia("Texas", 3);
CALL AgregarProvincia("California", 3);
CALL AgregarProvincia("Nevada", 3);
CALL AgregarProvincia("Colorado", 3);
CALL AgregarProvincia("Florida", 3);
CALL AgregarProvincia("Wisconsin", 3);
CALL AgregarProvincia("Ohio", 3);
CALL AgregarProvincia("Alabama", 3);

-- Agregar ciudades
CALL AgregarCiudad("Cartago", 1);
CALL AgregarCiudad("Paraiso", 1);
CALL AgregarCiudad("Alajuela", 2);
CALL AgregarCiudad("San Carlos", 2);

CALL AgregarDireccion(30101, 1);
CALL AgregarDireccion(30201, 2);
CALL AgregarDireccion(20101, 3);
CALL AgregarDireccion(21001, 4);

CALL AgregarUbicacion("100m Sur, 100m Norte de las Ruinas", 1);
CALL AgregarUbicacion("100m Este, 100m Oeste de la bomba", 2);
CALL AgregarUbicacion("Por el Palí", 3);
CALL AgregarUbicacion("Por la finca de los Guzmán", 4);

Call AgregarConcesionario("Purdy Motor", 1);
Call AgregarConcesionario("Veinsa Motors", 3);

Call AgregarTaller("Taller Alpha", 2, 1);
Call AgregarTaller("Taller Bravo", 3, 1);
Call AgregarTaller("Taller Charlie", 4, 1);
Call AgregarTaller("Taller Delta", 1, 1);
Call AgregarTaller("Taller Echo", 2, 1);

Call AgregarTaller("Taller Foxtrot", 2, 2);
Call AgregarTaller("Taller Golf", 3, 2);
Call AgregarTaller("Taller Hotel", 4, 2);
Call AgregarTaller("Taller India", 1, 2);
Call AgregarTaller("Taller Juliet", 2, 2);

CALL ObtenerDireccionCompleta(2);



