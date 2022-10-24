{% macro row_to_columns(table_name,column_name,count_column) %}

    {% set new_columns = dbt_utils.get_column_values(
        table = ref( table_name ),
        column = column_name
    ) %}
    {% for new_column in new_columns %}
        count( case when {{ column_name }} = '{{ new_column }}' 
        then {{count_column}}
        else NULL
        end ) as {{new_column}}_count
        {% if not loop.last %}
        ,
        {% endif %}
    {% endfor %}

{% endmacro %}

