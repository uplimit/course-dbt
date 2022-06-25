
SELECT *
FROM (
        SELECT dim_cust.user_guid
        FROM {{ ref('dim_users_addresses') }} dim_cust
            LEFT JOIN {{ ref('stg_greenery__users') }} stg_cust on dim_cust.user_guid = stg_cust.user_guid
        WHERE stg_cust.user_guid is NULL
        UNION ALL
        SELECT stg_cust.user_guid
        FROM {{ ref('stg_greenery__users') }} stg_cust
            LEFT JOIN {{ ref('dim_users_addresses') }} dim_cust on stg_cust.user_guid= dim_cust.user_guid
        WHERE dim_cust.user_guid is NULL
    ) assert_dim_customers_test