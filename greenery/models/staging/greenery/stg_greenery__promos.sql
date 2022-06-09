{{
  config(
    materialized='view'
  )
}}

with
source_promos as (
    select * from {{ source('src_greenery','promos') }}
)
,

renamed_recast as (

  select 

    -- ids
      promo_id as promo_guid,

      --strings
      discount,
      status

  from source_promos

)

select * from renamed_recast
