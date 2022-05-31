CREATE FOREIGN TABLE core.pd_userinroles (
	id uuid NOT NULL,
	f_user integer NOT NULL,
	f_role integer NOT NULL,
	c_created_user text NOT NULL,
	d_created_date timestamp with time zone,
	c_change_user text,
	d_change_date timestamp with time zone,
	sn_delete boolean NOT NULL
)
SERVER master_db
OPTIONS (schema_name 'core', table_name 'pd_userinroles');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN f_user OPTIONS (column_name 'f_user');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN f_role OPTIONS (column_name 'f_role');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN c_created_user OPTIONS (column_name 'c_created_user');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN d_created_date OPTIONS (column_name 'd_created_date');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN c_change_user OPTIONS (column_name 'c_change_user');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN d_change_date OPTIONS (column_name 'd_change_date');

ALTER FOREIGN TABLE core.pd_userinroles ALTER COLUMN sn_delete OPTIONS (column_name 'sn_delete');

ALTER FOREIGN TABLE core.pd_userinroles OWNER TO city;
