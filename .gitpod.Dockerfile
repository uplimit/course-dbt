FROM gitpod/workspace-postgres

RUN pip install \
    dbt-core==1.6.1 \
    dbt-postgres==1.6.1 \
    dbt-redshift==1.6.1 \
    dbt-snowflake==1.6.2
