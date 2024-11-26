{{ config(materialized='view') }}


with addresses as (
    select 
        address_id as address_guid,
        address,
        lpad(zipcode,5,0) as zipcode,
        state,
        country
    from {{source('postgres','addresses')}}
)


SELECT
*
from addresses