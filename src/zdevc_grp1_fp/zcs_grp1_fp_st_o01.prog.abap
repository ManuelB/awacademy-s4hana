*&---------------------------------------------------------------------*
*& Include          ZCS_GRP1_FP_WL_O01
*&---------------------------------------------------------------------*

MODULE status_2000 OUTPUT.
  SET PF-STATUS 'S2000'.
  SET TITLEBAR 'T2000'.
ENDMODULE.

MODULE status_2100 OUTPUT.
  SET PF-STATUS 'S2100'.
  SET TITLEBAR 'T2100'.

*Anfügen der Feldbezeichner der ansonsten numerischen Wechselstatuses
  CASE zsd_grp1_fp_wt-status.
    WHEN 0.
      feld1 = 'Unbekannt'.
    WHEN 1.
      feld1 = 'Neu'.
    WHEN 2.
      feld1 = 'Warten auf Antwort'.
    WHEN 3.
      feld1 = 'Warten auf Antwort des Lieferanten'.
    WHEN 4.
      feld1 = 'Erfolgreich'.
    WHEN 5.
      feld1 = 'Fehlgeschlagen'.
  ENDCASE.

*Generieren der Dynpro-Elemente für das Texteditorfeld
  CREATE OBJECT cont1
    EXPORTING
      container_name = 'CUCTRL'.

  CREATE OBJECT lo_text_editor
    EXPORTING
      parent = cont1.

ENDMODULE.

MODULE status_2500 OUTPUT.
  SET PF-STATUS 'S2500'.
  SET TITLEBAR 'T2500'.

  IF contwt IS INITIAL.

*Container mit zugehörigem ALV
    CREATE OBJECT contwt
      EXPORTING
        container_name = 'CUCTRL3'.

    CREATE OBJECT alvwt
      EXPORTING
        i_parent = contwt.

**********************************************************************
*Doppelklick
    CREATE OBJECT my_event.
    SET HANDLER my_event->handle_double_click FOR alvwt.
  ELSE.
    alvwt->refresh_table_display( ).
**********************************************************************

  ENDIF.

*Methodenaufruf
  CALL METHOD alvwt->set_table_for_first_display
    EXPORTING
      i_structure_name = 'ZSD_GRP1_FP_WT'
    CHANGING
      it_outtab        = lt_wt.
ENDMODULE.

MODULE status_2600 OUTPUT.
  SET PF-STATUS 'S2600'.
  SET TITLEBAR 'T2600'.

*Mit Doppelklick gewählte Daten übertragen
  IF ls_wt IS NOT INITIAL.
    SELECT * FROM zsd_grp1_fp_wt
      WHERE auftnr = ls_wt-auftnr.
    ENDSELECT.
  ENDIF.

ENDMODULE.

MODULE status_2650 OUTPUT.
  SET PF-STATUS 'ST2650'.
  SET TITLEBAR 'S2650'.

  IF cont2 IS INITIAL.

*Container mit zugehörigem ALV
    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.

    CREATE OBJECT editext
      EXPORTING
        parent = cont2.

*Aufruf der Funktion des BAPI
    CALL FUNCTION 'ZBAPI_GRP1_EDI'
      EXPORTING
        i_auftnr = zsd_grp1_fp_wt-auftnr
        i_kdnr   = zsd_grp1_fp_ks-kdnr
        i_wt     = zsd_grp1_fp_wt
        i_ks     = zsd_grp1_fp_ks
      IMPORTING
        ex_text  = lt_text.

    LOOP AT lt_text INTO ls_text1.
      ls_text =  ls_text1-hell && ls_text1-topofpage && ls_text1-text.
      APPEND ls_text TO lt_text2.
    ENDLOOP.

*Methodenaufruf
    CALL METHOD editext->set_text_as_stream
      EXPORTING
        text = lt_text2.

  ENDIF.
ENDMODULE.
