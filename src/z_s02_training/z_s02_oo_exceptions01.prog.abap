*&---------------------------------------------------------------------*
*& Report Z_S02_OO_EXCEPTIONS01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_oo_exceptions01.

***** Lokale Ausnahmeklasse

CLASS lcx_my_exception DEFINITION INHERITING FROM cx_static_check.

ENDCLASS.

CLASS lcx_my_exception IMPLEMENTATION.

ENDCLASS.


***** Irgendeine Klasse
CLASS lcl_my_class DEFINITION.
  METHODS beispiel.
ENDCLASS.

CLASS lcl_my_class IMPLEMENTATION.
  METHOD beispiel.
IF 1 = 0.
  ELSE.
    " Fehlerfall
    RAISE EXCEPTION type lcl_my_class.

ENDIF.
  ENDMETHOD.
ENDCLASS.




START-OF-SELECTION.



  DATA: lv_result TYPE i VALUE 100.
  DATA lo_cx_zd TYPE REF TO cx_sy_zerodivide.
  DATA lo_cx_root TYPE REF TO cx_root.
  DATA lo_myclass TYPE REF TO lcl_my_class.
  DATA lo_cx_my_ex TYPE REF TO lcl_my_ex.

  TRY.                                                " "Versuch das, was zwischen try und entry steht und fange ggf. den Fehler ab.
      lv_result = 10 / 0.                             " macht Laufzeitfehler

*  CATCH cx_sy_zerodivide INTO lo_cx_zd.                           " Catchblock. wurde aus Laufzeitfehlerbericht kopiert. CX_root ist der oberste Oschi.
    CATCH cx_root INTO lo_cx_root.                                 " CX_root ist der oberste Oschi.
      WRITE: | Divicion durch Nada no es good. |.
  ENDTRY.

*IF lo_cx_zd IS BOUND.
*  DATA(lv_fehlertext) = lo_cx_zd->get_longtext( ).
*  WRITE: / lv_fehlertext.
*ENDIF.

  IF lo_cx_root IS BOUND.
    DATA(lv_fehlertext_root) = lo_cx_root->get_longtext( ).
    WRITE: / lv_fehlertext_root.
  ENDIF.

  WRITE: lv_result.


*  DATA lo_my_ex TYPE REF TO lcx_my_exception.
*
*  lo_my_ex = NEW lcx_my_exception( ).

lo_myclass = new lcl_my_class( ).

TRY.
lo_myclass->beispiel( ).
CATCH lcx_my_exception INTO lo_cx_my_ex.

ENDTRY.
