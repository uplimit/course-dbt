{% macro usd_to_eur(column_name, precision=2) %}
    ROUND(
       ( {{ column_name }}  / 0.91)::NUMERIC, -- for now this is static
       {{ precision }}
    )
{% endmacro %}