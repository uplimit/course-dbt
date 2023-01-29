{{
  config(
    materialized='view'
  )
}}

select 
  PROMO_ID
  , DISCOUNT
  , STATUS
FROM {{ source('postgres', 'promos') }}