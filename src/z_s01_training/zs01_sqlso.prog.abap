*&---------------------------------------------------------------------*
*& Report Z_S01_SQL_SO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_sqlso.


*verstanden.
DATA vb TYPE vbak.  "Deklaration von varbiable. Wichtig hier: Typ ist name der ganzen Tabelle. Die Variable wird referenziert, nicht die Tabelle.
*Ränder
*SELEct-Options bietet Datenfeld range mit 2 Feldern für eine Range of values,
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: s_kunnr FOR vb-kunnr, "Feld 1
  s_auart FOR vb-auart, "Feld 2.
  s_VBTYP FOR vb-VBTYP. "Feld 3.

SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_land TYPE t005-land1.
*  PARAMETERS: p_test TYPE t005-curin.

SELECTION-SCREEN END OF BLOCK b2.


START-OF-SELECTION.

*Liest alles von vbak wo Bedingungen aus Eingabefelder stimmen und überträgt in t_result.
  SELECT * INTO TABLE  @DATA(t_result)
  FROM vbak
  WHERE kunnr IN @s_kunnr
    AND auart IN @s_auart.

    cl_demo_output=>display( t_result ).
