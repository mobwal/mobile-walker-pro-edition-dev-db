CREATE SEQUENCE core.pd_roles_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE core.pd_roles_id_seq OWNER TO mobwal;

ALTER SEQUENCE core.pd_roles_id_seq
	OWNED BY core.pd_roles.id;
