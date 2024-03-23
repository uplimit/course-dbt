{{
    config(
        materialized = 'table'
        , unique_key = 'product_id'
    )
}}

select 
    p.product_id
    , p.name
    , p.price
    , p.inventory

from {{ source('greenery_sources','products') }} p