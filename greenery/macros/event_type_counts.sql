{%- macro event_type_counts(ref_table, ref_column, count_column) -%}

    {% set list = dbt_utils.get_column_values(
        table = ref( ref_table ),
        column =  ref_column 
    ) %}

    {%- for list_item in list -%}
        count(
            case
                when {{ ref_column }} = '{{ list_item }}'
                    then {{ count_column }}
                else null
            end
        )               as {{list_item}}_count
        {%- if not loop.last -%}
        , 
        {%- endif -%}
    {%- endfor -%}

{%- endmacro -%}