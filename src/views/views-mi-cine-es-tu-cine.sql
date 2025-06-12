USE mi_cine_es_tu_cine
GO

--#1 Para ver peliculas que estan en cartelera
CREATE VIEW vw_peliculas_cartelera AS
SELECT
    p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
    f.fecha,
    f.hora,
    s.nombre_sala,
    s.ubicacion
FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN funcion f ON pf.funcion_id = f.funcion_id
INNER JOIN sala s ON f.sala_id = s.sala_id
INNER JOIN cartelera c ON f.cartelera_id = c.cartelera_id
WHERE GETDATE() BETWEEN c.fecha_inicio AND c.fecha_fin;
GO

--#2 Para visulalizar actores que participan en esas peliculas
CREATE VIEW vw_pelicula_actor AS
SELECT 
	p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
	a.nombre_actor,
	a.nacionalidad

	FROM pelicula p

	INNER JOIN pelicula_actor pa ON p.pelicula_id = pa.pelicula_id
	INNER JOIN actor a ON pa.actor_id = a.actor_id
	GO

--#3 Para visualizar los asientos que tiene cada sala
CREATE VIEW vw_sala_asientos AS
SELECT 
	s.sala_id,
	s.ubicacion,
	s.nombre_sala,
	a.asiento_id,
	a.fila,
	a.secuencia
	FROM sala s
	LEFT JOIN asiento a ON s.sala_id = a.sala_id
GO


--#4 Para poder ver los asientos disponibles solo si están en el estado de libre
CREATE VIEW vw_asiento_disponibles AS
SELECT
    af.asiento_funcion_id,
    a.fila,
    a.secuencia,
    s.nombre_sala,
    f.fecha,
    f.hora
FROM asiento_funcion af
INNER JOIN asiento a ON af.asiento_id = a.asiento_id
INNER JOIN funcion f ON af.funcion_id = f.funcion_id
INNER JOIN sala s ON f.sala_id = s.sala_id
WHERE af.estado = 'Libre';
GO


--#5 Realiza un conteo de cuales peliculas son las más vendidas 
CREATE VIEW vw_peliculas_mas_vendidas AS
SELECT 
	p.titulo,
	COUNT(t.tiquete_id) AS cantidad_ventas

FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN tiquete t ON pf.funcion_id = t.funcion_id
GROUP BY p.titulo
GO

--#Para ver las vistas en el orden deseado
SELECT *
FROM vw_peliculas_mas_vendidas
ORDER BY cantidad_ventas DESC;
GO

--#6 Ver subtitulo e idioma de una pelicula
CREATE VIEW vw_pelicula_sub_idioma AS
SELECT 
	p.pelicula_id,
	p.titulo,
	pl.idioma,
	ps.subtitulo

FROM pelicula p
LEFT JOIN pelicula_idioma pl ON p.pelicula_id = pl.pelicula_id
LEFT JOIN pelicula_subtitulo ps ON p.pelicula_id = ps.pelicula_id
GO


--#7 Para ver los puntos que tiene el cliente
CREATE VIEW vw_cliente_puntos AS
SELECT 
	c.cliente_id,
	CONCAT(c.nombre_cliente, ' ', ISNULL(c.apellido,''), ' ', ISNULL(c.segundo_apellido, '')) AS nombre_completo,
	p.acumulado,
	p.canjeado,
	p.saldo
FROM cliente c
INNER JOIN puntos p ON c.cliente_id = p.cliente_id;
GO

--#8 para ver metodos de pago en compra
CREATE VIEW vw_metodo_pago_compra AS
SELECT 
	c.compra_id,
	CONCAT_WS(' ', cl.nombre_cliente, cl.apellido, cl.segundo_apellido) AS nombre_cliente,
	mp.tipo AS tipo_pago,
	mp.detalles AS detalles_pago,
	c.canal
FROM compra c
LEFT JOIN cliente cl ON c.cliente_id = cl.cliente_id
INNER JOIN metodo_de_pago mp ON c.metodo_pago_id = mp.metodo_pago_id
GO

SELECT * 
FROM vw_metodo_pago_compra
GO


--#9 Para visualizar compra mas a detalle 
CREATE VIEW vw_compra_tiquete_dependiente AS
SELECT 
	c.compra_id,
	CONCAT_WS(' ', cl.nombre_cliente, cl.apellido, cl.segundo_apellido) AS nombre_cliente,
	d.nombre_dependiente,
	c.canal,
	mp.tipo AS tipo_pago,
	mp.detalles AS detalles_pago,
	t.precio,
	t.tipo_pago_o_puntos

FROM compra c

LEFT JOIN cliente cl ON c.cliente_id = cl.cliente_id
INNER JOIN metodo_de_pago mp ON c.metodo_pago_id = mp.metodo_pago_id
INNER JOIN dependiente d ON c.dependiente_id = d.dependiente_id
INNER JOIN tiquete t ON c.compra_id = t.compra_id
GO


--#10 Vista tabla auditoria
CREATE VIEW vw_auditoria AS
SELECT 
	a.auditoria_id,
	a.usuario,
	a.accion,
	a.tabla AS tabla_afectada,
	a.fecha_hora,
	a.descripcion

FROM auditoria a

GO


--#11 Ver auditoria de menos de un mes 
CREATE VIEW vw_auditoria_reciente AS
SELECT 
    a.auditoria_id,
    a.usuario,
    a.accion,
    a.tabla AS tabla_afectada,
    a.fecha_hora,
    a.descripcion
FROM auditoria a
WHERE fecha_hora >= DATEADD(MONTH, -1, GETDATE());
GO


--#12 Para ver todo desde compra
CREATE VIEW vw_compra_todo AS
SELECT
	c.compra_id,
	CONCAT_WS(' ', cl.nombre_cliente, cl.apellido, cl.segundo_apellido) AS nombre_cliente,
	d.nombre_dependiente,
	c.canal,
	mp.tipo AS tipo_pago,
	mp.detalles AS detalles_pago,
	t.precio,
	t.tipo_pago_o_puntos,
	df.hora,
	df.fecha,
	s.nombre_sala,
	s.ubicacion,
	ass.fila,
	ass.secuencia,
	p.titulo,
	p.sinopsis,
	p.duracion,
	p.pais_origen,
	p.imagen_url,
	pl.idioma,
	ps.subtitulo,
	a.nombre_actor,
	a.nacionalidad,
	pcs.nombre_categoria

FROM compra c

LEFT JOIN cliente cl ON c.cliente_id = cl.cliente_id
INNER JOIN metodo_de_pago mp ON c.metodo_pago_id = mp.metodo_pago_id
INNER JOIN dependiente d ON c.dependiente_id = d.dependiente_id
INNER JOIN tiquete t ON c.compra_id = t.compra_id
INNER JOIN funcion df ON t.funcion_id = df.funcion_id
INNER JOIN sala s ON df.sala_id = s.sala_id
INNER JOIN asiento ass ON s.sala_id = ass.sala_id
INNER JOIN pelicula_funcion pf ON df.funcion_id = pf.funcion_id
INNER JOIN pelicula p ON pf.pelicula_id = p.pelicula_id
INNER JOIN pelicula_idioma pl ON p.pelicula_id = pl.pelicula_id
INNER JOIN pelicula_subtitulo ps ON p.pelicula_id = ps.pelicula_id
INNER JOIN pelicula_actor pa ON p.pelicula_id = pa.pelicula_id
INNER JOIN actor a ON pa.actor_id = a.actor_id
INNER JOIN pelicula_categoria pc ON p.pelicula_id = pc.pelicula_id
INNER JOIN categoria pcs ON pc.pelicula_id = pcs.categoria_id

GO



--13 Peliculas en cartelera mas sus actores e idiomas
CREATE VIEW vw_pelicula_cartelera_isa AS
SELECT
    p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
	pl.idioma,
	ps.subtitulo,
	a.nombre_actor,
	a.nacionalidad,
	cs.nombre_categoria,
    f.fecha,
    f.hora,
    s.nombre_sala,
    s.ubicacion
FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN funcion f ON pf.funcion_id = f.funcion_id
INNER JOIN pelicula_idioma pl ON p.pelicula_id = pl.pelicula_id
INNER JOIN pelicula_subtitulo ps ON p.pelicula_id = ps.pelicula_id
INNER JOIN pelicula_actor pa ON p.pelicula_id = pa.pelicula_id
INNER JOIN actor a ON pa.actor_id = a.actor_id
INNER JOIN pelicula_categoria pc ON p.pelicula_id = pc.pelicula_id
INNER JOIN categoria cs ON pc.categoria_id = cs.categoria_id
INNER JOIN sala s ON f.sala_id = s.sala_id
INNER JOIN cartelera c ON f.cartelera_id = c.cartelera_id
WHERE GETDATE() BETWEEN c.fecha_inicio AND c.fecha_fin;
GO


--#14 Pelicula con sus asientos funcion
CREATE VIEW vw_pelicula_sala_asiento_funcion AS

SELECT
    p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
    f.fecha,
    f.hora,
    s.nombre_sala,
    s.ubicacion,
	a.fila,
	a.secuencia,
	af.estado

FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN funcion f ON pf.funcion_id = f.funcion_id
INNER JOIN sala s ON f.sala_id = s.sala_id
INNER JOIN asiento a ON s.sala_id = a.sala_id 
INNER JOIN asiento_funcion af ON f.funcion_id = af.funcion_id
GO
