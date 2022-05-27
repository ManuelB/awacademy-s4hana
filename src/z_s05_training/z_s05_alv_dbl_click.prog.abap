*&---------------------------------------------------------------------*
*& Report Z_S05_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_alv_dbl_click.
*
TABLES:
  spfli, scarr, sflight.


DATA cont1 TYPE REF TO cl_gui_custom_container.
DATA dock TYPE REF TO cl_gui_docking_container.
DATA dia TYPE REF TO cl_gui_dialogbox_container.

*anwebdzbf-controls
DATA alv1 TYPE REF TO cl_gui_alv_grid.
DATA alv2 TYPE REF TO cl_gui_alv_grid.
DATA lt_spfli TYPE TABLE OF spfli.
DATA ls_spfli TYPE spfli.
DATA lt_sbook TYPE TABLE OF sbook.
DATA lt_sflight TYPE TABLE OF sflight.
DATA double1 TYPE REF TO cl_gui_alv_grid.


CLASS lcl_listener DEFINITION.
  public section.
  methods:
    on_double_click
    for event double_click of cl_gui_alv_grid
    importing e_row e_column.
    data:
        my_caption type c length 256.
ENDCLASS.


CLASS lcl_listener IMPLEMENTATION.

  method on_double_click.
    read table lt_spfli index e_row-index into ls_spfli.
    CONCATENATE 'Flüge zur Flugliste.' ls_spfli-carrid ls_spfli-connid
    into my_caption SEPARATED BY space.

    select * from sflight into table lt_sflight
      where carrid = ls_spfli-carrid
      and connid = ls_spfli-connid.

    if dia is initial.

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
    else.

      alv1->refresh_table_display( ).
      endif.
        CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      it_outtab        = lt_sflight.

    endmethod.
ENDCLASS.

DATA  my_event TYPE REF TO lcl_listener.

START-OF-SELECTION.

*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "user command
    WHEN 'SHOW'.

      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
        SELECT * FROM sflight INTO TABLE lt_sflight.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
      WHERE carrid = spfli-carrid.
        SELECT * FROM sflight INTO TABLE lt_sflight
            WHERE carrid = spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.
        MESSAGE: 'NICHT DA' TYPE 'E'.
        "spfli-cityfrom = 'nicht da'.
        CLEAR spfli.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM. " GO OUT FROM THE PROGRAM
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.


  IF cont1 IS INITIAL. "is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.
*        CREATE OBJECT cont2
*      EXPORTING
*        container_name = 'CUCTRL2'.


CREATE OBJECT my_event.


*            parent                      =.

*
*      CREATE OBJECT web
*        EXPORTING
*         parent             = dia.

*            CREATE OBJECT web
*        EXPORTING
*         parent             = cont1.

    CREATE OBJECT dock.
*  EXPORTING
*    side                        = p_side.


    CREATE OBJECT alv1
      EXPORTING
*       i_parent = dock.
        i_parent = cont1.
    set handler my_event->on_double_click FOR alv1.



  ENDIF.




*
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = lt_spfli.
  .

  cl_gui_control=>set_focus( alv1 ).

ENDMODULE.
