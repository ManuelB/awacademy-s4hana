*&---------------------------------------------------------------------*
*& Report Z_S02_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_alv_demo_doppelklick.

*TABLES:
*  scarr, spfli, sflight.
*
*DATA:
** Container
*  cont1      TYPE REF TO cl_gui_custom_container,
*  dock       TYPE REF TO cl_gui_docking_container,          " Docking-Container - an anderen Container andocken bzw. Erweitern
*  dia        TYPE REF TO cl_gui_dialogbox_container,        " damit kommt das webfenster schwebend als separates Fenster
*
** Anwendungs-Controls
*  alv1       TYPE REF TO cl_gui_alv_grid,
*  alv2       TYPE REF TO cl_gui_alv_grid,
** "Inhalte" - lokale Tabellen
*  ls_spfli   TYPE spfli,
*  lt_sflight TYPE TABLE OF sflight,
*  lt_spfli   TYPE TABLE OF spfli
*  .
*
***** Handler
*CLASS lcl_listener DEFINITION.
*  PUBLIC SECTION.
*    METHODS:
*      handle_double_click
*        FOR EVENT double_click OF cl_gui_alv_grid
*        IMPORTING e_row. " e_column.
*ENDCLASS.
*
*CLASS lcl_listener IMPLEMENTATION.
*  METHOD handle_double_click.
*    DATA:
*      my_caption TYPE c LENGTH 256.
*    READ TABLE lt_spfli INDEX e_row-index INTO ls_spfli.
*    CONCATENATE 'Flüge zur Fluglinie' ls_spfli-carrid ls_spfli-connid
*      INTO my_caption SEPARATED BY space.
** Detailtabelle mit den relevanten Daten füllen
*    SELECT * FROM sflight INTO TABLE lt_sflight
*      WHERE carrid = ls_spfli-carrid
*      AND   connid = ls_spfli-connid.
*
*    IF alv2 IS INITIAL.
**            lifetime                    = lifetime_default
*
*      CREATE OBJECT dia
*        EXPORTING
*          width   = 500
*          height  = 200
*          top     = 50
*          left    = 50
*          caption = my_caption.
**      CREATE OBJECT dock
**        EXPORTING
**      "    side = p_side.
**      "side                        = dock->DOCK_AT_bottom.
**      side                        = dock->DOCK_AT_LEFT.
*      CREATE OBJECT alv2
*        EXPORTING
**         i_parent = dock.
*          i_parent = dia.
*    ELSE.
*      alv2->refresh_table_display( ).
*    ENDIF.
*    CALL METHOD alv2->set_table_for_first_display
*      EXPORTING
*        i_structure_name = 'SFLIGHT'
*      CHANGING
*        it_outtab        = lt_sflight.
*  ENDMETHOD.
*ENDCLASS.
*
*DATA:
*my_event TYPE REF TO lcl_listener.
*
*
*
*
*
**PARAMETERS:
**p_side type etc --> dock an verschiedenen Postionen setzen
*
*START-OF-SELECTION.
*
*CALL SCREEN 100.
*
*
*
**PROCESS AFTER INPUT.
**&---------------------------------------------------------------------*
**&      Module  USER_COMMAND_0100  INPUT
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*MODULE user_command_0100 INPUT.             "bein Drücken auf einen Button gibt es code aus in sy-ucomm
*  CASE sy-ucomm.
*    WHEN 'SHOW'.                            "Achtung, SHOW muss gross geschrieben sein.
*      IF spfli-carrid IS INITIAL.
*        SELECT * FROM spfli INTO TABLE lt_spfli.
*        "  SELECT * FROM sflight INTO TABLE lt_sflight.
*      ELSE.
*        SELECT * FROM spfli INTO TABLE lt_spfli
*          WHERE carrid = spfli-carrid.
*        "   SELECT * FROM sflight INTO TABLE lt_sflight
*        "     WHERE carrid = spfli-carrid.
*      ENDIF.
*      IF sy-subrc <> 0.
*        "spfli-cityfrom = 'nichts da'.
*        CLEAR: spfli, sflight.
*      ENDIF.
*    WHEN 'BACK'.
*      LEAVE PROGRAM.
*  ENDCASE.
*
*ENDMODULE.
*
*
**&---------------------------------------------------------------------*
**& Module STATUS_0100 OUTPUT
**&---------------------------------------------------------------------*
**&
**&---------------------------------------------------------------------*
*
*
********************************************************************************************
**Erzeugung:
**in Dynpro 100 gehen und:
**PROCESS BEFORE OUTPUT.
**MODULE STATUS_0100. <-- Einkommentieren und als Rahmenporogramm anlegen
********************************************************************************************
*
*
*MODULE status_0100 OUTPUT.
** SET PF-STATUS 'xxxxxxxx'.
** SET TITLEBAR 'xxx'.
*
*
*  IF cont1 IS INITIAL.                         " damit die Objekte NICHT bei jeder eingabe wieder generiert werden (weil Roundtrip) --> verwaiste Objekte. Auch mit "is not bound" möglich.
** Container erzeugen
*    CREATE OBJECT cont1                       " MUSTER > ABAP-Object
*      EXPORTING
*        container_name = 'CUCTRL'.            " muss gross sein. Damit ist ein Containerobjekt erstellt
*
*CREATE OBJECT my_event.
*
**    CREATE OBJECT dock.
**  EXPORTING
**    side                        = DOCK_AT_LEFT
*
*
*
** Anwendungscontrolls erzeugen
*    CREATE OBJECT alv1                       " MUSTER > ABAP-Object
*      EXPORTING
*        i_parent = cont1.                    "
*    SET HANDLER my_event->handle_double_click FOR alv1.
*
*    CREATE OBJECT alv2
*      EXPORTING
*        i_parent = dock.
*
*  ELSE.
*    alv1->refresh_table_display( ).
*
*  ENDIF.
*
*
*
** Methoden aufrufen
*  CALL METHOD alv1->set_table_for_first_display     " MUSTER > CALL-FUNCTION
*    EXPORTING
*      i_structure_name = 'SPFLI'
*    CHANGING
*      it_outtab        = lt_spfli.
*
*
*  CALL METHOD alv2->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SFLIGHT'
*    CHANGING
*      it_outtab        = lt_sflight.
*
*
*
** Methoden der Anwendungscontrols anwenden: Tabelle anzeigen, Webseite anzeigen
*  CALL METHOD alv1->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SPFLI'
*    CHANGING
*      it_outtab        = lt_spfli.
*
*
*  cl_gui_control=>set_focus( alv1 ).
*
*ENDMODULE.

*************
*************
*************
*************
*************
*************

***** Musterlösung
TABLES:
  spfli, sflight.
DATA:
* Container
  cont1      TYPE REF TO cl_gui_custom_container,
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,
* Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid,
  alv2       TYPE REF TO cl_gui_alv_grid,
  ls_spfli   TYPE spfli,
  lt_spfli   TYPE TABLE OF spfli,
  lt_sflight TYPE TABLE OF sflight.
*

CLASS lcl_listener DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_double_click
        FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row. " e_column.
ENDCLASS.
*
CLASS lcl_listener IMPLEMENTATION.

  METHOD handle_double_click.
    DATA:
      my_caption TYPE c LENGTH 256.
    READ TABLE lt_spfli INDEX e_row-index INTO ls_spfli.
    CONCATENATE 'Flüge zur Fluglinie' ls_spfli-carrid ls_spfli-connid
      INTO my_caption SEPARATED BY space.
* Detailtabelle mit den relevanten Daten füllen
    SELECT * FROM sflight INTO TABLE lt_sflight
      WHERE carrid = ls_spfli-carrid
      AND   connid = ls_spfli-connid.

    IF alv2 IS INITIAL.
*            lifetime                    = lifetime_default

      CREATE OBJECT dia
        EXPORTING
          width   = 500
          height  = 200
          top     = 50
          left    = 50
          caption = my_caption.
*      CREATE OBJECT dock
*        EXPORTING
*      "    side = p_side.
*      "side                        = dock->DOCK_AT_bottom.
*      side                        = dock->DOCK_AT_LEFT.
      CREATE OBJECT alv2
        EXPORTING
*         i_parent = dock.
          i_parent = dia.
    ELSE.
      alv2->refresh_table_display( ).
    ENDIF.
    CALL METHOD alv2->set_table_for_first_display
      EXPORTING
        i_structure_name = 'SFLIGHT'
      CHANGING
        it_outtab        = lt_sflight.
  ENDMETHOD.
ENDCLASS.

DATA:
  my_event TYPE REF TO lcl_listener.
*
PARAMETERS:
  p_side TYPE i DEFAULT 1.
*
START-OF-SELECTION.
  CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
        "  SELECT * FROM sflight INTO TABLE lt_sflight.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
          WHERE carrid = spfli-carrid.
        "   SELECT * FROM sflight INTO TABLE lt_sflight
        "     WHERE carrid = spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.
        "spfli-cityfrom = 'nichts da'.
        CLEAR: spfli, sflight.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*
MODULE status_0100 OUTPUT.
  IF cont1 IS INITIAL. "is not bound
* Container erzeugen
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.

    CREATE OBJECT my_event.


* Anwendungscontrols erzeugen
    CREATE OBJECT alv1
      EXPORTING
*       i_parent = dock.
        i_parent = cont1.
    SET HANDLER my_event->handle_double_click FOR alv1.

  ELSE.
    alv1->refresh_table_display( ).
  ENDIF.

* Methoden der Anwendungscontrols anwenden: Tabelle anzeigen, Webseite anzeigen
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = lt_spfli.


  cl_gui_control=>set_focus( alv1 ).

ENDMODULE.
