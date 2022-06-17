CREATE OR REPLACE FUNCTION dbo.of_arm_cd_routes(sender jsonb) RETURNS TABLE(id uuid, c_name text, c_description text, c_templates text, f_user bigint, c_user_name text, f_status integer, c_status text, n_count integer, dx_created timestamp without time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
*
* @example
* [{ "action": "of_mui_cd_routes", "schema": "dbo", "method": "Select", "data": [{ "params": [sender] }], "type": "rpc", "tid": 0 }]
*/
DECLARE
	_isAdmin	boolean;
BEGIN
	select position('.admin.' in u.c_claims) > 0 into _isAdmin from core.sf_users((sender#>>'{id}')::bigint) as u;
	
    RETURN QUERY select r.id, r.c_name, r.c_description, r.c_templates, r.f_user, u.c_name, rs.id, rs.c_name,
	(select count(*) from dbo.cd_points as p where p.fn_route = r.id)::integer, r.dx_created
    from dbo.cd_routes as r
	left join core.pd_users as u on u.id = r.f_user
	left join dbo.cs_route_statuses as rs ON r.f_status = rs.id
	where 
		case when _isAdmin then 
			r.f_user in (select lu.id from core.of_level_users(sender) as lu) 
		else 
			r.f_user = (sender#>>'{id}')::bigint 
		end
	order by r.dx_created desc;
END
$$;

ALTER FUNCTION dbo.of_arm_cd_routes(sender jsonb) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_arm_cd_routes(sender jsonb) IS 'Получение списка маршрутов';
