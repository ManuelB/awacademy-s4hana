*&---------------------------------------------------------------------*
*& Report z_t01_exceptions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_t01_exceptions.

CLASS cx_application_error DEFINITION
  INHERITING FROM cx_static_check.
ENDCLASS.

CLASS my_class DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: my_method
* Exception propagieren
      RAISING cx_application_error.
ENDCLASS.

CLASS my_class IMPLEMENTATION.
  METHOD my_method.
*    ...
* Auslösen der Systemexception cx_sy_zerodivide
    RAISE EXCEPTION TYPE cx_application_error.
*    ...
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
* Behandlung einer OO-Exception
  TRY.
* Funktionsaufruf, der Exception cx_sy_zerodivide auslösen kann
      my_class=>my_method( ).
* Exception cx_sy_zerodivide abfangen
    CATCH cx_application_error INTO DATA(e_text).
      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.
