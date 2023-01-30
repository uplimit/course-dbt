{%- macro get_event_type_counts() -%}
  {%- set event_types = dbt_utils.get_column_values(
                       table=ref('stg_postgres__events'),
                       column='event_type') -%}
    {%- for event in event_types %}
        count_if(event_type = '{{event}}') as {{event}}_in_session
    {%- if not loop.last -%},{%- endif -%}
  {%- endfor -%}
{% endmacro %}