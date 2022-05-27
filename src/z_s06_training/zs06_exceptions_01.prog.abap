*&---------------------------------------------------------------------*
*& Report ZS06_EXCEPTIONS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_exceptions_01.

"lokale ausnahmeklass
CLASS lcx_my_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS lcx_my_exception IMPLEMENTATION.
ENDCLASS.

**********************************************************************
"Irgendeine klasse
**********************************************************************

CLASS lcl_my_class DEFINITION.

  METHODS beispiel RAISING lcx_my_exception.

ENDCLASS.

CLASS lcl_my_class IMPLEMENTATION.

  METHOD beispiel.
    IF 1 = 0."ifgendwas passiert im program...

    ELSE.
      "fehlerfall
      RAISE EXCEPTION lcx_my_exception.

    ENDIF.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA lv_result TYPE i VALUE 100.
  DATA lo_cx_zd TYPE REF TO cx_sy_zerodivide.


  TRY.
      lv_result = 10 / 0.

    CATCH cx_sy_zerodevide INTO lo_cx_zd.

      WRITE:/ |Nicht durch null teilbar!|.
  ENDTRY.

  if lo_cx_zd is not initial.
    data(lv_fehlertext_zd=lo_cx_zd->get_longtext().
    write:/ lv_fehlertext_zd.
