*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_SFLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_SQL_SFLIGHT.
SELECT * INTO TABLE @DATA(tsflight) "Selektiert alle Einträge aus spfli und schreibt diese in die neue interne standard Tabelle tspfli
  FROM sflight.

INSERT ZAWS12_Sflight FROM TABLE tsflight. "schreib alle Einträge aus tspfli in meine leere Kopie der spfli
IF sy-subrc = 0. "Wenn Daten vorhanden --> Ausführen
  COMMIT WORK.
ENDIF.
