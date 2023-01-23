with orders_items as (

    select
        *
    from
        {{ ref('stg_postgres__order_items') }}

),

orders as (

    select
        order_id,
        user_id,
        created_at_utc,
        order_cost_usd
    from
        {{ ref('stg_postgres__orders') }}

),

final as (

    select
        {{ dbt_utils.surrogate_key(['order_id', 'user_id', 'product_id']) }} as orders_users_products_id,
        orders.order_id,
        orders.user_id,
        orders_items.product_id,
        orders_items.quantity,
        orders.created_at_utc
    from
        orders
    left join 
        orders_items using(order_id)
    
)

select * from final