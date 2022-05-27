*&---------------------------------------------------------------------*
*& Report ZS01_OO_EXCEPTIONS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_OO_EXCEPTIONS_01.


*DATA lv_result TYPE i VALUE 100.


DATA(lv_result2) = 35.
DATA lo_cx_zd TYPE ref to cx_sy_zerodivide.
DATA lo_cx_root TYPE ref to cx_root.

WRITE:lv_result2.


TRY.

DATA(lv_result) = 10 / 0.

CATCH cx_sy_zerodivide INTO lo_cx_zd.
  CATCH cx_root into lo_cx_root.


  WRITE: 'Nicht durch Null teilbar!.'.
ENDTRY.


If lo_cx_zd is Bound.
  DATA(lv_fehlertext) = lo_cx_zd->get_longtext( ).
  write lv_fehlertext.

WRITE:lv_result.
ENDIF.

*cx_root = oberste aller Ausnahmeklassen.
