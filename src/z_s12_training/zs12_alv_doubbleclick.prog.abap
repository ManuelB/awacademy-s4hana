*&---------------------------------------------------------------------*
*& Report ZS12_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_alv_doubbleclick.

TABLES:
  scarr,
  sflight,
  spfli.
CLASS lcl_listener DEFINITION DEFERRED. "Erlaubt das setzen der Klasse vor DATA damit diese in DATA erkannt wird
DATA:
*Container
  cont1      TYPE REF TO cl_gui_custom_container, "man braucht einen Container
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,


*Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid, "Anwendungs-Control
  alv2       TYPE REF TO cl_gui_alv_grid, "Anwendungs-Control
  ls_spfli   TYPE spfli,
  lt_spfli   TYPE TABLE OF spfli,
  lt_sflight TYPE TABLE OF sflight.

CLASS lcl_listener DEFINITION.
  PUBLIC SECTION.
    class-METHODS:
    on_close for event close of cl_gui_dialogbox_container
    importing sender.
    methods:
      handle_double_click
        FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING
          e_row." e_column
    DATA:
          my_caption TYPE c LENGTH 256.
ENDCLASS.

CLASS lcl_listener IMPLEMENTATION.
  method on_close.
    if sender is not INITIAL.
      sender->free( ).
      endif.
    endmethod.

  METHOD handle_double_click.
      READ TABLE lt_spfli INDEX e_row-index INTO ls_spfli.
*   IF my_caption IS INITIAL.
      clear my_caption.
      CONCATENATE 'Flüge zur Fluglinie' ls_spfli-carrid ls_spfli-connid INTO my_caption SEPARATED BY space.
*      else.
*        clear my_caption.
*          ENDIF.
      SELECT * FROM sflight INTO TABLE lt_sflight
        WHERE carrid = ls_spfli-carrid
        AND connid = ls_spfli-connid.


    IF dia IS INITIAL.
*      CREATE OBJECT dock
*        EXPORTING
*          side = dock_at_left.

      CREATE OBJECT dia
        EXPORTING
          width   = 500
          height  = 200
          top     = 50
          left    = 50
          caption = my_caption. "Titel des Dialogfensters

      CREATE OBJECT alv2 "Anwendungscontrol
        EXPORTING
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
  my_event   TYPE REF TO lcl_listener.

START-OF-SELECTION.
*set handler lcl_listener=>on_close for dia.
  CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "Usercommand wird abgefragt "Welcher button gedrückt wird, wird hierhin verschoben
    WHEN 'SHOW'. "Show Button fkt.code - case sensitive

      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
        SELECT * FROM sflight INTO TABLE lt_sflight.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
        WHERE carrid = spfli-carrid.
        SELECT * FROM sflight INTO TABLE lt_sflight
        WHERE carrid = spfli-carrid.
      ENDIF.
*      CASE spfli-carrid.
*        WHEN sy-subrc NE 0.
*          MESSAGE 'Keine gültige Fluggesellschaft eingegeben' TYPE 'E'.
*
*      ENDCASE.
*      CASE spfli-connid.
*        WHEN sy-subrc <> 0.
*          MESSAGE 'Keine gültige Flugverbindung eingegeben' TYPE 'E'.
*
*      ENDCASE.
      IF sy-subrc <> 0.
        CLEAR: spfli, sflight.
      ENDIF.
    WHEN 'BACK'. "back button fkt.code - case sensitive
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

*******************************************************************************************
*Erzeugung:
*in Dynpro 100 gehen und:
*PROCESS BEFORE OUTPUT.
*MODULE STATUS_0100. <-- Einkommentieren und als Rahmenporogramm anlegen
*******************************************************************************************


MODULE status_0100 OUTPUT.

  IF cont1 IS INITIAL. "Damit die Objekte nur ein mal erzeugt werden
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'. "Bereich auf Dynpro zuweisen - UI Element
*In Dynpro 100 gehen und Custom Control erzeugen mit dem Namen CUCTRL


    CREATE OBJECT my_event.

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

    SET HANDLER my_event->handle_double_click FOR alv1. "Setzt Hanlder für alv1 um das Event handle_double_click umzusetzen
    CREATE OBJECT alv2 "Anwendungscontrol
      EXPORTING
        i_parent = dia.
  ELSE.
    alv1->refresh_table_display( ).
  ENDIF.

* Methoden der Anwendungscontrols anwenden: Tabelle anzeigen, Webseite anzeigen

*Erzeugung wie oben nur jetzt 'Call Method' - vom "Child" angeben
*Instanz: alv1
*Klasse/Interface: cl_gui_alv_grid
*Methode: set_table_for_first_display
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
*Strukturkomponente von SPFLI
    CHANGING
      it_outtab        = lt_spfli.
*Implementierung eines URL-Fensters

  cl_gui_control=>set_focus( alv1 ).




ENDMODULE.
