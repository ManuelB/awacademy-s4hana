CLASS zcl_t01_rechteck DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES:
    if_oo_adt_classrun, zcl_t01_berechnbar.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_t01_rechteck IMPLEMENTATION.
  METHOD zcl_t01_berechnbar~area.
    i_flaeche = 5 * 5.
  ENDMETHOD.
  METHOD if_oo_adt_classrun~main.
      out->write( EXPORTING data = 'Hallo Welt').
  ENDMETHOD.

ENDCLASS.
