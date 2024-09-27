# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

# Updating dbt version

To update dbt version you need to edit `.gitpod.yml` file and put a specific verion of dbt adapter you want to use:

```yaml
image: ghcr.io/dbt-labs/dbt-snowflake:1.8.3. # update version here
...
```

If you run `dbt --version` you may see that dbt-core might be slightly behind the latest version, but that's fine as soon as adapter version is up-to-date.


## License
GPL-3.0
