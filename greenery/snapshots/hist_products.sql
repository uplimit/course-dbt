{{
  config(
    materialized = 'table',
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
   )
}}

select 
    p.* 

from {{ ref('postgres__products') }} p