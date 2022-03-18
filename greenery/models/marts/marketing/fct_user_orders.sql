WITH user_orders AS (
     SELECT user_id
            ,COUNT(order_id) AS number_of_orders
            ,SUM(order_total_amount) AS total_order_amount
            ,SUM(number_of_products) AS total_number_of_purchased_products
            ,SUM(order_discount) AS total_discount_amount
    FROM {{ ref('fct_orders') }}
    GROUP BY user_id
)

SELECT
    users.user_id
    ,users.user_name
    ,users.email
    ,users.phone_number
    ,users.address AS user_address
    ,users.created_at_utc
    ,users.updated_at_utc
    ,COALESCE(user_orders.number_of_orders, 0) AS total_number_of_orders
    ,COALESCE(user_orders.total_order_amount, 0) AS total_order_amount
    ,COALESCE(user_orders.total_discount_amount, 0) AS total_discount_amount
    ,COALESCE(user_orders.total_number_of_purchased_products, 0) AS total_number_of_purchased_products
FROM {{ ref('dim_users') }} users
LEFT JOIN user_orders ON users.user_id = user_orders.user_id
