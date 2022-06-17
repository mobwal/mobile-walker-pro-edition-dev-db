CREATE OR REPLACE FUNCTION core.of_arm_pd_users(sender jsonb) RETURNS TABLE(id bigint, c_login text, b_disabled boolean, d_created_date timestamp without time zone, d_change_date timestamp without time zone, c_about text, c_name text, c_post text, c_imp_id text, d_last_auth_date timestamp without time zone, f_level uuid, c_level text, c_notice text, c_created_user text, c_change_user text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
*
* @example
* [{ "action": "of_arm_pd_users", "schema": "core", "method": "Select", "data": [{ "params": [sender] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY
	WITH RECURSIVE included_levels(f_parent, id) AS (
		select l.f_parent, l.id
		from core.pd_levels as l 
		where l.id = (sender#>>'{f_level}')::uuid
		union all
		select l.f_parent, l.id
		from core.pd_levels as l, included_levels as il 
		where l.f_parent = il.id
	)
	select 
	u.id,
	u.c_login,
	u.b_disabled,
	u.d_created_date,
	u.d_change_date,
	u.c_about,
	case when u.c_name = '' or u.c_name is null then u.c_login else u.c_name end,
	u.c_post,
	u.c_imp_id,
	u.d_last_auth_date,
	u.f_level,
	l.c_name,
	u.c_notice,
	u.c_created_user,
	u.c_change_user
   FROM core.pd_users u
   left join core.pd_levels as l on u.f_level = l.id
   inner join core.pd_userinroles as uir on uir.f_user = u.id
   inner join core.pd_roles as r on r.id = uir.f_role
   
   where r.c_name in ('admin', 'user') and u.sn_delete = false 
   and u.f_level in (select t.id from included_levels as t);
END
$$;

ALTER FUNCTION core.of_arm_pd_users(sender jsonb) OWNER TO mobwal;

COMMENT ON FUNCTION core.of_arm_pd_users(sender jsonb) IS 'Получение списка пользователей для АРМ';
