{% snapshot orders_snapshot %}

{# select distinct(status) from orders; shipped, preparing, delivered #}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      check_cols=['status'],
    )
}}

SELECT 
    * 
FROM 
  {{ source('greenery', 'orders') }}

{% endsnapshot %}