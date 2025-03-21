CREATE TABLE comunidades (
  id_comunidad TINYINT NOT NULL,
  nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO comunidades (id_comunidad, nombre)
VALUES
	(1, 'Andalucía'),
	(2, 'Aragón'),
	(3, 'Principado de Asturias'),
	(4, 'Islas Baleares'),
	(5, 'Canarias'),
	(6, 'Cantabria'),
	(7, 'Castilla y León'),
	(8, 'Castilla-La Mancha'),
	(9, 'Cataluña'),
	(10, 'Comunidad Valenciana'),
	(11, 'Extremadura'),
	(12, 'Galicia'),
	(13, 'Comunidad de Madrid'),
	(14, 'Región de Murcia'),
	(15, 'Comunidad Foral de Navarra'),
	(16, 'País Vasco'),
	(17, 'La Rioja'),
	(18, 'Ceuta'),
	(19, 'Melilla');
