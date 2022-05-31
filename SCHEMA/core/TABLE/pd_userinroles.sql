CREATE TABLE core.pd_userinroles (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_user integer NOT NULL,
	f_role integer NOT NULL,
	c_created_user text DEFAULT 'mobwal'::text NOT NULL,
	d_created_date timestamp with time zone DEFAULT now(),
	c_change_user text,
	d_change_date timestamp with time zone,
	sn_delete boolean DEFAULT false NOT NULL
);

ALTER TABLE core.pd_userinroles OWNER TO mobwal;

COMMENT ON TABLE core.pd_userinroles IS 'Пользователи в ролях';

COMMENT ON COLUMN core.pd_userinroles.id IS 'Идентификатор';

COMMENT ON COLUMN core.pd_userinroles.f_user IS 'Пользователь';

COMMENT ON COLUMN core.pd_userinroles.f_role IS 'Роль';

COMMENT ON COLUMN core.pd_userinroles.c_created_user IS 'Пользователь создавший запись';

COMMENT ON COLUMN core.pd_userinroles.d_created_date IS 'Дата создания записи';

COMMENT ON COLUMN core.pd_userinroles.c_change_user IS 'Пользователь обновивший запись';

COMMENT ON COLUMN core.pd_userinroles.d_change_date IS 'Дата обновления записи';

COMMENT ON COLUMN core.pd_userinroles.sn_delete IS 'Удален';

--------------------------------------------------------------------------------

CREATE TRIGGER pd_userinroles_log
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_userinroles
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userinroles
	ADD CONSTRAINT pd_userinroles_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userinroles
	ADD CONSTRAINT pd_userinroles_f_role_fkey FOREIGN KEY (f_role) REFERENCES core.pd_roles(id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userinroles
	ADD CONSTRAINT pd_userinroles_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);
