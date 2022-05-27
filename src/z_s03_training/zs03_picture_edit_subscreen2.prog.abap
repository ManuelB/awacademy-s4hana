*&---------------------------------------------------------------------*
*& Report ZS03_PICTURE_EDIT_SUBSCREEN2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_PICTURE_EDIT_SUBSCREEN2.

CONTROLS: tsarea TYPE TABSTRIP.
DATA:
      cust TYPE REF TO cl_gui_custom_container,
      cust2 TYPE REF TO cl_gui_custom_container,
      pict TYPE REF TO cl_gui_picture,
      edit TYPE REF TO cl_gui_textedit,
      url TYPE cndp_url.

SET SCREEN 100.
