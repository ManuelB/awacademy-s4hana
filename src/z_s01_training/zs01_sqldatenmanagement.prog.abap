*&---------------------------------------------------------------------*
*& Report Z_S01_DATENMANAGEMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_sqldatenmanagement.


*-Liste Terminaufträge mit Lieferstatus = nicht/unvollständig bearbeitet

*  Auftragsnettowert / währung für noch nicht ausgelieferte Aufträge -> Kohle fehlt uns
SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, SUM( NETWR ) AS Auftragswert, v~waerk as currency
*  wählt felder vbak
   FROM vbak AS v
  INNER JOIN kna1 AS k
  ON v~kunnr = k~kunnr
   WHERE v~auart = 'TA'
  AND ( v~lfstk = 'A' OR v~lfstk = 'B' )
  And k~land1 = 'DE'
  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, v~waerk
* nach Kunde Land, gruppiert
    HAVING k~land1 = 'DE' " Kommt aus  Eingabe
  INTO TABLE @DATA(tresult2).
  cl_demo_output=>display( tresult2 ).
