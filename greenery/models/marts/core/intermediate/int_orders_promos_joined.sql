

with

staged_orders as (

    select * from {{ ref('stg_public__orders')}}

),

staged_promos as (

    select * from {{ ref('stg_public__promos')}}

),

order_items_agg as (

    select * from {{ ref('int_order_items_agg')}}

),

final as (

    select
        staged_orders.order_guid
        , user_guid
        , staged_orders.promo_id
        , coalesce(promo_discount,0) as promo_discount
        , promo_status
        , created_at_utc
        , order_cost
        , shipping_cost
        , order_total                as order_total_spend
        , total_items                as order_total_items
        , tracking_id
        , shipping_service
        , estimated_delivery_at_utc
        , delivered_at_utc
        , order_status

    from staged_orders
    left join staged_promos using(promo_id)
    left join order_items_agg using(order_guid)

)

select * from final