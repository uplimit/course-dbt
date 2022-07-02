

{{
    config(
        materialized='table'
    )
}}

select 
user_id,
sum(order_cost) as orders_cost

from {{ref('init_users_value')}}
 GROUP BY 1

 