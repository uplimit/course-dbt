{{
    config(
        materialized = 'table'
        , unique_key = 'order_item_id'
    )
}}

select 
    oi.order_id 
    , oi. product_id 
    -- ToDo: ideally, the below surrogate key should be done using a macro
    , oi.order_id || '-' ||  oi. product_id as order_item_id
    , oi.quantity

from {{ source('postgres','order_items') }} oi