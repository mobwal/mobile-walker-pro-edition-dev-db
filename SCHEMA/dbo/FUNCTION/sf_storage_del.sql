CREATE OR REPLACE FUNCTION dbo.sf_storage_del(_task_id uuid, _f_user bigint) RETURNS TABLE(id uuid, c_dir text)
    LANGUAGE plpgsql
    AS $$
/**
 * функция по получению каталог для удаления
 * @params {uuid} _task_id - идентификатор задачи
 * @params {bigint} _f_user - идентификатор пользователя
 *
 * @returns {uuid} идентификатор записи в таблице dbo.sd_storage_dels
 */
DECLARE
	_id uuid;
	_c_dir text;
BEGIN
	select sd.id, sd.c_dir into _id, _c_dir 
	from dbo.sd_storage_dels as sd
	where sd.task_id is null
	order by sd.d_date_del
	limit 100 FOR UPDATE;
	
	IF _id is not null THEN
		update dbo.sd_storage_dels as s
		set task_id = _task_id,
		f_user = _f_user
		where s.id = _id;
		
		return query select _id, _c_dir;
	ELSE
		return query select null::uuid, null::text;
	END IF;
	
END;
$$;

ALTER FUNCTION dbo.sf_storage_del(_task_id uuid, _f_user bigint) OWNER TO city;

COMMENT ON FUNCTION dbo.sf_storage_del(_task_id uuid, _f_user bigint) IS 'Процедура получения каталога для удаления';
