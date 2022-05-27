*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_GROUPBY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_sql_groupby.

SELECT FROM sflight "nimm von sflight
  FIELDS carrid,
  MIN( price ) AS min_price, "AS eigener out-put
  MAX( price ) AS max_price
  GROUP BY carrid
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).
