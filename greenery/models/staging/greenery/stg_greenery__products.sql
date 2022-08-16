{{
    config(
        materialzed = 'view'
    )
}}

WITH products_source AS (
    SELECT
        product_id
        , name
        , price
        , inventory
    FROM
        {{
            source('greenery', 'products')
        }}
)

, renamed_casted AS (
    SELECT
        product_id AS product_id_guid
        , name
        , price
        , inventory
    FROM 
        products_source  
)

SELECT 
        product_id_guid
        , name
        , price
        , inventory
FROM 
    renamed_casted
