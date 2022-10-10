{{ config(materialized='view') }}


with addresses as (
    select 
        address_id as address_guid,
        address,
        zipcode,
        state,
        country
    from {{source('postgres','addresses')}}
)


SELECT
*
from addresses