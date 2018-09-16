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

-- Agregar Concesionarios
CALL AgregarConcesionario("Concesionario la UNO", 1);
CALL AgregarConcesionario("Concesionario la DOS", 3);

-- Agregar Talleres
CALL AgregarTaller("Taller Alpha", 2, 1);
CALL AgregarTaller("Taller Bravo", 3, 1);
CALL AgregarTaller("Taller Charlie", 4, 1);
CALL AgregarTaller("Taller Delta", 1, 1);
CALL AgregarTaller("Taller Echo", 2, 1);

CALL AgregarTaller("Taller Foxtrot", 2, 2);
CALL AgregarTaller("Taller Golf", 3, 2);
CALL AgregarTaller("Taller Hotel", 4, 2);
CALL AgregarTaller("Taller India", 1, 2);
CALL AgregarTaller("Taller Juliet", 2, 2);

-- Agregar Marcas
CALL AgregarMarca("Toyota"); -- 1
CALL AgregarMarca("Mitsubishi"); -- 2
CALL AgregarMarca("Nissan"); -- 3
CALL AgregarMarca("Ford"); -- 4
CALL AgregarMarca("Suzuki"); -- 5

-- Agregar Modelos
CALL AgregarModelo("Rav4", 1);
CALL AgregarModelo("Hilux", 1);
CALL AgregarModelo("Yaris", 1);
CALL AgregarModelo("Avensis", 1);
CALL AgregarModelo("Prius", 1);

CALL AgregarModelo("Montero", 2);
CALL AgregarModelo("Outlander", 2);
CALL AgregarModelo("L200", 2);

CALL AgregarModelo("Navarra", 3);
CALL AgregarModelo("Murano", 3);
CALL AgregarModelo("Pathfinder", 3);
CALL AgregarModelo("QASHQAI", 3);

CALL AgregarModelo("Fiesta", 4);
CALL AgregarModelo("Mustang", 4);
CALL AgregarModelo("Focus", 4);
CALL AgregarModelo("Kuga", 4);

CALL AgregarModelo("Grand Vitara", 5);
CALL AgregarModelo("Jimny", 5);
CALL AgregarModelo("Vitara", 5);
CALL AgregarModelo("Swift", 5);

CALL AgregarCoche(731898, 19, "gris", "usado", 300, 2);
CALL AgregarCoche(140594, 7, "morado", "nuevo", 0, 2);
CALL AgregarCoche(579390, 13, "gris", "reparacion", 22, 1);
CALL AgregarCoche(664449, 16, "morado", "usado", 69, 2);
CALL AgregarCoche(707522, 16, "gris", "usado", 152, 1);
CALL AgregarCoche(505354, 14, "gris", "reparacion", 195, 2);
CALL AgregarCoche(503249, 7, "amarillo", "reparacion", 224, 1);
CALL AgregarCoche(631613, 13, "azul", "nuevo", 0, 1);
CALL AgregarCoche(850940, 11, "café", "reparacion", 46, 1);
CALL AgregarCoche(586351, 4, "blanco", "nuevo", 0, 2);
CALL AgregarCoche(541747, 15, "azul", "nuevo", 0, 1);
CALL AgregarCoche(268864, 6, "gris", "reparacion", 139, 1);
CALL AgregarCoche(341232, 8, "negro", "usado", 192, 1);
CALL AgregarCoche(970234, 19, "café", "nuevo", 0, 1);
CALL AgregarCoche(861812, 19, "azul", "nuevo", 0, 1);
CALL AgregarCoche(361906, 7, "amarillo", "usado", 369, 1);
CALL AgregarCoche(926391, 10, "amarillo", "reparacion", 172, 1);
CALL AgregarCoche(528327, 9, "verde", "reparacion", 214, 1);
CALL AgregarCoche(894561, 3, "blanco", "nuevo", 0, 2);
CALL AgregarCoche(596659, 7, "verde", "usado", 69, 2);
CALL AgregarCoche(664913, 14, "amarillo", "usado", 326, 1);
CALL AgregarCoche(868067, 5, "negro", "nuevo", 0, 1);
CALL AgregarCoche(507161, 4, "café", "reparacion", 331, 2);
CALL AgregarCoche(489255, 11, "verde", "nuevo", 0, 2);
CALL AgregarCoche(859814, 6, "café", "nuevo", 0, 1);
CALL AgregarCoche(952273, 11, "morado", "usado", 355, 1);
CALL AgregarCoche(905678, 8, "negro", "reparacion", 332, 1);
CALL AgregarCoche(730815, 5, "azul", "reparacion", 354, 1);
CALL AgregarCoche(334096, 16, "azul", "reparacion", 33, 1);
CALL AgregarCoche(603761, 6, "verde", "nuevo", 0, 1);
CALL AgregarCoche(355078, 11, "verde", "reparacion", 326, 1);
CALL AgregarCoche(939852, 16, "morado", "nuevo", 0, 1);
CALL AgregarCoche(137938, 4, "amarillo", "usado", 40, 1);
CALL AgregarCoche(655257, 9, "negro", "usado", 238, 1);
CALL AgregarCoche(277813, 4, "gris", "usado", 328, 1);
CALL AgregarCoche(880017, 9, "gris", "usado", 377, 2);
CALL AgregarCoche(880791, 3, "azul", "nuevo", 0, 2);
CALL AgregarCoche(882766, 16, "azul", "nuevo", 0, 1);
CALL AgregarCoche(761194, 11, "amarillo", "nuevo", 0, 2);
CALL AgregarCoche(270995, 8, "morado", "nuevo", 0, 2);
CALL AgregarCoche(888193, 16, "blanco", "nuevo", 0, 2);
CALL AgregarCoche(395597, 13, "morado", "reparacion", 118, 1);
CALL AgregarCoche(264861, 5, "café", "usado", 37, 2);
CALL AgregarCoche(883736, 16, "negro", "nuevo", 0, 1);
CALL AgregarCoche(708862, 14, "amarillo", "reparacion", 168, 1);
CALL AgregarCoche(663976, 10, "café", "nuevo", 0, 2);
CALL AgregarCoche(847236, 5, "blanco", "nuevo", 0, 2);
CALL AgregarCoche(908781, 4, "café", "usado", 400, 1);
CALL AgregarCoche(244835, 20, "amarillo", "nuevo", 0, 1);
CALL AgregarCoche(834463, 1, "azul", "reparacion", 164, 1);




CALL ObtenerDireccionCompleta(2);



