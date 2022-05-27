CLASS z_grp3_teslamodel3 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      batterie        TYPE i,
      nummernschild   TYPE string,
      geschwindigkeit TYPE i,
      besitzer        TYPE string.
    METHODS
      vollgas.
    INTERFACES Z_grp3_Auto.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS Z_GRP3_TESLAMODEL3 IMPLEMENTATION.


  METHOD vollgas.
  ENDMETHOD.


  METHOD  z_grp3_auto~besitzer.
   me->besitzer = besitzer.
  ENDMETHOD.


  METHOD Z_grp3_auto~max_geschwindigkeit.
  me->geschwindigkeit = me->z_grp3_max_geschwindigkeit(  ).
  ENDMETHOD.
ENDCLASS.
