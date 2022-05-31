CREATE OR REPLACE FUNCTION core.sf_remove_outdated() RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
* системная функция должна выполнять от postgres
*/
DECLARE
    _n_day_del_after     	integer = 14; -- Удаление старых данных через N дней
	_dg_cnt					integer; --diagnostic
	_dg_text				text = '';
BEGIN

	select c_value::integer into _n_day_del_after
	from core.sd_settings
	where c_key = 'N_DAY_DEL_AFTER';

	delete from core.sd_action_log where (d_date  + (_n_day_del_after * '1 day'::interval)) < now();
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || now()::text || ' core.sd_action_log: удалено '|| _dg_cnt::text || E'\n';
	
	delete from core.sd_sys_log where (dx_created  + (_n_day_del_after * '1 day'::interval)) < now();
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || now()::text || ' core.sd_sys_log: удалено '|| _dg_cnt::text || E'\n';
	
	-- если пользователь заблокирован, то нужно очистить данные по нему
	perform core.sf_clear_data(u.id) from core.pd_users as u
	where u.f_org = u.id and u.b_disabled = true and u.sn_delete = false;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || now()::text || ' core.sf_clear_data: очистка '|| _dg_cnt::text || E'\n';

	perform core.sf_write_log('Очистка таблиц выполнена. ' || E'\n' || _dg_text, null, 0);

	EXCEPTION
	WHEN OTHERS
    THEN 
		perform core.sf_write_log('Непредвиденная ошибка очистки таблиц. ' || E'\n' || _dg_text, null, 1);

END;
$$;

ALTER FUNCTION core.sf_remove_outdated() OWNER TO pgagent;

COMMENT ON FUNCTION core.sf_remove_outdated() IS 'Процедура очистки устаревших данных';
