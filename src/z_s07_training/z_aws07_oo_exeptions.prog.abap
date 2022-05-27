*&---------------------------------------------------------------------*
*& Report Z_AWS07_OO_EXEPTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AWS07_OO_EXEPTIONS.


CLASS lcx_my_exeption DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS lcx_my_exeption IMPLEMENTATION.
ENDCLASS.


**********************************************************************
* Irgendeine Klasse
CLASS lcl_my_class DEFINITION.
  PUBLIC SECTION.

    METHODS beispiel RAISING lcx_my_exeption.

ENDCLASS.

CLASS lcl_my_class IMPLEMENTATION.
  METHOD beispiel .

    IF 1 = 0. "Irgendwas passiert im Programm...
    ELSE.
      "FEHLERFALL
      RAISE EXCEPTION TYPE lcx_my_exeption.

    ENDIF.

  ENDMETHOD.
ENDCLASS.



**********************************************************************
START-OF-SELECTION.

  DATA lv_result  TYPE i VALUE 100.
  DATA lo_cx_zd   TYPE REF TO cx_sy_zerodivide.
  DATA lo_myclass TYPE REF TO lcl_my_class.
  DATA lo_cx_my_ex TYPE REF TO lcx_my_exeption.
*DATA lo_cx_root TYPE REF TO cx_root.


  TRY.
      lv_result = 10 / 0.

    CATCH cx_sy_zerodivide INTO lo_cx_zd.
*  CATCH cx_root INTO lo_cx_root. "Oberste Oberklasse der Ausnahmeklassen.
      WRITE: / |Nicht durch Null teilbar!.|.
  ENDTRY.

  IF lo_cx_zd IS NOT INITIAL.
    DATA(lv_fehlertext_zd) = lo_cx_zd->get_longtext( ).
    WRITE / lv_fehlertext_zd.
  ENDIF.

  WRITE: / lv_result.

**********************************************************************

*  DATA lo_my_ex TYPE REF TO lcx_my_exeption.
*
*  lo_my_ex = NEW lcx_my_exeption(
**  textid   =
**  previous =
*  ).
*
*  lo_my_ex->get_longtext( ).

ULINE.

  lo_myclass = NEW lcl_my_class( ).

  TRY.
      lo_myclass->beispiel( ).
    CATCH lcx_my_exeption INTO lo_cx_my_ex.
      WRITE: / lo_cx_my_ex->get_text( ).
  ENDTRY.
