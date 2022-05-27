
CLASS pkw DEFINITION.
PUBLIC SECTION.
METHODS:
fahren,
tanken,
get_inhalt RETURNING VALUE(re_inhalt) TYPE i,
get_farbe RETURNING VALUE(re_farbe) type string.
PROTECTED SECTION.
DATA:
km TYPE i,
inhalt TYPE i,
farbe TYPE string.
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
fahren,
bezahlen,
get_inhalt RETURNING VALUE(re_inhalt) TYPE i,
tanken REDEFINITION,
get_km RETURNING VALUE(re_km) TYPE i.
ENDCLASS.

CLASS taxi IMPLEMENTATION.
METHOD fahren.

ENDMETHOD.

 METHOD tanken.
super—>tanken( ).
me->inhalt = super->inhalt.

ENDMETHOD.





ENDCLASS.



¥
START-OF-SELECTION.
DATA:
my_pkw TYPE REF TO pkw,
my_taxi TYPE REF TO taxi.

CREATE OBJECT: my_pkw, my_taxi.
WRITE: / my_taxi->km, my_pkw->farbe.
my_taxi->fahren( ).
my_taxi->get_farbe( ).
my_pkw->bezahlen( ).
