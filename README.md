# Analytics engineering with dbt

Questions to week 1 project:
Q: How many users do we have?
A: 130

Q: On average, how many orders do we receive per hour?
A: 7.52

Q: On average, how long does an order take from being placed to being delivered?
A: 3.89

Q: How many users have only made one purchase? Two purchases? Three+ purchases?
A: 1 order- 25, 2 orders - 28, 3+ orders - 71

Q: On average, how many unique sessions do we have per hour?
A: 16.33

# Updating dbt version

To update dbt version you need to edit `.gitpod.yml` file and put a specific verion of dbt adapter you want to use:

```yaml
image: ghcr.io/dbt-labs/dbt-snowflake:1.8.3. # update version here
...
```

If you run `dbt --version` you may see that dbt-core might be slightly behind the latest version, but that's fine as soon as adapter version is up-to-date.


## License
GPL-3.0
