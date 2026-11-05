-- =============================================
-- 01_carga.sql
-- Importación de los CSV a PostgreSQL (base: olist)
-- =============================================
-- 8 tablas se importaron con el asistente de DBeaver (Importar datos -> CSV).
-- La tabla de reviews se creó manualmente porque los comentarios
-- contienen comillas y saltos de línea, y se importó con pgAdmin
-- (Import/Export: csv, header, quote ", escape ", UTF8).

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