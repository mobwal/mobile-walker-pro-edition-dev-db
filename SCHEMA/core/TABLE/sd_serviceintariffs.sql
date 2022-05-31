CREATE FOREIGN TABLE core.sd_serviceintariffs (
	id uuid NOT NULL,
	f_service integer NOT NULL,
	f_tariff integer NOT NULL,
	n_sum numeric NOT NULL,
	n_order integer,
	c_name jsonb,
	c_notice jsonb
)
SERVER master_db
OPTIONS (schema_name 'blg', table_name 'sd_serviceintariffs');

ALTER FOREIGN TABLE core.sd_serviceintariffs ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.sd_serviceintariffs ALTER COLUMN f_service OPTIONS (column_name 'f_service');

ALTER FOREIGN TABLE core.sd_serviceintariffs ALTER COLUMN f_tariff OPTIONS (column_name 'f_tariff');

ALTER FOREIGN TABLE core.sd_serviceintariffs ALTER COLUMN n_sum OPTIONS (column_name 'n_sum');

ALTER FOREIGN TABLE core.sd_serviceintariffs ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE core.sd_serviceintariffs ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE core.sd_serviceintariffs ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE core.sd_serviceintariffs OWNER TO city;
