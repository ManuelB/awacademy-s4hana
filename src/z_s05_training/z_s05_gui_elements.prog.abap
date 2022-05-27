*&---------------------------------------------------------------------*
*& Report Z_S05_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_GUI_ELEMENTS.

DATA lv_zahl TYPE i.


SELECTION-SCREEN BEGIN OF BLOCK MAIN WITH FRAME.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.



PARAMETERS p_param LIKE lv_zahl.

SELECT-OPTIONS so_sel FOR lv_zahl NO INTERVALS.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

PARAMETERS p_check AS CHECKBOX DEFAULT 'X'.

PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.

SELECTION-SCREEN SKIP.
PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.
 SELECTION-SCREEN END OF BLOCK b2.
 SELECTION-SCREEN END OF BLOCK MAIN.
