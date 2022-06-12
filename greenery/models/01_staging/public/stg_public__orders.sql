-- stg_orders.sql

with

source as (

    select * from {{ source('public', 'orders') }}

)

select * from source