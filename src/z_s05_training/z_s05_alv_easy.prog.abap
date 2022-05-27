*&---------------------------------------------------------------------*
*& Report Z_S05_DYNPRO_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_alv_easy.
*
TABLES:
   sflight.
*spfli, scarr,

DATA cont1 TYPE REF TO cl_gui_custom_container.

*anwebdzbf-controls
DATA alv1 TYPE REF TO cl_gui_alv_grid.
DATA lt_sflight TYPE TABLE OF sflight.

*
CALL SCREEN 100.
*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm. "user command
    WHEN 'SHOW'.
      if sflight-carrid is initial.
      SELECT * FROM sflight INTO TABLE lt_sflight.
        else.
          SELECT * FROM sflight INTO TABLE lt_sflight
        WHERE carrid = sflight-carrid.
            endif.
      IF sy-subrc <> 0.

        CLEAR sflight.
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

    CREATE OBJECT alv1
     EXPORTING
       i_parent = cont1.

endif.


*
    CALL METHOD alv1->set_table_for_first_display
  EXPORTING

    i_structure_name              = 'SFLIGHT'
  CHANGING
    it_outtab                     = lt_SFLIGHT.




ENDMODULE.
