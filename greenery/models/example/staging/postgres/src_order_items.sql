

{{ config(materialized='view') }}

with order_items as (
    select
        order_id as order_guid,
        product_id as product_guid,
        quantity
    from {{source('postgres','order_items')}}
)

SELECT
*
from order_items