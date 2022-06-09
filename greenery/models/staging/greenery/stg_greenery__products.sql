{{
  config(
    materialized='view'
  )
}}

with
source_products as (
    select * from {{ source('src_greenery','products') }}
)
,

renamed_recast as (
  select 

    --ids
      product_id as product_guid,

      --strings
      name as product_name,

      --numericals 
      price as price_usd,
      inventory as inventory_qty

  from source_products
)

select * from renamed_recast
