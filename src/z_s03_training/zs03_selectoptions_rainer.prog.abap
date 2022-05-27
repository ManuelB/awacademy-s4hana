*&---------------------------------------------------------------------*
*& Report ZS03_SELECTOPTIONS_RAINER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_SELECTOPTIONS_RAINER.
DATA vb TYPE vbak.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: s_kunnr FOR vb-kunnr,
                  s_auart FOR vb-auart.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_land TYPE t005-land1.

SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.

  SELECT * INTO TABLE @DATA(t_result)
    FROM vbak
    WHERE kunnr IN @s_kunnr
      AND auart IN @s_auart.
