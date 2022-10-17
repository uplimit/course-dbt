{{ config(materialized='table') }}

select
 promo_id,
 discount,
 status
from {{ source('_postgres__sources', 'promos')}} promos