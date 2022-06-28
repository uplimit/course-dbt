{%- macro get_non_null_column_values(model_name,column_name) -%}

{%- set non_null_column_query -%}
SELECT 
    distinct{{column_name}}
FROM {{ ref(model_name) }}
WHERE {{column_name}} IS NOT NULL
ORDER BY distinct{{column_name}}
{%- endset -%}

{%- set results = run_query(non_null_column_query) -%}

{{ log(results, info=True) }}

{{ return([]) }}

{%- endmacro -%}