*&---------------------------------------------------------------------*
*& Report ZS11_SQL_GROUPBY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_sql_groupby.


SELECT FROM ZS11_sflight
  FIELDS carrid,
  MIN( price ) AS min_price,
  MAX( price ) AS max_price
  GROUP BY carrid
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).
