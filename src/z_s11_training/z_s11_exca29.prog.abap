*&---------------------------------------------------------------------*
*& Report Z_S11_EXCA29
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_exca29.


DATA:
*  length TYPE zrk02_ty_betrag default 5, "ehy default value is invalid here
  width  TYPE zrk02_ty_betrag,
  umfang TYPE p LENGTH 5 DECIMALS 3,
  area   TYPE p LENGTH 5 DECIMALS 3.



PARAMETERS : p_length TYPE zrk02_ty_betrag DEFAULT '3.14',
             p_width  TYPE zrk02_ty_betrag.


CALL FUNCTION 'ZS11_RECHTECK_A29'
  EXPORTING
    i_length    = p_length
    i_width     = p_width
  IMPORTING
    e_area      = area
    e_perimeter = umfang
  EXCEPTIONS
    zero_dim    = 1
    neg_dim     = 2
    OTHERS      = 3.
IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1.
      WRITE 'Any dimension cant be zero'.
    WHEN 2.
      WRITE 'Any dimension cant be negative'.
    WHEN OTHERS.
      WRITE 'Some other mistake'.
  ENDCASE.
ELSE.
  WRITE :/ 'The perimeter is :', umfang, 'The area is :', area.

ENDIF.
