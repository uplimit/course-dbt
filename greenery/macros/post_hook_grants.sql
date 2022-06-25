{% macro grant_select(role) %}
{% set grants %}
    GRANT USAGE ON SCHEMA {{ target.schema }} TO  {{role}};
    GRANT SELECT ON {{ this }} TO {{role}};

{% endset %}

{% do run_query(grants) %}
{% do log("Privileges granted", info=True) %}
{% endmacro %}