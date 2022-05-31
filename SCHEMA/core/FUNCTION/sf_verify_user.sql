CREATE OR REPLACE FUNCTION core.sf_verify_user(_login text, _password text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
/**
 * @params {text} _login - логин
 * @params {text} _password - пароль
 * 
 * @returns {bigint} - иден. пользователя
 */
DECLARE
	_f_user 	bigint;
	_f_org 		bigint;
	_n_period	date;
	_c_service	text;
	_b_include	boolean = false; -- включен ли разрешенный сервис
BEGIN
	select c_value into _c_service
	from core.sd_settings
	where c_key = 'C_NAME';

	select (case when t.b_verify then t.id else -1 end), t.f_org into _f_user, _f_org from (select 
		case when u.s_hash is null 
			then u.c_password = _password 
			else crypt(_password, u.s_hash) = u.s_hash 
		end as b_verify,
		u.id,
		u.f_org
	from core.pd_users as u 
	where u.c_login = _login and u.b_disabled = false and u.sn_delete = false) as t;
	
	select count(*) > 0 into _b_include from core.sf_services(_f_org) as s
	where s.c_const = _c_service;
	
	IF _b_include = false THEN
		return null;
	END IF;
	
	-- проверяем авторизован ли был пользователь
	IF _f_user is not null and _f_user <> _f_org THEN
		select 
			coalesce((select i.n_period from core.sd_invoices as i where i.f_org = u.id order by i.n_period desc limit 1), u.d_created_date::date + interval '1 month')::date into _n_period
		from core.pd_users as u
		where u.id = _f_org;
		
		-- теперь нужно проверить, что услуга не оказывается бесплатно
		IF (select count(*) from core.sf_services(_f_org) as s where s.c_const = _c_service and s.c_tariff <> 'FREE') > 0 THEN
			-- создаем в специальной таблице запись о том, что пользователь авторизовался в указанный период
			INSERT INTO core.sd_account_use (f_org, n_period, f_user, d_date_modify) 
			values (_f_org, _n_period, _f_user, now());
		END IF;
	END IF;
	
	return _f_user;
END
$$;

ALTER FUNCTION core.sf_verify_user(_login text, _password text) OWNER TO city;

COMMENT ON FUNCTION core.sf_verify_user(_login text, _password text) IS 'Проверка пользователя на авторизацию';
