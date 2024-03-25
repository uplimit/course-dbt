{% macro lbs_to_kgs(column_name, precision=2) %}
    round(
        (
            case when {{ column_name }} = -99 then null else {{ column_name }} end
            / 2.205
        )::numeric,
        {{ precision }}
    )
{% endmacro %}
