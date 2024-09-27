

{{
  config(
    materialized='view'
  )
}}

{%- set event_types = get_event_types() -%}

SELECT
  product_id
  {%- for event_type in event_types %}
    ,SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{event_type}}_total
  {% endfor %}
FROM {{ ref('stg_events') }}

WHERE product_id IS NOT NULL

GROUP BY 1
