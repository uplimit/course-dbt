{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'promos') }} as promos
)

, rename_recast as (
    SELECT
        promo_id,
        discount,
        status
    FROM sources
)

select * from rename_recast