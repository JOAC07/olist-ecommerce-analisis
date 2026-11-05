-- consulta Pregunta 1: evolución mensual de pedidos y facturación
-- (se excluyen 2016 y sep-oct 2018 por datos incompletos)
SELECT
  DATE_TRUNC('month', o.order_purchase_timestamp)::date AS mes,
  COUNT(DISTINCT o.order_id)                            AS pedidos,
  SUM(i.price)                                          AS facturacion,
  ROUND(SUM(i.price) / COUNT(DISTINCT o.order_id), 2)   AS ticket_promedio
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY 1
ORDER BY 1;


-- consulta Pregunta 2: top 10 categorías por facturación
SELECT
  COALESCE(t.product_category_name_english, 'sin_categoria') AS categoria,
  COUNT(DISTINCT o.order_id)  AS pedidos,
  SUM(i.price)                AS facturacion,
  ROUND(100.0 * SUM(i.price) / SUM(SUM(i.price)) OVER (), 2) AS pct_facturacion
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON i.order_id = o.order_id
JOIN olist_products_dataset p    ON p.product_id = i.product_id
LEFT JOIN product_category_name_translation t
       ON t.product_category_name = p.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY facturacion DESC
LIMIT 10;

-- consulta Pregunta 3: facturación y ticket promedio por estado del cliente
SELECT
  c.customer_state                                    AS estado,
  COUNT(DISTINCT o.order_id)                          AS pedidos,
  SUM(i.price)                                        AS facturacion,
  ROUND(SUM(i.price) / COUNT(DISTINCT o.order_id), 2) AS ticket_promedio,
  ROUND(100.0 * SUM(i.price) / SUM(SUM(i.price)) OVER (), 2) AS pct_facturacion
FROM olist_orders_dataset o
JOIN olist_customers_dataset c   ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset i ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY facturacion DESC;

-- consulta Pregunta 5: puntaje promedio de reviews según puntualidad de la entrega
SELECT
  CASE
    WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'a_tiempo'
    WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date + INTERVAL '7 days' THEN 'tarde_1_a_7_dias'
    ELSE 'tarde_mas_7_dias'
  END                                AS puntualidad,
  COUNT(*)                           AS reviews,
  ROUND(AVG(r.review_score), 2)      AS score_prom,
  ROUND(100.0 * COUNT(*) FILTER (WHERE r.review_score <= 2) / COUNT(*), 2) AS pct_score_bajo
FROM olist_orders_dataset o
JOIN olist_order_reviews_dataset r ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 1
ORDER BY score_prom DESC;

-- consulta Pregunta 6: tasa de recompra
-- customer_id cambia en cada pedido; customer_unique_id identifica a la persona
WITH compras_por_cliente AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS cant_pedidos
  FROM olist_orders_dataset o
  JOIN olist_customers_dataset c ON c.customer_id = o.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY 1
)
SELECT
  COUNT(*)                                          AS clientes,
  COUNT(*) FILTER (WHERE cant_pedidos > 1)          AS clientes_recompra,
  ROUND(100.0 * COUNT(*) FILTER (WHERE cant_pedidos > 1) / COUNT(*), 2) AS pct_recompra,
  MAX(cant_pedidos)                                 AS max_pedidos_un_cliente
FROM compras_por_cliente;

-- consulta Pregunta 7: medios de pago, cuotas y monto promedio
SELECT
  p.payment_type                           AS medio_pago,
  COUNT(DISTINCT p.order_id)               AS pedidos,
  ROUND(100.0 * COUNT(DISTINCT p.order_id) / SUM(COUNT(DISTINCT p.order_id)) OVER (), 2) AS pct_pedidos,
  ROUND(AVG(p.payment_value), 2)           AS monto_prom,
  ROUND(AVG(p.payment_installments), 1)    AS cuotas_prom
FROM olist_order_payments_dataset p
JOIN olist_orders_dataset o ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY pedidos DESC;
