*&---------------------------------------------------------------------*
*& Report ZS04_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_alv_demo_aufgabe.

TABLES: scarr, spfli, sflight.


DATA: lt_spfli   TYPE TABLE OF spfli,
      lt_scarr   TYPE TABLE OF scarr,
      lt_scustom TYPE TABLE OF scustom,
      my_url     TYPE scarr-url,
*Container
      cont1      TYPE REF TO cl_gui_custom_container,
      cont2      TYPE REF TO cl_gui_custom_container,
      dia        TYPE REF TO cl_gui_dialogbox_container,
      dock       TYPE REF TO cl_gui_docking_container,
*Anwendungs-controls
      alv1       TYPE REF TO cl_gui_custom_alv_grid,
      alv2       TYPE REF TO cl_gui_custom_alv_grid,
      alvdock    TYPE REF TO cl_gui_custom_alv_grid,
      web        TYPE REF TO cl_gui_html_viewer.


CALL       SCREEN 100.


MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'SHOW'.

      SELECT * FROM scarr INTO TABLE lt_scarr.

      SELECT * FROM scustom INTO TABLE lt_scustom.

*Beschaffen der URL mit alternativer Ausgabe falls keine ID gewählt wurde.
      IF spfli-carrid IS INITIAL.
        my_url = 'https://awacademy.de/'.
      ELSE.
        SELECT SINGLE url FROM scarr INTO my_url WHERE carrid = spfli-carrid.
      ENDIF.

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
        container_name = 'CUCTRL'. "SPFLI

    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'. "SCARR

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.

*********************************************************************
*Dialogbox-Container für Web-Browser mit zugehöriger Dialogbox
    CREATE OBJECT dia
      EXPORTING
        width  = 300
        height = 100.

    CREATE OBJECT web
      EXPORTING
        parent = dia.

**********************************************************************
*Docking Container für SCUSTOM mit zugehöriger ALV
    CREATE OBJECT dock
      EXPORTING
        side = dock->dock_at_left.

    CREATE OBJECT alvdock
      EXPORTING
        i_parent = dock.

  ENDIF.

**********************************************************************
*Aufruf der Methoden
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI' "Spaltenüberschrift kommt dadurch automatisch aus dem Dict.
    CHANGING
      it_outtab        = lt_spfli.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.

  CALL METHOD web->show_url
    EXPORTING
      url = my_url.

  CALL METHOD alvdock->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCUSTOM'
    CHANGING
      it_outtab        = lt_scustom.

ENDMODULE.
