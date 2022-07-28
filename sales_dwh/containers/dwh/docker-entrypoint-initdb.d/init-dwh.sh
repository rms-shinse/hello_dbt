#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE TABLE IF NOT EXISTS sales_person_team (
		id serial PRIMARY KEY,
		who VARCHAR(255) NOT NULL,
		team VARCHAR(255) NOT NULL
	);

	COPY sales_person_team(who, team)
	FROM '/docker-entrypoint-initdb.d/sales_person_team.csv'
	DELIMITER ','
	CSV HEADER;

	CREATE TABLE IF NOT EXISTS contracts (
		id serial PRIMARY KEY,
		who_selled VARCHAR(255) NOT NULL,
		what_selled VARCHAR(255) NOT NULL,
		created_at TIMESTAMP NOT NULL,
		amount INT NOT NULL
	);

	COPY contracts(who_selled, what_selled, created_at, amount)
	FROM '/docker-entrypoint-initdb.d/contracts.csv'
	DELIMITER ','
	CSV HEADER;
EOSQL
