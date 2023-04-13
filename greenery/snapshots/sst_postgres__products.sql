{% snapshot sst_postgres__products %}

{{
  config(
    target_database = 'DEV_DB',
    target_schema = 'DBT_PAVELFILATOVPALTACOM',
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory']
   )
}}

select * from {{ ref('stg_postgres__products') }}

{% endsnapshot %}