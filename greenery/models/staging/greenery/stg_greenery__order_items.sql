{{
    config(
        materialzed = 'view'
    )
}}

WITH order_items_source AS (
    SELECT 
        order_id
        , product_id
        , quantity
    FROM
        {{
            source('greenery', 'order_items')
        }}
)

, renamed_casted AS (
    SELECT
        order_id AS order_guid
        , product_id AS product_guid
        , quantity
    FROM 
        order_items_source  
)

SELECT 
    order_guid
    , product_guid
    , quantity
FROM 
    renamed_casted