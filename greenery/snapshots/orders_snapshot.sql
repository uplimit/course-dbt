{% snapshot orders_snapshot %}

{{
   config(
       target_database='DEV_DB',
       target_schema='dbt_jberkowitzhealthjoycom',
       unique_key='order_id',
       strategy='check',
       check_cols=['status'],
   )
}}

select * from {{ source('postgres', 'orders') }}

{% endsnapshot %}