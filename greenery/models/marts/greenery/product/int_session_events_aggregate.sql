{{ 
    config(
        materialized = 'table'
    )  
}}

-- Referencing https://medium.com/@oluwabukunmige/templating-your-sql-queries-using-jinga-on-dbt-ce3d1e14a7fc 
-- Next goal is to have it use dbt_utils to run the query 
{%- set event_types -%}
SELECT
	distinct(event_type)
FROM
	{{ ref('stg_greenery__events') }}
ORDER BY event_type
{%- endset -%}


{%- set event_type_results = run_query(event_types) -%}

{% if execute %}
{# Return the event type values #}
{% set event_type_results_list = event_type_results.columns[0].values() %}
{% else %}
{% set event_type_results_list =[] %}
{% endif %}

WITH session_events_aggregate AS (
  SELECT
      session_guid
      , user_guid
      , MIN(created_at_utc) AS session_start
      , MAX(created_at_utc) AS session_end
      , COUNT(event_guid) AS events_per_session
      , COUNT(DISTINCT order_guid) AS orders_placed
      , COUNT(DISTINCT product_guid) AS products_purchased
      {% for event_type in event_type_results_list %}
	    {# Using a for loop to iterate through ea event type #}
	    , SUM(CASE 
            WHEN event_type = '{{event_type}}' 
            THEN 1 ELSE 0 END) 
            AS {{event_type}}
	    {% endfor %} 
  FROM 
    {{ 
        ref('stg_greenery__events')
    }}
  GROUP BY 
    session_guid
    , user_guid
)

SELECT  
    * 
FROM 
    session_events_aggregate