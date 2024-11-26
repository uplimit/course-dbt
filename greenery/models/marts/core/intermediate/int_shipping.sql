SELECT 
    orders.order_id 
    , addresses.address_id
    , addresses.address
    /* check for for zip code length */
    , CASE WHEN LENGTH(addresses.zipcode::text) = 4 THEN CONCAT(0, addresses.zipcode) ELSE zipcode::text END AS zipcode
    , addresses.state
    , addresses.country
    /* Add flag to determin local orders vs int orders */
    , CASE WHEN addresses.country = 'United States' THEN true ELSE false END AS is_usa
    , orders.created_at_utc
    , orders.shipping_cost
    , orders.tracking_id
    , orders.shipping_service
    , orders.status
    , orders.estimated_delivery_at_utc
    , orders.delivered_at_utc
FROM {{ ref('stg_addresses__addresses') }} AS addresses
JOIN {{ ref('stg_orders__orders') }} AS orders ON addresses.address_id = orders.address_id