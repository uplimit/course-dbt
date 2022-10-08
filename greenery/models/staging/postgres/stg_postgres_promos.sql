{{
  config(
    materialized='table'
  )
}}

SELECT 
	PROMO_ID,
	DISCOUNT,
	STATUS
FROM {{ source('postgres', 'promos') }}