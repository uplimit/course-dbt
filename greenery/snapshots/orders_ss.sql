
{% snapshot orders_ss %}

{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='order_guid',
    check_cols=['status'],
   )
}}


select 
        order_id as order_guid,
        user_id as user_guid,
        promo_id as promo_guid,
        address_id as address_guid,
        convert_timezone('America/New_York',created_at) as created_at_tstamp_est,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id as tracking_guid,
        shipping_service,
        convert_timezone('America/New_York',estimated_delivery_at) as estimated_delivery_tstamp_est,
        convert_timezone('America/New_York',delivered_at) as delivered_at_tstamp_est,
        status
 from {{ source('postgres', 'orders') }}

{% endsnapshot %}
