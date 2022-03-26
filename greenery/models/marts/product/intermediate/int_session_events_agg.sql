{% set sql_statement %}
    select distinct quote_literal(event_type) as event_type, event_type as column_name from {{ ref('fct_events') }}
{% endset %}

{%- set event_types = dbt_utils.get_query_results_as_dict(sql_statement) -%}

SELECT
    {{ dbt_utils.surrogate_key(['session_id', 'user_id', 'created_at_utc', 'event_type', 'page_url']) }} AS unique_key
    ,session_id
    ,created_at_utc
    ,user_id
    ,product_id
    ,order_id
    {% for event_type in event_types['event_type'] %}
    ,SUM(CASE WHEN event_type = {{event_type}} THEN 1 ELSE 0 END) AS {{ event_types['column_name'][loop.index0] }}
    {% endfor %}
FROM {{ ref('stg_events') }}

{{ dbt_utils.group_by(6) }}

