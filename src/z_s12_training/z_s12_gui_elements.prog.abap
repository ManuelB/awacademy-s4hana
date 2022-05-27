*&---------------------------------------------------------------------*
*& Report Z_S12_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_gui_elements.

DATA lv_zahl TYPE i.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

    PARAMETERS p_param LIKE lv_zahl.

    SELECT-OPTIONS so_sel FOR lv_zahl.
  SELECTION-SCREEN END OF BLOCK b2.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
    PARAMETERS p_check AS CHECKBOX DEFAULT 'X'. "Boolean --> ja oder nein - in ABAP ' ' oder 'X'
    SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME.
      PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.
      PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.
      SELECTION-SCREEN SKIP.

    SELECTION-SCREEN END OF BLOCK b4.
  SELECTION-SCREEN END OF BLOCK b3.
SELECTION-SCREEN END OF BLOCK b1.
ULINE.
