*&---------------------------------------------------------------------*
*& Report Z_S06_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_GUI_ELEMENTS.
*
*DATA lv_zahl TYPE i.
*
*PARAMETERS p_param LIKE lv_zahl.
*
*SELECT-OPTIONS so_sel FOR lv_zahl NO INTERVALS.
*
*PARAMETERS p_check AS CHECKBOX DEFAULT 'X'.
*
*PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.
*PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.

DO.

ENDDO. Write: 'fertig'.
