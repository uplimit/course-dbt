echo "Running the command script"
mkdir -p /workspace/.dbt
ln -snf /workspace/.dbt ~/.dbt

export PGPASSWORD=gitpod PGDATABASE=dbt
