REPORT zs04_probe_assii_aufg10.

INTERFACE lif_fahrzeug.
ENDINTERFACE.

INTERFACE lif_auto.
  METHODS:
    besitzer IMPORTING besitzer TYPE string,
    max_geschwindigkeit RETURNING VALUE(max_geschw) TYPE i.
ENDINTERFACE.

CLASS lcl_teslamodel3 DEFINITION.
PUBLIC SECTION.
  INTERFACES:
    lif_auto,
    lif_fahrzeug.
  METHODS: vollgas.
  DATA: batterie        TYPE i,
        nummernschild   TYPE string,
        geschwindigkeit TYPE i,
        besitzer        TYPE string.
ENDCLASS.

CLASS lcl_teslamodel3 IMPLEMENTATION.

  METHOD lif_auto~besitzer.
    me->besitzer = besitzer.
    ENDMETHOD.

    METHOD lif_auto~max_geschwindigkeit.
      max_geschw = 261.
      ENDMETHOD.

     METHOD vollgas.
       me->geschwindigkeit = me->lif_auto~max_geschwindigkeit( ).
       ENDMETHOD.

       ENDCLASS.
