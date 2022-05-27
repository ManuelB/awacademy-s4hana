*&---------------------------------------------------------------------*
*& Report z_exception_klasse
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_exception_klasse.


*1. kauefer_zu_jung_exception als ABAP Klasse implementieren,
* welche von cx_static_check abgeleitet ist
*2. Klasse Laden definieren
*3. Methode alkoholKaufen mit Importing paramter alter type i definieren
*4. An Method alkoholKaufen RAISING kauefer_zu_jung_exception ran schreiben
*5. Methode alkoholKaufen so implementieren,
*dass wenn alter < 18 ist Exception mit RAISE EXCEPTION TYPE kauefer_zu_jung_exception geworfen wird
*6. START-OF-SELECTION mit TRY CATCH implementieren
*7. Einmal alkoholKaufen mit Alter 20 aufrufen
*8. Einmal alkoholKaufen mit Alter 16 aufrufen

CLASS kauefer_zu_jung_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.



 CLASS cx_application_error DEFINITION

  INHERITING FROM cx_static_check.
ENDCLASS. CLASS my_class DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: my_method
* Exception propagieren
      RAISING cx_application_error.
ENDCLASS. CLASS my_class IMPLEMENTATION.
  METHOD my_method.
*    ...
* Auslösen der Systemexception cx_sy_zerodivide
    RAISE EXCEPTION TYPE cx_application_error.
*    ...
  ENDMETHOD.
ENDCLASS. START-OF-SELECTION.
* Behandlung einer OO-Exception
  TRY.
* Funktionsaufruf, der Exception cx_sy_zerodivide auslösen kann
      my_class=>my_method( ).
* Exception cx_sy_zerodivide abfangen
    CATCH cx_application_error INTO DATA(e_text).
      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.
