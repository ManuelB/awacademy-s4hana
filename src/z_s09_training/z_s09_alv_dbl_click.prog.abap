*&---------------------------------------------------------------------*
*& Report Z_S05_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_alv_dbl_click.
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
DATA lt_sflight TYPE TABLE OF sflight.
*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "user command
    WHEN 'SHOW'.

      if spfli-carrid is initial.
      SELECT * FROM spfli INTO TABLE lt_spfli.
        SELECT * FROM sflight INTO TABLE lt_sflight.
        else.
          SELECT * FROM spfli INTO TABLE lt_spfli
        WHERE carrid = spfli-carrid.
    SELECT * FROM sflight INTO TABLE lt_sflight
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
*        CREATE OBJECT cont2
*      EXPORTING
*        container_name = 'CUCTRL2'.

        CREATE OBJECT dia
          EXPORTING
            width = 300
            height = 100.

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

    CREATE OBJECT alv2
      EXPORTING
        i_parent = dia.
endif.

CALL METHOD alv2->set_table_for_first_display
  EXPORTING

    i_structure_name              = 'SFLIGHT'
  CHANGING
    it_outtab                     = lt_sflight.


*
    CALL METHOD alv1->set_table_for_first_display
  EXPORTING

    i_structure_name              = 'SPFLI'
  CHANGING
    it_outtab                     = lt_spfli.




ENDMODULE.
