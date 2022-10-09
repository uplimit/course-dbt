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

with orders as (

    select * from {{ source('_postgres__sources', 'orders') }}

)

select 
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

from orders

{% endsnapshot %}