*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_sql_case.

SELECT FROM spfli
  FIELDS carrid,
  connid,
  cityfrom,
  cityto,fltime as flight_time,
  CASE WHEN fltime < 100 THEN 'short'
  WHEN fltime BETWEEN 100 AND 300 THEN 'medium'
  ELSE 'long'
END AS fltime
ORDER BY carrid, connid
INTO TABLE @DATA(result).

cl_demo_output=>display( result ).
