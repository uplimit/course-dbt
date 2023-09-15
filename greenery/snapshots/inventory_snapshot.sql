{% snapshot inventory_snapshot %}

{{
  config(
    target_database = "DEV_DB",
    target_schema = "DBT_BURJACK86GMAILCOM",
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
   )
}}

  SELECT 
  PRODUCT_ID
  , NAME
  , PRICE
  , INVENTORY 
  FROM {{ source('postgres', 'products') }}

{% endsnapshot %}