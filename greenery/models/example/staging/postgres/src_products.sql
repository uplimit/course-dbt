

{{ config(materialized='view') }}

with products as (
    select
        product_id as product_guid,
        name as product_name,
        price,
        inventory
    from {{source('postgres','products')}}
)

SELECT
*
from products