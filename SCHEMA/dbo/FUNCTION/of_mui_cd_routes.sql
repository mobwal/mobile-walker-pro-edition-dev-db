CREATE OR REPLACE FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) RETURNS TABLE(id uuid, c_name text, c_description text, b_check boolean)
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
    RETURN QUERY select r.id, r.c_name, r.c_description, false
    from dbo.cd_routes as r
	inner join dbo.cd_route_history as rh ON rh.fn_route = r.id
	inner join dbo.cs_route_statuses as rs ON rh.fn_status = rs.id
	where uir.f_user = (sender#>>'{id}')::bigint and (rs.c_const = 'ASSIGNED' or rs.c_const = 'NO_VERIFIED');
END
$$;

ALTER FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) IS 'Получение списка маршрутов';
