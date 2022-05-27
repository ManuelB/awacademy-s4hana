*&---------------------------------------------------------------------*
*& Report Z_S02_A38
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_A38.


**********************
***** Definition
**********************
class auto DEFINITION.
  PUBLIC SECTION.
  methods:
  importing
    excetions
    .
  PRIVATE SECTION.
  DATA:
        .
ENDCLASS.


**********************
***** Implementation
**********************
class auto IMPLEMENTATION.
  method.
    ENDMETHOD.
    ENDCLASS.


**********************
***** Hauptprogramm
**********************

    START-OF-SELECTION.
    CREATE object .


    call method eins.

    WRITE: / 'stuff&shit', mein_auto->get_kennz( ).
