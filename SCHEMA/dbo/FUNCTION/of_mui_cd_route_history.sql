CREATE OR REPLACE FUNCTION dbo.of_mui_cd_route_history(sender jsonb, _c_version text) RETURNS TABLE(id uuid, f_route uuid, f_status integer, f_user bigint, d_date timestamp without time zone, c_notice text)
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
		rh.f_route,
		rh.f_status,
		rh.f_user,
		rh.d_date,
		rh.c_notice
	from dbo.cd_route_history as rh
	inner join dbo.cd_routes as r ON r.id = rh.f_route
	where rh.f_user = (sender#>>'{id}')::bigint;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_route_history(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_route_history(sender jsonb, _c_version text) IS 'История маршрута';
