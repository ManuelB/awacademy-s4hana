*&---------------------------------------------------------------------*
*& Report Z_S05_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_alv_dbl_click2.
*
TABLES:
  spfli, scarr, sflight.


DATA cont1 TYPE REF TO cl_gui_custom_container.
DATA cont2 TYPE REF TO cl_gui_custom_container.
*DATA dock TYPE REF TO cl_gui_docking_container.
DATA dia TYPE REF TO cl_gui_dialogbox_container.
DATA dia2 TYPE REF TO cl_gui_dialogbox_container.
*anwebdzbf-controls
DATA alv1 TYPE REF TO cl_gui_alv_grid.
DATA alv2 TYPE REF TO cl_gui_alv_grid.
DATA lt_spfli TYPE TABLE OF spfli.
DATA ls_spfli TYPE spfli.
DATA lt_sflight TYPE TABLE OF sflight.
DATA lt_sbook TYPE TABLE OF sbook.
DATA lt_scarr TYPE TABLE OF scarr.
DATA lt_scustom TYPE TABLE OF scustom.
*

class lcl_listener DEFINITION.
  public section.
  data: my_caption type c length 50.
  methods:
  on_double_click
  for event double_click of cl_gui_alv_grid
  importing e_row e_column.
  endclass.

class lcl_listener IMPLEMENTATION.
  METHOD on_double_click.

    read table lt_spfli into ls_spfli index e_row-index.
    select * from sbook into table lt_sbook
      where carrid = ls_spfli-carrid
      and connid = ls_spfli-connid.

      CONCATENATE 'Flüge zur Flugliste:' ls_spfli-carrid ls_spfli-connid into my_caption SEPARATED BY space.
    if dia is initial.

      CREATE OBJECT dia
          EXPORTING
            width = 300
            height = 100
            top = 50
            left = 50
            caption = my_caption.


          CREATE OBJECT alv2
      EXPORTING
        i_parent = dia.

       else.

         alv2->refresh_table_display( ).

         endif.

CALL METHOD alv2->set_table_for_first_display
  EXPORTING

    i_structure_name              = 'SBOOK'
  CHANGING
    it_outtab                     = lt_sbook.

      endmethod.


  endclass.

start-of-selection.

DATA  my_event TYPE REF TO lcl_listener.

CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "user command
    WHEN 'SHOW'.
      if spfli-carrid is initial.
      SELECT * FROM spfli INTO TABLE lt_spfli.
      SELECT * FROM sbook INTO TABLE lt_sbook.
        else.
          SELECT * FROM spfli INTO TABLE lt_spfli
        WHERE carrid = spfli-carrid.
              SELECT * FROM sbook INTO TABLE lt_sbook
        WHERE carrid = spfli-carrid.
            endif.
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


*            parent                      =.

*CREATE OBJECT dock.
**  EXPORTING
**    side                        = DOCK_AT_LEFT
CREATE OBJECT my_event.

    CREATE OBJECT alv1
     EXPORTING
       i_parent = cont1.

 set handler my_event->on_double_click FOR alv1.

endif.

*
    CALL METHOD alv1->set_table_for_first_display
  EXPORTING

    i_structure_name              = 'SPFLI'
  CHANGING
    it_outtab                     = lt_spfli.


 cl_gui_control=>set_focus( alv1 ).

ENDMODULE.
