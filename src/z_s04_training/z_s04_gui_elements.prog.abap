*&---------------------------------------------------------------------*
*& Report Z_S04_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_gui_elements.

DATA lv_zahl TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS p_para LIKE lv_zahl.

  SELECT-OPTIONS so_sel FOR lv_zahl NO INTERVALS.

  PARAMETERS p_check AS CHECKBOX DEFAULT 'X'.

  PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.
  SELECTION-SCREEN SKIP.
  PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.

SELECTION-SCREEN END OF BLOCK b1.
