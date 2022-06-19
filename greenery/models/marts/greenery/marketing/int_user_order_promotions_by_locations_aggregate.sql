{{ 
    config(
        materialized = 'table'
    )  
}}


SELECT
    o.order_guid
    , o.user_guid
    , dua.state
    , dua.country
    , o.created_at_utc
    ,SUM(CASE WHEN promo_description = 'digitized' THEN 1 ELSE 0 END) as digitized
    ,SUM(CASE WHEN promo_description = 'instruction set' THEN 1 ELSE 0 END) as instruction_set
	,SUM(CASE WHEN promo_description = 'leverage' THEN 1 ELSE 0 END) as leverage
    ,SUM(CASE WHEN promo_description = 'mandatory' THEN 1 ELSE 0 END) as mandatory
    ,SUM(CASE WHEN promo_description = 'no_promotion' THEN 1 ELSE 0 END) as no_promotion
	,SUM(CASE WHEN promo_description = 'optional' THEN 1 ELSE 0 END) as optional    
    ,SUM(CASE WHEN promo_description = 'task_force' THEN 1 ELSE 0 END) as task_force
FROM 
  	{{ 
        ref('stg_greenery__orders') 
    }} o
LEFT JOIN 
    {{ 
        ref('dim_users_addresses') 
    }} dua
ON 		o.user_guid = dua.user_guid
GROUP BY
		 o.order_guid
		 , o.user_guid
		 , dua.state
		 , dua.country
		 , o.created_at_utc
		 , o.delivered_at_utc