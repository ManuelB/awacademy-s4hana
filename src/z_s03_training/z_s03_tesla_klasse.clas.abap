



CLASS z_s03_tesla_klasse DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      vollgas.
    INTERFACES Z_S03_auto.

    DATA:
      batterie TYPE i,
      nrschild TYPE string,
      speed    TYPE i.

ENDCLASS.



CLASS Z_S03_TESLA_KLASSE IMPLEMENTATION.


  METHOD vollgas.

  ENDMETHOD.


  METHOD z_s03_auto~besitzer.

  ENDMETHOD.


  METHOD z_s03_auto~max_speed.

  ENDMETHOD.
ENDCLASS.
