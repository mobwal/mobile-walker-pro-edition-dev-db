CREATE FOREIGN TABLE core.sd_invoices (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_org bigint NOT NULL,
	n_sum numeric NOT NULL,
	d_date_modify timestamp without time zone,
	n_period date NOT NULL
)
SERVER master_db
OPTIONS (schema_name 'blg', table_name 'sd_invoices');

ALTER FOREIGN TABLE core.sd_invoices ALTER COLUMN id OPTIONS (column_name 'id');

ALTER FOREIGN TABLE core.sd_invoices ALTER COLUMN f_org OPTIONS (column_name 'f_org');

ALTER FOREIGN TABLE core.sd_invoices ALTER COLUMN n_sum OPTIONS (column_name 'n_sum');

ALTER FOREIGN TABLE core.sd_invoices ALTER COLUMN d_date_modify OPTIONS (column_name 'd_date_modify');

ALTER FOREIGN TABLE core.sd_invoices ALTER COLUMN n_period OPTIONS (column_name 'n_period');

ALTER FOREIGN TABLE core.sd_invoices OWNER TO city;
