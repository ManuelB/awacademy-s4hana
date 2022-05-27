*&---------------------------------------------------------------------*
*& Report Z_S09_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_GUI_ELEMENTS.

DATA lv_zahl TYPE i.

PARAMETERS p_param LIKE lv_zahl.

SELECT-OPTIONS so_sel FOR lv_zahl NO INTERVALS.

PARAMETERS p_check AS CHECKBOX DEFAULT 'X'. "X in ABAP SPrache steht nur JA hier angeharkt"

PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.
PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.
