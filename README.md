# Proyecto Integrador - RetailPro

Este repositorio contiene la documentación y el desarrollo técnico del proyecto integrador **RetailPro**, enfocado en la gestión, limpieza, modelado y análisis de datos de ventas para la empresa TechDB.

---

## 📌 Progreso y Resumen de Entregas

### Módulo 3: Base de Datos Relacional
- Diseñé y creé la base de datos `Ventas_Tech_DB` en PostgreSQL.
- Definí la estructura de tablas primarias (`clientes`, `productos`, `ventas`, `categorias`) aplicando restricciones de claves primarias y foráneas para asegurar la integridad referencial.

### Módulo 4: Consultas Avanzadas en SQL
- Desarrollé consultas SQL estructuradas utilizando combinaciones `INNER JOIN`, `LEFT JOIN` y `UNION ALL` para cruzar información entre ventas, productos y categorías.
- Documenté los scripts utilizando exclusivamente el formato de comentarios estándar `--`.
- Formulé hallazgos de negocio basados de manera estricta en los datos reales del dataset.

### Módulo 5: Control de Versiones y Repositorio
- Organicé la estructura del proyecto en GitHub para asegurar la trazabilidad del código y los datasets.
- Centralicé el script SQL (`Modulo4_Consultas.sql`) y el dataset base para mantener un historial limpio de cambios.

### Módulo 6: Pipeline ETL y Modelado en Power BI
- Importé el dataset `Pipeline_ETL_Dataset.xlsx` a Power Query para iniciar la fase de extracción y transformación.
- Realicé el perfilado de datos: eliminé duplicados en claves primarias, gestioné valores nulos en columnas descriptivas y ajusté los tipos de datos en cada tabla.
- Renombré las tablas siguiendo una nomenclatura dimensional estándar: `Dim_Clientes`, `Dim_Productos`, `Dim_Categorias` y `Fact_Ventas`.
- Integré la información del producto en la tabla de hechos mediante un cruce de consultas (Merge / `LEFT JOIN`) y expandí solo las columnas necesarias (`nombre_producto` y `categoria`).
- Documenté cada paso del flujo ETL en el Editor Avanzado mediante comentarios en lenguaje M (`//`).
- Guardé y publiqué el archivo final del modelo: `Pipeline_ETL_Pimienta_Vanessa.pbix`.
