CREATE OR REPLACE FUNCTION dbo.sf_expired_storages() RETURNS TABLE(id uuid, c_name text, c_dir text)
    LANGUAGE plpgsql
    AS $$
/**
* функция по удалению файлов 
*/
BEGIN
	return query 
	select s.id, s.c_name, s.c_dir from dbo.sd_storages as s
	where s.d_date_expired > CURRENT_DATE;
END;
$$;

ALTER FUNCTION dbo.sf_expired_storages() OWNER TO city;

COMMENT ON FUNCTION dbo.sf_expired_storages() IS 'Процедура получения старых файлов, которые нужно очистить';
