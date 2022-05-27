*&---------------------------------------------------------------------*
*& Report Z_S09_GROUP_BY_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_GROUP_BY_AUFGABE.






SELECT FROM SFLIGHT
  FIELDS carrid,
  MIN( price ) AS min_price,
  MAX( price ) AS max_price
  Group BY carrid
  INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).
