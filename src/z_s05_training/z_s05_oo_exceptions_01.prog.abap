*&---------------------------------------------------------------------*
*& Report Z_S05_OO_EXCEPTIONS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_oo_exceptions_01.

*Lokalle Ausnahmeklasse
CLASS lcx_my_exception DEFINITION INHERITING FROM  cx_static_check.
ENDCLASS.

CLASS lcx_my_exception IMPLEMENTATION.
ENDCLASS.

CLASS lcl_my_class DEFINITION.
  public section.
  METHODS beispiel RAISING lcx_my_exception.
ENDCLASS.

CLASS lcl_my_class IMPLEMENTATION.
  METHOD beispiel.
IF 1 = 0. " WAS PASSIERT
  ELSE.
  "FEHLERFALL
    RAISE EXCEPTION TYPE lcx_my_exception.
  ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

DATA lv_result TYPE i VALUE 100.
DATA lo_cx_zd TYPE REF TO cx_sy_zerodivide.
DATA lo_cx_root TYPE REF TO cx_root.
DATA lo_my_class TYPE REF TO lcl_my_class.


TRY.
    lv_result = 10 / 0.

*  CATCH cx_root. hier soll mann nicht machen/ Oerflache der ausnahmeklassen
  CATCH cx_sy_zerodivide INTO lo_cx_zd.
*      CATCH cx_root INTO lo_cx_root.
    WRITE: |Division durch 0 ist nicht erlaubt.|.
ENDTRY.

IF lo_cx_zd  IS NOT INITIAL.
  DATA(lv_fehlertext) = lo_cx_zd->get_longtext( ).
  WRITE: / lv_fehlertext.
ENDIF.

*IF lo_cx_root IS NOT INITIAL.
*DATA(lv_fehlertext_root) = lo_cx_root->get_longtext( ).
*WRITE: / lv_fehlertext_root.
*endif.


WRITE: lv_result.

******************************************************************************
DATA lo_my_ex TYPE REF TO lcx_my_exception.

*lo_my_ex = NEW lcx_my_exception(
*  textid   =
*  previous =   ).


*lo_my_ex->get_longtext( ).

ULINE.

lo_my_class = NEW lcl_my_class( ).

TRY.
lo_my_class->beispiel( ).
CATCH lcx_my_exception INTO lo_my_ex.
  WRITE: / lo_my_ex->get_text( ).
ENDTRY.
