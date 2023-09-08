{{
  config(
    materialized='table'
  )
}}


select
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  u.phone_number,
  u.created_at,
  u.updated_at,
  u.address_id,
  a.address,
  lpad(a.zipcode:: varchar, 5,'0') as zipcode,
  a.state,
  a.country
from {{ ref('stg_users')}} u
left join {{ ref('stg_addresses')}} a
on u.address_id = a.address_id