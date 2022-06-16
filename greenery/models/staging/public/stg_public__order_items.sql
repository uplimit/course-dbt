-- stg_public__order_items.sql

with

source as (

    select * from {{ source('public', 'order_items') }}

),

standardized as (

    select
        order_id,
        product_id,
        quantity as product_quantity

    from source

)

select * from standardized