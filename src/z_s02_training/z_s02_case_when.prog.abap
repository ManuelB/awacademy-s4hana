*&---------------------------------------------------------------------*
*& Report Z_S02_CASE_WHEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_CASE_WHEN.

SELECT FROM ZS02_SPFLI
  FIELDS carrid, connid, cityfrom, cityto,
  CASE WHEN fltime LT 100 THEN 'short'
  WHEN fltime BETWEEN 100 AND 300 THEN 'medium'
  ELSE 'long'
  END AS fltime
  ORDER BY carrid, connid
  INTO TABLE @DATA(result). "im Debugger auf Tabelle, result wählen, dann sieht man die Spalte mit den neuen Informationen angezeigt.

  BREAK-POINT.
