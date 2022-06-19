{{ 
  config(
    materialized = 'table'
  ) 
}}
WITH order_facts AS (
  SELECT 
    user_guid
    , orders_done
    , first_order_timestamp_utc
    , last_order_timestamp_utc
    , avg_order_cost
    , rounded_avg_order_cost_usd
    , total_order_amount_usd 
  FROM 
    {{
      ref('intermediate_order_facts_aggregate') 
    }}
)

, users_address_info as (
  SELECT 
      first_name
	    , last_name
      , user_guid
	    , email
	    , phone_number
	    , street_address
	    , zipcode
	    , state
	    , country
	    , created_at_utc
	    , updated_at_utc
	    , days_of_membership
  FROM
    {{
      ref('dim_users_addresses') 
    }}
) 

SELECT 
  of.user_guid
  , of.orders_done
  , of.first_order_timestamp_utc
  , of.last_order_timestamp_utc
  , of.avg_order_cost
  , of.rounded_avg_order_cost_usd
  , of.total_order_amount_usd 
  , uai.first_name
	, uai.last_name
	, uai.email
	, uai.phone_number
	, uai.street_address
	, uai.zipcode
	, uai.state
	, uai.country
	, uai.created_at_utc
	, uai.updated_at_utc
	, uai.days_of_membership 
FROM order_facts of
LEFT JOIN users_address_info uai
     ON uai.user_guid = of.user_guid 