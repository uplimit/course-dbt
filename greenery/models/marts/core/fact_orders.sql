with orders as (

    select
        *
    from
        {{ ref('stg_postgres__orders') }}

),

promos as (

    select
        *
    from
        {{ ref('stg_postgres__promos') }}
),

final as (

    select
        orders.order_id,
        orders.user_id,
        orders.address_id,
        orders.created_at_utc,
        orders.promo_type,
        promos.discount_usd,
        orders.order_cost_usd,
        orders.shipping_cost_usd,
        orders.order_total_usd,
        orders.tracking_id,
        orders.shipping_service,
        orders.estimated_delivery_at_utc,
        orders.delivered_at_utc,
        orders.order_status,
        orders.is_delivered,
        datediff(day, created_at_utc, delivered_at_utc) as time_to_delivery,
        datediff(day, estimated_delivery_at_utc, delivered_at_utc) as delivery_estimate_difference
    from
        orders
    left join 
        promos using(promo_type)
    
)

select * from final