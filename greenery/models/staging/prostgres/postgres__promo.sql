{{
    config(
        materialized = 'table'
        , unique_key = 'promo_id'
    )
}}

select 
    p.promo_id
    , p.discount
    , p.status

from {{ source('greenery_sources','promos') }} p