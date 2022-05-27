*&---------------------------------------------------------------------*
*& Report Z_S09_VBAK_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_VBAK_AUFGABE.

DATA:
KUNNR TYPE zS09_VBAK-KUNNR VALUE '1',
LAND1 TYPE zS9_VBAK-landtx VALUE 'DE'.



cl_demo_input=>new(
)->add_field( CHANGING field = KUNNR
)->add_field( CHANGING field = LAND1 )->request( ).


SELECT COUNT( DISTINCT VBELN )
from ZS05_VBAK
INTO @DATA(lt_COUNT).

SELECT VKORG, VTWEG, LFSTK, COUNT( DISTINCT VBELN )
from ZS09_VBAK
WHERE AUART = 'TA'
AND LFSTK = 'NICHT BEARBEITET'
OR LFSTK = 'TEILWEISE BERARBEITET'
GROUP BY VKORG, VTWEG, LFSTK
INTO @DATA(lt_vbak).
ENDSELECT.



cl_demo_output=>display( lt_vbak ).


"----------------------------------"

SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~vlfstk, SUM( NETWR ) AS Auftragswert, v~waerk as Currency
  FROM vbak AS v
  INNER JOIN knal AS k
  ON v~kunnr = k~kunnr
  WHERE v~auart = 'TA'
  AND ( v~lfstk = 'A' OR v~lfstk = 'B')
  " AND k~land1 = 'DE'
  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, v~waerk
  " HAVING k~land1 = 'DE'
  INTO TABLE @DATA(tresult2).

  cl_demo_output=>display( tresult2 ).
