{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'products') }} as products
)

, rename_recast as (
    SELECT
        product_id,
        name as product_name,
        price,
        inventory
    FROM sources
)

select * from rename_recast