{{ 
    config(
        materialized='table',
        enabled=false
    ) 
}}

select *
from {{ ref('my_first_dbt_model') }}
where id = 1
