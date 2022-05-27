*&---------------------------------------------------------------------*
*& Include ZMP_GRP3_STROM_WECHSELTOP                - Modulpool        ZMP_GRP_3_STROM_WECHSEL
*&---------------------------------------------------------------------*
PROGRAM zmp_grp_3_strom_wechsel MESSAGE-ID ZMSG_GRP3_FP.

TABLES:
  zgrp3_liefwe, zgrp3_kunde, zgrp3_tstatus.
DATA:
* Container
  cont1        TYPE REF TO cl_gui_custom_container,
  cont2        TYPE REF TO cl_gui_custom_container,
  cont3        TYPE REF TO cl_gui_custom_container,
  dia          TYPE REF TO cl_gui_dialogbox_container,
  dock         TYPE REF TO cl_gui_docking_container,
* Anwendungs-Controls
  alv1         TYPE REF TO cl_gui_alv_grid,
  alv2         TYPE REF TO cl_gui_alv_grid,
  ls_liefwe    TYPE zgrp3_liefwe,
  lt_liefwe    TYPE TABLE OF zgrp3_liefwe,
  ls_kunde     TYPE zgrp3_kunde,
  lt_kunde     TYPE TABLE OF  zgrp3_kunde,
  picture1     TYPE REF TO cl_gui_picture,
  url          TYPE cndp_url,
  edit         TYPE REF TO cl_gui_textedit,
  display_text TYPE c LENGTH 255,
  it_text      LIKE TABLE OF display_text.

CLASS lcl_listener DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_double_click
        FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row. " e_column.
ENDCLASS.
