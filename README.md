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

### 4. ¿Cómo es el desempeño logístico?
- Entrega promedio: 12,6 días vs 23,7 días estimados. La estimación es muy conservadora (casi el doble del tiempo real).
- Solo el 8,1% de los pedidos llega después de la fecha estimada.
- Los estados del norte tienen las entregas más lentas (RR 29 días, AP 27, AM 26), más del doble del promedio, pero con pocas demoras porque su estimación es aún más holgada.
- Alagoas (23,9%) y Maranhão (19,7%) tienen las tasas de entregas tarde más altas, casi 3 veces el promedio.
- Oportunidad: ajustar las estimaciones por región y revisar la logística en el nordeste.

### 5. ¿La demora en la entrega afecta la satisfacción?
- Sí, de forma directa. Score promedio: 4,29 (a tiempo) → 3,18 (1-7 días tarde) → 1,73 (más de 7 días tarde).
- Las reviews negativas (1-2 estrellas) pasan del 9% al 78% cuando la demora supera una semana: 8,5 veces más probabilidad de una mala review.
- Conclusión: la puntualidad es el principal driver de satisfacción. Mejorar la logística en los estados con más entregas tarde (AL, MA) tendría impacto directo en la reputación.

### 6. ¿Qué porcentaje de clientes vuelve a comprar?
- De 93.358 clientes únicos, solo 2.801 (3%) realizaron más de una compra.
- El 97% compró una única vez: el crecimiento depende casi por completo de captar clientes nuevos.
- Oportunidad: estrategias de retención (email marketing, cupones post-compra, programa de fidelización). Mejorar la puntualidad de entrega (ver pregunta 5) también podría impactar en la recompra.

### 6. ¿Qué porcentaje de clientes vuelve a comprar?
- De 93.358 clientes únicos, solo 2.801 (3%) realizaron más de una compra.
- El 97% compró una única vez: el crecimiento depende casi por completo de captar clientes nuevos.
- Oportunidad: estrategias de retención (email marketing, cupones post-compra, programa de fidelización). Mejorar la puntualidad de entrega (ver pregunta 5) también podría impactar en la recompra.

## Conclusiones principales
1. **Crecimiento fuerte pero con menor ticket**: los pedidos se multiplicaron ~9 veces en 2017-2018, mientras el ticket promedio bajó de ~149 a ~126.
2. **La puntualidad define la satisfacción**: con más de 7 días de demora, las reviews negativas pasan del 9% al 78%.
3. **Retención muy baja**: solo el 3% de los clientes vuelve a comprar.
4. **Alta concentración geográfica**: SP, RJ y MG suman ~63% de la facturación; el nordeste tiene los peores índices de entrega tarde.
5. **Recomendaciones**: ajustar las estimaciones de entrega por región, mejorar la logística en el nordeste y desarrollar estrategias de recompra.

## Datos
Dataset: [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

Los CSV no están incluidos en el repo. Para reproducir el proyecto:
1. Descargar el dataset desde Kaggle.
2. Descomprimir los 9 CSV en `data/`.
3. Ejecutar los scripts de `sql/` en orden.