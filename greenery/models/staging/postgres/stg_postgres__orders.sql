with source as (

    select 
        * 
    from 
        {{ source('postgres', 'orders') }}

),

renamed as (

    select
        order_id,
        user_id,
        address_id,
        created_at::timestampntz as created_at_utc,
        promo_id as promo_type,
        order_cost::decimal(20,2) as order_cost_usd,
        shipping_cost::decimal(20,2) as shipping_cost_usd,
        order_total::decimal(20,2) as order_total_usd,
        tracking_id,
        shipping_service,
        estimated_delivery_at::timestampntz as estimated_delivery_at_utc,
        delivered_at::timestampntz as delivered_at_utc,
        status as order_status,
        order_status = 'delivered' as is_delivered
    from 
        source

)

select * from renamed
  