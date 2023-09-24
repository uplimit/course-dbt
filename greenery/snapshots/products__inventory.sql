{% snapshot products_snapshot %}

{{
		config(
			target_database = target.database,
			target_schema = target.schema,
			strategy='check',
			unique_key='product_id',
			check_cols=['inventory'],
		)
}}

    SELECT 
		product_id
		,name 
		,price
		,inventory
    FROM {{ source("postgres", "products") }}

{% endsnapshot %}