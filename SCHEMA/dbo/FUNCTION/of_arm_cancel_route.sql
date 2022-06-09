CREATE OR REPLACE FUNCTION dbo.of_arm_cancel_route(sender jsonb, _f_route uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {jsonb} sender - текущий пользователь
 * @params {uuid} _f_route - иден. маршрута
 *
 * @example
 * [{ "action": "of_arm_cancel_route", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _f_route] }], "type": "rpc", "tid": 0 }]
 */
BEGIN
	update dbo.cd_routes as r
	set f_status = (select rs.id from dbo.cs_route_statuses as rs where rs.c_const = 'CANCEL')
	where r.id = _f_route;
	
	perform core.sf_write_log('Принудительное закрытие маршрута', _f_route::text, 0);
END
$$;

ALTER FUNCTION dbo.of_arm_cancel_route(sender jsonb, _f_route uuid) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_arm_cancel_route(sender jsonb, _f_route uuid) IS 'Открытая функция по закрытию маршрута';
