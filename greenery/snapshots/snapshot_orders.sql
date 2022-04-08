{% snapshot orders_snapshot %}

{{
    config(
        target_schema='dbt_zoe_l',
        unique_key='order_id',
        strategy='check',
        check_cols=['status']
    )
}}

SELECT * FROM {{ source('tutorial', 'orders') }}

{% endsnapshot %}
