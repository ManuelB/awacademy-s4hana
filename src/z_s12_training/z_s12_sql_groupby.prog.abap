*&---------------------------------------------------------------------*
*& Report Z_S12_SQL_GROUPBY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_sql_groupby.

SELECT FROM ZAWS12_sflight
  FIELDS carrid,
  MIN( price ) AS min_price, "eigener output
  MAX( price ) AS max_price "eigner output
  GROUP BY carrid
  INTO TABLE @DATA(result). "eigene Tabelle mit carrid (hiernach wird sortiert) und min bzw. max price
cl_demo_output=>display( result ).


SELECT FROM ZAWS12_sflight
FIELDS carrid,
MIN( seatsmax ) AS min_seat, "eigener output
MAX( seatsmax ) AS max_seat "eigner output
GROUP BY carrid
  order by carrid descending "Sortiert die carrid absteigend alphabetisch
INTO TABLE @DATA(result2). "eigene Tabelle mit carrid (hiernach wird sortiert) und min bzw. max price

cl_demo_output=>display( result2 ).
"dritte Tabelle beschreiben
"über 1. loopen - move corresponding für jeden eintrag
"Einträge aus 2. Tabelle über carrid dazulesen - READ <> - Werte für seatsmin/max übertragen --> Insert

*  LOOP AT result.
*
*  ENDLOOP.
