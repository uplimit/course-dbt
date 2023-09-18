--snowflake_warehouse env_var is to demosntrate another config we can apply. In our case we only have 1 size of 
--transformer_dev warehouse but we could have multiple and depending on model requirements
--we could choose to run/deploy against a bigger warehouse
{{ config(
     materialized='table',
     snowflake_warehouse=env_var('SNOWFLAKE_WAREHOUSE_XS'))
}}

select
    product_id,
    name,
    price,
    inventory
from {{ source ('postgress', 'products') }}