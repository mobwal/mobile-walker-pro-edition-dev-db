CREATE OR REPLACE FUNCTION dbo.of_arm_cd_results(sender jsonb, _f_route uuid) RETURNS TABLE(f_route uuid, c_route_name text, d_route_date timestamp without time zone, c_address text, c_point_imp_id text, n_point_longitude numeric, n_point_latitude numeric, b_anomaly boolean, c_login_name text, n_result_longitude numeric, n_result_latitude numeric, jb_data jsonb, n_distance integer, c_template_name text, d_result_date timestamp without time zone, c_attachments text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {uuid} _f_route - иден. маршрута
*
* @example
* [{ "action": "of_arm_cd_results", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _f_route] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select
		r.id,
		r.c_name as c_route_name,
		r.dx_created as d_route_date,
		p.c_address as c_address,
		p.c_imp_id as c_point_imp_id,
		p.n_longitude as n_point_longitude,
		p.n_latitude as n_point_latitude,
		p.b_anomaly as b_anomaly,
		u.c_login as c_login_name,
		rr.n_longitude as n_result_longitude,
		rr.n_latitude as n_result_latitude,
		rr.jb_data,
		rr.n_distance::integer,
		t.c_template as c_template_name,
		rr.d_date as d_result_date,
		concat((SELECT string_agg(t.id::text, ', '::text)
		   FROM dbo.cd_attachments as t where t.fn_result = rr.id)) AS c_attachments
	from dbo.cd_results as rr
	left join dbo.cd_templates as t on t.id = rr.fn_template
	left join core.pd_users as u on rr.fn_user = u.id
	inner join dbo.cd_points as p on p.id = rr.fn_point
	inner join dbo.cd_routes as r on r.id = p.fn_route
	where rr.fn_route = _f_route and p.b_disabled = false and rr.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.of_arm_cd_results(sender jsonb, _f_route uuid) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_arm_cd_results(sender jsonb, _f_route uuid) IS 'Получение результатов';
