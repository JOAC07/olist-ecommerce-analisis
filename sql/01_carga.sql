-- =============================================
-- 01_carga.sql
-- Importación de los CSV a PostgreSQL (base: olist)
-- =============================================
-- 5 tablas se importaron con el asistente de DBeaver (Importar datos -> CSV):
--   orders, order_payments, products, sellers, product_category_name_translation.
-- 4 tablas se importaron con pgAdmin (Import/Export: csv, header, quote ", escape ", UTF8):
--   order_reviews, customers, order_items, geolocation.
-- Motivo: el importador de DBeaver falló con la tabla de reviews (comentarios con
-- comillas y saltos de línea) y se interrumpió la carga de las tablas restantes.
-- La tabla de reviews se creó manualmente con tipos text para evitar límites de longitud.

DROP TABLE IF EXISTS olist_order_reviews_dataset;

CREATE TABLE olist_order_reviews_dataset (
    review_id               text,
    order_id                text,
    review_score            int,
    review_comment_title    text,
    review_comment_message  text,
    review_creation_date    timestamp,
    review_answer_timestamp timestamp
);