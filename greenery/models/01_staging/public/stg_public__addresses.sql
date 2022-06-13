-- stg_public__addresses.sql

with

source as (

    select * from {{ source('public', 'addresses') }}

),

standardized as (

select
    address_id as user_address_id,
    address    as user_address,
    zipcode    as user_zipcode,
    state      as user_state,
    country    as user_country

from source

)

select * from standardized