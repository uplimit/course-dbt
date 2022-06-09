{{
  config(
    materialized='view'
  )
}}

with
source_events as (
    select * from {{ source('src_greenery','events') }}
)
,

renamed_recast as (

  select 
      -- ids
      event_id as event_guid,
      session_id as session_guid,
      user_id as user_guid,
      order_id as order_guid,
      product_id as product_guid,

      --strings
      page_url,
      event_type,

      --timestamps
      created_at as created_at_utc

  from source_events
)

select * from renamed_recast