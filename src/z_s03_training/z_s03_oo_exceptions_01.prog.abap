*&---------------------------------------------------------------------*
*& Report Z_S03_OO_EXCEPTIONS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_oo_exceptions_01.

* cf Z_T04_OO_EXCETIONS_01
*lokale Ausnahmeklasse
CLASS lcx_my_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS lcx_my_exception IMPLEMENTATION.
ENDCLASS.

********************************
*Irgendeine Klasse

CLASS lcl_my_class DEFINITION.
  PUBLIC SECTION.
  METHODS beispiel RAISING lcx_my_exception.
ENDCLASS.

CLASS lcl_my_class IMPLEMENTATION.
  METHOD beispiel.

    IF 1 = 0. "irgendwas passiert im Programm
    ELSE.
      " FEHLERFALL
      RAISE EXCEPTION lcx_my_exception.
*      On peut pas juste faire write fehler ici pcq on est pas sur que ca apparaisse.
    ENDIF.

ENDMETHOD.
ENDCLASS.









***********************************************************

START-OF-SELECTION.


*Ausnahmeklassen: cx_root ist die oberste.

  DATA lv_result TYPE i VALUE 100.
  DATA lo_cx_zd TYPE REF TO cx_sy_zerodivide.
*  DATA lo_cx_root TYPE REF TO cx_root.
  DATA lo_myclass TYPE REF TO lcl_my_class.
  DATA lo_cx_my_ex TYPE REF TO lcx_my_exception.


  TRY.
      lv_result = 10 / 0.
    CATCH cx_sy_zerodivide INTO lo_cx_zd.
*  CATCH cx_root into lo_cx_root. "Oberste Oberklasse der Ausnahmeklasse
*CATCH cx_root. Behandelt alle Fehler
      WRITE: /  |Nicht durch null teilbar!|.
  ENDTRY.

  IF lo_cx_zd IS NOT INITIAL.
    DATA(lv_fehlertext_zd) = lo_cx_zd->get_longtext( ).
    WRITE / lv_fehlertext_zd.
  ENDIF.

* if lo_cx_root is not INITIAL.
*  DATA(lv_fehlertext_root) = lo_cx_root->get_longtext( ).
*  write / lv_fehlertext_root.
*  ENDIF.
* Ausnahme CX_SY_ZERODIVIDE. Ausnahmeklassen fangen immer mit CX an.

  WRITE: lv_result.



************************************************************
*  DATA lo_my_ex TYPE REF TO lcx_my_exception.
*
*  lo_my_ex = NEW lcx_my_exception(
**  textid   =
**  previous =
*  ).
*  lo_my_ex->get_longtext( ).



lo_myclass = NEW lcl_my_class( ).


TRY.
  lo_myclass->beispiel( ).
CATCH lcx_my_exception into lo_cx_my_ex.
  WRITE: / lo_cx_my_ex->get_text( ).
  ENDTRY.
