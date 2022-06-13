-- stg_public__addresses.sql

with

source as (

    select * from {{ source('public', 'addresses') }}

),

standardized as (

select
    address_id,
    address,
    zipcode,
    state,
    country

from source

)

select * from standardized