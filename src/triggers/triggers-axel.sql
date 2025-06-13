USE mi_cine_es_tu_cine
GO




-- 1 Evita insertar un tiquete si el asiento ya está reservado.
CREATE TRIGGER trg_prevenir_asiento_reservado
ON tiquete
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN asiento_funcion af ON i.asiento_funcion_id = af.asiento_funcion_id
        WHERE af.estado = 'Reservado'
    )
    BEGIN
        RAISERROR('El asiento ya está reservado.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        INSERT INTO tiquete (funcion_id, asiento_funcion_id, compra_id, precio, tipo_pago_o_puntos)
        SELECT funcion_id, asiento_funcion_id, compra_id, precio, tipo_pago_o_puntos
        FROM inserted;
    END
END;
GO




--2 Sumar puntos al cliente según el monto pagado en cada tiquete.
CREATE TRIGGER trg_sumar_puntos
ON tiquete
AFTER INSERT
AS
BEGIN
    
    UPDATE p
    SET acumulado = p.acumulado + pt.puntos_sumados,
        saldo = p.saldo + pt.puntos_sumados
    FROM puntos p
    JOIN (
        SELECT c.cliente_id, SUM(i.precio / 100) AS puntos_sumados
        FROM inserted i
        JOIN compra c ON c.compra_id = i.compra_id
        GROUP BY c.cliente_id
    ) pt ON p.cliente_id = pt.cliente_id;
END;
GO

select *from auditoria

--3 Para auditorias de pelicula
 CREATE TRIGGER trg_auditoria_pelicula
ON pelicula
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @usuario NVARCHAR(50) = SUSER_SNAME();
    DECLARE @accion NVARCHAR(20);
    DECLARE @descripcion NVARCHAR(100);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'UPDATE';
        SET @descripcion = 'Actualización en película';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @accion = 'INSERT';
        SET @descripcion = 'Inserción en película';
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'DELETE';
        SET @descripcion = 'Eliminación en película';
    END;

INSERT INTO auditoria (usuario, accion, tabla, fecha_hora, descripcion)
VALUES (@usuario, @accion, 'pelicula', GETDATE(), @descripcion);
END;

GO




--4 Auditoria para una nueva función
CREATE TRIGGER trg_auditoria_funcion
ON funcion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @usuario NVARCHAR(50) = SUSER_SNAME();
    DECLARE @accion NVARCHAR(20);
    DECLARE @descripcion NVARCHAR(100);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'UPDATE';
        SET @descripcion = 'Actualización en función';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @accion = 'INSERT';
        SET @descripcion = 'Inserción en función';
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'DELETE';
        SET @descripcion = 'Eliminación en función';
    END

    INSERT INTO auditoria (usuario, accion, tabla, fecha_hora, descripcion)
    VALUES (@usuario, @accion, 'funcion', GETDATE(), @descripcion);
END;
GO


-- 5 Auditoria para una nueva compra
CREATE TRIGGER trg_auditoria_compra
ON funcion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @usuario NVARCHAR(50) = SUSER_SNAME();
    DECLARE @accion NVARCHAR(20);
    DECLARE @descripcion NVARCHAR(100);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'UPDATE';
        SET @descripcion = 'Actualización en función';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @accion = 'INSERT';
        SET @descripcion = 'Inserción en función';
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'DELETE';
        SET @descripcion = 'Eliminación en función';
    END

    INSERT INTO auditoria (usuario, accion, tabla, fecha_hora, descripcion)
    VALUES (@usuario, @accion, 'compra', GETDATE(), @descripcion);
END;
GO



--6 Auditoria para ver cambios en puntos
CREATE TRIGGER trg_auditoria_puntos
ON funcion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @usuario NVARCHAR(50) = SUSER_SNAME();
    DECLARE @accion NVARCHAR(20);
    DECLARE @descripcion NVARCHAR(100);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'UPDATE';
        SET @descripcion = 'Actualización en función';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @accion = 'INSERT';
        SET @descripcion = 'Inserción en función';
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'DELETE';
        SET @descripcion = 'Eliminación en función';
    END

    INSERT INTO auditoria (usuario, accion, tabla, fecha_hora, descripcion)
    VALUES (@usuario, @accion, 'puntos', GETDATE(), @descripcion);
END;
GO



--7 Auditoria para ver si hay cambios en los tiqutes
CREATE TRIGGER trg_auditoria_tiquete
ON funcion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @usuario NVARCHAR(50) = SUSER_SNAME();
    DECLARE @accion NVARCHAR(20);
    DECLARE @descripcion NVARCHAR(100);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'UPDATE';
        SET @descripcion = 'Actualización en función';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @accion = 'INSERT';
        SET @descripcion = 'Inserción en función';
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @accion = 'DELETE';
        SET @descripcion = 'Eliminación en función';
    END

    INSERT INTO auditoria (usuario, accion, tabla, fecha_hora, descripcion)
    VALUES (@usuario, @accion, 'tiquete', GETDATE(), @descripcion);
END;
GO

--8 Trigger para cambiar de estado al asiento
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