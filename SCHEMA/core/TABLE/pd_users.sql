CREATE TABLE core.pd_users (
	id bigint DEFAULT nextval('core.pd_users_id_seq'::regclass) NOT NULL,
	c_login text NOT NULL,
	c_password text,
	s_hash text,
	jb_data jsonb,
	c_about text,
	c_name text,
	c_post text,
	c_imp_id text,
	f_level uuid,
	c_notice text,
	c_email text,
	c_version text,
	n_version bigint,
	d_last_auth_date timestamp without time zone,
	d_last_change_password timestamp without time zone,
	c_created_user text DEFAULT 'mobwal'::text NOT NULL,
	d_created_date timestamp without time zone DEFAULT now() NOT NULL,
	c_change_user text DEFAULT 'mobwal'::text,
	d_change_date timestamp without time zone,
	b_disabled boolean DEFAULT false NOT NULL,
	sn_delete boolean DEFAULT false NOT NULL,
	d_date_remove timestamp without time zone,
	b_back_pay boolean DEFAULT false NOT NULL
);

ALTER TABLE core.pd_users OWNER TO mobwal;

COMMENT ON TABLE core.pd_users IS 'Пользователи';

COMMENT ON COLUMN core.pd_users.id IS 'Идентификатор';

COMMENT ON COLUMN core.pd_users.c_login IS 'Логин';

COMMENT ON COLUMN core.pd_users.c_password IS 'Пароль';

COMMENT ON COLUMN core.pd_users.s_hash IS 'Hash';

COMMENT ON COLUMN core.pd_users.c_about IS 'О себе';

COMMENT ON COLUMN core.pd_users.c_name IS 'Имя/ФИО';

COMMENT ON COLUMN core.pd_users.c_post IS 'Должность/Пост';

COMMENT ON COLUMN core.pd_users.c_imp_id IS 'Идентификатор для импорта/экспорта';

COMMENT ON COLUMN core.pd_users.c_notice IS 'Примечание, которое указывается администратором ';

COMMENT ON COLUMN core.pd_users.c_email IS 'Адрес электронной почты';

COMMENT ON COLUMN core.pd_users.c_version IS 'Версия приложения';

COMMENT ON COLUMN core.pd_users.n_version IS 'Числовой вариант версии приложения';

COMMENT ON COLUMN core.pd_users.d_last_auth_date IS 'Дата последней авторизации';

COMMENT ON COLUMN core.pd_users.d_last_change_password IS 'Дата изменения пароля';

COMMENT ON COLUMN core.pd_users.d_created_date IS 'Дата создания записи';

COMMENT ON COLUMN core.pd_users.d_change_date IS 'Дата обновления записи';

COMMENT ON COLUMN core.pd_users.b_disabled IS 'Отключен';

COMMENT ON COLUMN core.pd_users.sn_delete IS 'Удален';

COMMENT ON COLUMN core.pd_users.d_date_remove IS 'Дата удаления';

COMMENT ON COLUMN core.pd_users.b_back_pay IS 'Оплата по факту периода. Разрешено заходить в минус';

--------------------------------------------------------------------------------

CREATE INDEX pd_users_b_disabled_sn_delete_idx ON core.pd_users USING btree (b_disabled, sn_delete);

--------------------------------------------------------------------------------

CREATE TRIGGER pd_users_log
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_users
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_log_action();

--------------------------------------------------------------------------------

CREATE TRIGGER pd_users_trigger_version
	BEFORE INSERT OR UPDATE ON core.pd_users
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_convert_version();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_uniq_c_login UNIQUE (c_login);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_f_level_fkey FOREIGN KEY (f_level) REFERENCES core.pd_levels(id);
