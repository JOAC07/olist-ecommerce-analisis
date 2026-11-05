# Análisis de E-commerce con SQL — Dataset Olist

Proyecto de portfolio de análisis de datos sobre ventas de un e-commerce brasileño, usando PostgreSQL.

## Herramientas
- PostgreSQL 18
- DBeaver / pgAdmin

## Datos
Dataset: [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

Los CSV no están incluidos en el repo. Para reproducir el proyecto:
1. Descargar el dataset desde Kaggle.
2. Descomprimir los 9 CSV en `data/`.
3. Ejecutar los scripts de `sql/` en orden.

## Estructura
- `data/` — CSV originales (no versionados)
- `sql/02_limpieza.sql` — conversión de tipos (fechas a timestamp, montos a numeric) y validaciones
- `sql/03_analisis.sql` — consultas de análisis

## Limpieza
- Sin registros duplicados.
- 2.963 pedidos no entregados.
- 2 pedidos con estado "delivered" sin fecha de entrega.

## Preguntas de negocio y hallazgos

### 1. ¿Cómo evolucionaron las ventas?
- Los pedidos crecieron de 750 (ene-2017) a ~7.000 mensuales en 2018.
- Pico en nov-2017 (7.289 pedidos), asociado al Black Friday.
- El ticket promedio bajó de ~149 a ~126: más volumen, pero de menor valor por pedido.
- Se excluyen 2016 y sep–oct 2018 por datos incompletos.

### 2. ¿Qué categorías generan más ingresos?
- Las 10 principales categorías concentran el 62,4% de la facturación; las 3 primeras, el 25,9%.
- health_beauty lidera (9,3% de la facturación, ticket ~143).
- watches_gifts tiene el ticket más alto del top (~212): factura casi lo mismo que health_beauty con 36% menos pedidos.
- bed_bath_table es la categoría con más pedidos (9.272), pero con ticket bajo (~110): volumen alto, valor bajo.

### 3. ¿Cómo se distribuyen las ventas por estado?
- São Paulo concentra ~42% de los pedidos y ~38% de la facturación.
- SP, RJ y MG suman ~63% de la facturación: alta concentración en el sudeste.
- SP tiene el ticket promedio más bajo (125); los estados del norte/nordeste, los más altos (PB 218, PA 184, CE 172).
- Hipótesis: en estados lejanos se compran productos de mayor valor porque el flete y la demora desincentivan compras chicas (a validar con el análisis de logística).

## Datos
Dataset: [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

Los CSV no están incluidos en el repo. Para reproducir el proyecto:
1. Descargar el dataset desde Kaggle.
2. Descomprimir los 9 CSV en `data/`.
3. Ejecutar los scripts de `sql/` en orden.