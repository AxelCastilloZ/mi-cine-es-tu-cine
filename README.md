
**Proyecto de Base de Datos.**
# mi-cine-es-tu-cine

## Descripción del Proyecto

Este sistema gestiona las funciones, películas, boletos, clientes, salas, asientos, puntos acumulables, compras y auditoría de un cine ficticio con sedes en Costa Rica. Actualmente, la venta es únicamente por boletería. Se busca digitalizar y normalizar el manejo de cartelera y ventas.

## Integrantes

- Axel Castillo Zuñiga 
- John Granados Rojas
- Brenda Paola Espinoza Matarrita

## Problemática Solucionada

- Registro digital de funciones y películas.
- Gestión de boletos por canal de compra.
- Validación y control de asientos por función.
- Registro de métodos de pago y puntos.
- Auditoría de acciones administrativas.
- Base de datos preparada para integración web o móvil.

## Funcionalidades implementadas

- Gestión de películas, funciones, asientos y salas
- Registro de compras con método de pago y asignación de asientos
- Sistema de puntos acumulables y canjeables
- Auditoría de operaciones clave
- Procedimientos almacenados:
  - `sp_registrar_compra_asiento`
  - `sp_peliculas_en_cartelera`
  - `sp_peliculas_mas_vendidas`
  - `sp_asientos_disponibles`
  - `sp_bloquear_asiento_temporal`
  - `sp_crear_editar_pelicula`
