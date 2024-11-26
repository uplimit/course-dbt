with
purchases_per_user AS (
	SELECT
		user_id
		,COUNT(DISTINCT order_id) AS purchase_counter
    FROM {{ ref("stg_postgres__orders") }}
    GROUP BY user_id
)--purchases_per_user

, purchase_counter AS (
	SELECT
    	COUNT(user_id) AS users_who_purchased
        , sum(CASE WHEN purchase_counter >= 2 
				   THEN 1 
				   ELSE 0 
				   END
              ) AS users_who_purchased_twice_or_more
    FROM purchases_per_user
)--purchase_counter

SELECT
    users_who_purchased,
    users_who_purchased_twice_or_more,
    users_who_purchased_twice_or_more / users_who_purchased as repeat_rate
FROM purchase_counter