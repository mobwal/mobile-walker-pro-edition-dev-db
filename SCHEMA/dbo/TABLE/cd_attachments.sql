CREATE TABLE dbo.cd_attachments (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user bigint,
	fn_result uuid,
	fn_point uuid,
	fn_route uuid,
	n_longitude numeric(20,15),
	n_latitude numeric(20,15),
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	n_distance bigint,
	f_storage uuid,
	d_date timestamp without time zone
);

ALTER TABLE dbo.cd_attachments OWNER TO "mobwal-cloud";

COMMENT ON TABLE dbo.cd_attachments IS 'Файлы';

COMMENT ON COLUMN dbo.cd_attachments.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_attachments.fn_user IS 'Пользователь';

COMMENT ON COLUMN dbo.cd_attachments.fn_result IS 'Результат';

COMMENT ON COLUMN dbo.cd_attachments.fn_point IS 'Точка';

COMMENT ON COLUMN dbo.cd_attachments.fn_route IS 'Маршрут';

COMMENT ON COLUMN dbo.cd_attachments.n_longitude IS 'Долгота';

COMMENT ON COLUMN dbo.cd_attachments.n_latitude IS 'Широта';

COMMENT ON COLUMN dbo.cd_attachments.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_attachments
	ADD CONSTRAINT cd_attachments_pkey PRIMARY KEY (id);
