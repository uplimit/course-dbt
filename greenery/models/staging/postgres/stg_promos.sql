{{ 
  config(
    materialized='view'
  ) 
}}

with promos as (

    select * from {{ source('_postgres__sources', 'promos') }}

)

select 
    promo_id, 
    discount, 
    status

from promos