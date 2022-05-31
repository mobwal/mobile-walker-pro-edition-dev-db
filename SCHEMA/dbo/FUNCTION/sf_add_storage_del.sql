CREATE OR REPLACE FUNCTION dbo.sf_add_storage_del(_c_dir text, _f_user bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {text} _c_dir - относительный каталог для удлаения
 * @params {bigint} _f_user - иден. пользователя инициализировавший запрос
 */
BEGIN
	insert into dbo.sd_storage_dels(c_dir, f_user)
	values (_c_dir, _f_user);
END
$$;

ALTER FUNCTION dbo.sf_add_storage_del(_c_dir text, _f_user bigint) OWNER TO city;

COMMENT ON FUNCTION dbo.sf_add_storage_del(_c_dir text, _f_user bigint) IS 'Добавление хранилища для последующего удаления';
