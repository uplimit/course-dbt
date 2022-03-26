{% macro calculate_rates(numerator_column_name, denominator_column_name, dp = 2) %}
 
   round(
       ({{ numerator_column_name }}::numeric /
       NULLIF({{denominator_column_name }}::numeric, 0))
        * 100, {{dp}})

{% endmacro %}

