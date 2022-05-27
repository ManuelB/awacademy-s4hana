*&---------------------------------------------------------------------*
*& Report ZAW_S04_GROUP_BY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAWS04_SQL_GROUP_BY.

SELECT FROM sflight FIELDS carrid,
  MIN( price ) AS min_price,
  MAX( price ) AS max_price
  GROUP BY carrid
  ORDER BY carrid DESCENDING
  INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).


*BREAK-POINT.
