{{ config(materialized='table') }}

with events as (

  select * from {{ ref('stg_events') }}

),
order_items as (

  select * from {{ ref('stg_order_items') }}

),
products as (

  select * from {{ ref('stg_products') }}

),
page_views as (

  {{ sessions_per_event('product_id', 'page_view')}}

),
purchases as (

  select
    oi.product_id,
    cast(count(distinct e.session_id) as numeric) as total_purchases
  from events e
  left join order_items oi on e.order_id = oi.order_id
  where e.order_id is not null
  group by 1

)
select 
  pv.product_id,
  pr.name,
  pv.total_sessions as total_page_views,
  pu.total_purchases,
  round(total_purchases / total_sessions, 4) as product_conv_rate
from page_views pv
left join purchases pu on pv.product_id = pu.product_id
left join products  pr on pv.product_id = pr.product_id