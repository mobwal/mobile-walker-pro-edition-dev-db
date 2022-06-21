CREATE TABLE dbo.cd_results (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_route uuid,
	fn_point uuid,
	fn_user bigint,
	n_longitude numeric(20,15),
	n_latitude numeric(20,15),
	jb_data jsonb,
	c_notice text,
	n_distance bigint,
	fn_template uuid,
	d_date timestamp without time zone,
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cd_results OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_results IS 'Результат выполнения';

COMMENT ON COLUMN dbo.cd_results.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_results.fn_route IS 'Маршрут';

COMMENT ON COLUMN dbo.cd_results.fn_point IS 'Точка маршрута';

COMMENT ON COLUMN dbo.cd_results.n_longitude IS 'Долгота';

COMMENT ON COLUMN dbo.cd_results.n_latitude IS 'Широта';

COMMENT ON COLUMN dbo.cd_results.jb_data IS 'JSON данные';

COMMENT ON COLUMN dbo.cd_results.d_date IS 'Дата создания';

COMMENT ON COLUMN dbo.cd_results.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE INDEX cd_results_fn_route_idx ON dbo.cd_results USING btree (fn_route);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_results
	ADD CONSTRAINT cd_results_pkey PRIMARY KEY (id);
