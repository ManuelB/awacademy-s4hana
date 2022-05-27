*&---------------------------------------------------------------------*
*& Report Z_AW07_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_write.

DATA lv_textausgabe(5)  TYPE c VALUE 'hello'.

WRITE: 'hello', 'world'.

ULINE.

WRITE: lv_textausgabe, lv_textausgabe.
WRITE: / sy-datum.
