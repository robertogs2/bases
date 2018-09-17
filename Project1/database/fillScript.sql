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
CALL AgregarCoche(579390, 13, "gris", "usado", 22, 1);
CALL AgregarCoche(664449, 16, "morado", "usado", 69, 2);
CALL AgregarCoche(707522, 16, "gris", "usado", 152, 1);
CALL AgregarCoche(505354, 14, "gris", "usado", 195, 2);
CALL AgregarCoche(503249, 7, "amarillo", "usado", 224, 1);
CALL AgregarCoche(631613, 13, "azul", "nuevo", 0, 1);
CALL AgregarCoche(850940, 11, "café", "usado", 46, 1);
CALL AgregarCoche(586351, 4, "blanco", "nuevo", 0, 2);
CALL AgregarCoche(541747, 15, "azul", "nuevo", 0, 1);
CALL AgregarCoche(268864, 6, "gris", "usado", 139, 1);
CALL AgregarCoche(341232, 8, "negro", "usado", 192, 1);
CALL AgregarCoche(970234, 19, "café", "nuevo", 0, 1);
CALL AgregarCoche(861812, 19, "azul", "nuevo", 0, 1);
CALL AgregarCoche(361906, 7, "amarillo", "usado", 369, 1);
CALL AgregarCoche(926391, 10, "amarillo", "usado", 172, 1);
CALL AgregarCoche(528327, 9, "verde", "usado", 214, 1);
CALL AgregarCoche(894561, 3, "blanco", "nuevo", 0, 2);
CALL AgregarCoche(596659, 7, "verde", "usado", 69, 2);
CALL AgregarCoche(664913, 14, "amarillo", "usado", 326, 1);
CALL AgregarCoche(868067, 5, "negro", "nuevo", 0, 1);
CALL AgregarCoche(507161, 4, "café", "usado", 331, 2);
CALL AgregarCoche(489255, 11, "verde", "nuevo", 0, 2);
CALL AgregarCoche(859814, 6, "café", "nuevo", 0, 1);
CALL AgregarCoche(952273, 11, "morado", "usado", 355, 1);
CALL AgregarCoche(905678, 8, "negro", "usado", 332, 1);
CALL AgregarCoche(730815, 5, "azul", "usado", 354, 1);
CALL AgregarCoche(334096, 16, "azul", "usado", 33, 1);
CALL AgregarCoche(603761, 6, "verde", "nuevo", 0, 1);
CALL AgregarCoche(355078, 11, "verde", "usado", 326, 1);
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
CALL AgregarCoche(395597, 13, "morado", "usado", 118, 1);
CALL AgregarCoche(264861, 5, "café", "usado", 37, 2);
CALL AgregarCoche(883736, 16, "negro", "nuevo", 0, 1);
CALL AgregarCoche(708862, 14, "amarillo", "usado", 168, 1);
CALL AgregarCoche(663976, 10, "café", "nuevo", 0, 2);
CALL AgregarCoche(847236, 5, "blanco", "nuevo", 0, 2);
CALL AgregarCoche(908781, 4, "café", "usado", 400, 1);
CALL AgregarCoche(244835, 20, "amarillo", "nuevo", 0, 1);
CALL AgregarCoche(834463, 1, "azul", "usado", 164, 1);


-- Agrega personas
CALL AgregarPersona(123,"Celso", "Borges Mora", 22,88996633, 403, 1 );
CALL AgregarPersona(147,"Andres", "Campos Castro", 69,79463521, 512, 2 );
CALL AgregarPersona(159,"Teto", "Gutierrez Sánchez", 50,67924359, 256, 3 );
CALL AgregarPersona(789,"Alejandro", "Calvo Porras", 18,87642025, 128, 4 );
CALL AgregarPersona(456,"Iván", "Calvo Alverts", 33,79852630, 064, 4 );
CALL AgregarPersona(741,"Allan", "Navarro Brenes", 40,78945612, 032, 1 );
CALL AgregarPersona(321,"Crisptofer", "Fernández Fernández", 26,89764532, 016, 2 );
CALL AgregarPersona(987,"Jimena", "Salas Alfaro", 22,69325896, 008, 3 );
CALL AgregarPersona(951,"Alejandra", "Monterrey Arguedas", 23,74125896, 004, 4 );
CALL AgregarPersona(333,"Erick", "Muñoz Alvarado", 20,70118002, 002, 1 );
CALL AgregarPersona(205,"Raúl", "Madrigal Acuña", 26,70310065, 001, 2 );
CALL AgregarPersona(258,"Ignacio", "Mora Jiménez", 28,86865320, 000, 3 );


-- Agrega clientes
CALL AgregarClientePorCedula(205);
CALL AgregarClientePorCedula(258);

-- Agrega mecánicos
CALL AgregarMecanicoCompleto("2008-12-10",500000,159,1);
CALL AgregarMecanicoCompleto("2010-1-15",800000,789,2);
CALL AgregarMecanicoCompleto("2016-2-20",700000,456,3);
CALL AgregarMecanicoCompleto("2017-3-03",200000,741,4);
CALL AgregarMecanicoCompleto("2015-4-22",900000,321,5);

CALL AgregarMecanicoCompleto("2018-5-27",800000,987,6);
CALL AgregarMecanicoCompleto("2015-6-29",500000,951,7);
CALL AgregarMecanicoCompleto("2017-7-24",600000,333,8);
CALL AgregarMecanicoCompleto("2014-8-15",600000,123,9);
CALL AgregarMecanicoCompleto("2015-9-17",600000,147,10);


-- Agrega reparaciones
CALL AgregarReparacionCompleto(1, "Nacho chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(2, "Pancho chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(3, "Andrés chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(4, "Crisptofer chocó saliendo de la casa");
CALL AgregarReparacionCompleto(5, "Raúl chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(6, "Erick chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(7, "Alejandra chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(8, "Alejandro chocó saliendo de la casa");
CALL AgregarReparacionCompleto(9, "Iván chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(10, "Celso chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(11, "Teto chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(12, "Pablito chocó un carrito");
CALL AgregarReparacionCompleto(13, "Pedro chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(14, "Susana chocó saliendo de la casa");
CALL AgregarReparacionCompleto(15, "Ingrid chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(16, "Adrián chocó saliendo de la casa");
CALL AgregarReparacionCompleto(17, "Mariana chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(18, "Tiffany chocó saliendo de la casa");
CALL AgregarReparacionCompleto(19, "Cristina chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(20, "Carolina chocó saliendo de la casa");
CALL AgregarReparacionCompleto(21, "Aymarú chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(22, "Fernanda chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(23, "Jhousen chocó saliendo de la casa");
CALL AgregarReparacionCompleto(24, "Jose chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(25, "Bryan chocó saliendo de la casa");
CALL AgregarReparacionCompleto(26, "Chaco chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(27, "Juan chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(28, "Sebastián chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(29, "Allan chocó saliendo de la casa");
CALL AgregarReparacionCompleto(30, "Pablo chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(31, "Ángel chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(32, "Daniel chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(33, "Melissa chocó saliendo de la casa");
CALL AgregarReparacionCompleto(34, "Óscar chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(35, "Kenneth chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(36, "Karen chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(37, "María chocó un carrito");
CALL AgregarReparacionCompleto(38, "Mauricio chocó saliendo de la universidad");
CALL AgregarReparacionCompleto(39, "Milton chocó saliendo de la casa");
CALL AgregarReparacionCompleto(40, "Jeff chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(41, "Carlos chocó saliendo de la casa");
CALL AgregarReparacionCompleto(42, "Belinda chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(43, "Gabriela chocó saliendo de la casa");
CALL AgregarReparacionCompleto(44, "Gregory chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(45, "Jorman chocó saliendo de la casa");
CALL AgregarReparacionCompleto(46, "Saúl chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(47, "Fernando chocó saliendo de la chicharronera");
CALL AgregarReparacionCompleto(48, "Érika chocó saliendo de la casa");
CALL AgregarReparacionCompleto(49, "Alexander chocó saliendo de la concesionaria");
CALL AgregarReparacionCompleto(50, "Chino chocó saliendo de la casa");

-- Agrega ventas
CALL AgregarCompra("2018-12-01",30000000,1,1,1);
CALL AgregarCompra("2016-11-02",40000000,2,1,2);
CALL AgregarCompra("2017-10-03",50000000,1,1,3);
CALL AgregarCompra("2015-9-04",60000000,2,1,4);
CALL AgregarCompra("2014-8-05",70000000,1,1,5);
CALL AgregarCompra("2013-7-06",80000000,2,1,6);
CALL AgregarCompra("2012-4-07",90000000,1,1,7);
CALL AgregarCompra("2011-5-08",100000000,2,1,8);
CALL AgregarCompra("2010-6-09",110000000,1,1,9);
CALL AgregarCompra("2009-2-10",120000000,2,1,10);
CALL AgregarCompra("2008-3-11",130000000,1,1,11);
CALL AgregarCompra("2009-1-12",25000000,2,1,12);
CALL AgregarCompra("2010-12-13",20000000,1,1,13);
CALL AgregarCompra("2011-11-14",15000000,2,1,14);
CALL AgregarCompra("2012-10-15",1000000,1,2,15);
CALL AgregarCompra("2013-9-16",2000000,2,2,16);
CALL AgregarCompra("2014-8-17",1000000,1,2,17);
CALL AgregarCompra("2015-7-18",9000000,2,2,18);
CALL AgregarCompra("2016-6-19",8000000,1,2,19);
CALL AgregarCompra("2017-5-20",7000000,2,2,20);
CALL AgregarCompra("2018-4-21",6000000,1,2,21);
CALL AgregarCompra("2007-3-22",5000000,2,2,22);
CALL AgregarCompra("2004-2-23",4000000,1,2,23);
CALL AgregarCompra("2003-1-24",3000000,2,2,24);
CALL AgregarCompra("2002-12-25",2000000,1,2,25);


CALL ObtenerDireccionCompleta(2);



