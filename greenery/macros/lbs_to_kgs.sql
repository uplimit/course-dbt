{% macro lbs_to_kgs(column_name, precision=2) %}
    ROUND(
       ({{ column_name }} / 2.205)::NUMERIC, 
       {{ precision }}
    )
{% endmacro %}