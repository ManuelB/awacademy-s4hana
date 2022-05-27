REPORT zrk_if_inherit_demo.

INTERFACE lif.
  METHODS: bezahlen.
  DATA: farbe TYPE string.
ENDINTERFACE.

CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:
      fahren,
      tanken,
      get_farbe RETURNING VALUE(re_farbe) TYPE string.
  PROTECTED SECTION.
    DATA:
      km    TYPE i,
      farbe TYPE string.
ENDCLASS.

CLASS pkw IMPLEMENTATION.
  METHOD fahren.
    "...
  ENDMETHOD.
  METHOD tanken.
    "...
  ENDMETHOD.
  METHOD get_farbe.
    ENDMETHOD.
ENDCLASS.

CLASS taxi DEFINITION INHERITING FROM pkw.
  PUBLIC SECTION.
*    INTERFACES: lif.
    METHODS:
*      fahren,
      tanken REDEFINITION,
      get_km RETURNING VALUE(re_km) TYPE i.
ENDCLASS.

CLASS taxi IMPLEMENTATION.
*  METHOD fahren.
*    "...
*  ENDMETHOD.
  METHOD tanken.
    "...
  ENDMETHOD.
*  METHOD bezahlen.
*    "...
*  ENDMETHOD.
  METHOD get_km.
    ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
DATA:
my_pkw TYPE REF TO pkw,
my_taxi TYPE REF TO taxi,
my_lif TYPE REF TO lif.

CREATE OBJECT: my_pkw, my_taxi." my_lif.
*my_lif = my_taxi.
WRITE: my_lif->farbe. "my_taxi->km, my_pkw->farbe.
