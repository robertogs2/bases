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

CALL AgregarCoche(170881, 13, café, nuevo, 0, 1);
CALL AgregarCoche(120056, 2, negro, reparacion, 26, 1);
CALL AgregarCoche(543260, 7, negro, nuevo, 0, 1);
CALL AgregarCoche(582936, 4, negro, nuevo, 0, 1);
CALL AgregarCoche(867067, 19, amarillo, reparacion, 337, 1);
CALL AgregarCoche(769990, 9, azul, reparacion, 137, 1);
CALL AgregarCoche(931814, 17, café, nuevo, 0, 1);
CALL AgregarCoche(795954, 13, morado, usado, 313, 1);
CALL AgregarCoche(729920, 3, negro, usado, 170, 1);
CALL AgregarCoche(881184, 14, morado, nuevo, 0, 1);
CALL AgregarCoche(845492, 16, amarillo, usado, 325, 2);
CALL AgregarCoche(585994, 3, blanco, reparacion, 67, 2);
CALL AgregarCoche(949900, 14, café, usado, 390, 1);
CALL AgregarCoche(500005, 2, verde, usado, 135, 1);
CALL AgregarCoche(554121, 7, blanco, usado, 393, 2);
CALL AgregarCoche(440292, 17, amarillo, reparacion, 329, 2);
CALL AgregarCoche(945069, 17, negro, nuevo, 0, 1);
CALL AgregarCoche(443772, 11, azul, usado, 252, 1);
CALL AgregarCoche(164334, 20, café, reparacion, 309, 2);
CALL AgregarCoche(959087, 17, café, usado, 35, 2);
CALL AgregarCoche(130573, 4, morado, reparacion, 51, 1);
CALL AgregarCoche(313299, 13, negro, usado, 320, 1);
CALL AgregarCoche(723359, 16, gris, reparacion, 57, 1);
CALL AgregarCoche(699650, 16, café, nuevo, 0, 1);
CALL AgregarCoche(511700, 4, amarillo, usado, 38, 1);
CALL AgregarCoche(386491, 20, gris, usado, 316, 1);
CALL AgregarCoche(860593, 15, blanco, usado, 254, 1);
CALL AgregarCoche(653257, 3, blanco, nuevo, 0, 2);
CALL AgregarCoche(179744, 20, verde, usado, 316, 1);
CALL AgregarCoche(930640, 19, gris, usado, 273, 2);
CALL AgregarCoche(956506, 6, gris, nuevo, 0, 1);
CALL AgregarCoche(316663, 18, verde, nuevo, 0, 2);
CALL AgregarCoche(703079, 11, verde, reparacion, 69, 1);
CALL AgregarCoche(547801, 1, amarillo, usado, 309, 1);
CALL AgregarCoche(465102, 18, morado, usado, 204, 2);
CALL AgregarCoche(732217, 4, blanco, nuevo, 0, 2);
CALL AgregarCoche(760515, 9, azul, nuevo, 0, 2);
CALL AgregarCoche(916243, 2, negro, usado, 348, 2);
CALL AgregarCoche(809763, 14, verde, reparacion, 172, 1);
CALL AgregarCoche(877239, 20, negro, usado, 221, 2);
CALL AgregarCoche(519798, 1, negro, reparacion, 140, 1);
CALL AgregarCoche(514123, 19, café, reparacion, 36, 1);
CALL AgregarCoche(705265, 10, negro, nuevo, 0, 2);
CALL AgregarCoche(177553, 13, amarillo, nuevo, 0, 2);
CALL AgregarCoche(421454, 16, amarillo, reparacion, 25, 2);
CALL AgregarCoche(830137, 3, gris, nuevo, 0, 1);
CALL AgregarCoche(897301, 17, gris, usado, 18, 1);
CALL AgregarCoche(696916, 6, morado, reparacion, 221, 1);
CALL AgregarCoche(120098, 19, morado, nuevo, 0, 1);
CALL AgregarCoche(940023, 15, gris, usado, 115, 1);

CALL ObtenerDireccionCompleta(2);



