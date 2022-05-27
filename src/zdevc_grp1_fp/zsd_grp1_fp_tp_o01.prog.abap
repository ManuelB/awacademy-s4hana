*&---------------------------------------------------------------------*
*& Include          ZSD_GRP1_FP_TP_O01
*&---------------------------------------------------------------------*

MODULE status_1000 OUTPUT.
  SET PF-STATUS 'S1000'.
  SET TITLEBAR 'T1000'.

  IF cont1 IS INITIAL.

*Container mit zugehörigem ALV
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

**********************************************************************
*Doppelklick
    CREATE OBJECT my_event.
    SET HANDLER my_event->handle_double_click FOR alv1.
  ELSE.
    alv1->refresh_table_display( ).
**********************************************************************
  ENDIF.

**********************************************************************
*Funktion um Spaltenüberschriften zu überschreiben
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZISU_FP_TARIFE'
    CHANGING
      ct_fieldcat      = lt_fcat.

  LOOP AT lt_fcat INTO ls_fcat.
    CASE ls_fcat-fieldname.
      WHEN 'ABSCHLAG'.
        ls_fcat-coltext = 'Sofortbonus(€)'.
        MODIFY lt_fcat FROM ls_fcat.
      WHEN 'BONUS'.
        ls_fcat-coltext = 'Abschlagsbonus(%)'.
        MODIFY lt_fcat FROM ls_fcat.
      WHEN OTHERS.
    ENDCASE.
  ENDLOOP.
**********************************************************************

*Methodenaufruf
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'ZISU_FP_TARIFE'
    CHANGING
      it_outtab        = lt_tarife
      it_fieldcatalog  = lt_fcat.

ENDMODULE.

MODULE status_1100 OUTPUT.
  SET PF-STATUS 'S1100'.
  SET TITLEBAR 'T1100'.

*Mit Doppelklick gewählte Daten übertragen
  IF ls_tarife IS NOT INITIAL.
    SELECT * FROM zisu_fp_tarife
   WHERE anbietername = ls_tarife-anbietername
   AND anbietertarif = ls_tarife-anbietertarif.
    ENDSELECT.
  ENDIF.

ENDMODULE.
