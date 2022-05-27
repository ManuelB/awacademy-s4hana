REPORT zs03_alv_dock_rainer.
*
TABLES:
  scarr, spfli, sflight.
DATA:
* Container
  cont1      TYPE REF TO cl_gui_custom_container,
  cont2      TYPE REF TO cl_gui_custom_container,
  dia        TYPE REF TO cl_gui_dialogbox_container,
  dock       TYPE REF TO cl_gui_docking_container,
* Anwendungs-Controls
  alv1       TYPE REF TO cl_gui_alv_grid,
  alv2       TYPE REF TO cl_gui_alv_grid,
  web        TYPE REF TO cl_gui_html_viewer,
  my_url     TYPE scarr-url,
  lt_scustom TYPE TABLE OF scustom,
  lt_scarr   TYPE TABLE OF scarr,
  lt_spfli   TYPE TABLE OF spfli.
*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'SHOW'.
      SELECT * FROM scustom INTO TABLE lt_scustom.
      SELECT * FROM scarr INTO TABLE lt_scarr.
* Die URL beschaffen, die ausgegeben werden soll.
      SELECT SINGLE url FROM scarr INTO my_url
        WHERE carrid = spfli-carrid.
      IF spfli-carrid IS INITIAL.
        SELECT * FROM spfli INTO TABLE lt_spfli.
      ELSE.
        SELECT * FROM spfli INTO TABLE lt_spfli
          WHERE carrid = spfli-carrid.
      ENDIF.
      IF sy-subrc <> 0.
        "spfli-cityfrom = 'nichts da'.
        CLEAR spfli.
      ENDIF.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
*
MODULE status_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  IF cont1 IS INITIAL. "is not bound
    CREATE OBJECT cont1
      EXPORTING
        container_name = 'CUCTRL'.
    CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.
    CREATE OBJECT dia
      EXPORTING
        width  = 300
        height = 100.
    CREATE OBJECT dock.
*  EXPORTING
*    side                        = DOCK_AT_LEFT



*
    CREATE OBJECT alv1
      EXPORTING
        i_parent = dock.
*        i_parent = cont1.

* Webseite "my_url" wird angezeigt
*    CREATE OBJECT web
*      EXPORTING
*        parent = cont1.

    CREATE OBJECT web
      EXPORTING
        parent = dia.

    CREATE OBJECT alv2
      EXPORTING
*       i_parent = dock.
        i_parent = cont2.
  ENDIF.

*  CALL METHOD alv1->set_table_for_first_display
*    EXPORTING
*      i_structure_name = 'SPFLI'
*    CHANGING
*      it_outtab        = lt_spfli.
  CALL METHOD alv1->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCUSTOM'
    CHANGING
      it_outtab        = lt_scustom.


  CALL METHOD web->show_url
    EXPORTING
      url = my_url. "  'https://www.google.de'.

  CALL METHOD alv2->set_table_for_first_display
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      it_outtab        = lt_scarr.

ENDMODULE.
