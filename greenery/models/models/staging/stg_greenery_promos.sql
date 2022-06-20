{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'promos') }} as promos
)

, rename_recast as (
    SELECT
        promo_id as promo_code,
        discount,
        status
    FROM sources
)

select * from rename_recast