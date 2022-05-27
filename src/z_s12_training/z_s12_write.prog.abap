*&---------------------------------------------------------------------*
*& Report Z_S12_WRITE
*&---------------------------------------------------------------------*
*&
**&---------------------------------------------------------------------*
*REPORT z_s12_write.
*
*DATA lv_hello(5) TYPE c Value 'HELLO'.
*
*
*WRITE: 'Hello World'.
*
*ULINE.
*
*WRITE: lv_hello, lv_hello, 'World'.
*Data a type i value 3.
*Data b type i value 7.
*data c type i value 2.
*b = a*b-c.

write: |{ sy-datlo date = RAW}|.
