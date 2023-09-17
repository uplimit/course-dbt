{{
  config(
    materialized='view'
  )
}}

with source as (
    select
        *
    from {{ source('postgres', 'order_items') }}
)
--difference between recasting and transoforming col in source
, reaname_recast as ( 
    SELECT 
      order_id AS order_uuid,
      product_id AS product_uuid,
      quantity
    FROM source
)

select * from reaname_recast


