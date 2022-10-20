{{
  config(
    materialized='table'
  )
}}

with users as (
    select * from {{ ref('dim_users') }}
),

orders as (
    select * from {{ ref('fct_orders') }}
),

results as (
    select
        u.user_id,
        u.first_name,
        u.last_name,
        u.full_name,
        u.zipcode,
        u.state,
        u.country,

        count(distinct o.order_id)      as order_count,
        count(distinct o.promo_id)      as promo_count,
        

        avg(o.products_purchased)       as avg_products_purchased,
        avg(o.total_items_purchased)    as avg_total_products_purchased,
        avg(o.order_cost)               as avg_order_cost,
        avg(o.shipping_cost)            as avg_shipping_cost,
        avg(o.total_cost)               as avg_order_total,
        avg(o.est_days_to_delivery)     as avg_est_delivery_days,
        avg(o.actual_days_to_delivery)  as avg_actual_delivery_days,
        avg(o.delivery_estimate_error)  as avg_est_delivery_error

    from users u
    left join orders o
        on u.user_id = o.user_id
    {{ dbt_utils.group_by(n=7) }}

)

select * from results