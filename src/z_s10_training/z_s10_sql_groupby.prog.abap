*&---------------------------------------------------------------------*
*& Report Z_S10_GROUPBY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s10_sql_groupby.

*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
* PARAMETERS: p_carr   TYPE s_carr_id,
*              p_preis  TYPE s_price.
*
*SELECTION-SCREEN END OF BLOCK a1.
* se cauta la toate companiile aviatice care este limita maxima si minima de pret.

SELECT FROM sflight
  FIELDS carrid,
    MIN( price ) AS min_price,
    MAX( price ) AS max_price
  GROUP BY carrid
  INTO TABLE @DATA(result). "
BREAK-POINT.

cl_demo_output=>display( result ).
