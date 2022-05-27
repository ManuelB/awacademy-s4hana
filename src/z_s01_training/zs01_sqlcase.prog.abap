*&---------------------------------------------------------------------*
*& Report Z_S01_SQL_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_sql_case.


SELECT FROM spfli
  FIELDS carrid, connid, cityfrom, cityto,fltime as Flugzeit,
* Wählt alle Felder, die gelistet werden.
  CASE WHEN fltime LT 100 THEN 'Kurzstrecke'
       WHEN fltime BETWEEN 100 AND 300 THEN 'Mittelstrecke'
*  Wählt Bedingungen.
  ELSE 'Langstrecke'

  END AS fltime
* Ende des obigen Teils, fltime ist der Alias für die Anweisungen da oben. Gleichzeiting Anweisungsende & Alias vergabe.
  ORDER BY carrid, connid
*  sortiert Ergebnis
  INTO TABLE @DATA(result).

  BREAK-POINT.

cl_demo_output=>display( result ).
*Output.

*Group by = Bildet Gruppen = Eine Menge von Zeilen wird in einer Zusammengefasst. Normalerweise der erste Eintrag.
*Hotelkette Minmax
*Having = zusätzliche einschränkung nach der Ergebnismenge nnach Group by
*Order by - Sortierung.
*Endselect = schleißt Select von Einzelsätzen. Notwendig, wenn Endergbnis nicht eine interne Tabelle, sondern während ddes Selektionsvorgangs die gefundene Einträge verbunden werden.
*Select count (distinct) zählt ohne Doppeleinträge
*distinct = ohne Doppeleinträge.
*Select distinct = *entfernt mehrfach vorkommende einträge ohne zu zählen.
