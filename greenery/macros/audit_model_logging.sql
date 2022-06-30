{% macro audit_model_logging(event_type) %}

{% if target.name == "prod" or var('override_logging') == True %}

{% call statement('audit', fetch_result=False) %}

-- Meta insert

INSERT INTO {{target.database}}.audits.model_logging

SELECT

'{{ event_type }}',

'{{ model.name }}',

'{{ model.alias }}',

'{{ this.schema }}',

'{{ this.table }}',

'{{ model.config.materialized }}',

'{{ flags.FULL_REFRESH }}',

-- These fields should only be populated for end runs

(CASE WHEN '{{ event_type }}' = 'START' THEN NULL ELSE info_schema.table_type END),

(CASE WHEN '{{ event_type }}' = 'START' THEN NULL ELSE info_schema.is_transient END),

(CASE WHEN '{{ event_type }}' = 'START' THEN NULL ELSE info_schema.clustering_key END),

(CASE WHEN '{{ event_type }}' = 'START' THEN NULL ELSE info_schema.row_count END),

(CASE WHEN '{{ event_type }}' = 'START' THEN NULL ELSE info_schema.bytes END),

(CASE WHEN '{{ event_type }}' = 'START' THEN NULL ELSE info_schema.retention_time END),

CURRENT_TIMESTAMP,

(SELECT MAX(run_id) FROM {{ target.database }}.audits.run_logging)

-- Hack to allow for start queries if model has never been created before

FROM VALUES ('placeholder')

LEFT JOIN (

SELECT * FROM information_schema.tables

WHERE table_catalog = UPPER('{{ target.name }}')

AND table_schema = UPPER('{{ this.schema }}')

AND table_name = UPPER('{{ this.table }}')

) info_schema

ON 1 = 1

{%- endcall %}

{% endif %}

{% endmacro %}