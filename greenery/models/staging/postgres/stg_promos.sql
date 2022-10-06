{{ config(materialized='table') }}

SELECT
 promo_id,
discount,
status
FROM {{ source('_postgres__sources', 'promos')}} promos