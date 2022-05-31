CREATE OR REPLACE FUNCTION dbo.of_mui_cd_attachments(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_result uuid, n_longitude numeric, n_latitude numeric, d_date timestamp without time zone, c_path text, n_distance bigint)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_attachments", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
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
		s.c_name,
		a.n_distance
	from dbo.cd_attachments as a
	inner join dbo.sd_storages as s ON s.id = a.f_storage
	where s.f_user = (sender#>>'{id}')::bigint;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_attachments(sender jsonb, _c_version text) OWNER TO city;

COMMENT ON FUNCTION dbo.of_mui_cd_attachments(sender jsonb, _c_version text) IS 'Список вложений';
