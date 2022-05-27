*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_JOINS_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_abapsql_joins_aufgabe.

*SELECT DISTINCT cityto
*  FROM spfli
*  WHERE carrid = 'AA' and cityfrom = 'NEW YORK'
*  INTO TABLE @DATA(Destinations).

*Parameter: p_kunden TYPE kunnr.
*
*
*
*SELECT FROM vbak
*  FIELDS vkorg,vtweg,lfstk,kunnr
*  WHERE
*  kunnr = @p_kunden
*
*  GROUP BY vkorg,vtweg,lfstk
*  INTO TABLE @DATA(result).
*
*cl_demo_output=>display( Result ).

SELECT b~land1,a~vkorg, a~vtweg, b~kunnr, a~lfstk, SUM( netwr ) AS Auftragswert, a~waerk AS Currency
  FROM vbak AS a

  INNER JOIN kna1 AS b

  ON a~kunnr = b~kunnr
  WHERE a~auart = 'TA'
  AND ( a~lfstk = 'A' OR a~lfstk = 'B' )
  "AND b~land1 = 'DE'
  GROUP BY b~land1, a~vkorg, a~vtweg, b~kunnr, a~lfstk, a~waerk
  "HAVING b~land1 = 'DE'
  INTO TABLE @DATA(result).
  cl_demo_output=>display( result ).
