CREATE OR REPLACE FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) RETURNS TABLE(id uuid, c_name text, c_description text, b_check boolean, c_templates text)
    LANGUAGE plpgsql STABLE ROWS 100
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_routes", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select r.id, r.c_name, r.c_description, (select count(*) > 0 from dbo.cd_points as p where p.fn_route = r.id and p.b_check = false), r.c_templates
    from dbo.cd_routes as r
	inner join dbo.cs_route_statuses as rs ON r.f_status = rs.id
	where r.f_user = (sender#>>'{id}')::bigint and rs.c_const = 'ASSIGNED';
END
$$;

ALTER FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) IS 'Получение списка маршрутов';
