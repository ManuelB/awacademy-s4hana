*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_SELECT_DISTINCT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_ABAPSQL_SELECT_DISTINCT.

SELECT DISTINCT cityto
  FROM spfli
  WHERE carrid = 'AA' and cityfrom = 'NEW YORK'
  INTO TABLE @DATA(Destinations).

  cl_demo_output=>display( Destinations ).
