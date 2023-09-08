{{
  config(
    materialized='view'
  )
}}

{%- set event_types = get_event_types() -%}

SELECT
  user_id,
  session_id
  {%- for event_type in event_types %}
    ,SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{event_type}}_total
  {% endfor %}
  , CASE WHEN checkout_total = 0 THEN 0 ELSE 1 END AS has_converted

FROM {{ ref('stg_events') }}

GROUP BY 1,2
