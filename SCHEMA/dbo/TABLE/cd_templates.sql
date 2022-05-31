CREATE TABLE dbo.cd_templates (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_org bigint NOT NULL,
	c_name text NOT NULL,
	c_template text NOT NULL,
	c_layout text NOT NULL,
	c_description text,
	n_order integer NOT NULL,
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	sn_delete boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cd_templates OWNER TO city;

COMMENT ON TABLE dbo.cd_templates IS 'Шаблоны результатов';

COMMENT ON COLUMN dbo.cd_templates.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_templates.f_org IS 'Идентификатор организации';

COMMENT ON COLUMN dbo.cd_templates.c_name IS 'Пользовательское имя шаблона';

COMMENT ON COLUMN dbo.cd_templates.c_template IS 'Шаблон';

COMMENT ON COLUMN dbo.cd_templates.c_layout IS 'Разметка из кода';

COMMENT ON COLUMN dbo.cd_templates.c_description IS 'Описание';

COMMENT ON COLUMN dbo.cd_templates.n_order IS 'Сортировка';

COMMENT ON COLUMN dbo.cd_templates.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_templates
	ADD CONSTRAINT cd_templates_pkey PRIMARY KEY (id);
