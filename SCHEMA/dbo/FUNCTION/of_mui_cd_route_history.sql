CREATE OR REPLACE FUNCTION dbo.of_mui_cd_route_history(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_status integer, fn_user bigint, d_date timestamp without time zone, c_notice text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_route_history", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		rh.id,
		rh.fn_route,
		rh.fn_status,
		rh.fn_user,
		rh.d_date,
		rh.c_notice
	from dbo.cd_route_history as rh
	inner join dbo.cd_routes as r ON r.id = rh.fn_route
	where r.f_org = (sender#>>'{f_org}')::bigint;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_route_history(sender jsonb, _c_version text) OWNER TO city;

COMMENT ON FUNCTION dbo.of_mui_cd_route_history(sender jsonb, _c_version text) IS 'История маршрута';
