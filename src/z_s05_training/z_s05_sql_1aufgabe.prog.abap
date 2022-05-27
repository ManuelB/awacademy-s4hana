*&---------------------------------------------------------------------*
*& Report Z_S05_SQL_1AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_1AUFGABE.




       DATA:
  KUNNR TYPE zS05_VBAK-KUNNR VALUE '1'.


cl_demo_input=>new(
  )->add_field( CHANGING field = KUNNR )->request( ).


  SELECT COUNT( DISTINCT VBELN )
     from ZS05_VBAK
  INTO @DATA(lt_COUNT).

SELECT VKORG, VTWEG, LFSTK, KUNNR, COUNT( DISTINCT VBELN ) AS anahl
  from ZS05_VBAK
  WHERE AUART = 'TA'
  AND LFSTK = 'A'
  OR LFSTK = 'B'
  GROUP BY VKORG, VTWEG, LFSTK, KUNNR
  INTO @DATA(lt_vbak).
 ENDSELECT.



cl_demo_output=>display( lt_vbak ).



SELECT k~LAND1, v~VKORG, v~VTWEG, K~KUNNR, V~LFSTK, COUNT( DISTINCT VBELN ) AS anzahl
  from ZS05_VBAK as v
  INNER JOIN KNA1 AS K
  ON v~KUNNR = K~KUNNR
  WHERE V~AUART = 'TA'
  AND ( V~LFSTK = 'A' OR V~LFSTK = 'B' )
  GROUP BY  k~LAND1, v~VKORG, v~VTWEG, K~KUNNR, V~LFSTK
  INTO TABLE @DATA(lt_vbak2).

  cl_demo_output=>display( lt_vbak2 ).

  SELECT k~LAND1, v~VKORG, v~VTWEG, K~KUNNR, V~LFSTK, SUM( NETWR ) AS AUFTRAGSWERT, V~WAERK AS CURRENCY
  from ZS05_VBAK as v
  INNER JOIN KNA1 AS K
  ON v~KUNNR = K~KUNNR
  WHERE V~AUART = 'TA'
  AND ( V~LFSTK = 'A' OR V~LFSTK = 'B' )
  GROUP BY  k~LAND1, v~VKORG, v~VTWEG, V~LFSTK, K~KUNNR, V~WAERK
  INTO TABLE @DATA(lt_vbak3).

  cl_demo_output=>display( lt_vbak3 ).
