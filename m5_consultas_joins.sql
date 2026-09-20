-- =============================================================================
-- ENTREGABLE MÓDULO 5: CONSULTAS CON JOINs Y VISTA DE NEGOCIO
-- Proyecto Integrador: RetailPro
-- Base de Datos: Ventas_Tech_DB
-- Archivo: m5_consultas_joins.sql
-- =============================================================================

USE Ventas_Tech_DB;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 1: VISTA PRINCIPAL DEL PROYECTO (INNER JOIN)
-- Cruzamos las 4 tablas para ver las ventas con el detalle del cliente,
-- el producto, la categoría y la ciudad en una sola tabla.
-- -----------------------------------------------------------------------------
SELECT 
    v.id_venta,
    v.fecha_venta,
    cl.id_cliente,
    cl.nombre AS cliente,
    cl.ciudad AS ciudad_cliente,
    p.id_producto,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes cl ON v.id_cliente = cl.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta ASC;

-- -----------------------------------------------------------------------------
-- CONSULTA 2: CLIENTES QUE TODAVÍA NO COMPRARON (LEFT JOIN)
-- Buscamos si hay clientes registrados que aún no tienen ninguna venta realizada.
-- -----------------------------------------------------------------------------
SELECT 
    cl.id_cliente,
    cl.nombre AS cliente,
    cl.email,
    cl.fecha_registro
FROM clientes cl
LEFT JOIN ventas v ON cl.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- -----------------------------------------------------------------------------
-- CONSULTA 3: PRODUCTOS QUE NO SE HAN VENDIDO (LEFT JOIN)
-- Buscamos qué artículos del catálogo no registran ninguna venta.
-- -----------------------------------------------------------------------------
SELECT 
    p.id_producto,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- -----------------------------------------------------------------------------
-- CONSULTA 4: TOTALES POR CANAL DE VENTA (UNION ALL)
-- Clasificamos las compras en 'Online' (hasta $200) y 'Presencial' (más de $200)
-- y sumamos los totales de cada canal.
-- -----------------------------------------------------------------------------
WITH VentasPorCanal AS (
    SELECT 
        id_venta,
        fecha_venta,
        (cantidad * precio_unitario) AS total_venta,
        'Online' AS canal
    FROM ventas
    WHERE (cantidad * precio_unitario) <= 200.00

    UNION ALL

    SELECT 
        id_venta,
        fecha_venta,
        (cantidad * precio_unitario) AS total_venta,
        'Presencial' AS canal
    FROM ventas
    WHERE (cantidad * precio_unitario) > 200.00
)
SELECT 
    canal,
    COUNT(id_venta) AS cantidad_ventas,
    SUM(total_venta) AS total_facturado
FROM VentasPorCanal
GROUP BY canal;

-- =============================================================================
-- HALLAZGOS Y CONCLUSIONES DEL ANÁLISIS (MÓDULO 5)
-- =============================================================================

-- Hallazgo 1: Unificación exitosa de los datos
-- Al cruzar las tablas con INNER JOIN se logró una sola vista limpia que combina
-- los datos de ventas con el nombre del cliente, su ciudad, el producto y su categoría.
-- Esta información queda lista para conectarse más adelante a Power BI.

-- Hallazgo 2: Estado de clientes e inventario
-- Al filtrar con LEFT JOIN e IS NULL se observa que todos los clientes registrados ya 
-- realizaron al menos una compra. Por parte del catálogo, el Teclado Mecánico es el único 
-- producto que no registró ventas en este período.

-- Hallazgo 3: Comportamiento por canal de venta
-- El canal Presencial concentra el mayor volumen de dinero porque ahí entran las compras 
-- de ticket alto, mientras que el canal Online junta operaciones más pequeñas pero frecuentes.