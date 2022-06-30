{% snapshot orders_snapshot%}
{{
    config(
        target_schema='snapshots'
        , strategy= 'check'
        ,unique_key= 'order_id'
        , check_cols=['status']
    )
}}

select * from {{ source ('src_greenery','orders')}}

{% endsnapshot %}
