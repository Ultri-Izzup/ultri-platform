#!/bin/bash
pg_dump -s -O -h localhost -U postgres -d ultri -n nugget > ./docker-postgres/sql/nugget-schema.sql 
pg_dump -a -O -h localhost -U postgres -d ultri -t nugget.nugget_type > ./docker-postgres/sql/nugget-schema-types.sql 
pg_dump -a -O -h localhost -U postgres -d ultri -t nugget.tenant > ./docker-postgres/sql/tenants.sql 
pg_dump -s -O -h localhost -U postgres -d ultri -n nugget_api > ./docker-postgres/sql/api-schema.sql 
pg_dump -s -O -h localhost -U postgres -d ultri -n reporting > ./docker-postgres/sql/reporting-schema.sql
pg_dump -s -O -h localhost -U postgres -d ultri -n supertokens > ./docker-postgres/sql/supertokens-schema.sql 
# pg_dump --data-only  --column-inserts  -O -h localhost -U postgres -d ultri --table nugget_api.org_roles  > ./docker-postgres/sql/api-org-roles.sql 