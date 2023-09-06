FROM gitpod/workspace-postgres

RUN pip install \
    dbt-core==1.4.5 \
    dbt-postgres==1.4.5 \
    dbt-redshift==1.4.0 \
    dbt-snowflake==1.4.2 \
    pgcli
