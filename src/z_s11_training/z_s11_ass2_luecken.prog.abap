*&---------------------------------------------------------------------*
*& Report Z_S11_ASS2_LUECKEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ASS2_LUECKEN.

CLASS C_auto DEFINITION.
PUBLIC SECTION.
EVENTS:
tank_leer.
Methods:
constructor,
fahren,
tanken
FOR EVENT tank_leer OF c_auto.
ENDCLASS.
CLASS c_auto IMPLEMENTATION.
METHOD constructor.
set handler me->tanken for me. "handler
ENDMETHOD.
METHOD fahren.
WRITE: 'fahren'.
RAISE EVENT tank_leer.
ENDMETHOD.
METHOD tanken.
WRITE: /'tanken'.
endmethod.
ENDCLASS.

CLASS c_tankstelle DEFINITION.

PUBLIC SECTION.
EVENTS:
guenstig.
METHODS :
set_preis IMPORTING im_preis TYPE i,
get_preis RETURNING VALUE(re_preis) TYPE i,
entscheiden,
verkaufen FOR EVENT guenstig  OF
c_tankstelle.
DATA:
preis TYPE i.
ENDCLASs.
CLASS C_tankstelle IMPLEMENTATION.
METHOD set_preis.
  me->preis = im_preis.
ENDMETHOD.
METHOD get_preis.
re_preis = me->preis.
ENDMETHOD.
METHOD entscheiden.
IF me->get_preis( ) < 5000.
RAISE EVENT guenstig.
ELSE.
WRITE:/ 'behalten'.
ENDIF.
ENDMETHOD.
METHOD verkaufen.
WRITE:/ 'verkaufen'.
ENDMETHOD.
ENDCLASS.

START-OF-SELECTION  .
PARAMETERS:
preis TYPE i DEFAULT 2000.
DATA:r_auto TYPE REF TO c_auto,
r_tankstelle TYPE REF TO c_tankstelle.
r_auto = NEW C_auto( ).
r_tankstelle = NEW c_tankstelle( ).
SET HANDLER r_tankstelle->verkaufen FOR r_tankstelle.
r_auto->fahren( ).
r_tankstelle->set_preis( preis ).
r_tankstelle->entscheiden( ).
