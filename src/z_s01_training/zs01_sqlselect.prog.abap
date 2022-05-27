*&---------------------------------------------------------------------*
*& Report Z_S01_ENDSELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_endselect.

*Verstanden

*Endselect schließt eine Mit Select begonnene Schleife ab.
*Ist notwendig, wenn das Ergebnis z.B. nicht in eine Interne Tabelle geschrieben wird,
* sondern während des Selektionsvorgangs die Gefundene Einträgge verarbeitet werden.

*Strukturtyp erstellung

DATA: BEGIN OF lty_wa,
        carrid   TYPE sflight-carrid,
        connid   TYPE sflight-connid,
        seatsocc TYPE sflight-seatsocc,
      END OF lty_wa,
* Tabelle mit der Struktur von davoben.
      tline like TABLE OF lty_wa. " deklaraion einer  Tabelle.

BREAK-POINT.

*Selectschleife
* Gruppiert Flugggeselleschaftskürzel und Flugverbindungsnummer und summiert die belegten Plätze anhand der Verbindungsnummer.
SELECT carrid, connid, SUM( seatsocc ) AS occ
  FROM sflight
  GROUP BY Carrid, connid "gruppiert mit 2 Kriterien. 1. Fluggesellschaftskürzel, dann verbindungsnummer.
  ORDER BY carrid, connid "sortiert nach Feld carrid.
  INTO @lty_wa.


INSERT lty_wa INTO TABLE tline.
*fügt Daten in unseren table tline.


ENDSELECT.
* SELECT wird nicht durch ENDSELECT abgeschlossen
* wenn es ein SELECT SINGLE-Befehl ist,
* wenn in der INTO-Klausel nur Aggregatfunktionen vorkommen oder
* wenn die INTO-Klausel INTO TABLE itab oder APPENDING TABLE itab nicht den Zusatz PACKAGE SIZE enthält.



cl_demo_output=>display( tline ). "output.
