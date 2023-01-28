with products as (

    select
        *
    from
        {{ ref('stg_postgres__products') }}

),

orders_products as (

    select
        *
    from
        {{ ref('int_orders_users_products') }}

),

orders_products_joined as (

    select
        orders_products.order_id,
        products.product_id,
        products.price_usd,
        orders_products.quantity,
        orders_products.created_at_utc,
        price_usd * quantity as product_total_cost
    from
        orders_products
    left join products using(product_id)
  
),

products_agg as (

    select
        product_id,
        count(order_id) as n_times_ordered,
        sum(quantity) as n_products_ordered,
        sum(product_total_cost) as total_revenue_usd,
        max(created_at_utc) as most_recent_order_utc
    from
        orders_products_joined
    group by 1

),

final as (
    
    select
        products.product_id,
        products.product_name,
        products.price_usd,
        products.inventory,
        products_agg.n_times_ordered,
        products_agg.n_products_ordered,
        products_agg.total_revenue_usd,
        products_agg.most_recent_order_utc
    from
        products
    left join
        products_agg using(product_id)

)

select * from final