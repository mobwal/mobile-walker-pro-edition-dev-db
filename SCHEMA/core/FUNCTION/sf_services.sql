CREATE OR REPLACE FUNCTION core.sf_services(_f_user bigint) RETURNS TABLE(c_const text, c_tariff text)
    LANGUAGE plpgsql
    AS $$
/**
* @params {bigint} _f_user - иден. пользователя
*/
BEGIN
	return query 
	select s.c_const, t.c_const from core.cd_userinservices as uis
	left join core.sd_serviceintariffs as sp on sp.f_service = uis.f_service
	left join core.sd_tariffs as t on t.id = sp.f_tariff
	left join core.cd_services as s on s.id = uis.f_service
	left join core.pd_users as u on u.id = uis.f_org 
	where uis.f_org = _f_user and uis.b_disabled = false and uis.d_date_deactivate is null and uis.d_date_disabled is null
	order by s.n_order;
	
END;
$$;

ALTER FUNCTION core.sf_services(_f_user bigint) OWNER TO city;

COMMENT ON FUNCTION core.sf_services(_f_user bigint) IS 'Получение списка услуг доступных пользователю';
