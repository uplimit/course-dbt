{{
  config(
    materialized='view',
    enabled=true
  )
}}

select
  promo_id,
  status,
  discount

from {{ source('postgres', 'promos') }}