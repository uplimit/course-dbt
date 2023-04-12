with source as (
    select * from {{ source('postgres','orders') }}
),

final as 
(
    select 
    order_id
    ,user_id
    ,promo_id
    ,address_id
    ,created_at
    ,order_cost
    ,shipping_cost
    ,order_total
    ,tracking_id
    ,shipping_service
    ,estimated_delivery_at
    ,delivered_at
    ,status as order_status

    from source 
)
select * from final