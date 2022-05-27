*&---------------------------------------------------------------------*
*& Report Z_S02_ASS2_Q10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_ass2_q10.

INTERFACE auto
  PUBLIC.
  METHODS: besizter
    IMPORTING etwas TYPE string.
  METHODS: max_geschwindigkeit.
ENDINTERFACE.


INTERFACE fahrzeug
  PUBLIC.
ENDINTERFACE.

CLASS teslamodel3 DEFINITION.

  PUBLIC SECTION.
    METHODS:
      vollgas.

    DATA:
      batterie        TYPE i,
      nummernschild   TYPE string,
      geschwindigkeit TYPE i,
      besitzer        TYPE string.

  PRIVATE SECTION.
ENDCLASS.

CLASS teslamodel3 IMPLEMENTATION.


  METHOD auto~besitzer.
    me->besitzer = etwas.
  ENDMETHOD.


  METHOD auto~max_geschwindigkeit.
  ENDMETHOD.

  METHOD vollgas.
    me->geschwindigkeit = me->auto~max_geschwindigkeit(  ).
  ENDMETHOD.

ENDCLASS.
