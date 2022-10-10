
{{ config(materialized='view') }}

with promos as (
    select
        promo_id as promo_guid,
        discount,
        status
    from {{source('postgres','promos')}}
)


SELECT
*
from promos