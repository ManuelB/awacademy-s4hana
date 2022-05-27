*&---------------------------------------------------------------------*
*& Report ZAWS04_SQL_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAWS04_SQL_CASE.

SELECT FROM spfli
  FIELDS carrid, connid, cityfrom, cityto,
  CASE WHEN fltime < 100 THEN 'short'
  WHEN fltime BETWEEN 100 AND 300 THEN 'medium'
  ELSE 'long'
  END AS fltime
  ORDER BY fltime, carrid, connid
  INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).
