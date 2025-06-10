use mi_cine_es_tu_cine
go




-- Evita insertar un tiquete si el asiento ya está reservado.
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








-- Sumar puntos al cliente según el monto pagado en cada tiquete.
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
