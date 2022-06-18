-- stg_public__addresses.sql

with

source as (

    select * from {{ source('public', 'addresses') }}

),

source_standardized as (

select
      address_id as user_address_guid
    , address    as user_address
    , zipcode    as user_zip_code
    , state      as user_state
    , country    as user_country

from source

)

select * from source_standardized