{{
  config(
    materialized='table'
  )
}}

select 
  PROMO_ID
  , DISCOUNT
  , STATUS
FROM {{ source('postgres', 'promos') }}