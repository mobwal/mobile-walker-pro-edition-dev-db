CREATE OR REPLACE FUNCTION dbo.of_mui_cd_attachments(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_result uuid, n_longitude numeric, n_latitude numeric, d_date timestamp without time zone, c_name text, n_distance bigint, b_server boolean, b_disabled boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_attachments", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		a.id,
		a.fn_route,
		a.fn_point,
		a.fn_result,
		a.n_longitude,
		a.n_latitude,
		a.d_date,
		a.c_name,
		a.n_distance,
		true,
		a.b_disabled
	from dbo.cd_attachments as a
	inner join dbo.cd_routes as r on r.id = a.fn_route
	inner join dbo.cs_route_statuses as rs on rs.id = r.f_status
	where rs.c_const = 'ASSIGNED' and a.fn_user = (sender#>>'{id}')::bigint;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_attachments(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_attachments(sender jsonb, _c_version text) IS 'Список вложений';
