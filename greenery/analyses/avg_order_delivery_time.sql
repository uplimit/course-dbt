with delivered_orders as (

    select
        created_at_utc,
        delivered_at_utc
    from
        {{ ref('stg_postgres__orders') }}
    where
        order_status = 'delivered'
),

order_length as (

    select
        datediff(hour, created_at_utc, delivered_at_utc) as order_length_hours
    from
        delivered_orders

)

select 
    round(avg(order_length_hours), 2) as avg_order_delivered_hours,
    round(avg(order_length_hours / 24), 2) as avg_order_delivered_days
from
    order_length