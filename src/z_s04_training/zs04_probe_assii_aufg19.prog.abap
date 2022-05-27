REPORT zrk_klasse_fehler.

CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:
      fahren,
      tanken,
      get_inhalt RETURNING VALUE(re_inhalt) TYPE i, "Implementierung fehlt
      get_farbe RETURNING VALUE(re_farbe) TYPE string. "Implementierung fehlt
  PROTECTED SECTION.
    DATA:
      km     TYPE i,
      inhalt TYPE i,
      farbe  TYPE string.
ENDCLASS.

CLASS pkw IMPLEMENTATION.
METHOD fahren.
me->km = me->km + 100.
ENDMETHOD.
METHOD tanken.
me->inhalt = me->inhalt + 20.
ENDMETHOD.
ENDCLASS.

CLASS taxi DEFINITION INHERITING FROM pkw.
  PUBLIC SECTION.
    METHODS:
*      fahren, "Bereits deklariert - REDEFINITION fehlt,
      bezahlen,
*      get_inhalt RETURNING VALUE(re_inhalt) TYPE i, "Bereits deklariert.
      tanken REDEFINITION,
      get_km RETURNING VALUE(re_km) TYPE i.
ENDCLASS.

CLASS taxi IMPLEMENTATION.
*  METHOD fahren. "Bereits implementiert in CLASS pkw.
*  "...
*  ENDMETHOD.
  METHOD tanken.
    super->tanken(  ).
    me->inhalt = me->inhalt + 40.
*    me->inhalt = super->inhalt. "super-> ist nicht möglich
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA:
    my_pkw  TYPE REF TO pkw,
    my_taxi TYPE REF TO taxi.

  CREATE OBJECT: my_pkw, my_taxi.
*  WRITE: / my_taxi->km, my_pkw->farbe. "Zugriff auf km und farbe nicht erlaubt (protected)
  my_taxi->fahren( ).
  my_taxi->get_farbe( ).
*  my_pkw->bezahlen( ). "Methode bezahlen wurde nicht angegeben. Nur über Klasse taxi
