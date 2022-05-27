*&---------------------------------------------------------------------*
*& Report z_s09_aufgabe_exceptions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_aufgabe_exceptions.

CLASS kaufer_zu_jung_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS kaufer_zu_jung_exception IMPLEMENTATION.
ENDCLASS.

CLASS laden DEFINITION.
  PUBLIC SECTION.
    METHODS:
      alkoholKaufen
        IMPORTING
          im_alter TYPE i
        RAISING
          kaufer_zu_jung_exception.
ENDCLASS.

CLASS laden IMPLEMENTATION.
  METHOD alkoholkaufen.
    IF im_alter > 18.
*    ELSEIF im_alter = 18.
*      WRITE: / 'Zeig mir mal deinen Ausweis!'.
    ELSE.
      RAISE EXCEPTION TYPE kaufer_zu_jung_exception.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA:
    lo_zujung TYPE REF TO kaufer_zu_jung_exception,
    lv_alter  TYPE i VALUE 16,
    lv_alter2 TYPE i VALUE 20,
    lv_alter3 TYPE i VALUE 18,
    l_laden   TYPE REF TO laden.
  l_laden = NEW laden( ).

  TRY.
      l_laden->alkoholkaufen( im_alter = lv_alter ).
    CATCH kaufer_zu_jung_exception.

      WRITE: / 'Du bist zu jung!'.
  ENDTRY.

  TRY.
      l_laden->alkoholkaufen( im_alter = lv_alter2 ).
      WRITE: / 'Dein Alter ist okay!'.
      ULINE.
    CATCH kaufer_zu_jung_exception.
  ENDTRY.

  TRY.
      l_laden->alkoholkaufen( im_alter = lv_alter3 ).
    CATCH kaufer_zu_jung_exception.
  ENDTRY.


*  Behandlung einer oo-Exception
*try.
** Funktionsaufruf, der Exception cx_sy_zerodivide auslösen kann
*  my_class=>my_method( ).
** Exception cx_sy_zerodivide abfangen
*CATCH cx_application_error INTO DATA(e_text).
*  MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
*ENDTRY.
*ENDTRY.
