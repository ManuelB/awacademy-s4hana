*&---------------------------------------------------------------------*
*& Report Z_S11_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_write.

WRITE :'Hello World1'.
WRITE:/'HELLO WORLD2',/.
WRITE :'hello', 'world3'.

DATA a TYPE i.
a = 3.
WRITE :/ a.

DATA lv_hello(10) TYPE c VALUE 'Hellooo'.
ULINE.
WRITE : / lv_hello, 'world4'.


*DATA: d TYPE i VALUE 3, b TYPE i VALUE 7.
*
*B = d * b - c.

WRITE: |{ sy-datlo DATE = RAW }|.
WRITE: sy-datlo.
WRITE: |{ sy-datlo DATE = ISO }|.
*WRITE: sy-datlo, date RAW.

DO  3 TIMES.
  WRITE:/ sy-index.
  DO 2 TIMES.
    WRITE: sy-index.
  ENDDO.

ENDDO.
WRITE: / 'ende'.
