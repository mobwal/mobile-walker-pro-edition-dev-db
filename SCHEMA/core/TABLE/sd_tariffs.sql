CREATE FOREIGN TABLE core.sd_tariffs (
	id integer NOT NULL,
	b_month boolean NOT NULL,
	b_accounts boolean NOT NULL,
	c_name jsonb,
	c_const text NOT NULL,
	b_disk boolean NOT NULL
)
SERVER master_db
OPTIONS (schema_name 'blg', table_name 'sd_tariffs');

ALTER FOREIGN TABLE core.sd_tariffs ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.sd_tariffs ALTER COLUMN b_month OPTIONS (column_name 'b_month');

ALTER FOREIGN TABLE core.sd_tariffs ALTER COLUMN b_accounts OPTIONS (column_name 'b_accounts');

ALTER FOREIGN TABLE core.sd_tariffs ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE core.sd_tariffs ALTER COLUMN c_const OPTIONS (column_name 'c_const');

ALTER FOREIGN TABLE core.sd_tariffs ALTER COLUMN b_disk OPTIONS (column_name 'b_disk');

ALTER FOREIGN TABLE core.sd_tariffs OWNER TO city;
