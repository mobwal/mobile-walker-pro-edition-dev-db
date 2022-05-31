CREATE OR REPLACE FUNCTION core.sf_clear_data(_f_org bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
* системная функция должна выполнять от postgres
* @params _f_org {bigint} - иден. пользователя
*/
DECLARE
	_dg_cnt					integer; --diagnostic
	_dg_text				text = '';
BEGIN

	delete from dbo.cd_points as p where p.f_org = _f_org;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || now()::text || ' dbo.cd_points: удалено '|| _dg_cnt::text || E'\n';
	
	delete from dbo.cd_routes as r where r.f_org = _f_org;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || now()::text || ' dbo.cd_routes: удалено '|| _dg_cnt::text || E'\n';
	
	delete from dbo.cd_collections as c where c.f_org = _f_org;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || now()::text || ' dbo.cd_collections: удалено '|| _dg_cnt::text || E'\n';
	
	delete from dbo.cd_templates as t where t.f_org = _f_org;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || now()::text || ' dbo.cd_templates: удалено '|| _dg_cnt::text || E'\n';

	perform core.sf_write_log('Очистка таблиц пользователя ' || _f_org::text || ' выполнена. ' || E'\n' || _dg_text, null, 0);

	EXCEPTION
	WHEN OTHERS
    THEN 
		perform core.sf_write_log('Непредвиденная ошибка очистки пользователя ' || _f_org::text || '.' || E'\n' || _dg_text, null, 1);

END;
$$;

ALTER FUNCTION core.sf_clear_data(_f_org bigint) OWNER TO city;

COMMENT ON FUNCTION core.sf_clear_data(_f_org bigint) IS 'Процедура очистки удаления данных по организации';
