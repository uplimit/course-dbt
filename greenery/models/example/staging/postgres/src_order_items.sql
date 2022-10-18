

{{ config(materialized='view') }}

with order_items as (
    select
        iff(order_id is null or product_id is null, null, abs(hash(concat(order_id,product_id)))) as order_item_id,
        order_id as order_guid,
        product_id as product_guid,
        quantity
    from {{source('postgres','order_items')}}
)

SELECT
*
from order_items