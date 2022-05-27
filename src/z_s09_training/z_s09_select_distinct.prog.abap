*&---------------------------------------------------------------------*
*& Report Z_S09_SELECT_DISTINCT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_SELECT_DISTINCT.

SELECT DISTINCT cityto
  from spfli
  WHERE carrid = 'LH' AND
  cityfrom = 'FRANKFURT'
  INTO TABLE @DATA(destinations).
  cl_demo_output=>display( destinations ).
