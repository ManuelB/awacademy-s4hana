*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_SPFLI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_SQL_SPFLI.
""""""""""""""""""""""""""""""""""""""""""""""""""""Kopie von spfli mit Daten befüllen""""""""""""""""""""""""""""""""""""""""""""""""""""
SELECT * INTO TABLE @DATA(tspfli) "Selektiert alle Einträge aus spfli und schreibt diese in die neue interne standard Tabelle tspfli
  FROM spfli.

INSERT ZAWS12_SPFLI FROM TABLE tspfli. "schreib alle Einträge aus tspfli in meine leere Kopie der spfli
IF sy-subrc = 0. "Wenn Daten vorhanden --> Ausführen
  COMMIT WORK.
ENDIF.
