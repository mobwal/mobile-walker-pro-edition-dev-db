CREATE OR REPLACE FUNCTION dbo.sf_add_attachment(_id uuid, _f_user bigint, _f_route uuid, _f_point uuid, _f_result uuid, _n_latitude numeric, _n_longitude numeric, _d_date timestamp without time zone, _c_name text, _c_dir text, _n_size integer, _c_extension text, _c_mime text, _n_distance numeric, _ba_data bytea) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	_f_service 	bigint;		-- идентификатор сервиса
	_f_org 		bigint;		-- организация
	_c_service	text;		-- имя сервиса
	_f_storage	uuid;		-- хранилище
BEGIN
	select u.f_org into _f_org from core.pd_users as u where u.id = _f_user;
	select s.c_value into _c_service from core.sd_settings as s where s.c_key = 'C_NAME';
	select s.id into _f_service from core.cd_services as s where s.c_const = _c_service;

	INSERT INTO dbo.sd_storages(c_name, n_length, d_date, f_user, f_org, f_service, d_date_expired, c_dir, c_mime, ba_data)
	VALUES (_c_name, _n_size, _d_date, _f_user, _f_org, _f_service, '2099-12-31'::date, _c_dir, _c_mime, _ba_data) 
    RETURNING id into _f_storage;

	INSERT INTO dbo.cd_attachments(id, fn_result, fn_point, fn_route, d_date, n_longitude, n_latitude, n_distance, f_storage)
	VALUES (_id, _f_result, _f_point, _f_route, _d_date, _n_longitude, _n_latitude, _n_distance, _f_storage);
END
$$;

ALTER FUNCTION dbo.sf_add_attachment(_id uuid, _f_user bigint, _f_route uuid, _f_point uuid, _f_result uuid, _n_latitude numeric, _n_longitude numeric, _d_date timestamp without time zone, _c_name text, _c_dir text, _n_size integer, _c_extension text, _c_mime text, _n_distance numeric, _ba_data bytea) OWNER TO city;

COMMENT ON FUNCTION dbo.sf_add_attachment(_id uuid, _f_user bigint, _f_route uuid, _f_point uuid, _f_result uuid, _n_latitude numeric, _n_longitude numeric, _d_date timestamp without time zone, _c_name text, _c_dir text, _n_size integer, _c_extension text, _c_mime text, _n_distance numeric, _ba_data bytea) IS 'Добавление файла';
