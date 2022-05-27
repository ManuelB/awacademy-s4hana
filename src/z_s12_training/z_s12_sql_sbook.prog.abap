*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_SBOOK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_SQL_SBOOK.

""""""""""""""""""""""""""""""""""""""""""""""""""""Kopie von sbook mit Daten befüllen""""""""""""""""""""""""""""""""""""""""""""""""""""
SELECT * INTO TABLE @DATA(tsbook)
    FROM sbook.
INSERT ZAWS12_sbook FROM TABLE tsbook.
IF sy-subrc = 0. "Wenn Daten vorhanden --> Ausführen
  COMMIT WORK.
ENDIF.
