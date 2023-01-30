with products as (

    select
        *
    from
        {{ ref('dim_products') }}

),

events_products as (

    select
        event_order_product_id,
        event_id,
        session_id,
        coalesce(product_viewed_id, product_ordered_id) as event_product_id,
        event_type,
        created_at_utc
    from
        {{ ref('int_events_orders_products') }}
),

final as (

    select
        events_products.*,
        products.product_name
    from
        events_products
    left join products on events_products.event_product_id = products.product_id
)

select * from final
