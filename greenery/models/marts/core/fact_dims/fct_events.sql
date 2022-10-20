{{
  config(
    materialized='table'
  )
}}

with events_source as (
    select * from {{ ref('stg_postgres_events') }}
),

results as (
    select
      -- Primary Key
      event_id,

      -- Foreign Keys
      session_id,
      product_id,
      order_id,
      user_id,

      -- Event Info
      event_at,
      event_type,
      page_url

    from events_source
)

select * from results