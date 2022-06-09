{{
  config(
    materialized='view'
  )
}}

with
source_order_items as (
    select * from {{ source('src_greenery','order_items') }}
)
,

renamed_recast as (
  select 

    -- ids
      order_id as order_guid,
      product_id as product_guid,

      -- numerical
      quantity as product_qty
  from source_order_items
)

select * from renamed_recast
