{{
  config(
    materialized='table'
  )
}}

with product_source as (
  select * from {{ ref('stg_postgres_products') }}
),

product_events as (
  select * from {{ ref('stg_postgres_events') }}
),

product_orders as (
  select * from {{ ref('stg_postgres_order_items') }}
),

results as (
    select
        -- Primary Key
        p.product_id,
        p.name,
        p.price,
        
        -- Aggregated Order Information
        count(distinct o.order_id)  as total_orders,
        sum(o.quantity)             as total_sold,

        -- Aggregated Event Information
        count(distinct e.event_id)  as total_events

    from product_source p
    left join product_orders o
        on p.product_id = o.product_id
    left join product_events e
        on p.product_id = e.product_id
    
    {{ dbt_utils.group_by(n=3) }}
)

select * from results