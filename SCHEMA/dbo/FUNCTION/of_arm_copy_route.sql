CREATE OR REPLACE FUNCTION dbo.of_arm_copy_route(sender jsonb, _f_route uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {jsonb} sender - объект
 * @params {uuid} _f_route - иден. маршрута
 *
 * @example
 * [{ "action": "of_arm_copy_route", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _f_route] }], "type": "rpc", "tid": 0 }]
 */
DECLARE
	_new_id uuid;
BEGIN
	insert into dbo.cd_routes(c_name, c_description, c_templates, f_user, f_status)
	select concat(r.c_name, ' - copy'), r.c_description, null, null, (select rs.id from dbo.cs_route_statuses as rs where rs.c_const = 'CREATED') 
	from dbo.cd_routes as r
	where r.id = _f_route RETURNING id INTO _new_id;
	
	INSERT INTO dbo.cd_points(fn_route, c_address, c_description, c_imp_id, n_order, n_longitude, n_latitude, jb_data, b_anomaly, b_check, c_comment, dx_created)
	select _new_id, p.c_address, p.c_description, p.c_imp_id, p.n_order, p.n_longitude, p.n_latitude, p.jb_data, p.b_anomaly, p.b_check, p.c_comment, p.dx_created 
	from dbo.cd_points as p
	where p.fn_route = _f_route;
	
	perform core.sf_write_log('Копирование маршрута', _f_route::text, 0);
END
$$;

ALTER FUNCTION dbo.of_arm_copy_route(sender jsonb, _f_route uuid) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_arm_copy_route(sender jsonb, _f_route uuid) IS 'Открытая функция по копированию маршрута';
