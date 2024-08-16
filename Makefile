DEFAULT_PYTHON_VERSION = 3.12.2
DIRS = customers orders

install:
	pre-commit install
	for dir in $(DIRS); do \
		cd $$dir; \
		if [ -f .python-version ]; then \
			PYTHON_VERSION=`cat .python-version`; \
		else \
			PYTHON_VERSION=$(DEFAULT_PYTHON_VERSION); \
			printf "$(DEFAULT_PYTHON_VERSION)" > .python-version; \
		fi; \
		pyenv local $$PYTHON_VERSION; \
		poetry env use $$PYTHON_VERSION; \
		poetry install --no-root; \
		poetry run duckdb $$dir.duckdb -c "create schema if not exists raw"; \
		cd ../; \
	done; \
	cd customers; \
	poetry run duckdb customers.duckdb -c "create table if not exists raw.customers as select * from 'db_sources/raw_customers.csv'"; \
	poetry run dbt deps; \
	poetry run dbt build; \
	cd ../orders; \
	poetry run duckdb orders.duckdb -c "create table if not exists raw.orders as select * from 'db_sources/raw_orders.csv'"; \
	poetry run duckdb orders.duckdb -c "create table if not exists raw.payments as select * from 'db_sources/raw_payments.csv'"; \
	poetry run dbt deps; \
	poetry run dbt build; \


clean:
	for dir in $(DIRS); do \
		rm -rf $$dir/*.duckdb; \
		rm -rf $$dir/target; \
		rm -rf $$dir/.venv; \
		rm -rf $$dir/poetry.lock; \
	done