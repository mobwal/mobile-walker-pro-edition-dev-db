CREATE TABLE core.pd_levels (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_parent uuid,
	c_name text NOT NULL,
	c_imp_id text,
	c_description text,
	b_disabled boolean DEFAULT false NOT NULL,
	c_created_user text DEFAULT 'mobwal'::text NOT NULL,
	d_created_date timestamp without time zone DEFAULT now(),
	c_change_user text,
	d_change_date timestamp without time zone
);

ALTER TABLE core.pd_levels OWNER TO mobwal;

COMMENT ON TABLE core.pd_levels IS 'Подразделения (уровни)';

COMMENT ON COLUMN core.pd_levels.id IS 'Идентификатор';

COMMENT ON COLUMN core.pd_levels.f_parent IS 'Родитель';

COMMENT ON COLUMN core.pd_levels.c_name IS 'Наименование';

COMMENT ON COLUMN core.pd_levels.c_imp_id IS 'Идентификатор импорта';

COMMENT ON COLUMN core.pd_levels.c_description IS 'Описание';

COMMENT ON COLUMN core.pd_levels.d_created_date IS 'Дата создания';

COMMENT ON COLUMN core.pd_levels.d_change_date IS 'Дата модификации';

--------------------------------------------------------------------------------

CREATE INDEX pd_levels_f_parent_idx ON core.pd_levels USING btree (f_parent);

--------------------------------------------------------------------------------

CREATE TRIGGER pd_levels_log
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_levels
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_levels
	ADD CONSTRAINT pd_levels_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_levels
	ADD CONSTRAINT pd_levels_f_parent_fkey FOREIGN KEY (f_parent) REFERENCES core.pd_levels(id);
