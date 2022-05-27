REPORT z_t01_klasse_fehler.
*
CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:
      fahren,
      tanken,
      get_inhalt RETURNING VALUE(re_inhalt) TYPE i,
      get_farbe RETURNING VALUE(re_farbe) TYPE string.

    DATA:
      km     TYPE i,
      inhalt TYPE i,
      farbe  TYPE string.
ENDCLASS.
*
CLASS pkw IMPLEMENTATION.
  METHOD fahren.
    me->km = me->km + 100.
  ENDMETHOD.
  METHOD tanken.
    me->inhalt = me->inhalt + 20.
  ENDMETHOD.
  METHOD get_inhalt.
  ENDMETHOD.
  METHOD get_farbe.
  ENDMETHOD.
ENDCLASS.
*
CLASS taxi DEFINITION INHERITING FROM pkw.
  PUBLIC SECTION.
    METHODS:
      fahren REDEFINITION,
      bezahlen,
      get_inhalt REDEFINITION,
      tanken REDEFINITION,
      get_km RETURNING VALUE(re_km) TYPE i.
ENDCLASS.
*
CLASS taxi IMPLEMENTATION.
  METHOD fahren.
  ENDMETHOD.
  METHOD tanken.
    super->tanken(  ).
    me->inhalt = 10. " super->inhalt.
  ENDMETHOD.
  METHOD bezahlen.

  ENDMETHOD.

  METHOD get_inhalt.

  ENDMETHOD.

  METHOD get_km.

  ENDMETHOD.

ENDCLASS.
*
START-OF-SELECTION.
  DATA:
    my_pkw  TYPE REF TO pkw,
    my_taxi TYPE REF TO taxi.
  CREATE OBJECT : my_pkw, my_taxi.
  WRITE: my_taxi->km, my_pkw->farbe.
  my_taxi->fahren(  ).
  my_taxi->get_farbe( ).
"  my_pkw->bezahlen(  ).
"1 Zeile 8  es fehlt die Implementierung der Methode get_inhalt
"2 Zeile 9  es fehlt die Implementierung der Methode get_farbe
"3 Zeile 29 REDEFINITION fehlt
"4 Zeile 30 es fehlt die Implementierung der Methode bezahlen
"5 Zeile 31 REDEFINITION fehlt
"6 Zeile 42 super ist nur für das ansprechen von Methoden gültig
"7 Zeile 52 Der Zugriff auf die protected property km ist nicht erlaubt
"8 Zeile 52 Der Zugriff auf die protected property farbe ist nicht erlaubt
"9 Zeile 54 Es fehlt die Implementierung der Methode get_farbe
"10 Zeile 55 Funktion bezahlen ist unbekannt
