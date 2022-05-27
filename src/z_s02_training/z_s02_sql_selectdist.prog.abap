*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_SELECTDIST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_sql_selectdist.

SELECT DISTINCT cityto
  FROM spfli
  WHERE carrid = 'AZ' AND
      cityfrom = 'ROME'
  INTO TABLE @DATA(destinations).

cl_demo_output=>display( destinations ).
