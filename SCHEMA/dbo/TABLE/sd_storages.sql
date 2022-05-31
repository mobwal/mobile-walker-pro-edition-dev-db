CREATE FOREIGN TABLE dbo.sd_storages (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text NOT NULL,
	n_length integer NOT NULL,
	d_date date NOT NULL,
	f_user bigint NOT NULL,
	f_org bigint NOT NULL,
	f_service integer NOT NULL,
	d_date_expired date,
	c_dir text NOT NULL,
	c_mime text NOT NULL,
	ba_data text NOT NULL
)
SERVER master_db
OPTIONS (schema_name 'dbo', table_name 'sd_storages');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN n_length OPTIONS (column_name 'n_length');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN d_date OPTIONS (column_name 'd_date');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN f_org OPTIONS (column_name 'f_org');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN f_service OPTIONS (column_name 'f_service');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN d_date_expired OPTIONS (column_name 'd_date_expired');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN c_dir OPTIONS (column_name 'c_dir');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN c_mime OPTIONS (column_name 'c_mime');

ALTER FOREIGN TABLE dbo.sd_storages ALTER COLUMN ba_data OPTIONS (column_name 'ba_data');

ALTER FOREIGN TABLE dbo.sd_storages OWNER TO city;
