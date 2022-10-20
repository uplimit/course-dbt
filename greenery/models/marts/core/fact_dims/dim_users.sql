{{
  config(
    materialized='table'
  )
}}

with user_source as (
  select * from {{ ref('stg_postgres_users') }}
),

address_source as (
  select * from {{ ref('stg_postgres_addresses') }}
),

orders_source as (
  select * from {{ ref('stg_postgres_orders') }}
),

events_source as (
  select * from {{ ref('stg_postgres_events') }}
),

results as (
    select
        u.user_id,
        u.first_name,
        u.last_name,
        u.full_name,
        u.email,
        u.phone_number,
        u.created_at,
        u.updated_at,
        a.address,
        a.zipcode,
        a.state,
        a.country,

        count(distinct o.order_id)      as order_count,
        count(distinct e.session_id)    as session_count,
        sum(o.total_cost)               as total_revenue

    from user_source u
    left join address_source a
        on u.address_id = a.address_id
    left join orders_source o
        on u.user_id = o.user_id
    left join events_source e
        on u.user_id = e.user_id

    {{ dbt_utils.group_by(n=12) }}

)

select * from results