{{
    config(
        materialized = 'table'
        , unique_key = 'address_id'
    )
}}

select 
    a.address_id
    , a.address
    , a.zipcode
    , a.state
    , a.country

from {{ source('greenery_sources','addresses') }} a