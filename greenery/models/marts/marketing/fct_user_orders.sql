{{
  config(
    materialized = 'table'
  )
}}

select
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , AVG(order_total)::float as average_order_total_cost
    , COUNT(order_total) as number_of_orders
from {{ ref('int_user_orders') }}
group by 1,2,3,4,5