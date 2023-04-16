{{ 
    config(
        MATERIALIZED = 'table'
    )
}}

WITH products_source AS 
(
    SELECT
        product_id
        , name
        , price
        , inventory
    FROM 
        {{ source('postgres', 'products') }}
)

SELECT
    ps.product_id
    , ps.name
    , ps.price
    , ps.inventory
FROM products_source ps