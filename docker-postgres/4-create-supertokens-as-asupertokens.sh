#!/bin/bash
set -e
export PGPASSWORD=$SUPERTOKENS_PASS;
psql -v ON_ERROR_STOP=1 --username "$SUPERTOKENS_USER"  --dbname "$DB_NAME" < /sql/supertokens-schema.sql