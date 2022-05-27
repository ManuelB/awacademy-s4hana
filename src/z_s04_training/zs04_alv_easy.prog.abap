*&---------------------------------------------------------------------*
*& Report ZS04_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_alv_easy.

TABLES: scarr, spfli, sflight.


DATA: lt_spfli   TYPE TABLE OF spfli,
      lt_sflight TYPE TABLE OF sflight,
*Container
      cont1      TYPE REF TO cl_gui_custom_container,
*Anwendungs-controls
      alv1       TYPE REF TO cl_gui_custom_alv_grid.

CALL       SCREEN 100.


MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'SHOW'.

      SELECT * FROM sflight INTO TABLE lt_sflight.


* Beschaffen der Flugdaten ohne und mit ID.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli WHERE carrid =  spfli-carrid.
      ENDIF.

*      IF sy-subrc <> 0.
*        CLEAR spfli.
*        MESSAGE 'Keine Flugverbindung gefunden!' TYPE 'I' DISPLAY LIKE 'E'.
*      ENDIF.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.


**********************************************************************
*PBO

MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  IF cont1 IS INITIAL. "IS NOT BOUND

**********************************************************************
*Container für SPFLI und SCARR mit zugehörigen ALVs
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'. "SFLIGHT

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

  ENDIF.

**********************************************************************
*Aufruf der Methoden
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SFLIGHT' "Spaltenüberschrift kommt dadurch automatisch aus dem Dict.
    CHANGING
      it_outtab        = lt_sflight.

ENDMODULE.
