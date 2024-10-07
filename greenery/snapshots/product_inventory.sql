{% snapshot product_inventory %}

  {{
    config(
      target_schema='snapshots',
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
    )
  }}

  SELECT * FROM {{ source('postgres', 'products') }}

{% endsnapshot %}