CREATE SEQUENCE dbo.ad_mobile_devices_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE dbo.ad_mobile_devices_id_seq OWNER TO mobwal;
