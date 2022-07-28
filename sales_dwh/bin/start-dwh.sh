#!/bin/bash

docker container rm hello_dbh_sales_dwh; 

docker run \
  --name hello_dbh_sales_dwh \
  -e POSTGRES_PASSWORD=mypostgrespassword \
  -e POSTGRES_USER=mypostgressuser \
  -e POSTGRES_DB=salesdwh \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v $(pwd)/containers/dwh/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d \
  -v $(pwd)/containers/dwh/data:/var/lib/postgresql/data/pgdata \
  -p 5432:5432 \
  postgres:14.4-alpine
