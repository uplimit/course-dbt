{% macro get_event_types() %}

{% set event_types_query %}
select distinct
event_type
from stg_events
order by 1
{% endset %}

{% set results = run_query(event_types_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}