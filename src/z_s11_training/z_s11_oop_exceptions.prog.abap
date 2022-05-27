*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_EXCEPTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oop_exceptions.

*lokale Ausnahmeklasse

CLASS lcx_my_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.
CLASS lcx_my_exception IMPLEMENTATION.
ENDCLASS.


*****************************************************************

class lcl_my_class definition.
  public section.
  Methods beispiel raising lcx_my_exception.
  endclass.

  class lcl_my_class implementation.
    Method beispiel.
      if 1 = 0. "um ein fehler zu fangen
        else.
*          fehlerfall
          Raise EXCEPTION type lcx_my_exception. "fehler in my fehler klasse raisen

          endif.
      endmethod.
    endclass.




*´*************************************************************
START-OF-SELECTION.

DATA lv_result  TYPE i VALUE 100.
DATA lo_cx_zd   TYPE REF TO cx_sy_zerodivide.

Data lo_myclass type ref to lcl_my_class.
Data lo_cx_my_ex type ref to lcx_my_exception.
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

*IF lo_cx_root IS NOT INITIAL.
*DATA(lv_fehlertext_root) = lo_cx_root->get_longtext( ).
*WRITE / lv_fehlertext_root.
*ENDIF.

*CX_SY_ZERODIVIDE
WRITE: / lv_result.

*****************************************************************************

*Data lo_my_ex type ref to lcx_my_exception.
*lo_my_ex = new lcx_my_exception(
**  textid   =
**  previous =
*).
*
*lo_my_ex->get_longtext( ).

lo_myclass = new lcl_my_class( ).
*lo_myclass->beispiel( ).


    TRY.
      lo_myclass->beispiel( ).
    CATCH lcx_my_exception INTO lo_cx_my_ex.
*      *  in catch bloch fehler behandlung durchführen
      WRITE: / lo_cx_my_ex->get_text( ). "verebte method zu rufen um fehler text auszugeben
  ENDTRY.
