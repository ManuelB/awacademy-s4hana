*&---------------------------------------------------------------------*
*& Report ZS04_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_alv_dblclick.

TABLES: spfli, sflight.

CLASS lcl_eventlistener DEFINITION DEFERRED.

DATA: ls_spfli   TYPE spfli,
      lt_spfli   TYPE TABLE OF spfli,
      lt_sflight TYPE TABLE OF sflight,
*Container
      cont1      TYPE REF TO cl_gui_custom_container,
      dia        TYPE REF TO cl_gui_dialogbox_container,
      dock       TYPE REF TO cl_gui_docking_container,
*Anwendungs-controls
      alv1       TYPE REF TO cl_gui_custom_alv_grid,
      alv2       TYPE REF TO cl_gui_custom_alv_grid,
*Event für Doppelklick
      my_event   TYPE REF TO lcl_eventlistener.



CLASS lcl_eventlistener DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_double_click FOR EVENT double_click OF cl_gui_custom_alv_grid
        IMPORTING e_row. " e_column.
*    handle_close_button FOR EVENT close OF cl_gui_dialogbox_container
*    IMPORTING sender.
ENDCLASS.

CLASS lcl_eventlistener IMPLEMENTATION.
  METHOD handle_double_click.
    DATA:
*          ls_spfli        LIKE LINE OF lt_spfli,
*          fldate(10)      TYPE c,
          my_caption(256) TYPE c.
    READ TABLE lt_spfli INDEX e_row-index INTO ls_spfli.
    CONCATENATE ls_spfli-carrid ls_spfli-connid INTO my_caption SEPARATED BY space.
    SELECT * FROM sflight INTO TABLE lt_sflight
      WHERE carrid = ls_spfli-carrid
      AND connid = ls_spfli-connid.
*    CLEAR ls_spfli.
    IF dia IS INITIAL.
      CREATE OBJECT dia
        EXPORTING
          width   = 500
          height  = 300
          top     = 50
          left    = 50
          caption = my_caption.
      CREATE OBJECT alv2
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

*  METHOD handle_close_button.
*IF sender IS NOT INITIAL.
*    DATA(lo_event) = NEW lcl_eventlistener( ).
*  SET HANDLER my_event->handle_close_button FOR dia.
*
*  ENDIF.
*
*
*
*    ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  CALL SCREEN 100.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'SHOW'.
* Beschaffen der Flugdaten ohne und mit ID.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
*        SELECT * FROM sflight INTO TABLE lt_sflight.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli WHERE carrid =  spfli-carrid.
*        SELECT * FROM sflight INTO TABLE lt_sflight WHERE carrid =  spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.
        CLEAR: spfli, sflight.
        MESSAGE 'Keine Flugverbindung gefunden!' TYPE 'I' DISPLAY LIKE 'E'.
      ENDIF.
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
*Container/Dialogbox/Dock für SPFLI und SFLIGHT
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'. "SPFLI


*    CREATE OBJECT dock
*      EXPORTING
*        side = dock->dock_at_left.

    CREATE OBJECT my_event.

**********************************************************************
*ALVs
    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

    SET HANDLER my_event->handle_double_click FOR alv1.
  ELSE.
    alv1->refresh_table_display( ).
  ENDIF.



**********************************************************************
*Aufruf der Methoden
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI' "Spaltenüberschrift kommt dadurch automatisch aus dem Dict.
    CHANGING
      it_outtab        = lt_spfli.

  cl_gui_control=>set_focus( alv1 ).

ENDMODULE.
