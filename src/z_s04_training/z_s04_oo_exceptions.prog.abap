*&---------------------------------------------------------------------*
*& Report Z_S04_OO_EXCEPTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_oo_exceptions_01. "Exceptions sind behandelbare Ausnahmen


**********************************************************************
*Lokale Ausnahmeklasse

CLASS lcx_my_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.


CLASS lcx_my_exception IMPLEMENTATION.
ENDCLASS.



**********************************************************************
* Beispielklasse

CLASS lcl_myclass DEFINITION.
  PUBLIC SECTION.
    METHODS beispiel RAISING lcx_my_exception.
ENDCLASS.


CLASS lcl_myclass IMPLEMENTATION.
  METHOD beispiel.
    IF 1 = 0. "Irgendwas passiert im Programm
    ELSE.
      "Fehlerfall
      RAISE EXCEPTION TYPE lcx_my_exception.
    ENDIF.
  ENDMETHOD.
ENDCLASS.



**********************************************************************
START-OF-SELECTION.

  DATA: lv_result  TYPE i VALUE 100,
        lo_cx_zd   TYPE REF TO cx_sy_zerodivide,
        lo_cx_root TYPE REF TO cx_root, "cx_root ist die oberste Oberklasse der Ausnahmeklassen.
        lo_myclass TYPE REF TO lcl_myclass,
        lo_my_exc  TYPE REF TO lcx_my_exception.


  lo_myclass = NEW lcl_myclass( ).

  TRY.
      lo_myclass->beispiel( ).
    CATCH lcx_my_exception INTO lo_my_exc.
      WRITE: / lo_my_exc->get_text( ).
  ENDTRY.





**********************************************************************
*START-OF-SELECTION.
*
*
*DATA: lv_result  TYPE i VALUE 100,
*      lo_cx_zd   TYPE REF TO cx_sy_zerodivide,
*      lo_cx_root TYPE REF TO cx_root. "cx_root ist die oberste Oberklasse der Ausnahmeklassen.
*
*TRY.
*
*    lv_result = 10 / 0.
*
*  CATCH cx_sy_zerodivide INTO lo_cx_zd.
*
*    WRITE: / 'Nicht durch NUll teilbar'.
*
*ENDTRY.
*
*
*IF lo_cx_zd IS NOT INITIAL.
*  DATA(lv_fehlertext_zd) = lo_cx_zd->get_longtext( ). "Inline-Typisierung - sollte vermieden werden!!!
*  WRITE / lv_fehlertext_zd.
*ENDIF.
*
*
*IF lo_cx_root IS NOT INITIAL.
*  DATA(lv_fehlertext_root) = lo_cx_root->get_longtext( ).
*  WRITE / lv_fehlertext_root.
*ENDIF.
*
*
*WRITE: lv_result.
**********************************************************************


*DATA lo_my_exc TYPE REF TO lcx_my_exception.
*
*lo_my_exc = NEW lcx_my_exception(
**  textid   =
**  previous =
*).
*
*lo_my_exc->get_longtext(
**    preserve_newlines =
*).
