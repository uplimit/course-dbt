



{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
select distinct
{{ column_name }}
from {{ relation }}
order by 1
{% endset %}

{% set results = run_query(relation_query) %}

{% if execute %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}


{% macro get_payment_methods() %}

{{ return(get_column_values('event_type', ref('stg_greenery_events'))) }}

{% endmacro %}
