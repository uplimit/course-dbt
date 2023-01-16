{{ config(materialized='table') }}

with src_addresses as (
    select * from {{ source('postgres','addresses' )}}
)

, renamed_recast AS (
    SELECT 
        ADDRESS_ID AS address_guid
        , ADDRESS as address
        , ZIPCODE as zipcode
        , STATE as state
        , COUNTRY as country
    FROM src_addresses
)

select * from renamed_recast