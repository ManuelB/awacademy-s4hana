CLASS z_cl_s10_teslamodel3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS: vollgas.

    INTERFACES z_s10_i_auto .
    DATA:
            batterie TYPE i,
            nummerschild type string,
            geschwindigkeit type i,
            besitzer type string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_cl_s10_teslamodel3 IMPLEMENTATION.


  METHOD z_s10_i_auto~besitzer.
  me->besitzer = besitzer.
  ENDMETHOD.


  METHOD z_s10_i_auto~max_geschwindigkeit.
  max_g = 180.
  ENDMETHOD.

  METHOD vollgas.
me->geschwindigkeit = me->z_s10_i_auto~max_geschwindigkeit(  ).
  ENDMETHOD.

ENDCLASS.
