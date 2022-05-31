CREATE OR REPLACE FUNCTION dbo.of_del_route(sender jsonb, _f_route uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {jsonb} sender - объект
 * @params {uuid} _f_route - иден. маршрута
 */
BEGIN
	delete from dbo.cd_points
	where f_org = (sender#>>'{f_org}')::bigint and fn_route = _f_route;

	delete from dbo.cd_routes
	where f_org = (sender#>>'{f_org}')::bigint and id = _f_route;
	
	perform core.sf_write_log('Удален маршрут', _f_route::text, 0);
END
$$;

ALTER FUNCTION dbo.of_del_route(sender jsonb, _f_route uuid) OWNER TO city;

COMMENT ON FUNCTION dbo.of_del_route(sender jsonb, _f_route uuid) IS 'Открытая функция по удалению маршрута';
