CREATE OR REPLACE FUNCTION core.sf_del_user(_f_org bigint, _f_user bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (select count(*) from core.pd_users as u where u.id = _f_user) = 1 THEN

		update core.pd_users
		set sn_delete = true,
		d_date_remove = now()
		where id = _f_user;

		RETURN _f_user;
	ELSE
		RETURN _f_user;
	END IF;
END
$$;

ALTER FUNCTION core.sf_del_user(_f_org bigint, _f_user bigint) OWNER TO mobwal;

COMMENT ON FUNCTION core.sf_del_user(_f_org bigint, _f_user bigint) IS 'Удаление пользователя';
