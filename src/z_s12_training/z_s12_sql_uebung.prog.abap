*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_sql_uebung.
*DATA: Kundennummer TYPE vbak-KUNNR VALUE ' '.
**      Land TYPE vbak-land1 VALUE ' '.
*cl_demo_input=>new(
*)->add_field( CHANGING field = Kundennummer )->request( ).
**  )->add_field( CHANGING field = LAND1
*
*select  COUNT( auart )
*  from vbak
*  where auaurt = 'Nicht bearbeitet'
*  or auaurt = 'teilweise bearbeitet'
**  and land1 = @land1
*    GROUP BY vtweg and vkorg and lfstk
**  HAVING land1
*  into table @DATA(ergebnis).
*  ENDSELECT.
*
*  cl_demo_output=>display( ergebnis ).

*  *********************************************************************************************
*  *Lösung
*  *********************************************************************************************
*  PARAMETERS: Kundennummer type kunnr.
*
*  select vkorg, vtweg, lfstk, count ( vbeln ) as Kundenaufträge
*    from vbak
*    where kunnr = @Kundennummer
*    and vbak-auart = 'TA'

*  *********************************************************************************************
*  *Lösung
*  *********************************************************************************************
*Liste Terminaufträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
"Bei Select sagen was ausgewählt werden soll, daher alle parameter
*SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, COUNT( lfstk ) AS anzahl "k und v da aus zwei verschiedenen Tabellen
*  FROM vbak AS v
*  INNER JOIN kna1 AS k
*  ON v~kunnr = k~kunnr
*  WHERE v~auart = 'TA'
*  AND ( v~lfstk = 'A' OR v~lfstk = 'B' )
*  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk
*  INTO TABLE @DATA(tresult1).
*cl_demo_output=>display( tresult1 ).


*Liste Terminaufträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
*Auftragsnettowert / Währung für noch nicht ausgelieferte Aufträge -> Kohle fehlt bei uns
*SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, sum( netwr ) AS Auftragswert, v~waerk as Currency
*  FROM vbak AS v
*  INNER JOIN kna1 AS k
*  ON v~kunnr = k~kunnr
*  WHERE auart = 'TA'
*  AND ( v~lfstk = 'A' OR v~lfstk = 'B' )
*  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, v~waerk
*  INTO TABLE @DATA(tresult2).
*  cl_demo_output=>display( tresult2 ).

SELECT FROM spfli
FIELDS carrid,
connid,
cityfrom,
cityto,
  distance,
  fltime, "oder fltime as Flugzeit
CASE WHEN fltime < 100 THEN 'Kurzzstrecke'
WHEN fltime BETWEEN 100 AND 300 THEN 'Mittelstrecke'
ELSE 'Langstrecke'
END AS fltimerenamed
ORDER BY carrid, connid
INTO TABLE @DATA(result).
cl_demo_output=>display( result ).
