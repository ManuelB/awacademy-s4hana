*&---------------------------------------------------------------------*
*& Report Z_S06_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_alv_demo_22.

TABLES:
  sflight,
  spfli.


DATA:
  "table
  ls_spfli type spfli,
  lt_spfli   TYPE TABLE OF spfli,                           "def of local table
  lt_sflight TYPE TABLE OF sflight,

  "anwendungs controlls alv1     TYPE REF TO cl_gui_alv_grid,
 alv1       TYPE REF TO cl_gui_alv_grid,
  alv2       TYPE REF TO cl_gui_alv_grid,                   "def of global klasse
                     "def of global klasse
  "container
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,
  cont1      TYPE REF TO cl_gui_custom_container,          "def of global klasse
cont2      TYPE REF TO cl_gui_custom_container.


CALL SCREEN 100.

CLASS handle_doubleclick_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      handle_double_click
      FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row. "e_column es_row_no.
ENDCLASS.

CLASS handle_doubleclick_handler IMPLEMENTATION.

  METHOD handle_double_click.
    DATA:
          my_caption type c length 300.

   READ TABLE lt_spfli index e_row-index into ls_spfli.
   concatenate 'Flüge für Fluglinie' ls_spfli-carrid ls_spfli-connid
   into my_caption SEPARATED BY space.
   "Details table with relevant info
   Select * from sflight into table lt_sflight
     where carrid = ls_spfli-carrid
     and connid = ls_spfli-connid.

     if cont2 is initial.
*       create object cont2
*       exporting
*         caption = my_caption.
       create object alv2
       exporting
         i_parent = cont2.
       else.
         alv2->refresh_table_display( ).
         endif.
         call method alv2->set_table_for_first_display
         EXPORTING
           i_structure_name = 'SFLIGHT'
           changing
             it_outtab = lt_sflight.
  ENDMETHOD.

ENDCLASS.

Data:
      my_event type ref to handle_doubleclick_handler.

START-OF-SELECTION.
call screen 100.


MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN'SHOW'.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.          "selecting all
      ELSE.                                               "ALWAYS CAPITAL LETTERS!
        SELECT * FROM spfli INTO TABLE lt_spfli           "selecting where
          WHERE carrid = spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.
        CLEAR: spfli, sflight.
      ENDIF.
    WHEN 'BACK'.                                          "ALWAYS CAPITAL LETTERS!
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_0100 OUTPUT.
"create container
  IF cont1 IS INITIAL."is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.                          " muss größ geschrieben sein      "these object are called with every round trip.not good!

    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL1'.

    create OBJECT my_event.

    "create user controlls

    CREATE OBJECT alv1
      EXPORTING
        i_parent = cont1.

    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.                                             "after = is the parent controll
                                                                      "after = is the parent controll
    SET HANDLER my_event->handle_double_click for alv1.
    else.
   alv1->refresh_table_display( ).
  ENDIF.

  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SPFLI'
    CHANGING
      it_outtab        = lt_spfli.

ENDMODULE.
