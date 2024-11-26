{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'order_items') }} as order_items
)

, rename_recast as (
    SELECT
        order_id,
        {{ dbt_utils.surrogate_key(['order_id', 'product_id']) }} as order_items_surrogate_key,
        product_id,
        quantity
    FROM sources
)

select * from rename_recast