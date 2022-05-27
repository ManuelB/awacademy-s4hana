*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_DATENMANSGEM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_sql_datenmansgem.


* mein Versuch, geht nicht.
*DATA: p_KUNNR TYPE kunnr VALUE '0000'.
*
*cl_demo_input=>new(
*)->add_field( CHANGING field = p_KUNNR )->request( ).
*
*SELECT vkorg, vtweg, lfstk, COUNT( vbeln ) AS AB
*  FROM vbak
*  WHERE lfstk = 'A' OR lfstk = 'B' AND kunnr = @p_KUNNR
*    GROUP BY vkorg, vtweg, lfstk, AB
*    ORDER BY vkorg, vtweg, lfstk
*  INTO TABLE @DATA(tresult1).
*
*cl_demo_output=>display( tresult1 ).


*****
* Lösung von Tim/Rainer
*****
SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, COUNT( lfstk ) AS anzahl
  FROM vbak AS v
  INNER JOIN kna1 AS k
  ON v~kunnr = k~kunnr
  WHERE v~auart = 'TA'
  AND ( v~lfstk = 'A' OR v~lfstk = 'B' )
  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk
  INTO TABLE @DATA(tresult1).
cl_demo_output=>display( tresult1 ).



SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, sum( netwr ) AS Auftragswert, v~waerk as Currency
  FROM vbak AS v
  INNER JOIN kna1 AS k
  ON v~kunnr = k~kunnr
  WHERE auart = 'TA'
  AND ( v~lfstk = 'A' OR v~lfstk = 'B' )
  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, v~waerk
  INTO TABLE @DATA(tresult2).
  cl_demo_output=>display( tresult2 ).


BREAK-POINT.
