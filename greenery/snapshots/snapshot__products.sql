{% snapshot products_snapshot %}

	{{
	config(
		target_database = "DEV_DB",
		target_schema = "DBT_FPETRIBUFUNDTHROUGHCOM",
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