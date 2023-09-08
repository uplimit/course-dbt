{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'addresses') }} as addresses
)

, rename_recast as (
    SELECT
        address_id,
        address,
        zipcode,
        state,
        country

    FROM sources
)

select * from rename_recast