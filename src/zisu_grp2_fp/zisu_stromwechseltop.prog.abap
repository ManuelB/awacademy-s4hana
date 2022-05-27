*&---------------------------------------------------------------------*
*& Include          ZISU_STROMWECHSELTOP
*&---------------------------------------------------------------------*
PROGRAM zisu_stromwechsel MESSAGE-ID zmsg_fp_grp2.


TABLES :
  zisu_fp_kunden, zisu_fp_tarife, zisu_fp_wechsel.

DATA :
      flag type c length 1,
  cont1     TYPE REF TO cl_gui_custom_container,
  alv1      TYPE REF TO cl_gui_alv_grid,
  ls_tarife TYPE zisu_fp_tarife,
  lt_tarife TYPE TABLE OF zisu_fp_tarife,
lo_wechsel type ref to z_grp2_wechsel.


CLASS lcl_listener DEFINITION.
  PUBLIC SECTION.
    DATA answer TYPE n.
    METHODS: handle_double_click
      FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_row.
ENDCLASS.
