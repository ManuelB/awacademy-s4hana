*&---------------------------------------------------------------------*
*& Report ZS12_ASSESSMENT2_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS12_ASSESSMENT2_UEBUNG.
REPORT zrk_events.
CLASS C_auto DEFINITION.
PUBLIC SECTION.
EVENTS:
14
ankeer.
constructor,
fahren,
tanken
FOR EVENT tank_leer OF c_auto.
ENDCLASS-
CLASS IMPLEMENTATION.
METHOD_constructor.
L
ENDMETHOD.
SET
me-tanken FOR me.
METHOD fahren.
WRITE: 'fahren'.
RAISE EVENT tank_leer.
ENDMETHOD.
METHOD tanken.
WRITE: 'tanken'.
ENDCLASS.
CLASS Ctankstelle DEFINITION.
PUBLIC SECTION.
EVENTS:
guenstig.
METHODS
set_preis IMPORTING im_preis TYPE i,
get _preis RETURNING VALUE (re_preis) TYPE i,
entscheiden,
verkaufen FOR EVENT OF
c_tankstelle.
DATA:
preis TYPE i
ENDCLASs.
CLASS C_tankstelle IMPLEMENTATION.
METHOD ser_pes
nepe L
ENDMETHOD.
METHOD get preis.
L mepreis.
ENDMETHOD.
METHOD entscheiden.
IF me->get _preis ( ) <5000.
RAISE EVENT guenstig.
ELSE
WRITE:/ "behalten'.
ENDIF.
ENDMETHOD.
METHOD verkaufen.
WRITE: 'verkaufen".
ENDMETHOD.
ENDCLASS.
PARAMETERS:
preis TYPE i DEFAULT 200.
DATA:
TYPE REF TO c_auto,
T_auto
r_tankstelle TYPE REF TO c_tankstelle.
_auto= NEW C_auto()
T_tankstelle = NEW Ctankstelle().
SET HANDLER r_tankstelle->verkaufen FOR r_tankstelle.
_auto-fahren
tankstelle->set_preis preis
entscheiden ().
