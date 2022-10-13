{{ config(
    materialized = "table"
) }}

SELECT
    o.order_id
    , coe.event_created_at order_checkout_at
    , o.order_created_at
    , pse.event_created_at package_shipped_at
    , o.estimated_delivered_at
    , o.actual_delivered_at
    , DATEDIFF(
        HOUR
        , package_shipped_at
        , NVL(o.actual_delivered_at, o.estimated_delivered_at)
      ) AS hours_to_arrive
    , o.tracking_id
    , o.shipping_service
    , o.order_status
    , o.shipping_cost
    , addr.street_address
    , addr.zip_code
    , addr.state_name
    , addr.country_name
    , u.first_name
    , u.last_name
FROM {{ ref ('stg_order') }} o
LEFT JOIN {{ ref ('stg_address') }} addr
    ON o.address_id = addr.address_id
LEFT JOIN {{ ref ('stg_user') }} u
    ON o.user_id = u.user_id
LEFT JOIN {{ ref ('stg_event') }} coe -- checkout event
    ON coe.order_id = o.order_id
    AND coe.event_type = 'checkout'
LEFT JOIN {{ ref ('stg_event') }} pse -- package shipped event
    ON pse.order_id = o.order_id
    AND pse.event_type = 'package_shipped'