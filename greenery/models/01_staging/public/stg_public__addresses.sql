-- stg_addresses.sql

with

source as (

    select * from {{ source('public', 'addresses') }}

)

select * from source