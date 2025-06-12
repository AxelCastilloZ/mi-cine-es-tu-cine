



--Axel


-- PROCEDIMIENTOS ALMACENADOS 

-- 1. Registrar la compra de un asiento para una película
ALTER PROCEDURE sp_registrar_compra_asiento
    @cliente_id INT,
    @dependiente_id INT,
    @metodo_pago_id INT,
    @funcion_id INT,
    @asiento_id INT,
    @precio INT,
    @tipo_pago_o_puntos VARCHAR(75)
AS
BEGIN
    BEGIN TRY
        DECLARE @asiento_funcion_id INT;

        INSERT INTO asiento_funcion (funcion_id, asiento_id, estado)
        VALUES (@funcion_id, @asiento_id, 'Reservado');

        SET @asiento_funcion_id = SCOPE_IDENTITY();

        INSERT INTO compra (cliente_id, dependiente_id, metodo_pago_id, canal)
        VALUES (@cliente_id, @dependiente_id, @metodo_pago_id, 'web');

        DECLARE @compra_id INT = SCOPE_IDENTITY();

        INSERT INTO tiquete (funcion_id, asiento_funcion_id, compra_id, precio, tipo_pago_o_puntos)
        VALUES (@funcion_id, @asiento_funcion_id, @compra_id, @precio, @tipo_pago_o_puntos);
    END TRY
    BEGIN CATCH
        RAISERROR('Error al registrar la compra del asiento.', 16, 1);
    END CATCH
END;
GO


-- 2. Películas en cartelera
ALTER PROCEDURE sp_peliculas_en_cartelera
AS
BEGIN
    BEGIN TRY
        SELECT DISTINCT p.titulo, c.fecha_inicio, c.fecha_fin
        FROM pelicula p
        JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
        JOIN funcion f ON pf.funcion_id = f.funcion_id
        JOIN cartelera c ON f.cartelera_id = c.cartelera_id
        WHERE GETDATE() BETWEEN c.fecha_inicio AND c.fecha_fin;
    END TRY
    BEGIN CATCH
        RAISERROR('Error al obtener las películas en cartelera.', 16, 1);
    END CATCH
END;
GO




-- 3. Asientos disponibles para una función
ALTER PROCEDURE sp_asientos_disponibles @funcion_id INT
AS
BEGIN
    BEGIN TRY
        SELECT a.asiento_id, a.fila, a.secuencia
        FROM asiento a
        JOIN sala s ON a.sala_id = s.sala_id
        JOIN funcion f ON f.sala_id = s.sala_id
        WHERE f.funcion_id = @funcion_id
        AND a.asiento_id NOT IN (
            SELECT asiento_id FROM asiento_funcion WHERE funcion_id = @funcion_id AND estado = 'Reservado'
        );
    END TRY
    BEGIN CATCH
        RAISERROR('Error al obtener los asientos disponibles.', 16, 1);
    END CATCH
END;
GO





-- 4. Crear o editar película
ALTER PROCEDURE sp_crear_editar_pelicula
    @pelicula_id INT = NULL,
    @titulo VARCHAR(50),
    @sinopsis VARCHAR(250),
    @duracion INT,
    @pais_origen VARCHAR(50),
    @imagen_url VARCHAR(250)
AS
BEGIN
    BEGIN TRY
        IF @pelicula_id IS NULL
        BEGIN
            INSERT INTO pelicula (titulo, sinopsis, duracion, pais_origen, imagen_url)
            VALUES (@titulo, @sinopsis, @duracion, @pais_origen, @imagen_url);
        END
        ELSE
        BEGIN
            UPDATE pelicula
            SET titulo = @titulo,
                sinopsis = @sinopsis,
                duracion = @duracion,
                pais_origen = @pais_origen,
                imagen_url = @imagen_url
            WHERE pelicula_id = @pelicula_id;
        END
    END TRY
    BEGIN CATCH
        RAISERROR('Error al crear o editar la película.', 16, 1);
    END CATCH
END;
GO






--PRUEBA DE SPS

EXEC sp_registrar_compra_asiento
    @cliente_id = 1,
    @dependiente_id = 2,
    @metodo_pago_id = 1,
    @funcion_id = 4,         
    @asiento_id = 1,        
    @precio = 2500,
    @tipo_pago_o_puntos = 'moneda';



EXEC sp_peliculas_en_cartelera;

EXEC sp_peliculas_mas_vendidas;

EXEC sp_asientos_disponibles @funcion_id = 4;


EXEC sp_crear_editar_pelicula
    @titulo = 'Interestelar',
    @sinopsis = 'Una misión interestelar busca un nuevo hogar para la humanidad.',
    @duracion = 169,
    @pais_origen = 'EE.UU.',
    @imagen_url = 'https://ejemplo.com/interestelar.jpg';



EXEC sp_crear_editar_pelicula
    @pelicula_id = 1, 
    @titulo = 'Matrix Reloaded',
    @sinopsis = 'Segunda parte de la saga Matrix.',
    @duracion = 138,
    @pais_origen = 'EE.UU.',
    @imagen_url = 'https://ejemplo.com/matrix2.jpg';