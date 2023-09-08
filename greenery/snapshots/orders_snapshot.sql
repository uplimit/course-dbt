{% snapshot orders_snapshot %}
{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='order_id',
    check_cols=['status'],
   )
}}
SELECT
  order_id,
  user_id,
  promo_id,
  address_id,
  created_at,
  order_cost,
  shipping_cost,
  order_total,
  tracking_id,
  shipping_service,
  estimated_delivery_at,
  delivered_at,
  status
FROM {{ source('_postgres__sources', 'orders')}} orders

{% endsnapshot %}