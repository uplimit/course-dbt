{% set sql_statement %}
    select distinct quote_literal(event_type) as event_type, event_type as column_name from {{ ref('fct_events') }}
{% endset %}

{%- set event_types = dbt_utils.get_query_results_as_dict(sql_statement) -%}
