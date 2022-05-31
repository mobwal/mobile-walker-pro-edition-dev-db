CREATE OR REPLACE FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) RETURNS TABLE(id uuid, c_name text, c_description text)
    LANGUAGE plpgsql STABLE ROWS 100
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_routes", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select rh.id, rh.fn_route, rh.fn_status, rh.fn_user, concat(u.c_first_name, ' ', u.c_last_name, ' ', u.c_middle_name), rh.d_date, rh.c_notice
    from dbo.cd_userinroutes as uir
	left join core.pd_users as u on u.id = uir.f_user
	LEFT JOIN dbo.cd_route_history as rh ON rh.fn_route = uir.f_route
	where uir.f_user = (sender#>>'{id}')::bigint and dbo.sf_is_mobile_route(uir.f_route);
END
$$;

ALTER FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) OWNER TO city;

COMMENT ON FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) IS 'Получение списка маршрутов';
