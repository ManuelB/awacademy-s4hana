*&---------------------------------------------------------------------*
*& Report Z_S01_SQL_COALESCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_sql_coalesce.

*Null-Werte (nicht vorhandene Email-Adressen), die sich aus dem Left Outer JOIN ergeben, werden durch den String '<leer>' ersetzt.
*Nützlich, wenn Felder nicht gefüllt sind.


*E
CONSTANTS: co_no_email TYPE ad_smtpadr VALUE '<leer>'.
*Deklarierung einer Variable, die nicht geändert werden kann.
SELECT u~bname,
 u~persnumber,
 u~addrnumber,
*  u~ das allias,~dahinter = felder in Tabelle.
*  V
  coalesce( a~smtp_addr, @co_no_email ) AS email
* befehl: (erster Wert, wenn nicht vorhanden 2. Wert), dann deklaration des Feldes mit email.
  INTO TABLE @DATA(it_usr)
*  Übertragung der Tabelle.
  FROM usr21 AS u
*2 Tabellen kommen vor  usr21(left) und adr6.
  LEFT  OUTER JOIN adr6 AS a ON a~persnumber = u~persnumber AND a~addrnumber = u~addrnumber.
*  Anschluss der Join-Bedingung.

*A
   cl_demo_output=>display( it_usr ).
*  reagiert auf einem Feld mit einer 0 und macht das zu Leer.
