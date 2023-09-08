{{
  config(
    materialized='table'
  )
}}

SELECT 
	USER_ID ,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE_NUMBER,
	CREATED_AT,
	UPDATED_AT,
	ADDRESS_ID
FROM {{ source('postgres', 'users') }}