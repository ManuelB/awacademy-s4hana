REPORT z_s05_aufgabe002.

INTERFACE lif.
METHODS: bezahlen.
DATA: farbe TYPE string.
ENDINTERFACE.

CLASS Pkw DEFINITION.
PUBLIC SECTION.
METHODS:
fahren,
tanken,
get_farbe RETURNING VALUE(re_farbe) TYPE string.
DATA:
km TYPE i,
farbe TYPE string.
PROTECTED SECTION.

ENDCLASS.

CLASS pkw IMPLEMENTATION.
METHOD fahren.

ENDMETHOD.
METHOD tanken.

ENDMETHOD.

method get_farbe.
  endmethod.
ENDCLASS.

CLASS taxi DEFINITION INHERITING FROM pkw.
PUBLIC SECTION.
INTERFACES: lif.
METHODS:
fahren REDEFINITION,
tanken REDEFINITION.
*get_km RETURNING VALUE(re_km) TYPE i.
ENDCLASS.

CLASS taxi IMPLEMENTATION.
METHOD fahren.

ENDMETHOD.
METHOD tanken.

ENDMETHOD.
method lif~bezahlen.

  endmethod.
ENDCLASS.

START-OF-SELECTION.
DATA:
my_pkw TYPE REF TO pkw,
my_taxi TYPE REF TO taxi,
my_lif TYPE REF TO lif.
CREATE OBJECT: my_pkw, my_taxi.
my_lif = my_taxi.
WRITE: / my_lif->farbe, my_taxi->km, my_pkw->farbe.
