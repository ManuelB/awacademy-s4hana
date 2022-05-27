*&---------------------------------------------------------------------*
*& Report ZS12_FEHLER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS12_FEHLER.
LASS Pkw DEFINITION.
PUBLIC SECTION.
METHODS:
fahren
tanken,
get_inhalt RETURNING VALUE (re_inhalt) TYPE i,
get_farbe RETURNING VALUE (re_farbe) TYPE string.
PROTECTED SECTION.
DATA
kam TIPE 1,
inhalt TYPE i,
Tarbe TIPE String.
NDCLASS.
CLASS pkw IMPLEMENTAT ION.
METHOD fahren.
me > kin me- RIm +
100.
NDMETn
)
METHOD tanken.
me->inhalt = me->inhalt+20.
ENDE
ENDCLASS..
CLASS taxi DEFINITION INHERITING FROM pkw.
PUBLIC ECTION.
METHODS:
Fahren,
bezahlen,
get_inhalt RETURNING VALUE (re_inhalt) TYPE i,
tanken REDEF INITION,
get km RETURNING VALUE (re_km) TYPE i.
ENDCLASS.
aCLASS taxi IMPLEMENTATION.
METHOD fahren.
ENDMETHOD.
METHOD tanken.
Super tanken)
me-inhalt = super->inhalt.
ENDMETHOD.
ENDCL
START-OF-SELECTION.
DATA:
my_pkw TIPE REP TO pkw,
my_taX1 TIPE REP TO taxi.
