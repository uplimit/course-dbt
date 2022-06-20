{{
    config(
        materialized='table'
    )
}}

select 
stg_greenery_users.user_id,
order_cost

from {{ref('stg_greenery_users')}}
 left join  {{ref('stg_greenery_orders')}}
on stg_greenery_users.user_id=stg_greenery_orders.user_id
