{% macro lbs_to_kgs(column_name, precision=2) %}
    ROUND(
       (CASE WHEN {{ column_name }} = -99 THEN NULL ELSE {{ column_name }} END / 2.205)::NUMERIC, 
       {{ precision }}
    )
{% endmacro %}