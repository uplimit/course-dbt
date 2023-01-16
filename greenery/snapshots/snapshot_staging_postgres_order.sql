{% snapshot staging_postgres_orders_snapshot %}

    {{
    config(
        target_database = target.database,
        target_schema = target.schema,
        strategy='check',
        unique_key='order_id',
        check_cols=['status'],
    )
    }}

    SELECT * FROM {{ source('postgres', 'orders') }}

{% endsnapshot %}