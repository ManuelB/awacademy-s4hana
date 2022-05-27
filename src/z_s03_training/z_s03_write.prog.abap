*&---------------------------------------------------------------------*
*& Report Z_S03_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_write.

WRITE 'Hello World'.
WRITE: 'Hello', 'World'.
WRITE: 'bla','blou'.
ULINE.
ULINE.
ULINE.
DATA lv_hello(10) TYPE c VALUE 'HELLO'.
WRITE: lv_hello, lv_hello.
