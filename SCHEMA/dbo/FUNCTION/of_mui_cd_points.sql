CREATE OR REPLACE FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, c_address text, c_description text, n_order integer, n_longitude numeric, n_latitude numeric, jb_data text, b_anomaly boolean, b_check boolean, c_comment text, b_server boolean, b_disabled boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_points", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select p.id,
		p.fn_route,
		p.c_address,
		p.c_description,
		p.n_order,
		p.n_longitude,
		p.n_latitude,
		p.jb_data::text,
		p.b_anomaly,
		p.b_check,
		p.c_comment,
		true,
		p.b_disabled
	from dbo.cd_points as p
    inner join dbo.cd_routes as r on r.id = p.fn_route
	inner join dbo.cs_route_statuses as rs ON r.f_status = rs.id
	where r.f_user = (sender#>>'{id}')::bigint and rs.c_const = 'ASSIGNED';
END
$$;

ALTER FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) IS 'Список задание';
