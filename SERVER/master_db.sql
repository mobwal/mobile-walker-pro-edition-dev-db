CREATE SERVER master_db FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname 'mobile-walker-portal', host '127.0.0.1', port '5432');

ALTER SERVER master_db OWNER TO postgres;
