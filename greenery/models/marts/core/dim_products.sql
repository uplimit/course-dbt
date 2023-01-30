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
        {{ ref('int_events_orders_products') }}
    where order_id is not null

),

orders_products_joined as (

    select
        orders_products.order_id,
        products.product_id,
        products.price_usd,
        orders_products.quantity,
        price_usd * quantity as product_total_cost
    from
        orders_products
    left join products on orders_products.product_ordered_id = products.product_id
  
),

products_agg as (

    select
        product_id,
        count(order_id) as n_times_ordered,
        sum(quantity) as n_products_ordered,
        sum(product_total_cost) as total_revenue_usd
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
        products_agg.total_revenue_usd
    from
        products
    left join
        products_agg using(product_id)

)

select * from final