# dbt-opiner demo: multi project repo
Single repo with multiple projects for dbt-opiner demo and testing.

## Installation
This repo contains two dbt projects, each project contains their own poetry environment and dbt project configuration.

To setup both projects: 
- Install [poetry](https://python-poetry.org/docs/#installation)
- Install [duckdb](https://duckdb.org/docs/installation)
- Run `make install` in the root directory of this repo.

To clean the environments run `make clean`. This will delete duckdb local databases, dbt target and .venv folders, and  poetry.lock file.
