
{{ 
    config(
        materialized = 'table'
    )  
}}

-- Referencing https://medium.com/@oluwabukunmige/templating-your-sql-queries-using-jinga-on-dbt-ce3d1e14a7fc 
-- Next goal is to have it use dbt_utils to run the query 
{%- set promo_descriptions -%}
SELECT
	distinct(promo_description)
FROM
	{{ ref('stg_greenery__orders') }}
ORDER BY promo_description
{%- endset -%}


{%- set promo_desc_results = run_query(promo_descriptions) -%}

{% if execute %}
{# Return the promo description values #}
{% set promo_desc_results_list = promo_desc_results.columns[0].values() %}
{% else %}
{% set promo_desc_results_list =[] %}
{% endif %}

SELECT
    o.order_guid
    , o.user_guid
    , dua.state
    , dua.country
    , o.created_at_utc
    {% for promo_description in promo_desc_results_list %}
	{# Using a for loop to iterate through ea promo description #}
	, SUM(CASE 
            WHEN promo_description = '{{promo_description}}' 
            THEN 1 ELSE 0 END) 
            AS {{promo_description}}
	{% endfor %} 
FROM 
  	{{ 
        ref('stg_greenery__orders') 
    }} o
LEFT JOIN 
    {{ 
        ref('dim_users_addresses') 
    }} dua
ON 		o.user_guid = dua.user_guid
GROUP BY
		 o.order_guid
		 , o.user_guid
		 , dua.state
		 , dua.country
		 , o.created_at_utc
		 , o.delivered_at_utc