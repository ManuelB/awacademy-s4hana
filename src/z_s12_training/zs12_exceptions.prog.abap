*&---------------------------------------------------------------------*
*& Report ZS12_EXCEPTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_exceptions.


*Lokale Ausnahmeklasse
CLASS lcx_my_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS lcx_my_exception IMPLEMENTATION.
ENDCLASS.


CLASS lcl_my_class DEFINITION.
  PUBLIC SECTION.
    METHODS: beispiel RAISING lcx_my_exception.

ENDCLASS.

CLASS lcl_my_class IMPLEMENTATION.
  METHOD beispiel.
    IF 1 = 0. "Irgendetwas passiert im Program
    ELSE.
      "Fehlerfall
      RAISE EXCEPTION TYPE lcx_my_exception.
    ENDIF.

  ENDMETHOD.
ENDCLASS.



****************************************************************************
START-OF-SELECTION.

  DATA lv_result TYPE i VALUE 100.
  DATA lo_cx_zd TYPE REF TO cx_sy_zerodivide.
  DATA lo_myclass TYPE REF TO lcl_my_class.
*  DATA lo_cx_root TYPE REF TO cx_root.


  TRY.
      lv_result = 10 / 0.
    CATCH cx_sy_zerodivide INTO lo_cx_zd.
*CATCH cx_root. "Oberste Ausnahmeklasse --> fängt jeden Fehler ab

  ENDTRY.

*  IF lo_cx_zd IS NOT INITIAL.
*    DATA(lv_fehlertext_root) = lo_cx_root->get_longtext( ).
*    WRITE: / lv_fehlertext_root.
*  ENDIF.

*IF lo_cx IS NOT INITIAL.
*  DATA(lv_fehlertext_zx) = lo_cx_root->get_longtext( ).
*  WRITE: / lv_fehlertext_zx.
*ENDIF.

  WRITE: lv_result.

****************************************************************************

  DATA lo_my_ex TYPE REF TO lcx_my_exception.
  data lo_cx_my_ex type ref to lcx_my_exception.

*  lo_my_ex = NEW lcx_my_exception( ). "Erzeugung einer Instanz
*
*  lo_my_ex->get_text.
*
*  lo_myclass = NEW lcl_my_class( ).

  TRY.
      lo_myclass->beispiel( ).
    CATCH lcx_my_exception into lo_cx_my_ex.
      Write: / lo_cx_my_ex->get_text( ).

  ENDTRY.
