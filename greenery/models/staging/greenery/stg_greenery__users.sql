{{
  config(
    materialized='view'
  )
}}

with
source_users as (
    select * from {{ source('src_greenery','users') }}
)
,

renamed_recast as (

  select 
    -- ids
      user_id as user_guid,
      address_id as address_guid,

    -- strings
      first_name,
      last_name,
      email, -- rename to specificy user? in case we have supplier details?
      phone_number,
    
      -- timestamps
      created_at as created_at_utc,
      updated_at as updated_at_utc

from source_users
)

select * from renamed_recast
