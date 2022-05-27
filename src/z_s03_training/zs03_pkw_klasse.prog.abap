*&---------------------------------------------------------------------*
*& Report ZS03_PKW_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_pkw_klasse.

CLASS pkw DEFINITION.
  PUBLIC SECTION.
    METHODS:
      show_attributes.
*  PRIVATE SECTION.
    DATA:
      kennz TYPE string,

      farbe TYPE string.

ENDCLASS.

CLASS pkw IMPLEMENTATION.
  METHOD show_attributes.
    WRITE: / 'Farbe:', farbe, 'Kennzeichen:', kennz.
  ENDMETHOD.
ENDCLASS.

*    Hptprogramm
DATA:
      mein_auto TYPE REF TO pkw.


START-OF-SELECTION.
* sinon ca marche pas!
  CREATE OBJECT mein_auto.
  mein_auto->farbe = 'rot'.
  mein_auto->kennz = ' A-RK 1024'.
  CALL METHOD mein_auto->show_attributes.
