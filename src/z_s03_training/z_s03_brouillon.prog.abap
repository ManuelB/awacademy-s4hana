*&---------------------------------------------------------------------*
*& Report Z_S03_BROUILLON
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_BROUILLON.

*CLASS C_auto DEFINITION .
*PUBLIC SECTION.
*EVENTS:
*tank_leer.
*METHODS:
*constructor,
*fahren,
*tanken
*FOR EVENT tank_leer OF C_auto.
*ENDCLASs.
*CLASS C_auto IMPLEMENTATION.
*METHOD constructor.
*SET HANDLER me->tanken FOR me.
*ENDMETHOD.
*METHOD fahren.
*WRITE:/'fahren'.
*RAISE EVENT tank_leer.
*ENDMETHOD.
*METHOD tanken.
*WRITE: / 'tanken'.
*ENDMETHOD.
*ENDCLASS.
*
*CLASS c_tankstelle DEFINITION.
*PUBLIC SECTION.
*EVENTS:
*guenstig.
*METHODS:
*set_preis IMPORTING im_preis TYPE i,
*get_preis RETURNING VALUE(re_preis) TYPE i,
*entscheiden,
*verkaufen FOR EVENT guenstig OF
*c_tankstelle.
*DATA:
*preis TYPE i.
*ENDCLASs.
*
*CLASS C_tankstelle IMPLEMENTATION.
*METHOD set_preis.
*me->preis = im_preis.
*ENDMETHOD.
*METHOD get_preis.
*re_preis = me->preis.
*ENDMETHOD.
*METHOD entscheiden.
*IF me->get_preis( ) < 5000.
*RAISE EVENT guenstig.
*ELSE.
*WRITE: / 'behalten'.
*ENDIF.
*ENDMETHOD.
*METHOD verkaufen.
*WRITE:/ 'verkaufen'.
*ENDMETHOD.
*ENDCLASs.
*
*START-OF-SELECTION.
*
*PARAMETERS:
*preis TYPE i DEFAULT 2000.
*DATA:
*r_auto TYPE REF TO C_auto,
*r_tankstelle TYPE REF To c_tankstelle.
*
*r_auto = NEW C_auto( ).
*r_tankstelle = NEW c_tankstelle( ).
*SET HANDLER r_tankstelle->verkaufen FOR r_tankstelle .
*r_auto->fahren( ).
*r_tankstelle->set_preis( preis ).
* r_tankstelle->entscheiden( ).


**FRAGE 20
*
*INTERFACE j.
*EVENTS: e.
*METHODS: ma,
*on_e FOR EVENT e OF j.
*DATA: count TYPE i.
*ENDINTERFACE.
*CLASS k DEFINITION.
*PUBLIC SECTION.
*INTERFACES: j.
*METHODS:
*ma,
*constructor IMPORTING im_limit TYPE i.
*PRIVATE SECTION.
*DATA: limit TYPE i VALUE 9.
*ENDCLASS.
*
*CLASS k IMPLEMENTATION.
*METHOD constructor.
*limit = im_limit.
*SET HANDLER j~on_e FOR me.
*ENDMETHOD.
*METHOD ma.
*WHILE j~count < limit.
*WRITE: j~count.
*ADD 1 TO j~count.
*ENDWHILE.
*RAISE EVENT j~e.
*ENDMETHOD.
*METHOD j~ma.
*WHILE j~count > 0.
*WRITE: j~count.
*SUBTRACT 1 FROM j~count.
*ENDWHILE.
*RAISE EVENT j~e.
*ENDMETHOD.
*METHOD j~on_e.
*WRITE:
*'ok'. SKIP.
*ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*DATA:
*k_ref TYPE REF TO k.
*PARAMETERS:
*P_limit TYPE i DEFAULT 5.
*CREATE OBJECT k_ref
*EXPORTING
*im_limit = p_limit.
*k_ref->j~count = 3.
*CALL METHOD : k_ref->j~ma, k_ref->ma.


* FRAGE 17

INTERFACE lif.
METHODS: bezahlen.
DATA: farbe TYPE String.
ENDINTERFACE.
CLASS pkw DEFINITION.
PUBLIC SECTION.
METHODS:
fahren,
tanken,
get_farbe RETURNING VALUE(re_farbe) TYPE string.
PROTECTED SECTION.
DATA:
km TYPE i,
farbe TYPE string.
ENDCLASS.
CLASS pkw IMPLEMENTATION.
METHOD fahren.
ENDMETHOD.
METHOD tanken.
ENDMETHOD.
ENDCLASs.
CLASS taxi DEFINITION INHERITING FROM pkw.
PUBLIC SECTION.
INTERFACES: lif.
METHODS:
fahren REDEFINITION,
tanken REDEFINITION,
get_km RETURNING VALUE(re_km) TYPE i.
ENDCLASs.
CLASS taxi IMPLEMENTATION.
METHOD fahren.
ENDMETHOD.
METHOD tanken.
ENDMETHOD.
METHOD lif~bezahlen.
ENDMETHOD.
ENDCLASs.
START-OF-SELECTION.
DATA:
my_pkw TYPE REF TO Pkw,
my_taxi TYPE REF TO taxi.
my_lif TYPE REF TO taxi.

CREATE OBJECT: my_pkw, my_taxi, my_lif.
my_lif = my_taxi.
*WRITE: / my_lif->farbe, my_taxi->km, my_pkw->farbe.
