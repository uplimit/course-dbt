{{
  config(
    materialized='view'
  )
}}

with source as (
    select
        *
    from {{ source('postgres', 'events') }}
)

, reaname_recast as ( 
    SELECT
      event_id as event_uuid,
      user_id as user_uuid,
      event_type as web_event_type,
      order_id as order_uuid,
      page_url,
      product_id as product_uuid,
      session_id as session_uuid,
      created_at as web_event_created_at
    FROM source
)

select * from reaname_recast


