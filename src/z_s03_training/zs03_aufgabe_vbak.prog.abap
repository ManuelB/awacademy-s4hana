*&---------------------------------------------------------------------*
*& Report ZS03_AUFGABE_VBAK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_aufgabe_vbak.

**DATA:
**      Kunnr TYPE vbak-kunnr,
**      landtx TYPE vbak-landtx.
**
**
**SELECT vkorg, vtweg, lfstk, COUNT( vbeln ) AS AnzahlBel
**  FROM vbak
**  WHERE auart = 'TA'
**  AND LFSTK = 'A'
**  OR LFSTK = 'B'
**  GROUP BY vkorg, vtweg,lfstk
***HAVING kunnr = @kunnr AND
***  landtx = @landtx
**
**  INTO TABLE @DATA(result).
**cl_demo_output=>display( result ).
*
*SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, SUM ( NETWR ) AS Auftragswert, v~waerk AS currency
*
*************  CORRECTION de RAINER
*
*  **- Liste Terminazfträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
**SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, COUNT( lfstk ) AS anzahl
**  FROM vbak AS v
**  INNER JOIN kna1 AS k
**  ON v~kunnr = k~kunnr
**  WHERE v~auart = 'TA'
**    AND ( v~lfstk = 'A' OR v~lfstk = 'B')
*** AND k~land1 = 'DE'
**  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk  " KUNNR kommt aus Eingabe
***  HAVING k~land1 = 'DE'   " kommt aus Eingabe
**  INTO TABLE @DATA(tresult1).
**
**cl_demo_output=>display( tresult1 ).
*
**- Liste Terminazfträge mit Lieferstatus = nicht/unvollständig bearbeitet, nach Kunde Land, gruppiert
**  Auftragsnettowert / Währung für noch nicht ausgelieferte Aufträge -> Kohle fehlt uns
*SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, SUM( NETWR ) AS Auftragswert, v~waerk as Currency
* FROM vbak AS v
*  INNER JOIN kna1 AS k
*  ON v~kunnr = k~kunnr
*  WHERE v~auart = 'TA'
*    AND ( v~lfstk = 'A' OR v~lfstk = 'B')
** AND k~land1 = 'DE'
*  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk,  v~waerk  " KUNNR kommt aus Eingabe
**  HAVING k~land1 = 'DE'   " kommt aus Eingabe
*  INTO TABLE @DATA(tresult2).
*
*cl_demo_output=>display( tresult2 ).
*
**AUFGABE 2
*
*SELECT k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, SUM ( NETWR ) AS Auftragswert, v~waerk AS currency
*  from vbak AS v
*  INNER JOIN kna1 AS k
*  ON v~kunnr = k~kunr
*  WHERE v~auart = 'TA'
*  AND ( v~lfstk = 'A' or v~lfstk = 'B' )
*  GROUP BY k~land1, v~vkorg, v~vtweg, k~kunnr, v~lfstk, v~waerk
*  INTO TABLE @DATA(tresult2).


*******ABAP SQL CASE

*SELECT FROM spfli
*  FIELDS carrid,
*  connid,
*  cityfrom,
*  cityto,
** fltime AS Flugzeit,
*  CASE WHEN fltime < 100 THEN 'short'
*  WHEN fltime BETWEEN 100 AND 300 THEN 'medium'
*  ELSE 'long'
*  END AS fltime
*  ORDER BY carrid, connid
*  INTO TABLE @DATA(result).
*  cl_demo_output=>display( result ).
*
** Ligne 77 si on veut rajouter le fltime en plus, il faut lui donner un autre nom. Ou bien il faut donner ligne 81
**un autre nom pour END AS fltime.
****************

***************** ABAP SQL COALESCE

CONSTANTS: co_no_email TYPE ad_smtpadr VALUE '<leer>'.
SELECT u~bname,
  u~persnumber,
  u~addrnumber,
  COALESCE( a~smtp_addr, @co_no_email )  AS email
  INTO TABLE @DATA(it_usr)
  FROM usr21 AS u
  LEFT OUTER JOIN adr6 AS a ON a~persnumber = u~persnumber AND a~addrnumber =
  u~addrnumber.
  cl_demo_output=>display( it_usr ).
