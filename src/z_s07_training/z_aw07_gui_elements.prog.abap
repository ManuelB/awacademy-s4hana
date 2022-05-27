*&---------------------------------------------------------------------*
*& Report Z_AW07_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_GUI_ELEMENTS.

DATA lv_zahl TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
    PARAMETERS p_param LIKE lv_zahl.

    SELECT-OPTIONS so_sel FOR lv_zahl NO INTERVALS.
  SELECTION-SCREEN END OF BLOCK b2.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
    PARAMETERS p_check AS CHECKBOX DEFAULT 'X'.
  SELECTION-SCREEN END OF BLOCK b3.

  SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME.

    PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.
    SELECTION-SCREEN SKIP.
    PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.

  SELECTION-SCREEN END OF BLOCK b4.
SELECTION-SCREEN END OF BLOCK b1.
