{% macro test_regex_test(model, column_name, regex_pattern) %}
    select
        {{ column_name }}
    from {{ model }}
    where
        {{ column_name }} is not null
        and NOT {{ column_name }} RLIKE '{{ regex_pattern }}'
{% endmacro %}