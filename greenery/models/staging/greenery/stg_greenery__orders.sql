{{
  config(
    materialized='view'
  )
}}


with
source_orders as (
    select * from {{ source('src_greenery','orders') }}
),

renamed_recast as (

  select 

    --ids
      order_id as order_guid,
      user_id as user_guid,
      promo_id as promo_guid,
      address_id as address_guid, 
      tracking_id as tracking_guid,

      --numericals
      order_cost as order_cost_usd,
      shipping_cost as shipping_cost_usd,
      order_total as order_total_usd,

      --strings
      shipping_service,
      status,

      --timestamps
      created_at as created_at_utc,
      estimated_delivery_at as estimated_delivery_at_utc,
      delivered_at as delivered_at_utc

  from source_orders
)

select * from renamed_recast