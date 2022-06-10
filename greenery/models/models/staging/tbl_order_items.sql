{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'order_items') }} as order_items
)

, rename_recast as (
    SELECT
        order_id,
        product_id,
        quantity
    FROM sources
)

select * from rename_recast