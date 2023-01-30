with orders_items as (

    select
        *
    from
        {{ ref('stg_postgres__order_items') }}

),

events as (

    select
        event_id,
        session_id,
        product_id,
        user_id,
        order_id,
        event_type,
        created_at_utc
    from
        {{ ref('stg_postgres__events') }}
    where
        event_type <> 'package_shipped'

),

final as (

    select
        {{ dbt_utils.surrogate_key(['event_id', 'session_id', 'user_id', 'events.product_id', 'order_id', 'orders_items.product_id']) }} as event_order_product_id,
        events.event_id,
        events.session_id,
        events.user_id,
        events.product_id as product_viewed_id,
        events.order_id,
        events.event_type,
        events.created_at_utc,
        orders_items.product_id as product_ordered_id,
        orders_items.quantity
    from
        events
    left join orders_items using(order_id)

)

select * from final