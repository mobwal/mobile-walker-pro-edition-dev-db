CREATE OR REPLACE FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user bigint, d_date timestamp without time zone, b_disabled boolean, n_longitude numeric, n_latitude numeric, jb_data text, c_notice text, n_distance bigint, fn_template uuid)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_results", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		rh.id,
		rh.fn_route,
		rh.fn_point,
		rh.fn_user,
		rh.d_date,
		rh.b_disabled,
		rh.n_longitude,
		rh.n_latitude,
		rh.jb_data::text,
		rh.c_notice,
		rh.n_distance,
		rh.fn_template
	from dbo.cd_results as r
	where r.fn_user = (sender#>>'{id}')::bigint;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) OWNER TO city;

COMMENT ON FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) IS 'Список результатов';
