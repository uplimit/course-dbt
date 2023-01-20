with orders as (

    select
        user_id,
        order_id
    from
        {{ ref('stg_postgres__orders') }}

),

orders_per_user as (

    select
        user_id,
        count(order_id) as n_orders,
        case
            when
                n_orders = 1 then 'one_order'
            when 
                n_orders = 2 then 'two_orders'
            else
                '3+_orders'
        end as n_orders_bucket
    from
        orders
    group by 1

)

select 
    n_orders_bucket,
    count(user_id) as n_users
from
    orders_per_user
group by 1
