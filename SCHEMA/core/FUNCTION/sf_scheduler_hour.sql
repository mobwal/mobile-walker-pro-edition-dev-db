CREATE OR REPLACE FUNCTION core.sf_scheduler_hour() RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * системная функция должна выполнять от postgres
 */
DECLARE
	_dg_text	text = '';
	_c_service	text;
	_f_service	integer;
	_b_free		boolean = false; -- признак бесплатной услуги
BEGIN

	select c_value into _c_service
	from core.sd_settings
	where c_key = 'C_NAME';
	
	select s.id into _f_service from core.cd_services as s
	where s.c_const = _c_service;

	create temp table t_orgs (
		id bigint,
		d_date_created date,
		d_date_end_period date -- завершение периода
	) on commit drop;
	-- создаем временную информацию по организациям
	insert into t_orgs
	select 
		u.id, 
		u.d_created_date::date,
		coalesce((select i.n_period from core.sd_invoices as i where i.f_org = u.id order by i.n_period desc limit 1), u.d_created_date::date + interval '1 month')::date
	from core.pd_users as u
	where u.id in (select distinct f_org from core.pd_users);

	_dg_text = _dg_text || now()::text || ' Создана временная таблица для хранения ' || (select count(*) from t_orgs)::text || ' организаций.' || E'\n';
	
	select t.c_const = 'FREE' into _b_free from core.sd_serviceintariffs as sp
	left join core.sd_tariffs as t on t.id = sp.f_tariff
	left join core.cd_services as s on s.id = sp.f_service
	where s.c_const = _c_service;
	
	IF _b_free = false THEN
		-- вычислем кол-во строк используемого организациями
		INSERT INTO core.sd_rows_use (f_service, f_org, n_period, n_size, d_date_modify)
		-- добавить значение по умолчанию для начала периода
		select _f_service, t.id, t.d_date_end_period, t.n_length, t.d_date
		from (select 
			o.id, 
			o.d_date_end_period, 
			(select sum(t.n_count) from (select count(*) as n_count from dbo.cd_collections as c where c.f_org = o.id
			UNION ALL
			select count(*) as n_count from dbo.cd_points as p where p.f_org = o.id
			UNION ALL
			select count(*) as n_count from dbo.cd_routes as r where r.f_org = o.id
			UNION ALL
			select count(*) as n_count from dbo.cd_templates as t where t.f_org = o.id) as t) as n_length, 
			now() as d_date
		from t_orgs as o) as t;
		-- !!! нижний код можно удалить потом
		
		-- вычислем размер используемого дискового пространства организациями
		INSERT INTO core.sd_disk_use (f_service, f_org, n_period, n_size, d_date_modify)
		-- добавить значение по умолчанию для начала периода
		-- 10 это значение, которое нужно вычислять, минимум всегда должен быть 10 Гб
		select _f_service, t.id, t.d_date_end_period, case when t.n_length >= 10 then t.n_length else 0 end, t.d_date
		from (select 
			o.id, 
			o.d_date_end_period, 
			(select sum(s.n_length) from dbo.sd_storages as s where s.f_service = _f_service and s.f_org = o.id) / (1024 * 1024 * 1024) as n_length, 
			now() as d_date
		from t_orgs as o) as t;

		_dg_text = _dg_text || now()::text || ' Вычисление количества строк завершено.' || E'\n';
	END IF;
	
	perform core.sf_write_log('Планировщик "Каждый час" закончил работу. ' || E'\n' || _dg_text, null, 0);

	EXCEPTION
	WHEN OTHERS
    THEN
		perform core.sf_write_log('Непредвиденная ошибка планировщика "Каждый час" ' || E'\n' || _dg_text, null, 1);

END;
$$;

ALTER FUNCTION core.sf_scheduler_hour() OWNER TO city;

COMMENT ON FUNCTION core.sf_scheduler_hour() IS 'Планировщик запускаемый "Каждый час"';
