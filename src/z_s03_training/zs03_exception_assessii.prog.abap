*&---------------------------------------------------------------------*
*& Report zs03_exception_assessii
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_exception_assessii.

CLASS cx_kauefer_zu_jung_exception DEFINITION
  INHERITING FROM cx_static_check.
ENDCLASS.



CLASS laden DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: alkohol_kaufen IMPORTING im_alter TYPE i
* Exception propagieren
      RAISING cx_kauefer_zu_jung_exception.
ENDCLASS.



CLASS laden IMPLEMENTATION.
  METHOD alkohol_kaufen.
  if im_alter < 18.
  RAISE EXCEPTION TYPE cx_kauefer_zu_jung_exception.
*    ...
* Auslösen der Systemexception cx_sy_zerodivide

   ELSE.
WRITE: / 'Alkohol wurde verkauft.'.
    ENDIF.
*    ...
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

PARAMETERS:
p_alter TYPE i DEFAULT 20.

* Behandlung einer OO-Exception
  TRY.
* Funktionsaufruf, der Exception cx_sy_zerodivide auslösen kann
      laden=>alkohol_kaufen( im_alter = p_alter ).
* Exception cx_sy_zerodivide abfangen
    CATCH cx_kauefer_zu_jung_exception INTO DATA(e_text).
     MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
      WRITE: / 'Alkohol wurde nicht verkauft.'.
  ENDTRY.
