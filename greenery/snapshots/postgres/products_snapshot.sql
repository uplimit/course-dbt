{% snapshot products_snapshot %}

{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='product_uuid',
    check_cols=['inventory'],
   )
}}

  SELECT 
    product_id AS product_uuid,
    name as product_name,
    price,
    inventory
  FROM {{ source('postgres', 'products') }}

{% endsnapshot %}