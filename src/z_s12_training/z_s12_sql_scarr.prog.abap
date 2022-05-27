*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_SQL_SCARR.

""""""""""""""""""""""""""""""""""""""""""""""""""""Kopie von scarr mit Daten befüllen""""""""""""""""""""""""""""""""""""""""""""""""""""
SELECT * INTO TABLE @DATA(tscarr)
   FROM scarr.
INSERT ZAWS12_SCARR FROM TABLE tscarr.
IF sy-subrc = 0. "Wenn Daten vorhanden --> Ausführen
  COMMIT WORK.
ENDIF.
