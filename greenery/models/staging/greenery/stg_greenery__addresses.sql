{{
  config(
    materialized='view'
  )
}}

with
source_addresses as (
    select * from {{ source('src_greenery','addresses') }}
)
,

renamed_recast as (

  select 
      -- ids
      address_id as address_guid,

      -- strings
      address,
      zipcode::TEXT -- changing this to string to prepare for international deliveries
      state, -- Is this an optional field, and/or is this field available outside USA?
      country

  from source_addresses
)

select * from renamed_recast