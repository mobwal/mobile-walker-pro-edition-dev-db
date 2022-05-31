CREATE FOREIGN TABLE core.pd_levels (
	id uuid NOT NULL,
	f_parent uuid,
	c_name text NOT NULL,
	c_imp_id text,
	f_org bigint NOT NULL,
	c_description text,
	b_disabled boolean NOT NULL,
	c_created_user text NOT NULL,
	d_created_date timestamp without time zone,
	c_change_user text,
	d_change_date timestamp without time zone
)
SERVER master_db
OPTIONS (schema_name 'core', table_name 'pd_levels');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN f_parent OPTIONS (column_name 'f_parent');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN c_imp_id OPTIONS (column_name 'c_imp_id');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN f_org OPTIONS (column_name 'f_org');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN c_description OPTIONS (column_name 'c_description');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN c_created_user OPTIONS (column_name 'c_created_user');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN d_created_date OPTIONS (column_name 'd_created_date');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN c_change_user OPTIONS (column_name 'c_change_user');

ALTER FOREIGN TABLE core.pd_levels ALTER COLUMN d_change_date OPTIONS (column_name 'd_change_date');

ALTER FOREIGN TABLE core.pd_levels OWNER TO city;
