CREATE FOREIGN TABLE core.pd_users (
	id bigint NOT NULL,
	c_login text NOT NULL,
	c_password text,
	s_hash text,
	jb_data jsonb,
	c_about text,
	c_name text,
	c_post text,
	c_imp_id text,
	f_org bigint,
	f_level uuid,
	c_notice text,
	c_email text,
	c_version text,
	n_version bigint,
	d_last_auth_date timestamp without time zone,
	d_last_change_password timestamp without time zone,
	c_created_user text NOT NULL,
	d_created_date timestamp without time zone,
	c_change_user text,
	d_change_date timestamp without time zone,
	b_disabled boolean,
	sn_delete boolean,
	d_date_remove timestamp without time zone
)
SERVER master_db
OPTIONS (schema_name 'core', table_name 'pd_users');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_login OPTIONS (column_name 'c_login');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_password OPTIONS (column_name 'c_password');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN s_hash OPTIONS (column_name 's_hash');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN jb_data OPTIONS (column_name 'jb_data');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_about OPTIONS (column_name 'c_about');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_name OPTIONS (column_name 'c_name');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_post OPTIONS (column_name 'c_post');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_imp_id OPTIONS (column_name 'c_imp_id');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN f_org OPTIONS (column_name 'f_org');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN f_level OPTIONS (column_name 'f_level');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_notice OPTIONS (column_name 'c_notice');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_email OPTIONS (column_name 'c_email');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_version OPTIONS (column_name 'c_version');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN n_version OPTIONS (column_name 'n_version');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN d_last_auth_date OPTIONS (column_name 'd_last_auth_date');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN d_last_change_password OPTIONS (column_name 'd_last_change_password');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_created_user OPTIONS (column_name 'c_created_user');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN d_created_date OPTIONS (column_name 'd_created_date');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN c_change_user OPTIONS (column_name 'c_change_user');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN d_change_date OPTIONS (column_name 'd_change_date');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE core.pd_users ALTER COLUMN d_date_remove OPTIONS (column_name 'd_date_remove');

ALTER FOREIGN TABLE core.pd_users OWNER TO city;
