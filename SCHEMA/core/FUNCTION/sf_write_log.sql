CREATE OR REPLACE FUNCTION core.sf_write_log(_c_message text, c_data text, _n_level integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {text} _c_message - текст лога
 * @params {integer} _n_level - уровень логирования
 */
BEGIN
	insert into core.sd_sys_log(n_level_msg, dx_created, c_description)
	values (_n_level, now(), _c_message);
END
$$;

ALTER FUNCTION core.sf_write_log(_c_message text, c_data text, _n_level integer) OWNER TO city;

COMMENT ON FUNCTION core.sf_write_log(_c_message text, c_data text, _n_level integer) IS 'Запись логов';
