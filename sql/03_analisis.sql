-- Pregunta 1: evolución mensual de pedidos y facturación
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


-- Pregunta 2: top 10 categorías por facturación
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