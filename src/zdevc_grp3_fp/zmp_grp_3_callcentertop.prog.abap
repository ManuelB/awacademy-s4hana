*&---------------------------------------------------------------------*
*& Include          ZMP_GRP_3_CALLCENTERTOP
*&---------------------------------------------------------------------*

"PROGRAM ZMP_GRP_3_CALLCENTER.
**********************************************************************
TABLES:
  zgrp3_kunde.
DATA:

  cust_1   TYPE REF TO cl_gui_custom_container,
  cust_2   TYPE REF TO cl_gui_custom_container,
  text1    TYPE REF TO cl_gui_textedit,
  picture1 TYPE REF TO cl_gui_picture,
  url      TYPE cndp_url,
  ls_kunde TYPE zgrp3_kunde,
  lt_kunde TYPE TABLE OF zgrp3_kunde.

CLASS zgrp3_ca DEFINITION.
  PUBLIC SECTION.
    METHODS:
      status.
ENDCLASS.
