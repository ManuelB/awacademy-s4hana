*&---------------------------------------------------------------------*
*& Report ZAWS04_SQL_DATENMANAGEMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_datenmanagement.


**********************************************************************
*Wie viele Terminaufträge (TA) wurden nicht bearbeitet.

SELECT COUNT( DISTINCT auart )
  FROM vbak
  WHERE lfstk = 'A'
  INTO @DATA(ta_nb).
cl_demo_output=>display( ta_nb ).



**********************************************************************
*Wie viele Terminaufträge (TA) wurden teilweise bearbeitet.

SELECT COUNT( DISTINCT auart )
  FROM vbak
  WHERE lfstk = 'B'
  INTO @DATA(ta_twb).
cl_demo_output=>display( ta_twb ).


**********************************************************************
*Liste der TA mit Lieferstatus = nicht/teilweise bearbeitet, nach Kunde/Land gruppiert, sortiert nach Lieferstatus.

SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, COUNT( lfstk ) AS anzahl
  FROM vbak AS v
  INNER JOIN kna1 AS k
  ON v~kunnr = k~kunnr
  WHERE v~auart = 'TA'
  AND ( v~lfstk = 'A' OR v~lfstk = 'B' )
  "AND l-landl = 'DE'
  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk "KUNNR kommt aus Eingabe
  ORDER BY lfstk
  "HAVING k~land1 = 'DE' "kommt aus Eingabe
  INTO TABLE @DATA(tresult1).

cl_demo_output=>display( tresult1 ).

**********************************************************************
*Liste der TA mit Lieferstatus = nicht/teilweise bearbeitet, nach Kunde/Land gruppiert. AUftragsnettowert/Währung für noch nicht ausgelieferte Ware, sortiert nach Auftragswert.

SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, SUM( NETWR ) AS Auftragswert, v~waerk AS Currency
  FROM vbak AS v
  INNER JOIN kna1 AS k
  ON v~kunnr = k~kunnr
  WHERE v~auart = 'TA'
  AND ( v~lfstk = 'A' OR v~lfstk = 'B' )
  "AND l-landl = 'DE'
  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, v~waerk "KUNNR kommt aus Eingabe
  ORDER BY Auftragswert DESCENDING
  "HAVING k~land1 = 'DE' "kommt aus Eingabe
  INTO TABLE @DATA(tresult2).

cl_demo_output=>display( tresult2 ).


**********************************************************************
