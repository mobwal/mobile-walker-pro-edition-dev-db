CREATE FOREIGN TABLE core.sd_disk_use (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_org bigint NOT NULL,
	f_service integer NOT NULL,
	n_size bigint NOT NULL,
	d_date_modify timestamp without time zone,
	n_period date NOT NULL
)
SERVER master_db
OPTIONS (schema_name 'blg', table_name 'sd_disk_use');

ALTER FOREIGN TABLE core.sd_disk_use ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.sd_disk_use ALTER COLUMN f_org OPTIONS (column_name 'f_org');

ALTER FOREIGN TABLE core.sd_disk_use ALTER COLUMN f_service OPTIONS (column_name 'f_service');

ALTER FOREIGN TABLE core.sd_disk_use ALTER COLUMN n_size OPTIONS (column_name 'n_size');

ALTER FOREIGN TABLE core.sd_disk_use ALTER COLUMN d_date_modify OPTIONS (column_name 'd_date_modify');

ALTER FOREIGN TABLE core.sd_disk_use ALTER COLUMN n_period OPTIONS (column_name 'n_period');

ALTER FOREIGN TABLE core.sd_disk_use OWNER TO city;
