{{ config(materialized='table') }}

with src_products as (
    select * from {{ source('postgres','products' )}}
)

, renamed_recast as (
    SELECT
        PRODUCT_ID as product_guid
        , NAME as product_name
        , PRICE as product_price
        , INVENTORY as product_inventory
    from src_products
)

select * from renamed_recast