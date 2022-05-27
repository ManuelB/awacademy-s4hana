*&---------------------------------------------------------------------*
*& Report Z_S11_PROBE_ASESSMENT_UML
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_probe_asessment_uml.

INTERFACE auto.
  METHODS:  besitzer IMPORTING im_besitzer TYPE string,
    max_geschwindigkeit RETURNING VALUE(max_g) TYPE i.
ENDINTERFACE.

INTERFACE fahrzeug.
ENDINTERFACE.

CLASS teslamodel3 DEFINITION.

  PUBLIC SECTION.
    INTERFACES auto.
    METHODS vollgas.
    DATA:

      batterie        TYPE i,
      nummernschild   TYPE string,
      geschwindigkeit TYPE i,
      besitzer        TYPE string.
protected section.
private section.
ENDCLASS.

class teslamodel3 IMPLEMENTATION.
  method auto~besitzer.
    me->besitzer = besitzer.
ENDMETHOD.

    method auto~max_geschwindigkeit.
     max_g = 180.
      endmethod.

      method vollgas.
        me->geschwindigkeit = me->auto~max_geschwindigkeit( ).
        endmethod.
  endclass.
