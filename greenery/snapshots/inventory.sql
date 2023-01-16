{% snapshot inventory_snapshot %}

  {{
    config(
      target_database='dev_db',
      target_schema='dbt_oneryalcingmailcom',
      unique_key='product_id',
      strategy='check',
      check_cols=['status'],
    )
  }}

  SELECT * FROM {{ source('postgres', 'products') }}

{% endsnapshot %}
