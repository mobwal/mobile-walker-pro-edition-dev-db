CREATE OR REPLACE FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user bigint, d_date timestamp without time zone, b_disabled boolean, n_longitude numeric, n_latitude numeric, jb_data text, c_notice text, n_distance bigint, fn_template uuid)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_results", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		r.id,
		r.fn_route,
		r.fn_point,
		r.fn_user,
		r.d_date,
		r.b_disabled,
		r.n_longitude,
		r.n_latitude,
		r.jb_data::text,
		r.c_notice,
		r.n_distance,
		r.fn_template
	from dbo.cd_results as rr
    inner join dbo.cd_routes as r on r.id = rr.fn_route
	inner join dbo.cs_route_statuses as rs ON r.f_status = rs.id
	where r.f_user = (sender#>>'{id}')::bigint and rs.c_const = 'ASSIGNED';
END
$$;

ALTER FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) IS 'Список результатов';
