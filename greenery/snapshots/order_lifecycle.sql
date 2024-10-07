{% snapshot order_lifecycle %}

  {{
    config(
      target_schema='snapshots',
      unique_key = "avg_order_lifeycle",
    strategy='check',
    check_cols=['created_at', 'delivered_at', 'status'],
    )
  }}

  SELECT AVG(timestampdiff(DAY, delivered_at ,created_at)) avg_order_lifeycle FROM {{ source('postgres', 'orders') }}
  where delivered_at is not null

{% endsnapshot %}