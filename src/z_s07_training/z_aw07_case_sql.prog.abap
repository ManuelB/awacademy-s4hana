*&---------------------------------------------------------------------*
*& Report Z_AW07_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_case_sql.

DATA: carrid   TYPE spfli-carrid,
      connid   TYPE spfli-connid,
      cityfrom TYPE spfli-cityfrom,
      cityto   TYPE spfli-cityto,
      fltime   TYPE spfli-fltime.


SELECT FROM spfli
  FIELDS carrid,
  connid,
  cityfrom,
  cityto,
  CASE WHEN fltime < 100 THEN 'short'
  WHEN fltime BETWEEN 100 AND 300 THEN 'medium'
  ELSE 'long'
  END AS fltime
  ORDER BY carrid, connid
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).
