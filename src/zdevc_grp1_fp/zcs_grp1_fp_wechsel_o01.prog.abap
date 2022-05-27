*&---------------------------------------------------------------------*
*& Include          ZCS_GRP1_FP_WECHSEL_O01
*&---------------------------------------------------------------------*

MODULE status_3000 OUTPUT.
 SET PF-STATUS 'S3000'.
 SET TITLEBAR 'T3000'.

  IF cont1 IS INITIAL.
*Container Generierung
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.

*ALV-Grid Generierung
    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

*Doubleklick
    CREATE OBJECT my_event.

    SET HANDLER my_event->handle_double_click FOR alv1.
  ELSE.
    alv1->refresh_table_display( ).
  ENDIF.

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

  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'ZISU_FP_TARIFE'
    CHANGING
      it_outtab        = lt_tarife
      it_fieldcatalog  = lt_fcat.



ENDMODULE.



MODULE status_3100 OUTPUT.
  SET PF-STATUS 'S3100'.
 SET TITLEBAR 'S3100'.

  felda = ls_tarife-anbietername.
  feldt = ls_tarife-anbietertarif.

ENDMODULE.
