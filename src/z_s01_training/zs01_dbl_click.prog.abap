REPORT z02_dynpro_demo1.


TABLES:
  spfli, scarr, sflight.


DATA:
*      Container
  cont1      TYPE REF TO cl_gui_custom_container,
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,
*  Anwendungs-controls
  alv1       TYPE REF TO cl_gui_alv_grid,
  alv2       TYPE REF TO cl_gui_alv_grid,
  web        TYPE REF TO cl_gui_html_viewer,
  lt_spfli   TYPE TABLE OF spfli,
  lt_sflight TYPE TABLE OF sflight.


PARAMETERS:

p_side TYPE i DEFAULT 1.



CALL SCREEN 100.



MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      IF spflI-carrid IS INITIAL.
        SELECT * FROM sflight INTO TABLE lt_sflight.
        SELECT * FROM spfli INTO TABLE lt_spfli.

      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
          WHERE carrid = spfli-carrid.


        SELECT * FROM sflight INTO TABLE lt_sflight
     WHERE carrid = spfli-carrid.
      ENDIF.

      IF sy-subrc <> 0.
        spfli-cityfrom = 'Nicht da'.
        CLEAR spfli.
        CLEAR sflight.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.


  IF cont1 IS INITIAL. "Is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.


    CREATE OBJECT dia
      EXPORTING
        width  = 300
        height = 100.

    CREATE OBJECT dock
      EXPORTING
        side = p_side.



    CREATE OBJECT alv1
      EXPORTING
        i_parent = dock.

    CREATE OBJECT alv2
      EXPORTING
        i_parent = dia.
  ENDIF.
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
*
      i_structure_name = 'SPFLI'
*
    CHANGING
      it_outtab        = lt_spfli.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
*
      i_structure_name = 'SFLIGHT'
    CHANGING
      it_outtab        = lt_sflight.



ENDMODULE.
