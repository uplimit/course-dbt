{{
    config(
        materialized='view'
    )
}}

with promo_source as (
    select * from {{source('src_greenery','promos')}}

)

, renamed_recast as (
    select
     promo_id
     ,discount
     ,status
    from promo_source
)


select * from renamed_recast 