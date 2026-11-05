-- Pregunta 1: evolución mensual de pedidos y facturación
SELECT
  DATE_TRUNC('month', o.order_purchase_timestamp)::date AS mes,
  COUNT(DISTINCT o.order_id)                            AS pedidos,
  SUM(i.price)                                          AS facturacion,
  ROUND(SUM(i.price) / COUNT(DISTINCT o.order_id), 2)   AS ticket_promedio
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;