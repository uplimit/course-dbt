{{
    config(
        materialized='table'
    )
}}

select 
user_id,
order_id,
stg_greenery_orders.promo_id
,discount

from {{ref('stg_greenery_orders')}}
 left join  {{ref('stg_greenery_promos')}}
on stg_greenery_promos.promo_id=stg_greenery_orders.promo_id

