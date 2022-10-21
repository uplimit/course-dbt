{{
  config(
    materialized='table'
  )
}}

with users as (
    select * from {{ ref('dim_users') }}
),

events as (
    select * from {{ ref('int_user_session_events') }}
),

orders as (
  select * from {{ ref('fct_orders') }}
),

get_ids as (
  select
      user_id,
      session_id,
      order_id

  from events
  where order_id is not null
),

results as (
    select
        {{ dbt_utils.surrogate_key(['g.user_id', 'g.session_id', 'g.order_id']) }} as unique_key,
        g.user_id,
        g.session_id,
        g.order_id,
        u.first_name,
        u.last_name,
        ---u.full_name,
        u.zipcode,
        u.state,
        u.country,

        sum(e.checkout_count)         as checkout_count,
        sum(e.package_shipped_count)  as shipped_count,
        sum(e.add_to_cart_count)      as added_count,
        sum(e.page_view_count)        as viewed_count,
        sum(e.session_length_min)     as session_length_min,
        sum(e.product_count)          as product_viewed_count,
        sum(o.products_purchased)     as product_purchased_count
        
        

    from get_ids g
    left join users u
        on g.user_id = u.user_id
    left join events e
        on g.user_id = e.user_id
        and g.session_id = e.session_id
    left join orders o
        on g.user_id = o.user_id
        and g.order_id = o.order_id

    {{ dbt_utils.group_by(n=9) }}

)

select * from results