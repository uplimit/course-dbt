with orders as (

    select
        created_at_utc,
        order_id
    from
        {{ ref('stg_postgres__orders') }}

),

order_hours as (

    select
        date_part(hour, created_at_utc) as order_hour,
        count(order_id) as order_count
    from
        orders
    group by 1
)

select 
    round(avg(order_count), 0) as avg_orders_per_hour 
from 
    order_hours
