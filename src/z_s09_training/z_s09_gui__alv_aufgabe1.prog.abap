*&---------------------------------------------------------------------*
*& Report Z_S05_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_gui__alv_aufgabe1.
*
TABLES:
  spfli, scarr, sflight.


DATA cont1 TYPE REF TO cl_gui_custom_container.
DATA cont2 TYPE REF TO cl_gui_custom_container.
DATA dock TYPE REF TO cl_gui_docking_container.
DATA dia TYPE REF TO cl_gui_dialogbox_container.
*anwebdzbf-controls
DATA web TYPE REF TO cl_gui_html_viewer.
DATA my_url TYPE scarr-url.
DATA alv1 TYPE REF TO cl_gui_alv_grid.
DATA alv2 TYPE REF TO cl_gui_alv_grid.
DATA lt_spfli TYPE TABLE OF spfli.
DATA lt_scarr TYPE TABLE OF scarr.
DATA lt_scustom TYPE TABLE OF scustom.
*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "user command
    WHEN 'SHOW'.
      SELECT * FROM SCARR INTO TABLE LT_SCARR.
      SELECT * FROM SCUSTOM INTO TABLE LT_SCUSTOM.
      SELECT SINGLE url FROM SCARR INTO my_url
           WHERE carrid = spfli-carrid.
      if spfli-carrid is initial.
      SELECT * FROM spfli INTO TABLE lt_spfli.
        else.
          SELECT * FROM spfli INTO TABLE lt_spfli
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
        CREATE OBJECT cont2
      EXPORTING
        container_name = 'CUCTRL2'.

        CREATE OBJECT dia
          EXPORTING
            width = 300
            height = 100.

*            parent                      =.


      CREATE OBJECT web
        EXPORTING
         parent             = dia.

*            CREATE OBJECT web
*        EXPORTING
*         parent             = cont1.

CREATE OBJECT dock.
*  EXPORTING
*    side                        = DOCK_AT_LEFT


    CREATE OBJECT alv1
     EXPORTING
       i_parent = dock.

    CREATE OBJECT alv2
      EXPORTING
        i_parent = cont2.
endif.

CALL METHOD alv2->set_table_for_first_display
  EXPORTING

    i_structure_name              = 'SCARR'
  CHANGING
    it_outtab                     = lt_scarr.

CALL METHOD web->show_url
  EXPORTING
    url                    = my_url.
*    url                    = 'https://www.google.com'.

*
    CALL METHOD alv1->set_table_for_first_display
  EXPORTING

    i_structure_name              = 'SCUSTOM'
  CHANGING
    it_outtab                     = lt_scustom.




ENDMODULE.
