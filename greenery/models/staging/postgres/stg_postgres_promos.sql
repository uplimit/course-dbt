{{ config(materialized='table') }}

with src_promos as (
    select * from {{ source('postgres','promos' )}}
)

, renamed_recast as (
    SELECT
        PROMO_ID as product_guid
        , DISCOUNT as promo_discount
        , STATUS as promo_status
    from src_promos
)

select * from renamed_recast