{{ config(materialized='table') }}

with product as (
    select
    *
    from {{ref('src_products')}}
)



SELECT
    product_guid
    ,product_name
    ,price as product_price
    ,inventory as product_inventory
FROM product
