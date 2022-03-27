with fact_events as (

    select 
      {{ dbt_utils.star(from=ref('fact_events'), except=["event_id", "page_url"]) }}
    from {{ ref('fact_events') }}

)

select
  e.session_id,
  e.user_id,
  e.created_at_utc,
  e.event_type,
  e.order_id,
  coalesce(e.product_id, o.product_id) as product_id,
  p.product_name

from fact_events e
left join {{ ref('dim_order_items') }} o 
  on e.order_id = o.order_id
left join {{ ref('dim_products') }} p
  on coalesce(e.product_id, o.product_id) = p.product_id