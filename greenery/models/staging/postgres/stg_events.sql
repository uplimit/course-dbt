--snowflake_warehouse env_var is to demosntrate another config we can apply. In our case we only have 1 size of 
--transformer_dev warehouse but we could have multiple and depending on model requirements
--we could choose to run/deploy against a bigger warehouse
{{ config(
     materialized='table',
     snowflake_warehouse=env_var('SNOWFLAKE_WAREHOUSE_XS'))
}}

select
    event_id,
    session_id,
    user_id,
    page_url,
    created_at,
    event_type
    order_id,
    product_id
from {{ source ('postgress', 'events') }}