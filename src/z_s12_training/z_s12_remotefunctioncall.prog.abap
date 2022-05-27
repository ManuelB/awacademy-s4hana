*&---------------------------------------------------------------------*
*& Report Z_S12_REMOTEFUNCTIONCALL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_remotefunctioncall.

DATA: fil_line   TYPE adrc,
      fil_table  TYPE TABLE OF adrc,
      t_result   TYPE bapiret2_t,
      fil_table2 TYPE TABLE OF kna1.

SELECT ad~addrnumber, ad~name1, ad~street, ad~house_num1 FROM adrc AS ad
  INNER JOIN kna1 AS kn ON ad~addrnumber = kn~pstlz
  group by ad~country, ad~addrnumber, ad~name1, ad~street, ad~house_num1
  INTO @DATA(lt_result).
  endselect.

DATA:
  i_filnr     TYPE adrc-addrnumber,
  i_name      TYPE adrc-name1,
  i_post_code TYPE adrc-post_code1,
  i_city1     TYPE adrc-city1,
  i_street    TYPE adrc-street,
  i_housenr   TYPE adrc-house_num1,
  new_task    TYPE char10.
