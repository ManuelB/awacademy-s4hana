*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_GROUP_BY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_abapsql_group_by.


SELECT FROM sflight
  FIELDS carrid,
  MIN( price ) AS min_price,
  MAX( price ) AS max_price
  GROUP BY carrid
  INTO TABLE @DATA(result).
BREAK-POINT.

cl_demo_output=>display( result ). "this searches the table sflight and lists each carrier with min and max price, grouped by carrier.
