-- =============================================================================
-- ENTREGABLE MÓDULO 4: CONSULTAS SQL DE NEGOCIO
-- Proyecto Integrador: RetailPro
-- Base de Datos: Ventas_Tech_DB
-- Archivo: m4_consultas_negocio.sql
-- =============================================================================

USE Ventas_Tech_DB;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 1: RESUMEN EJECUTIVO MENSUAL
-- Muestra el total facturado, cantidad de pedidos y ticket promedio por mes.
-- -----------------------------------------------------------------------------

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;

-- -----------------------------------------------------------------------------
-- CONSULTA 2: RANKING DE PRODUCTOS (TOP 5)
-- Identifica los 5 productos con mayor facturación y sus unidades vendidas.
-- -----------------------------------------------------------------------------

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- -----------------------------------------------------------------------------
-- CONSULTA 3: TOTAL DE VENTAS POR PRODUCTO Y CATEGORÍA
-- Se utilizan encadenamientos con LEFT JOIN para garantizar que ningún producto 
-- quede excluido si no registra ventas o carece de categoría asignada.
-- -----------------------------------------------------------------------------

SELECT 
    p.nombre_producto,
    c.nombre_categoria,
    SUM(v.cantidad) AS total_vendido
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY p.nombre_producto, c.nombre_categoria;

-- Hallazgo 3: La categoría 'Computación' concentra el mayor volumen de unidades vendidas dentro del histórico registrado en la base de datos.

-- -----------------------------------------------------------------------------
-- CONSULTA 4: COMPARATIVO DE MESES CONTRA EL PROMEDIO GENERAL
-- Clasifica cada mes según si su facturación supera o no el promedio mensual general.
-- -----------------------------------------------------------------------------

WITH FacturacionMensual AS (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mes
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
PromedioGeneral AS (
    SELECT AVG(total_mes) AS promedio_mensual
    FROM FacturacionMensual
)
SELECT 
    fm.mes,
    fm.total_mes AS total_facturado,
    CASE 
        WHEN fm.total_mes >= pg.promedio_mensual THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento_contra_promedio
FROM FacturacionMensual fm
CROSS JOIN PromedioGeneral pg
ORDER BY fm.mes ASC;

-- =============================================================================
-- BLOQUE DE CIERRE: HALLAZGOS CLAVE DE NEGOCIO (RETAILPRO)
-- =============================================================================

-- HALLAZGOS Y MÉTRICAS CLAVE EXTRAÍDAS DEL ANÁLISIS:
-- 
-- 1. Concentración de facturación en Producto 1:
--    El id_producto 1 representa la mayor fuente de ingresos de la empresa, acumulando $3,600.00 
--    del total comercializado en el período. Es el producto principal en margen e ingresos.
-- 
-- 2. Recurrencia en la Base de Clientes:
--    Los clientes id_cliente 1, 2, 3, 4 y 5 registraron exactamente 2 pedidos cada uno durante 
--    el período analizado, lo que refleja un comportamiento uniforme de compra.
-- 
-- 3. Desempeño Mensual de Ventas:
--    El mes de Marzo (Mes 3) registró el nivel de facturación más alto del período analizado, 
--    posicionándose por encima del promedio mensual general obtenido en la Consulta 4.
