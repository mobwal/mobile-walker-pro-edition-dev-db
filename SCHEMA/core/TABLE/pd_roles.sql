CREATE FOREIGN TABLE core.pd_roles (
	id integer NOT NULL,
	c_name text NOT NULL,
	c_description text,
	n_weight integer,
	c_created_user text NOT NULL,
	d_created_date timestamp without time zone,
	c_change_user text,
	d_change_date timestamp with time zone,
	sn_delete boolean NOT NULL
)
SERVER master_db
OPTIONS (schema_name 'core', table_name 'pd_roles');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN n_weight OPTIONS (column_name 'n_weight');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN c_created_user OPTIONS (column_name 'c_created_user');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN d_created_date OPTIONS (column_name 'd_created_date');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN c_change_user OPTIONS (column_name 'c_change_user');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN d_change_date OPTIONS (column_name 'd_change_date');

ALTER FOREIGN TABLE core.pd_roles ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE core.pd_roles OWNER TO city;
