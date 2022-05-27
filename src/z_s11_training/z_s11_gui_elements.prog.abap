*&---------------------------------------------------------------------*
*& Report Z_S11_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_gui_elements.

DATA lv_zahl TYPE i.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.


  PARAMETERS p_param LIKE lv_zahl.

  SELECT-OPTIONS so_sel FOR lv_zahl. "NO INTERVALS, prevents the second input field to be generated.

  PARAMETERS p_check AS CHECKBOX DEFAULT 'X'.

  SELECTION-SCREEN SKIP.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.
  PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.
   SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF BLOCK b1.
