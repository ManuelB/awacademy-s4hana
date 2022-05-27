*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_BESTAND
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_grp1_rep_bestand.
PARAMETERS: p_artgr TYPE zsd_grp1_sw-artgr.

CLASS lcl_bestand DEFINITION.
  PUBLIC SECTION.
    METHODS ausgabe.
ENDCLASS.


CLASS lcl_bestand IMPLEMENTATION.
  METHOD ausgabe.
    SELECT artnr, artname, artgr, akbes
      FROM zsd_grp1_sw
      WHERE artgr = @p_artgr"for testing
      ORDER BY artgr
      INTO TABLE @DATA(ausgabe).
   cl_demo_output=>display( ausgabe ).
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA: lo_bestand TYPE REF TO lcl_bestand.

  lo_bestand = NEW lcl_bestand( ).

  lo_bestand->ausgabe( ).
