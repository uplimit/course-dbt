echo "Running the init script"

psql -f /dbt/scripts/init.sql
psql -d dbt -f /dbt/scripts/schema.sql
