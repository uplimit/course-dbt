-- stg_public__products.sql

with

source as (

    select * from {{ source('public', 'products') }}

),

standardized as (

    select
        product_id,
        name,
        price,
        inventory

    from source

)

select * from standardized