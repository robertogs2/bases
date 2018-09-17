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

-- Se agregan a Reparacion 1 
CALL AgregarCoche(579390, 13, "gris", "usado", 22, 6000000, 1);
CALL AgregarCoche(707522, 16, "gris", "usado", 152, 2000000, 1);
CALL AgregarCoche(503249, 7, "amarillo", "usado", 224, 8000000, 1);
CALL AgregarCoche(631613, 13, "azul", "nuevo", 0, 9000000, 1);
CALL AgregarCoche(850940, 11, "café", "usado", 46, 1000000, 1);
CALL AgregarCoche(541747, 15, "azul", "nuevo", 0, 11000000, 1);
CALL AgregarCoche(268864, 6, "gris", "usado", 139, 14000000, 1);
CALL AgregarCoche(341232, 8, "negro", "usado", 192, 2000000, 1);
CALL AgregarCoche(970234, 19, "café", "nuevo", 0, 9000000, 1);
CALL AgregarCoche(861812, 19, "azul", "nuevo", 0, 13000000, 1);
CALL AgregarCoche(541749, 15, "azul", "nuevo", 0, 11000000, 1);
CALL AgregarCoche(268869, 6, "gris", "usado", 139, 14000000, 1);
CALL AgregarCoche(341239, 8, "negro", "usado", 192, 2000000, 1);
CALL AgregarCoche(970239, 19, "café", "nuevo", 0, 9000000, 1);
CALL AgregarCoche(861819, 19, "azul", "nuevo", 0, 13000000, 1);
-- Se venden 1
CALL AgregarCoche(361906, 7, "amarillo", "usado", 369, 54000000, 1);
CALL AgregarCoche(926391, 10, "amarillo", "usado", 172, 7800000, 1);
CALL AgregarCoche(528327, 9, "verde", "usado", 214, 2300000, 1);
CALL AgregarCoche(664913, 14, "amarillo", "usado", 326, 4500000, 1);
CALL AgregarCoche(868067, 5, "negro", "nuevo", 0, 9800000, 1);
CALL AgregarCoche(859814, 6, "café", "nuevo", 0, 4500000, 1);
CALL AgregarCoche(952273, 11, "morado", "usado", 355, 5600000, 1);
CALL AgregarCoche(905678, 8, "negro", "usado", 332, 2300000, 1);
CALL AgregarCoche(730815, 5, "azul", "usado", 354, 26500000, 1);
CALL AgregarCoche(334096, 16, "azul", "usado", 33, 4500000, 1);
CALL AgregarCoche(603761, 6, "verde", "nuevo", 0, 7600000, 1);
CALL AgregarCoche(355078, 11, "verde", "usado", 326, 8900000, 1);
CALL AgregarCoche(939852, 16, "morado", "nuevo", 0, 6700000, 1);
CALL AgregarCoche(137938, 4, "amarillo", "usado", 40, 4000000, 1);
CALL AgregarCoche(655257, 9, "negro", "usado", 238, 8700000, 1);
CALL AgregarCoche(277813, 4, "gris", "usado", 328, 5500000, 1);
CALL AgregarCoche(882766, 16, "azul", "nuevo", 0, 2300000, 1);
CALL AgregarCoche(395597, 13, "morado", "usado", 118, 4000000, 1);
CALL AgregarCoche(264861, 5, "café", "usado", 37, 2300000, 2);
CALL AgregarCoche(883736, 16, "negro", "nuevo", 0, 3200000, 1);
CALL AgregarCoche(708862, 14, "amarillo", "usado", 168, 4000000, 1);
CALL AgregarCoche(908781, 4, "café", "usado", 400, 4000000, 1);
CALL AgregarCoche(244835, 20, "amarillo", "nuevo", 0, 4000000, 1);
CALL AgregarCoche(834463, 1, "azul", "usado", 164, 4000000, 1);


-- Se agregan a Reparacion 2
CALL AgregarCoche(731898, 19, "gris", "usado", 300, 4000000, 2);
CALL AgregarCoche(140594, 7, "morado", "nuevo", 0, 6700000, 2);
CALL AgregarCoche(664449, 16, "morado", "usado", 69, 4000000, 2);
CALL AgregarCoche(586351, 4, "blanco", "nuevo", 0, 4000000, 2);
CALL AgregarCoche(894561, 3, "blanco", "nuevo", 0, 4000000, 2);
CALL AgregarCoche(586352, 4, "blanco", "nuevo", 0, 4000000, 2);
CALL AgregarCoche(894563, 3, "blanco", "nuevo", 0, 4000000, 2);
CALL AgregarCoche(334561, 3, "blanco", "nuevo", 0, 4000000, 2);
CALL AgregarCoche(236352, 4, "blanco", "nuevo", 0, 4000000, 2);
CALL AgregarCoche(564563, 3, "blanco", "nuevo", 0, 4000000, 2);
-- Se venden 2
CALL AgregarCoche(596659, 7, "verde", "usado", 69, 6600000, 2);
CALL AgregarCoche(505354, 14, "gris", "usado", 195, 6700000, 2);
CALL AgregarCoche(507161, 4, "café", "usado", 331, 4000000, 2);
CALL AgregarCoche(489255, 11, "verde", "nuevo", 0, 9800000, 2);
CALL AgregarCoche(880017, 9, "gris", "usado", 377, 4900000, 2);
CALL AgregarCoche(880791, 3, "azul", "nuevo", 0, 6700000, 2);
CALL AgregarCoche(761194, 11, "amarillo", "nuevo", 0, 1100000, 2);
CALL AgregarCoche(270995, 8, "morado", "nuevo", 0, 4000000, 2);
CALL AgregarCoche(888193, 16, "blanco", "nuevo", 0, 2200000, 2);
CALL AgregarCoche(663976, 10, "café", "nuevo", 0, 9000000, 2);
CALL AgregarCoche(847236, 5, "blanco", "nuevo", 0, 3300000, 2);

-- Agrega personas
CALL AgregarPersona(123,"Celso", "Borges Mora", 22,88996633, 403, 1 );
CALL AgregarPersona(147,"Andres", "Campos Castro", 69,79463521, 512, 2 );
CALL AgregarPersona(159,"Roberto", "Gutierrez Sánchez", 50,67924359, 256, 3 );
CALL AgregarPersona(789,"Alejandro", "Calvo Porras", 18,87642025, 128, 4 );
CALL AgregarPersona(456,"Iván", "Calvo Alverts", 33,79852630, 064, 4 );
CALL AgregarPersona(741,"Allan", "Navarro Brenes", 40,78945612, 032, 1 );
CALL AgregarPersona(321,"Crisptofer", "Fernández Fernández", 26,89764532, 016, 2 );
CALL AgregarPersona(987,"Jimena", "Salas Alfaro", 22,69325896, 008, 3 );
CALL AgregarPersona(951,"Alejandra", "Monterrey Arguedas", 23,74125896, 004, 4 );
CALL AgregarPersona(333,"Erick", "Muñoz Alvarado", 20,70118002, 002, 1 );
CALL AgregarPersona(205,"Raúl", "Madrigal Acuña", 26,70310065, 001, 2 );
CALL AgregarPersona(258,"Ignacio", "Mora Jiménez", 28,86865320, 000, 3 );
CALL AgregarPersona(666,"Lucifer de Jesús", "Cruz Monterrey", 28,86666690, 000, 3 );

-- Agrega clientes
CALL AgregarClientePorCedula(205);
CALL AgregarClientePorCedula(258);
CALL AgregarClientePorCedula(666);


-- Agrega reparaciones
-- Terminadas concesionario 1 10
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 579390, "Nacho chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 707522, "Pancho chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 503249, "Andrés chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 631613, "Crisptofer chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 850940, "Raúl chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 541747, "Erick chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 268864, "Alejandra chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 341232, "Alejandro chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 970234, "Iván chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50", 861812, "Celso chocó saliendo de la chicharronera");
-- En curso concesionario 1 15
CALL AgregarReparacionCompleto("2008-3-11 03:03:50", NULL, 579390, "Nacho chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2008-3-12 03:03:50", NULL, 707522, "Pancho chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2008-3-13 03:03:50", NULL, 503249, "Andrés chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2008-3-14 03:03:50", NULL, 631613, "Crisptofer chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2008-3-15 03:03:50", NULL, 850940, "Raúl chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2008-3-16 03:03:50", NULL, 541747, "Erick chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2008-3-17 03:03:50", NULL, 268864, "Alejandra chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2008-3-18 03:03:50", NULL, 341232, "Alejandro chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2008-3-19 03:03:50", NULL, 970234, "Iván chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2008-3-20 03:03:50", NULL, 861812, "Celso chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2008-3-16 03:03:50", NULL, 541749, "Erick chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2008-3-17 03:03:50", NULL, 268869, "Alejandra chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2008-3-18 03:03:50", NULL, 341239, "Alejandro chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2008-3-19 03:03:50", NULL, 970239, "Iván chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2008-3-20 03:03:50", NULL, 861819, "Celso chocó saliendo de la chicharronera");

-- Terminadas concesionario 2 20
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",731898, "Teto chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",140594, "Pablito chocó un carrito");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",664449, "Pedro chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",586351, "Susana chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",894561, "Ingrid chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",586352, "Adrián chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",894563, "Mariana chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",334561, "Tiffany chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",236352, "Cristina chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2005-3-11 03:03:50", "2005-3-14 03:03:50",564563, "Carolina chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",731898, "Teto chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",140594, "Pablito chocó un carrito");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",664449, "Pedro chocó saliendo de la universidad");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",586351, "Susana chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",894561, "Ingrid chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",586352, "Adrián chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",894563, "Mariana chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",334561, "Tiffany chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",236352, "Cristina chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2007-3-11 03:03:50", "2007-3-14 03:03:50",564563, "Carolina chocó saliendo de la casa");

-- En curso conseionario 2 5
CALL AgregarReparacionCompleto("2008-3-20 03:03:50", NULL,586352, "Aymarú chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2008-3-20 03:03:50", NULL,894563, "Fernanda chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto("2008-3-20 03:03:50", NULL,334561, "Jhousen chocó saliendo de la casa");
CALL AgregarReparacionCompleto("2008-3-20 03:03:50", NULL,236352, "Jose chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto("2008-3-20 03:03:50", NULL,564563, "Bryan chocó saliendo de la casa");


-- Agrega mecánicos
-- Concesionario 1
CALL AgregarMecanicoCompleto("2008-12-10",500000,159,1);
CALL AgregarMecanicoCompleto("2010-1-15",800000,789,2);
CALL AgregarMecanicoCompleto("2016-2-20",700000,456,3);
CALL AgregarMecanicoCompleto("2017-3-03",200000,741,4);
CALL AgregarMecanicoCompleto("2015-4-22",900000,321,5);
-- Concesionaria 2
CALL AgregarMecanicoCompleto("2018-5-27",800000,987,6);
CALL AgregarMecanicoCompleto("2015-6-29",500000,951,7);
CALL AgregarMecanicoCompleto("2017-7-24",600000,333,8);
CALL AgregarMecanicoCompleto("2014-8-15",600000,123,9);
CALL AgregarMecanicoCompleto("2015-9-17",600000,147,10);


CALL AgregarReparacionXMecanico(1, 5, 5);
CALL AgregarReparacionXMecanico(1, 5, 1);
CALL AgregarReparacionXMecanico(1, 4, 5);
CALL AgregarReparacionXMecanico(2, 4, 8);
CALL AgregarReparacionXMecanico(2, 4, 9);
CALL AgregarReparacionXMecanico(3, 5, 4);
CALL AgregarReparacionXMecanico(3, 3, 10);
CALL AgregarReparacionXMecanico(3, 3, 7);
CALL AgregarReparacionXMecanico(3, 2, 5);
CALL AgregarReparacionXMecanico(4, 5, 10);
CALL AgregarReparacionXMecanico(4, 4, 6);
CALL AgregarReparacionXMecanico(5, 5, 7);
CALL AgregarReparacionXMecanico(5, 5, 10);
CALL AgregarReparacionXMecanico(5, 5, 1);
CALL AgregarReparacionXMecanico(5, 2, 9);
CALL AgregarReparacionXMecanico(6, 2, 3);
CALL AgregarReparacionXMecanico(6, 1, 10);
CALL AgregarReparacionXMecanico(7, 5, 8);
CALL AgregarReparacionXMecanico(7, 5, 2);
CALL AgregarReparacionXMecanico(7, 5, 1);
CALL AgregarReparacionXMecanico(8, 5, 5);
CALL AgregarReparacionXMecanico(8, 1, 9);
CALL AgregarReparacionXMecanico(8, 4, 3);
CALL AgregarReparacionXMecanico(9, 5, 3);
CALL AgregarReparacionXMecanico(9, 1, 10);
CALL AgregarReparacionXMecanico(10, 4, 7);
CALL AgregarReparacionXMecanico(10, 5, 8);
CALL AgregarReparacionXMecanico(10, 3, 3);
CALL AgregarReparacionXMecanico(10, 5, 4);
CALL AgregarReparacionXMecanico(11, 4, 10);
CALL AgregarReparacionXMecanico(11, 5, 2);
CALL AgregarReparacionXMecanico(12, 4, 10);
CALL AgregarReparacionXMecanico(12, 3, 4);
CALL AgregarReparacionXMecanico(12, 1, 5);
CALL AgregarReparacionXMecanico(13, 4, 1);
CALL AgregarReparacionXMecanico(13, 3, 10);
CALL AgregarReparacionXMecanico(13, 2, 9);
CALL AgregarReparacionXMecanico(14, 4, 6);
CALL AgregarReparacionXMecanico(14, 3, 6);
CALL AgregarReparacionXMecanico(14, 3, 7);
CALL AgregarReparacionXMecanico(15, 3, 6);
CALL AgregarReparacionXMecanico(15, 5, 10);
CALL AgregarReparacionXMecanico(15, 5, 2);
CALL AgregarReparacionXMecanico(15, 2, 6);
CALL AgregarReparacionXMecanico(16, 4, 6);
CALL AgregarReparacionXMecanico(16, 5, 4);
CALL AgregarReparacionXMecanico(16, 3, 3);
CALL AgregarReparacionXMecanico(16, 1, 5);
CALL AgregarReparacionXMecanico(17, 1, 10);
CALL AgregarReparacionXMecanico(17, 1, 1);
CALL AgregarReparacionXMecanico(17, 5, 4);
CALL AgregarReparacionXMecanico(17, 4, 1);
CALL AgregarReparacionXMecanico(18, 5, 1);
CALL AgregarReparacionXMecanico(18, 4, 5);
CALL AgregarReparacionXMecanico(18, 5, 3);
CALL AgregarReparacionXMecanico(18, 5, 2);
CALL AgregarReparacionXMecanico(19, 4, 3);
CALL AgregarReparacionXMecanico(19, 5, 2);
CALL AgregarReparacionXMecanico(19, 5, 9);
CALL AgregarReparacionXMecanico(19, 3, 4);
CALL AgregarReparacionXMecanico(20, 5, 10);
CALL AgregarReparacionXMecanico(20, 2, 2);
CALL AgregarReparacionXMecanico(20, 1, 8);
CALL AgregarReparacionXMecanico(20, 4, 1);
CALL AgregarReparacionXMecanico(21, 3, 7);
CALL AgregarReparacionXMecanico(21, 2, 3);
CALL AgregarReparacionXMecanico(22, 2, 4);
CALL AgregarReparacionXMecanico(22, 1, 7);
CALL AgregarReparacionXMecanico(22, 4, 9);
CALL AgregarReparacionXMecanico(23, 4, 1);
CALL AgregarReparacionXMecanico(23, 1, 2);
CALL AgregarReparacionXMecanico(23, 3, 3);
CALL AgregarReparacionXMecanico(23, 5, 1);
CALL AgregarReparacionXMecanico(24, 1, 4);
CALL AgregarReparacionXMecanico(24, 2, 7);
CALL AgregarReparacionXMecanico(25, 4, 4);
CALL AgregarReparacionXMecanico(25, 1, 2);
CALL AgregarReparacionXMecanico(25, 5, 8);
CALL AgregarReparacionXMecanico(25, 5, 8);
CALL AgregarReparacionXMecanico(26, 9, 6);
CALL AgregarReparacionXMecanico(26, 9, 1);
CALL AgregarReparacionXMecanico(26, 7, 3);
CALL AgregarReparacionXMecanico(27, 7, 6);
CALL AgregarReparacionXMecanico(27, 8, 7);
CALL AgregarReparacionXMecanico(28, 9, 1);
CALL AgregarReparacionXMecanico(28, 7, 8);
CALL AgregarReparacionXMecanico(28, 10, 5);
CALL AgregarReparacionXMecanico(29, 6, 6);
CALL AgregarReparacionXMecanico(29, 8, 2);
CALL AgregarReparacionXMecanico(29, 7, 2);
CALL AgregarReparacionXMecanico(29, 8, 4);
CALL AgregarReparacionXMecanico(30, 9, 2);
CALL AgregarReparacionXMecanico(30, 8, 7);
CALL AgregarReparacionXMecanico(30, 9, 8);
CALL AgregarReparacionXMecanico(31, 9, 8);
CALL AgregarReparacionXMecanico(31, 10, 4);
CALL AgregarReparacionXMecanico(31, 8, 4);
CALL AgregarReparacionXMecanico(32, 9, 6);
CALL AgregarReparacionXMecanico(32, 10, 7);
CALL AgregarReparacionXMecanico(32, 10, 8);
CALL AgregarReparacionXMecanico(33, 9, 9);
CALL AgregarReparacionXMecanico(33, 8, 8);
CALL AgregarReparacionXMecanico(33, 10, 7);
CALL AgregarReparacionXMecanico(34, 8, 9);
CALL AgregarReparacionXMecanico(34, 8, 9);
CALL AgregarReparacionXMecanico(35, 6, 10);
CALL AgregarReparacionXMecanico(35, 9, 4);
CALL AgregarReparacionXMecanico(36, 7, 5);
CALL AgregarReparacionXMecanico(36, 10, 6);
CALL AgregarReparacionXMecanico(36, 7, 9);
CALL AgregarReparacionXMecanico(36, 8, 9);
CALL AgregarReparacionXMecanico(37, 8, 8);
CALL AgregarReparacionXMecanico(37, 6, 1);
CALL AgregarReparacionXMecanico(37, 10, 8);
CALL AgregarReparacionXMecanico(37, 10, 3);
CALL AgregarReparacionXMecanico(38, 9, 2);
CALL AgregarReparacionXMecanico(38, 9, 5);
CALL AgregarReparacionXMecanico(39, 6, 8);
CALL AgregarReparacionXMecanico(39, 6, 10);
CALL AgregarReparacionXMecanico(40, 10, 9);
CALL AgregarReparacionXMecanico(40, 10, 5);
CALL AgregarReparacionXMecanico(41, 6, 10);
CALL AgregarReparacionXMecanico(41, 9, 4);
CALL AgregarReparacionXMecanico(41, 6, 7);
CALL AgregarReparacionXMecanico(42, 7, 1);
CALL AgregarReparacionXMecanico(42, 7, 8);
CALL AgregarReparacionXMecanico(42, 8, 5);
CALL AgregarReparacionXMecanico(43, 7, 6);
CALL AgregarReparacionXMecanico(43, 10, 4);
CALL AgregarReparacionXMecanico(44, 6, 5);
CALL AgregarReparacionXMecanico(44, 10, 7);
CALL AgregarReparacionXMecanico(44, 10, 6);
CALL AgregarReparacionXMecanico(44, 10, 8);
CALL AgregarReparacionXMecanico(45, 9, 9);
CALL AgregarReparacionXMecanico(45, 9, 8);
CALL AgregarReparacionXMecanico(45, 8, 8);
CALL AgregarReparacionXMecanico(46, 10, 9);
CALL AgregarReparacionXMecanico(46, 10, 1);
CALL AgregarReparacionXMecanico(47, 9, 4);
CALL AgregarReparacionXMecanico(47, 9, 5);
CALL AgregarReparacionXMecanico(47, 8, 4);
CALL AgregarReparacionXMecanico(47, 8, 6);
CALL AgregarReparacionXMecanico(48, 8, 4);
CALL AgregarReparacionXMecanico(48, 7, 4);
CALL AgregarReparacionXMecanico(49, 10, 4);
CALL AgregarReparacionXMecanico(49, 10, 1);
CALL AgregarReparacionXMecanico(49, 8, 2);
CALL AgregarReparacionXMecanico(50, 8, 4);
CALL AgregarReparacionXMecanico(50, 8, 7);


-- Agrega ventas
-- Concesionario 1
CALL AgregarCompraCompleto("2008-3-11 03:03:50",1, 11);
CALL AgregarCompraCompleto("2009-1-12 12:03:50",2, 13);
CALL AgregarCompraCompleto("2010-12-13 03:03:50",3, 14);
CALL AgregarCompraCompleto("2011-11-14 12:03:50",1, 15);
CALL AgregarCompraCompleto("2012-10-15 12:03:50",2, 16);
CALL AgregarCompraCompleto("2013-9-16 05:03:50",3, 17);
CALL AgregarCompraCompleto("2014-8-17 12:03:50",1, 18);
CALL AgregarCompraCompleto("2015-7-18 12:03:50",2, 19);
CALL AgregarCompraCompleto("2016-6-19 12:03:50",3, 20);
CALL AgregarCompraCompleto("2017-5-20 05:03:50",2, 21);
CALL AgregarCompraCompleto("2018-12-01 12:03:50",3, 22);
CALL AgregarCompraCompleto("2016-11-02 12:03:50",1, 23);
CALL AgregarCompraCompleto("2017-10-03 12:50:50",2, 24);
CALL AgregarCompraCompleto("2004-2-23 05:03:50",3, 25);
CALL AgregarCompraCompleto("2003-1-24 12:50:50",1, 26);
CALL AgregarCompraCompleto("2002-12-25 12:03:50",2, 27);
-- Concesionario 2
CALL AgregarCompraCompleto("2015-9-04 12:03:50",3, 40);
CALL AgregarCompraCompleto("2014-8-05 03:03:50",1, 41);
CALL AgregarCompraCompleto("2013-7-06 12:03:50",2, 42);
CALL AgregarCompraCompleto("2012-4-07 05:03:50",3, 45);
CALL AgregarCompraCompleto("2011-5-08 15:50:50",1, 46);
CALL AgregarCompraCompleto("2010-6-09 12:03:50",2, 47);
CALL AgregarCompraCompleto("2009-2-10 16:03:50",3, 48);
CALL AgregarCompraCompleto("2018-4-21 13:50:50",1, 49);
CALL AgregarCompraCompleto("2007-3-22 11:03:50",2, 50);



CALL ObtenerDireccionCompleta(2);



