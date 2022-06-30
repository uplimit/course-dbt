{% macro get_event_types() %}

{% set event_types = dbt_utils.get_column_values(table=ref('stg_greenery__events'), column='event_type') %}

{% endmacro %}
