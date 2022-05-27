*&---------------------------------------------------------------------*
*& Report Z_S02_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_GUI_ELEMENTS.

*Grundlegende GUI Elemente

DATA lv_zahl TYPE i.

PARAMETERS p_param LIKE lv_zahl. "oben auf TExtelement oder F5. Selektionstext. "Parameter" eingeben

SELECT-OPTIONS so_sel FOR lv_zahl NO INTERVALS.

PARAMETERS p_check AS CHECKBOX DEFAULT 'X'. " per Default angehakt

PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1. "man muss mehrere angeben
PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1. "man muss mehrere angeben



*Taschenrechner machen: Zwei Eingabefelder für eine Zahl
