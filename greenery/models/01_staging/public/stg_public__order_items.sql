-- stg_order_items.sql

with

source as (

    select * from {{ source('public', 'order_items') }}

)

select * from source