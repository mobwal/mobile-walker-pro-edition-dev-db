CREATE TABLE dbo.cd_collections (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_org bigint NOT NULL,
	c_address text NOT NULL,
	c_description text,
	n_longitude numeric(20,15),
	n_latitude numeric(20,15),
	c_imp_id text,
	c_append_data text,
	c_tag text,
	n_order integer NOT NULL,
	dx_created timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE dbo.cd_collections OWNER TO city;

COMMENT ON TABLE dbo.cd_collections IS 'Коллекция точек';

COMMENT ON COLUMN dbo.cd_collections.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_collections.f_org IS 'Идентификатор организации';

COMMENT ON COLUMN dbo.cd_collections.c_address IS 'Адрес';

COMMENT ON COLUMN dbo.cd_collections.c_description IS 'Описание';

COMMENT ON COLUMN dbo.cd_collections.n_longitude IS 'Долгота';

COMMENT ON COLUMN dbo.cd_collections.n_latitude IS 'Широта';

COMMENT ON COLUMN dbo.cd_collections.c_imp_id IS 'Идентификатор импорта';

COMMENT ON COLUMN dbo.cd_collections.c_append_data IS 'Дополнительные данные';

COMMENT ON COLUMN dbo.cd_collections.c_tag IS 'Метки';

COMMENT ON COLUMN dbo.cd_collections.n_order IS 'Сортировка';

COMMENT ON COLUMN dbo.cd_collections.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_collections
	ADD CONSTRAINT cd_collections_pkey PRIMARY KEY (id);
