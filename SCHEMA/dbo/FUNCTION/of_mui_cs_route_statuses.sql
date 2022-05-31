CREATE OR REPLACE FUNCTION dbo.of_mui_cs_route_statuses(sender jsonb, _c_version text) RETURNS TABLE(id integer, c_const text, n_order integer, b_disabled boolean)
    LANGUAGE plpgsql STABLE ROWS 10
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cs_route_statuses", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		rs.id,
		rs.c_const,
		rs.n_order,
		rs.b_disabled
	from dbo.cs_route_statuses as rs;
END
$$;

ALTER FUNCTION dbo.of_mui_cs_route_statuses(sender jsonb, _c_version text) OWNER TO city;

COMMENT ON FUNCTION dbo.of_mui_cs_route_statuses(sender jsonb, _c_version text) IS 'Справочник статусов маршрутов';
