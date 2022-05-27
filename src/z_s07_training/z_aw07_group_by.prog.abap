*&---------------------------------------------------------------------*
*& Report Z_AW07_GROUP_BY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_GROUP_BY.

SELECT FROM zs07_sflight
  FIELDS carrid,
  min( price ) as min_price,
  max( price ) as max_price

  GROUP BY carrid
  INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).
