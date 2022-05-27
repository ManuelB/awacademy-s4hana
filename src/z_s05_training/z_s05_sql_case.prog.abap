*&---------------------------------------------------------------------*
*& Report ZA_S05_SQL_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_CASE.

select from spfli
  FIELDS carrid,
  connid,
  cityfrom,
  cityto,
  fltime AS flzeit,
  CASE WHEN fltime < 100 THEN 'short'
  WHEN fltime BETWEEN 100 AND 300 THEN 'medium'
  ELSE 'long'
  END AS fltime
  ORDER BY flzeit ASCENDING, carrid, connid
  INTO TABLE @DATA(result).

 cl_demo_output=>display( result ).
