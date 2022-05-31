CREATE OR REPLACE FUNCTION dbo.sf_storage_item(_f_storage uuid) RETURNS TABLE(c_dir text, c_name text)
    LANGUAGE plpgsql COST 1.0 ROWS 1
    AS $$
/**
 * функция по получению каталог для удаления
 * @params {uuid} _f_storage - идентификатор хранилища
 */
BEGIN
	return query 
	select s.c_dir, s.c_name 
	from dbo.sd_storages as s
	where s.id = _f_storage;
END;
$$;

ALTER FUNCTION dbo.sf_storage_item(_f_storage uuid) OWNER TO city;

COMMENT ON FUNCTION dbo.sf_storage_item(_f_storage uuid) IS 'Процедура элемента хранилища';
