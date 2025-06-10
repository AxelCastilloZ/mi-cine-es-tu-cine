--Trigger que pone el asiento como "Reservado" al comprar un tiquete
CREATE TRIGGER trg_reservar_asiento
ON tiquete
AFTER INSERT
AS
BEGIN
    UPDATE asiento_funcion
    SET estado = 'Reservado'
    WHERE asiento_funcion_id IN (
        SELECT asiento_funcion_id FROM inserted
    );
END;
GO

--Guarda automáticamente en la tabla auditoria cada vez que se inserta un registro en la tabla pelicula
CREATE TRIGGER trg_auditoria_pelicula_insert
ON pelicula
AFTER INSERT
AS
BEGIN
    INSERT INTO auditoria (usuario, accion, tabla, descripcion)
    SELECT SYSTEM_USER, 'INSERT', 'pelicula', CONCAT('Película agregada: ', titulo)
    FROM inserted;
END;
GO

--Trigger de auditoría para eliminación de funciones
CREATE TRIGGER trg_auditoria_funcion_delete
ON funcion
AFTER DELETE
AS
BEGIN
    INSERT INTO auditoria (usuario, accion, tabla, descripcion)
    SELECT SYSTEM_USER, 'DELETE', 'funcion', CONCAT('Función eliminada ID: ', funcion_id)
    FROM deleted;
END;
GO