-- stg_public__order_items.sql

with

source as (

    select * from {{ source('public', 'order_items') }}

),

source_standardized as (

    select
          order_id   as order_guid
        , product_id as product_guid
        , quantity   as product_quantity

    from source

)

select * from source_standardized