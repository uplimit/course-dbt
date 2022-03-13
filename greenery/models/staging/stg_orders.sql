with 

source as (
    select  
        -- UUID for each unique order on platform
        order_id,
        -- UserId of the user that placed this order
        user_id,
        -- PromoId if any was used in the order
        promo_id,
        -- Delivery address for this order
        address_id,
        -- Timestamp when the order was created
        created_at,
        -- Dollar about of the items in the order
        order_cost,
        -- Cost of shipping for the order
        shipping_cost,
        -- Total cost of the order including shipping
        order_total,
        -- Tracking number for the order/package
        tracking_id,
        -- Company that was used for shipping
        shipping_service,
        -- Estimated date of delivery
        estimated_delivery_at,
        -- Actual timestamp of delivery
        delivered_at,
        -- Status of the order
        status
    from {{ source('greenery', 'orders') }}
)

select * from source