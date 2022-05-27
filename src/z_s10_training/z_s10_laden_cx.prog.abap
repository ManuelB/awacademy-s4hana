*&---------------------------------------------------------------------*
*& Report z_s10_laden_cx
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s10_laden_cx.

CLASS lcx_kauefer_zu_jung_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS lcx_kauefer_zu_jung_exception IMPLEMENTATION.
ENDCLASS.


**********************************************************************

CLASS lcl_laden DEFINITION.
  PUBLIC SECTION.

    class-METHODS alkohol_kaufen IMPORTING im_alter type i
    RAISING lcx_kauefer_zu_jung_exception.

ENDCLASS.

CLASS lcl_laden IMPLEMENTATION.
  METHOD alkohol_kaufen .

    IF im_alter < 18 .

      RAISE EXCEPTION TYPE lcx_kauefer_zu_jung_exception .

    ELSE.
        Write: / ' Viel Spaß!'.

    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

PARAMETERS p_alter TYPE i DEfault 16.

TRY.

lcl_laden=>alkohol_kaufen( im_alter = p_alter ).

CATCH lcx_kauefer_zu_jung_exception INTO DATA(e_text).
MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

       Write: / ' Zu jung'.
ENDTRY.
