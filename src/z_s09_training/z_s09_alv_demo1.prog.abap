*&---------------------------------------------------------------------*
*& Report Z_S09_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_alv_demo1.
*
TABLES:
  spfli, scarr, sflight.

DATA:

  contrl   TYPE REF TO cl_gui_custom_container,
  contrl2 TYPE REF TO cl_gui_custom_container,
  alv1     TYPE REF TO cl_gui_alv_grid,
  alv2     TYPE REF TO cl_gui_alv_grid,
  web      TYPE REF TO cl_gui_html_viewer,
  my_url TYPE scarr-url,
  lt_scarr TYPE TABLE of scarr,
  lt_spfli TYPE TABLE OF spfli.

*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT * FROM scarr INTO TABLE lt_scarr.
      SELECT SINGLE url FROM scarr INTO my_url.
        "WHERE carrid = spfli-carrid.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
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
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  IF contrl IS INITIAL. "is not bound
    CREATE OBJECT contrl
      EXPORTING
        container_name = 'CUTRL'.
    CREATE OBJECT contrl2
    EXPORTING
        container_name = 'CUTRL2'.


*    CREATE OBJECT alv1
*      EXPORTING
*        i_parent = cont1.
    CREATE OBJECT web
      EXPORTING
        parent = contrl.
    CREATE OBJECT alv2
      EXPORTING
        i_parent = contrl2.
  ENDIF.

*  CALL METHOD alv1->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SPFLI'
*    CHANGING
*      it_outtab        = lt_spfli.
  CALL METHOD web->show_url
    EXPORTING
      url =  my_url. "  'https://www.google.de'.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.

ENDMODULE.

*
*    CREATE OBJECT alv1
*      EXPORTING
*        i_parent = contrl.
*    CREATE OBJECT alv2
*    EXPORTING
*      i_parent = contrl2.
*
*  ENDIF.
*
*  CALL METHOD alv1->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SPFLI'
*    CHANGING
*      it_outtab        = lt_spfli.
*
*  CALL METHOD alv2->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SCARR'
*    CHANGING
*      it_outtab        = lt_scarr.
*
*
*ENDMODULE.
