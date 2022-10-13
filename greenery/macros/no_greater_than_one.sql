{% macro no_greater_than_one(model) %}
SELECT *
FROM {{ model }}
WHERE {{ column_name }} > 1
{% endmacro %}