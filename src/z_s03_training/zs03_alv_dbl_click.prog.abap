*&---------------------------------------------------------------------*
*& Report ZS03_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs03_alv_dbl_click.
TABLES:
  spfli, sflight.
DATA:
  cont1      TYPE REF TO cl_gui_custom_container,
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,

  alV1       TYPE REF TO cl_gui_alv_grid,
  alV2       TYPE REF TO cl_gui_alv_grid,
  ls_spfli   TYPE spfli,
  lt_sflight TYPE TABLE OF sflight,
  lt_spfli   TYPE TABLE OF spfli.

CLASS lcl_listener DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_double_click
        FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column.
ENDCLASS.

CLASS lcl_listener IMPLEMENTATION.

  METHOD
  handle_double_click.
    DATA:
        my_caption TYPE c LENGTH 256.
    READ TABLE lt_spfli INDEX e_row-index INTO ls_spfli.
*    CONCATENATE 'Flüge zur Fluglinie' ls_spfli-carrid ls_spfli-connid
*    INTO my_caption SEPARATED BY space.

 my_caption = |Flüge zur Fluglinie { ls_spfli-carrid } { ls_spfli-connid }|.

    SELECT * FROM sflight INTO TABLE lt_sflight
      WHERE carrid = ls_spfli-carrid
      AND connid = ls_spfli-connid.


    IF dia IS INITIAL.
      CREATE OBJECT dia
        EXPORTING
          width   = 500
          height  = 200
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
ENDCLASS.

DATA:
      my_event TYPE REF TO lcl_listener.

PARAMETERS:
p_side TYPE i DEFAULT 1.

START-OF-SELECTION.
* nötig hier wegen der oben lokalen definierten Klasse.

  CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
      WHERE carrid = spfli-carrid.

      ENDIF.
      IF sy-subrc <> 0.
        CLEAR: spfli, sflight.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_0100 OUTPUT.
  IF cont1 IS INITIAL.
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.

    CREATE OBJECT my_event.

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.
    SET HANDLER my_event->handle_double_click FOR alv1.

  ELSE.
    alv1->refresh_table_display( ).
  ENDIF.

  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = lt_spfli.

  cl_gui_control=>set_focus( alv1 ).
ENDMODULE.
