CREATE FOREIGN TABLE core.cd_services (
	id integer NOT NULL,
	c_name text NOT NULL,
	c_description text,
	b_disabled boolean NOT NULL,
	dx_created date,
	n_order integer,
	jb_data jsonb,
	c_const text NOT NULL,
	b_base boolean NOT NULL,
	jb_requires jsonb
)
SERVER master_db
OPTIONS (schema_name 'blg', table_name 'cd_services');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN dx_created OPTIONS (column_name 'dx_created');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN n_order OPTIONS (column_name 'n_order');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN c_const OPTIONS (column_name 'c_const');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN b_base OPTIONS (column_name 'b_base');

ALTER FOREIGN TABLE core.cd_services ALTER COLUMN jb_requires OPTIONS (column_name 'jb_requires');

ALTER FOREIGN TABLE core.cd_services OWNER TO city;
