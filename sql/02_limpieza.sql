-- =============================================
-- 02_limpieza.sql
-- Proyecto: Análisis E-commerce Olist
-- Objetivo: corregir tipos de datos después de importar los CSV
-- =============================================

-- 1. Fechas de pedidos: texto -> timestamp
ALTER TABLE olist_orders_dataset
  ALTER COLUMN order_purchase_timestamp      TYPE timestamp USING NULLIF(order_purchase_timestamp, '')::timestamp,
  ALTER COLUMN order_approved_at             TYPE timestamp USING NULLIF(order_approved_at, '')::timestamp,
  ALTER COLUMN order_delivered_carrier_date  TYPE timestamp USING NULLIF(order_delivered_carrier_date, '')::timestamp,
  ALTER COLUMN order_delivered_customer_date TYPE timestamp USING NULLIF(order_delivered_customer_date, '')::timestamp,
  ALTER COLUMN order_estimated_delivery_date TYPE timestamp USING NULLIF(order_estimated_delivery_date, '')::timestamp;

-- 2. Items: fecha límite de envío y montos -> timestamp / numeric
ALTER TABLE olist_order_items_dataset
  ALTER COLUMN shipping_limit_date TYPE timestamp     USING NULLIF(shipping_limit_date, '')::timestamp,
  ALTER COLUMN price               TYPE numeric(10,2) USING price::numeric(10,2),
  ALTER COLUMN freight_value       TYPE numeric(10,2) USING freight_value::numeric(10,2);

-- 3. Pagos: monto -> numeric
ALTER TABLE olist_order_payments_dataset
  ALTER COLUMN payment_value TYPE numeric(10,2) USING payment_value::numeric(10,2);