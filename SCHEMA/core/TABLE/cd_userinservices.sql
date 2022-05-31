CREATE FOREIGN TABLE core.cd_userinservices (
	id uuid NOT NULL,
	f_service integer NOT NULL,
	f_org bigint NOT NULL,
	d_date_activate timestamp without time zone NOT NULL,
	d_date_deactivate timestamp without time zone,
	d_date_disabled timestamp without time zone,
	b_disabled boolean NOT NULL
)
SERVER master_db
OPTIONS (schema_name 'blg', table_name 'cd_userinservices');

ALTER FOREIGN TABLE core.cd_userinservices ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.cd_userinservices ALTER COLUMN f_service OPTIONS (column_name 'f_service');

ALTER FOREIGN TABLE core.cd_userinservices ALTER COLUMN f_org OPTIONS (column_name 'f_org');

ALTER FOREIGN TABLE core.cd_userinservices ALTER COLUMN d_date_activate OPTIONS (column_name 'd_date_activate');

ALTER FOREIGN TABLE core.cd_userinservices ALTER COLUMN d_date_deactivate OPTIONS (column_name 'd_date_deactivate');

ALTER FOREIGN TABLE core.cd_userinservices ALTER COLUMN d_date_disabled OPTIONS (column_name 'd_date_disabled');

ALTER FOREIGN TABLE core.cd_userinservices ALTER COLUMN b_disabled OPTIONS (column_name 'b_disabled');

ALTER FOREIGN TABLE core.cd_userinservices OWNER TO city;
