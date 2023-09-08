{{config(materialized = 'view')}}

{% set sql_statement %}
    select product_id from {{ ref('stg_products') }}
{% endset %}

{% set product_ids = dbt_utils.get_query_results_as_dict(sql_statement) %}

SELECT
    {
        { 
            dbt_utils.surrogate_key(['t2.order_id', 't1.product_id']) 
        }
    } as unique_key
    , t2.order_id
    , {% for product_id in product_ids['product_id'] | unique %}
    sum(case 
            when t1.product_id = '{{product_id}}' then quantity
        end) as "count_purchased_{{product_id}}"
    {% if not loop.last %},{% endif %}
    {% endfor %}
FROM {{ref('stg_products')}} AS t1
LEFT JOIN {{ref('stg_order_items')}} AS t2
    ON t2.product_id = t1.product_id
GROUP BY 1