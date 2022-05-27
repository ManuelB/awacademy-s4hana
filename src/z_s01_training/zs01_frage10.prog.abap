REPORT zs01_frage10.



INTERFACES  Fahrzeug.


INTERFACE auto.
  METHODS besitzer

    IMPORTING im_besitzer TYPE string.

  METHODS max_geschwindigkeit RETURNING VALUE(max_g) TYPE i.

ENDINTERFACE.


CLASS teslamodel3 DEFINITION.
  PUBLIC SECTION.


    METHODS vollgas.



    DATA:
      batterie        TYPE i,
      nummernschild   TYPE String,
      geschwindigkeit TYPE i,
      besitzer        TYPE string.




ENDCLASS.

CLASS teslamodel3 IMPLEMENTATION.

  METHOD vollgas.



    WRITE: / 'gibt Vollgass'.


  ENDMETHOD.

  METHOD

ENDCLASS.
