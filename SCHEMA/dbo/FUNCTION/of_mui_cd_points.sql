CREATE OR REPLACE FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, c_address text, c_description text, n_order integer, n_longitude numeric, n_latitude numeric, jb_data text, b_anomaly boolean, b_check boolean, c_comment text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_points", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		p.id,
		p.fn_route,
		p.c_address,
		p.c_description,
		p.n_order,
		p.n_longitude,
		p.n_latitude,
		p.jb_data::text,
		p.b_anomaly,
		p.b_check,
		p.c_comment
	from dbo.cd_points as p
	where p.f_org = (sender#>>'{f_org}')::bigint;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) OWNER TO city;

COMMENT ON FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) IS 'Список задание';
