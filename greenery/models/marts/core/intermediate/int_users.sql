WITH customer_order_count AS
    (SELECT orders.user_id, COUNT(DISTINCT order_id) as number_of_user_orders
     FROM {{ ref('stg_orders__orders' ) }} as orders
     GROUP BY orders.user_id
    )

SELECT 
    users.user_id
    , CASE WHEN customer_order_count.number_of_user_orders > 1 THEN true ELSE false END AS is_repeat_customer
    , CASE WHEN customer_order_count.number_of_user_orders IS NULL THEN 0 ELSE customer_order_count.number_of_user_orders END AS number_of_user_orders
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.created_at_utc as user_created_at_utc
FROM {{ ref('stg_users__users') }} AS users
LEFT JOIN customer_order_count ON users.user_id = customer_order_count.user_id