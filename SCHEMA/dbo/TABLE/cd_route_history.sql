CREATE TABLE dbo.cd_route_history (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_route uuid NOT NULL,
	f_status integer NOT NULL,
	f_user integer NOT NULL,
	c_notice text,
	dx_created timestamp without time zone DEFAULT now()
);

ALTER TABLE dbo.cd_route_history OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_route_history IS 'История изменения статусов заданий';

COMMENT ON COLUMN dbo.cd_route_history.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_route_history.f_route IS 'Задание';

COMMENT ON COLUMN dbo.cd_route_history.f_status IS 'Статус';

COMMENT ON COLUMN dbo.cd_route_history.f_user IS 'Пользователь';

COMMENT ON COLUMN dbo.cd_route_history.c_notice IS 'Примечание';

COMMENT ON COLUMN dbo.cd_route_history.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_route_history
	ADD CONSTRAINT cd_route_history_pkey PRIMARY KEY (id);
