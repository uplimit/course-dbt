SELECT 
    shipping.order_id 
    , shipping.address_id
    , shipping.address
    , shipping.zipcode
    , shipping.state
    , shipping.country
    , shipping.is_usa
    , shipping.shipping_cost
    , shipping.tracking_id
    , shipping.shipping_service
    , shipping.status
    , CASE WHEN date_trunc('day', shipping.estimated_delivery_at_utc) > date_trunc('day', shipping.delivered_at_utc) THEN 'Early'
       WHEN  date_trunc('day', shipping.estimated_delivery_at_utc) < date_trunc('day', shipping.delivered_at_utc) THEN 'Late'
       WHEN  date_trunc('day', shipping.estimated_delivery_at_utc) = date_trunc('day', shipping.delivered_at_utc)  THEN 'On Time'
       ELSE NULL END as delivery_timeliness
    , delivered_at_utc::date - created_at_utc::date AS days_from_order_to_delivery
FROM {{ ref('int_shipping') }} AS shipping