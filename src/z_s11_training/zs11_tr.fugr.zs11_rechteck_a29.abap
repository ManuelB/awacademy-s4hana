FUNCTION ZS11_RECHTECK_A29.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_LENGTH) TYPE  ZRK02_TY_BETRAG DEFAULT 5
*"     REFERENCE(I_WIDTH) TYPE  ZRK02_TY_BETRAG DEFAULT 5
*"  EXPORTING
*"     REFERENCE(E_AREA) TYPE  ZRK02_TY_BETRAG
*"     REFERENCE(E_PERIMETER) TYPE  ZRK02_TY_BETRAG
*"  EXCEPTIONS
*"      ZERO_DIM
*"      NEG_DIM
*"----------------------------------------------------------------------

*
*

if i_length = 0 or i_width = 0.
  Raise Zero_Dim.
  Elseif i_length < 0 or i_width < 0.
    raise Neg_Dim.
    else.
  E_perimeter = 2 * ( i_length + i_width ).
  e_area = i_length * i_width.
endif.

*


ENDFUNCTION.
