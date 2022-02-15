echo "Running the init script"

# # Auto-start PostgreSQL server.
# [[ $(pg_ctl status | grep PID) ]] || pg_start > /dev/null

psql -f /dbt/scripts/init.sql
psql -d dbt -f /dbt/scripts/schema.sql
