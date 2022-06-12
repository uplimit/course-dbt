-- stg_products.sql

with

source as (

    select * from {{ source('public', 'products') }}

)

select * from source