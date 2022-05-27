*&---------------------------------------------------------------------*
*& Report Z_S04_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_write.

DATA lv_textausgabe(5) TYPE c VALUE 'HALLO'.


WRITE: 'Hello', 'World'.

ULINE.

WRITE: lv_textausgabe, lv_textausgabe.
