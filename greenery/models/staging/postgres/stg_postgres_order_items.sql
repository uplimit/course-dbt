{{ config(materialized='table') }}

with src_order_items as (
    select * from {{ source('postgres','order_items' )}}
)

, renamed_recast AS (
    SELECT 
        ORDER_ID AS order_guid
        , PRODUCT_ID as product_id
        , QUANTITY as quantity
    FROM src_order_items
)

select * from renamed_recast