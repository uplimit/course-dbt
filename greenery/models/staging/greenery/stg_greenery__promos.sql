{{
    config(
        materialized = 'view'
    )
}}

with promo_source as (
    select * from {{ source('src_greenery__promos', 'promos') }}
)

, renamed_recast as (
    SELECT
    promo_id as promo_guid
    , discount
    , status as promo_status
    from promo_source
)

select * from renamed_recast