#!/bin/bash
set -e
export PGPASSWORD=$API_PASS;
psql -v ON_ERROR_STOP=1 --username "$API_USER"  --dbname "$DB_NAME" < /sql/reporting-schema.sql