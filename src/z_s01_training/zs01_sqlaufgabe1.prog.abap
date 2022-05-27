*&---------------------------------------------------------------------*
*& Report ZAWT03_AUFGABE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zawt03_aufgabe1_r.

**- Liste Terminazfträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
*SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, COUNT( lfstk ) AS anzahl
*  FROM vbak AS v
*  INNER JOIN kna1 AS k
*  ON v~kunnr = k~kunnr
*  WHERE v~auart = 'TA'
*    AND ( v~lfstk = 'A' OR v~lfstk = 'B')
** AND k~land1 = 'DE'
*  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk  " KUNNR kommt aus Eingabe
**  HAVING k~land1 = 'DE'   " kommt aus Eingabe
*  INTO TABLE @DATA(tresult1).
*
*cl_demo_output=>display( tresult1 ).

*- Liste Terminazfträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
*  Auftragsnettowert / Währung für noch nicht ausgelieferte Aufträge -> Kohle fehlt uns
SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, SUM( NETWR ) AS Auftragswert, v~waerk as Currency
 FROM vbak AS v
  INNER JOIN kna1 AS k
  ON v~kunnr = k~kunnr
  WHERE v~auart = 'TA'
    AND ( v~lfstk = 'A' OR v~lfstk = 'B')
* AND k~land1 = 'DE'
  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk,  v~waerk  " KUNNR kommt aus Eingabe
*  HAVING k~land1 = 'DE'   " kommt aus Eingabe
  INTO TABLE @DATA(tresult2).

cl_demo_output=>display( tresult2 ).
