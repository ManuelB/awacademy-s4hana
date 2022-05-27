*&---------------------------------------------------------------------*
*& Report Z_S02_RANGES_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_RANGES_UEBUNG.

INCLUDE Z_T04_I_FLUGDATEN.

TABLES sbook.

DATA ls_sbook TYPE sbook.

* Beispiel SCARR
SELECT-OPTIONS so_sbook FOR sbook-order_date DEFAULT '20210929'.  " so steht für selction options. Man kann


LOOP AT lt_sbook INTO ls_sbook WHERE order_date IN so_sbook AND FORCURAM IN so_sbook.
WRITE: / |{ ls_sbook-order_date } - { ls_sbook-forcuram }|.
ENDLOOP.

*LOOP AT lt_sbook INTO ls_sbook WHERE FORCURAM IN so_sbook.
*WRITE: / |{ ls_sbook-forcuram } - { ls_sbook-forcuram }|.
*ENDLOOP.

IF sy-subrc <> 0.
  MESSAGE: |Keine Fluggesellschaft gefunden.| TYPE 'S'.
  ENDIF.
