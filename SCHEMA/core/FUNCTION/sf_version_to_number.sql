-- FUNCTION: core.sf_version_to_number(text)

-- DROP FUNCTION IF EXISTS core.sf_version_to_number(text);

CREATE OR REPLACE FUNCTION core.sf_version_to_number(
	_c_version text)
    RETURNS bigint
    LANGUAGE plpgsql
    COST 100
    STABLE PARALLEL UNSAFE
AS $BODY$
/**
* @returns _c_version {text} версия
*/
BEGIN
	RETURN (select split_part(_c_version, '.', 2)::integer * 24 * 60) + split_part(_c_version, '.', 4)::integer;
END
$BODY$;

ALTER FUNCTION core.sf_version_to_number(text)
    OWNER TO mobwal;

COMMENT ON FUNCTION core.sf_version_to_number(text)
    IS 'Преобразование версии в число';
