-- stg_public__products.sql

with

source as (

    select * from {{ source('public', 'products') }}

),

source_standardized as (

    select
          product_id
        , name        as product_name
        , price       as product_price
        , inventory   as product_inventory

    from source

)

select * from source_standardized